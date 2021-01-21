---
title: "Handling merges and conflicts in an encrypted GitHub Zettelkasten"
categories:
  - Blog
tags:
  - obsidian
  - zettelkasten
  - sync
  - GitHub
  - Android
classes: wide
toc: true
toc_label: "Table of Contents"
---

Since I implemented [an encrypted GitHub repository for my zettelkasten](/blog/obsidian-encrypted-github-android), I was totally happy using it, suspending work on my Chromebook to resume it on my Desktop PC, later continuing on my smartphone using the excellent [Epsilon Notes](http://epsilonexpert.com/) app - until I ran into a merge conflict because I had edited the same (daily) note on two devices without prior syncing.

This is when I realized, `git-crypt` does not support merging! As a consequence, it always treats conflicting files as having no difference to the local version of the main branch. Which, if you commit them, essentially leads to you always overwriting what had been pushed already with what you have locally: You will loose the remote changes.

Of course, you can avoid that. The easiest option, when encountering a merge conflict, would be to just `git clone` the GitHub repository into a different folder and then inspect the conflicting notes or using a command line or GUI diff (and merge) tool. 

However, we need to fix the merge-inability of `git-crypt`. Luckily enough, there is a fix: we "just" need to add a _merge handler script_ to `git-crypt`.

## Installing a merge handler for git-crypt


### Obsidian / Computer

I have taken the essentials of this solution from [this GitHub issue](https://github.com/AGWA/git-crypt/issues/140) which looks promising. So, first we need to add to `.git/config`. In preparation for other repositories, we just create a file with these contents, name it `git-config-for-merge`, and place it in the root of our vault:

```bash

# config for merge
[merge "git-crypt"]
	name = A custom merge driver used to merge git-crypted files.
	driver = $HOME/bin/my-merge-tool.sh %O %A %B
	recursive = binary
```

At the root of the repository, our vault, we also create the script `my-merge-tool.sh`:

```bash
#!/usr/bin/env bash
ancestor_decrypted="$1__decrypt"
current_decrypted="$2__decrypt"
other_decrypted="$3__decrypt"
echo ""
echo "###########################"
echo "# Git crypt driver called #"
echo "###########################"
echo ""

echo "Decrypting ancestor file..."
cat $1 | git-crypt smudge > "${ancestor_decrypted}"
echo "Decrypting current file..."
cat $2 | git-crypt smudge > "${current_decrypted}"
echo "Decrypting other file..."
cat $3 | git-crypt smudge > "${other_decrypted}"
echo ""

echo "Merging ..."
git merge-file -L "current branch" -L "ancestor branch" -L "other branch" "${current_decrypted}" "${ancestor_decrypted}" "${other_decrypted}"
exit_code=$?
cat "${current_decrypted}" | git-crypt clean > $2

echo "Removing temporary files..."
rm "${other_decrypted}" "${ancestor_decrypted}" "${current_decrypted}"

if [ "$exit_code" -eq "0" ]
then
    echo "@@@ No conflict!"
else
    echo "@@@ You need to solve some conflicts..."
fi

exit $exit_code
```

And the final file we create is an installer, which we call `install-merge-tool.sh`:

```bash
#!/usr/bin/env bash
mkdir -p $HOME/bin
cp my-merge-tool.sh $HOME/bin/
chmod +x $HOME/bin/my-merge-tool.sh

if ! grep my-merge-tool .git/config > /dev/null ; then
    cat git-config-for-merge >> .git/config
    echo "git config updated"
else
    echo "git config not updated"
fi
```

Then we make sure it's executable and run it:

```bash
$ chmod +x install-merge-tool.sh
$ ./install-merge-tool.sh
```

This copies the merge tool into the `bin` folder of your home folder and makes sure it's executable and updates your git config file accordingly. Unfortunately, the merge tool cannot be executed from within the root folder of the repository, since on Android, the repository has to reside in the **shared** folder which does not allow for executable permissions and removes them automatically.

Finally, we modify your `.gitattributes` to add a merge option at the end of each git-crypt-relevant line:

```bash
**.md filter=git-crypt diff=git-crypt merge=git-crypt
*/** filter=git-crypt diff=git-crypt merge=git-crypt
```

Voila! Now we have the tooling and config in place.

One last thing: We add and push the merge tool to git:
- either via Obsidian push ...
- or manually:

```bash
$ git add git-config-for-merge my-merge-tool.sh install-merge-tool.sh .gitattributes
$ git commit -m "adding merge tool"
$ git push
```

So from now on, we'll have it available on all other systems, same goes for `.gitattributes`. That will save us some time on other systems.

### Other systems
Since we checked in the merge tool, we just need to pull in those changes and run the installer:

- via Obsidian: git pull...
- or via commandline: `git pull`

Then we execute the merge tool installer:

```bash
$ sh install-merge-tool.sh    # note the sh command
```


### Android
We basically repeat what we did for Obsidian on other systems: 

We open termux and type:

```bash
# first we pull the merge tool using the pull script
$ ./pull.sh

# change zettelkasten to the name of your working copy:
$ cd storage/shared/zettelkasten 
$ sh install-merge-tool.sh     # note the sh command
```

Note that your `.git` directory will be in a different place if your Zettlkasten folder is not named `zettelkasten`.

## How to handle merges

There are 4 kinds of merge situations that can come up when pulling remote changes:
1. Pull fails due to uncommitted changes
2. Push fails because the GitHub repository is ahead
3. Normal merge, where git handles everything for you 
4. Merge fails with conflict markers in affected files 

### Merge situations

#### Case 1: Pull fails due to uncommitted changes
In Obsidian, on pull, you will get the notification that "pull failed due to uncommitted changes".

In this case, just use its "push" function to commit your local changes. Of course the push itself will fail, because you need to pull in the remote changes first.  But that doesn't need to be an issue yet. 

If the push fails:

#### Case 2: Push fails because GitHub repository is ahead
This is always the case when you change a file, like your daily note, that previously has been changed on another device, and when those changes have been pushed already. In this case, the `push` will fail and you will be asked to pull first. 

This, when pulling now, is where you'll encounter one of the other 2 scenarios.

#### Case 3: Normal merge
 This happens when your changes affect different files or if you changed a file, like your daily note, in two different locations on two different devices. For example, you change the top paragraph of your daily note on your main computer and forget to push those changes. Then, on your smartphone, you change the very last paragraph and push these changes. Back on your computer, you want to push and it fails (but your local changes will be commited locally). Since you are asked to pull first, you just pull.
 
 If you try pulling with the Obsidian git plugin now:
 - The notification will be the normal, small _"... Changed n files"_ notification
 - git will merge the changes and commit them
 - the next time you push, this merge will be pushed along with the other changes you will have made by then

So all is fine!

##### On Android or the command line
 On Android, when you tap the `pull.sh` homescreen widget or on the command line, if you prefer that, , you issue the `git pull` command inside your Zettelkasten folder, the following will happen:
  
 Git will see that the changes do not conflict: It will fix your daily note for you: taking changes from the GitHub version and the local changes into account. However, git usually wants to commit these changes immediately. So it will drop you into an editor where you can edit the pre-defined commit  message:
 
 ```
 Merge branch 'main' of github.com:your_username/zettelkasten
 ```
 
 You can safely exit the editor, saving this message. In case you've been dropped into the `vi` editor, just press `:x` - all other editors will display some kind of menu.
 
 Now you can push the combined changes with  the `git push` command.


#### Case 4: Merge fails with conflict markers in affected files
This is a tricky one since the plugin gives you no clear indication that it happened. That means:

**Any time a push fails, either pull from the command line or pay extra attention to the size of the pull notification! It will be large in case of a failed merge!**
{: .notice--danger :}

When you pull, the Obsidian git plugin will not warn you but your files will end up containing conflict markers with both conflicting version and original version.  See [Appendix A: Testing merge](#appendix-a-testing-merge) for more information.

To actively search for conflict markers, just search for `<<<<<<<` in your vault.

From the appendix:
> Any conflicts can be found when searching for `<<<<<`. This line is followed by the local version of the line in question. In case of multiple consecutive lines, all of them will show up here. This section is followed by the separator `=======`. After that, the remote version of the chunk in question is presented until the end marker `>>>>>>>`.

> Now you can decide how to go about these conflicting changes.

##### On Android or the command line
Here, the pull and merge conflict situation is easier to detect: The attempt to auto-merge changes upon pulling results in a clear error message. It looks like this:

```bash
###########################
# Git crypt driver called #
###########################

Decrypting ancestor file...
Decrypting current file...
Decrypting other file...

Merging ...
Removing temporary files...
@@@ You need to solve some conflicts...
Auto-merging testmerge.md
CONFLICT (content): Merge conflict in testmerge.md
Automatic merge failed; fix conflicts and then commit the result.
```

At the end, in the line

```bash
CONFLICT (content): Merge conflict in testmerge.md
```

git tells you exactly which files contain conflicts. Now you just need to hunt for conflict markers inside those files, not your entire vault.


And that's it. You see, the worst that can happen now, is: conflict markers in your notes that are easy to find. You will never loose any of your changes.


## Appendix A: Testing merge

First, we create a new branch in our Zettelkasten, so we can play around without causing permanent damage:

```bash
$ git checkout -b mergetest
```

OK, let's create a note `mergetest.md` and push it:

```bash
# in your vault
$ echo "this is a test" > mergetest.md
$ git add mergetest.md
$ git commit -m "testnote from the original vault"
$ git push -u origin mergetest
```

Then, we will clone the GitHub repository into a second working copy named `mergetest`:

```bash
$ git remote -v

# now we copy one of the two "git@github.com....git" specifiers 

$ cd some-other-folder  # outside of your zettelkasten/vault

# insert the stuff we copied between the "quotation marks"
$ git clone "git@github.com...git" mergetest 

# unlock it
$ git-crypt unlock ../git-crypt-key

# git config -- instead of the installer, we can run just this
$ cat git-config-for-merge >> .git/config

# switch to the mergetest branch
$ git checkout mergetest

# oh-my-zsh git config if needed
$ git config --add oh-my-zsh.hide-status 1
$ git config --add oh-my-zsh.hide-dirty 1
```

So now it's time to make a change in the `mergetest` vault:

```bash
# we modify the note
$ echo "this is the replacement line" > mergetest.md
```

We have just modified the note. But we didn't commit or push it. So what happens when we change this very note in our main vault, push the change and try to pull it into our test vault? We will have a merge conflict!

So let's try it out:

```bash
# in our main vault
$ echo "this will create conflict" > mergetest.md
$ git add mergetest.md
$ git commit -m "conflicting commit" 
$ git push
```

Now let's return to our mergetest vault and see what happens, when we pull:

```bash
# in the mergetest vault
$ git pull
...
Updating 63691a6..489d5b7
error: Your local changes to the following files would be overwritten by merge:
        mergetest.md
Please commit your changes or stash them before you merge.
Aborting
```


And voila! We get a serious error message 🙂!

We can look at the differences:

```bash
$ git diff
index 8615b53..385ee0f 100644
--- a/mergetest.md
+++ b/mergetest.md
@@ -1 +1 @@
-this is a test
+this is the replacement line
```

OK, so far this is working. But this just prevents us from pulling and doesn't do any harm.

Let's commit in the mergetest branch and try to pull:

```bash
# in the mergetest branch
$ git add mergetest.md
$ git commit -m "uh oh"
$ git pull

###########################
# Git crypt driver called #
###########################

Decrypting ancestor file...
Decrypting current file...
Decrypting other file...

Merging ...
Removing temporary files...
@@@ You need to solve some conflicts...
Auto-merging mergetest.md
CONFLICT (content): Merge conflict in mergetest.md
Automatic merge failed; fix conflicts and then commit the result.
```

WOW! We can see, the `git-crypt` merge tool was called!

So let's examine `mergetest.md`:

```bash
$ cat mergetest.md
<<<<<<< current branch
this is the replacement line
=======
this will create conflict
>>>>>>> other branch
```

Yayyy! 🥳 This is exactly what we wanted! It may look cryptic but git tells us exactly what is going on:

Any conflicts can be found when searching for `<<<<<`. This line is followed by the local version of the line in question. In case of multiple consecutive lines, all of them will show up here. This section is followed by the separator `=======`. After that, the remote version of the chunk in question is presented until the end marker `>>>>>>>`.

Now you can decide how to go about these conflicting changes.

**At the end, don't forget to switch back to the `main` branch:**
{: .notice--danger :}

```bash
# in your Zettelkasten folder (Obsidian vault)
$ git checkout main
$ git branch -d mergetest
$ git push origin --delete mergetest
```

And all your tests are gone.

## Appendix B: Future-proofing the Android scripts
Here, we will tidy up our scripts - so they become cross platform friendly - and we don't get any surprises if we replace them by some other script we developed for another system.

### Problem with widgets: /usr/bin/env does not exist

So consider `log.sh`:

```bash
source $HOME/repo.conf 
cd $HOME/storage/shared/$GH\_REPO 
git log 
cd $HOME 
bash -c "read -t 5 -n 1"
```

Ideally, we'd like to prefix that with a shebang line: `#!/usr/bin/env sh`:

```bash
#!/usr/bin/env sh
source $HOME/repo.conf 
cd $HOME/storage/shared/$GH\_REPO 
git log 
cd $HOME 
bash -c "read -t 5 -n 1"
```

Eventhough our script runs on the command line when we invoke it with

```bash
$ ./log.sh
```

it now stopped working when tapped on the homescreen, thanks to the "shebang line".

So what we do, is: We create a wrapper called `log` in `.shortcuts/` that just invokes `log.sh`, and remove the link to `log.sh`, so that `log` can become our new shortcut.

[How and why this works](#how-and-why-this-works) goes into more details about how and why the solution works.
{: .notice--warning :}

This is how we do it: 

```bash
$ cd

# remove the link
$ rm .shortcuts/log.sh 

# create the wrapper
$ echo '$HOME/log.sh' > .shortcuts/log
$ chmod +x .shortcuts/log
```

On our Android home screen we remove `log.sh`, and add `log` via the termux widget.

We repeat the same procedure for `pull.sh` and `push.sh`.

### How and why this works
The source of the solution is: [termux-exec](https://github.com/termux/termux-exec). 

According to [the termux wiki](https://wiki.termux.com/wiki/Termux-exec), `termux-exec` is already installed on current versions of termux. 

How does termux-exec do that? It installs a wrapper to the [execve()](https://man7.org/linux/man-pages/man2/execve.2.html) system call that translates all paths to `/bin/` and `/usr/bin/` to their termux counterparts.

How **can** it do that? With the `LD_PRELOAD` mechanism: You can set the environment variable `LD_PRELOAD` to one or more libraries you want to load **before** all others. This can be used to selectively override functions in other shared objects. In the case of `termux-exec`, the `execve()` system call is overridden. When the termux console starts, it automatically checks for an `LD_PRELOAD` override configuration - which it finds since `termux-exec` is installed.

Why do our wrapper scripts work in combination with the homescreen widgets? Apparently, the widget executes our scripts differently than the termux shell in the console does: The `LD_PRELOAD` is not in effect. However, once our wrapper script is running, **the shell**, not a widget, executes the script named in the wrapper - this is much more similar to the command line invocation, and the `LD_PRELOAD` trick works again.  

