---
title: "Syncing your Obsidian vault to Android via an encrypted GitHub repository"
categories:
  - Blog
tags:
  - roamresearch
  - obsidian
  - zettelkasten
  - sync
  - GitHub
  - Android
classes: wide
toc: true
toc_label: "Table of Contents"
---

Here I show you how I use an encrypted git repository on GitHub to sync my Zettelkasten to all my devices, including my Android smartphone.

## Front matter
You will get the most out of this article when you know git and the command line does not put you off. Setting up my workflow requires both. While I will walk you through all steps necessary to get to an encrypted, GitHub-hosted Zettelkasten, it can appear intimidating if you're completely unfamiliar with the command line.

I primarily work on Linux (or ChromeOS + Linux Shell), but all software involved is available for Windows and macOS, too.

## Motivation
I usually use 5 different machines on a regular basis:
- my Chromebook is my private laptop
- my Linux desktop at home with the big screen
- my work laptop under Linux
- occasionally my same work laptop, booted into Windows
- my mobile phone running Android

I want to be able to work on my notes on all machines. 

The solution I came up with, involves the following software:
- git
- `Obsidian Git` Plugin for Obsidian
- [git-crypt](https://github.com/AGWA/git-crypt)
- [termux](https://termux.com/) for Android 
- [termux:widget](https://wiki.termux.com/wiki/Termux:Widget) for Android

### Why not use BoxCryptor / Cryptomator and DropBox?
I had used DropBox sync in the past, with [Sublimeless_ZK](/projects/sublimeless_zk), and that lead to all sorts of sync conflicts on the DropBox side of things, especially after having been offline for a while - and in general, the sync was rather slow and also intermixed with everything else in my DropBox that wanted syncing. Syncing my  Zettelkasten on Windows was never instant, as DropBox had to catch up with too much. Also, that time I didn't use any encryption.

#### The broken Boxcryptor
When searching for cloud encryption software, [Boxcryptor](https://boxcryptor.com) is one of the first search results. From what I read, its Linux support seems to be second-class, only available via its "portable" version that seems to only allow access to files through its GUI, making it inaccessible for other software. 

Google also returns that in the past, their "classic" version had supported Linux properly, something they seem to have given up on. These days, they seem to focus more on MS Teams than Linux.

What I also noticed is that Boxcryptor's download page is broken; it returns:
```json
{"error":{},"message":"Cannot read property 'structuredData' of undefined"}
```

The overall picture I get, is:
- paid software
- clear focus on Windows and Mac
- subpar Linux support
    - decision to not longer  support Linux as a first class citizen
- not realizing their download page is broken

So Boxcryptor disqualified itself.

#### Cryptomator
I instantly liked [Cryptomator](https://cryptomator.org):
- it is free
- it is open source
- it supports Linux, Windows, Mac, Android, iOS
- independent security audits exist

So if I ever wanted to use cloud encryption software, it would be Cryptomator.

#### Why I don't like cloud encryption software for my Zettelkasten
Cloud encryption software like Cryptomator provides you with a virtual drive or virtual folder that acts as the interface to transparently encrypt and decrypt your files residing in another folder, one that is synced with the cloud.

The cloud-sync is left to the cloud provider. So to use Dropbox, you have to install their software that creates yet another virtual folder that gets synced to the cloud.

I don't like the idea of nesting virtual folders, and: I don't like to need to have encryption software and cloud-sync software running in the background. Especially on my chromebook, where I start the virtual Linux machine on-demand by opening the terminal, I want this to be as lightweight as possible. Just for running a terminal, I don't want to start unnecessary background software.

Instant synchronization, as handy as it might look, can be dangerous: If you delete a file (or large portions of it) by accident, this gets synced with the cloud instantly - your errors get propagated to all other devices instantly as well. By the time you realize you made a mistake, it might be too late. I don't like that. To protect yourself against such errors, you have to use some sort of backup or version control solution on top of the sync that sits on top of the transparent encryption.

Three layers of magic software is where too many things can go wrong. While I wouldn't mind syncing my Dropbox and using Cryptomator in general, I don't want to set them up just - and especially - for my Zettelkasten.

For all my version control needs I use git anyway - so if I can encrypt my git repository transparently, that's actually all I need.


### Why I prefer git and GitHub

I quite like the synchronization workflow I get through git:
- I work on my local copy
- I can refresh the local copy to the state of the cloud repository (`git pull`)
- I can make changes locally
- I stage the changes that I want to keep and commit them locally (`git add` and `git commit`)
- When I'm happy with it, I push the changes to the cloud repository (`git push`)

With an Obsidian plugin, committing and pushing are just one hotkey press away, as is pulling. If I feel like it, however, I can use git's command line tools or any other git software for syncing.

Syncing on demand is very useful. It protects me against accidently propagating mistakes to all synced devices. It gives me a chance to review my changes. And since git is built for distributed version control, detecting and resolving conflicts is something very natural to it.

Reverting back to previous versions, etc, is also possible with git. Since I use git extensively in my daily work, I really like the idea of using it to take care of my Zettelkasten, just as I trust it with all my source code.

Before deciding to taking my Zettelkasten (back to) the cloud, I had used git to sync between my devices:
- Chromebook
- Linux desktop
- work laptop
- Android phone

However, I had used my Linux box for keeping the central repository that all working copies push to, with my local IP address. Obviously this only works in my home network, so syncing on the go is not possible.

Using GitHub (or GitLab) or any public, cloud-hosted git repository will provide me with an off-site backup in the cloud and will enable syncing at work and on the go.

So let's dive in and get our vault under git control.

## Git and git-crypt
### (Re-) Initialize your Repo
In the following examples, your Obsidian vault will be located in `~/zettelkasten`.

**!!! PLEASE MAKE A COPY OF YOUR VAULT FIRST !!!**
{: .notice--danger :}

```bash
$ cp -pr zettelkasten zettelkasten.bak
```

This, `zettelkasten.bak`, will be our backup if anything goes wrong later.

We initialize a git repository, initialize `git-crypt` and copy the secret key it generates to `~/git-crypt-key`:

```bash
$ cd zettelkasten

# delete existing git repo
# let's not expose cleartext history!
$ rm -fr .git/    

$ git init    
$ git-crypt init

$ git-crypt export-key ../git-crypt-key
```

### Set up gitignore and .gitattributes
Here is my `.gitignore`, you may want to put the entire `.obsidian` directory into there, but I prefer it this way:

My `.gitignore`:
```
.obsidian/workspace
.obsidian/cache
```

Alternatively, just copy back the ignore file from your backup if you had used git before:

```bash
$ cp ../zettelkasten.bak/.gitignore .
```

`git-crypt` only encrypts files with certain git attributes. In my case, I specify:
- all `.md` markdown files in all subfolders
- all files in all subfolders 
    - this wil exclude dotfiles like `.gitattributes`

You ned to store these attributes in a file called `.gitattributes`.

Here is my `.gitattributes`:
```
*.md filter=git-crypt diff=git-crypt
*/** filter=git-crypt diff=git-crypt
```

Now, if you're using `oh-mz-zsh`, the following two commands will prevent it from slowing down your command line:

```bash
$ git config --add oh-my-zsh.hide-status 1
$ git config --add oh-my-zsh.hide-dirty 1
```

### Add your files
```bash
$ git add .
```

### TEST YOUR .gitattributes
```bash
$ git ls-files -z |xargs -0 git check-attr filter |grep unspecified
```

You should only see harmless files like `.gitattributes` be reported as unspecified. If any file pops up here that you want to be encrypted, you need to change your `.gitattributes`.

If unsure, use mine:
```
*.md filter=git-crypt diff=git-crypt
*/** filter=git-crypt diff=git-crypt
```

### Commit and push
First, we'll commit all files we have added before:
```bash
$ git commit -m '.'
```

#### Set up remote repo for testing your config
In order to test the encryption when pushing, we'll set up a bare git repository :
```bash
$ cd
$ mkdir bare
$ cd bare
$ git init --bare
```

We'll temporary add it as remote repo and push our zettelkasten there:
```bash
$ cd
$ cd zettelkasten
$ git remote add bare ../bare
$ git push bare master
```

Now we clone the bare repo to see whether we get back encrypted files:
```bash
$ cd 
$ git clone bare testcrypt
$ cd testcrypt
$ cat some file
```

The file should come back as scrambled. Let's try to unlock the repository:
```bash
$ git-crypt unlock ../git-crypt-key
$ cat some file
```

The file should be decrypted.

**Note:** From now on, you can add, commit, push from the `testcrypt` repository, and `git-crypt` will transparently encrypt and de-crypt your files.
{: .notice--warning :}

#### Cleaning up local test repos

```bash
$ cd
$ rm -fr bare testcrypt

$ cd zettelkasten
$ git remote rm bare
```

## Push to GitHub
Create an empty, **private** repository on GitHub and follow the instructions about how to push an existing repository. 

I assume, you have used GitHub before and have your credentials set up (e.g. for ssh use):

```bash
$ cd
$ cd zettelkasten

$ GH_USER=your github user name
$ GH_REPO=your repository name

$ git remote add origin \
      git@github.com:$GH_USER/$GH_REPO.git

$ git branch -M main   # ...
$ git push -u origin main
```

Great! Your encrypted zettelkasten is now on GitHub 😀!

### Checking it out on a different machine
To work with your vault on a different machine
- install git-crypt
- clone the repository
- unlock the repository

For that to work, copy the `git-crypt-key` to the new machine; I use `scp` for that:

```bash
$ cd
$ scp git-crypt-key other_machine:
```

Now clone and unlock:
```bash
$ GH_USER= your github username
$ GH_REPO= your github repository name

$ git clone git@github.com:$GH_USER/$GH_REPO.git

$ cd $GH_REPO
$ git-crypt unlock ../git-crypt-key
```

Don't forget, if you use `oh-my-zsh`, to do the following:
```bash
$ git config --add oh-my-zsh.hide-status 1
$ git config --add oh-my-zsh.hide-dirty 1
```

**Note:** From now on, you can add, commit, push from this repository, and `git-crypt` will transparently encrypt and de-crypt your files.
{: .notice--warning :}

## Obsidian
Install the plugin `Obsidian Git`.
Configure the plugin: Make sure, `Disable push` is deactivated.

Do this on all your machines.

Now, every time you want to sync your changes, press `ctrl+p` and search for "Obsidian Git : commit ...".

The plugin will automatically pull all remote changes when you start Obsidian. If you leave it running for days, you might want to pull recent changes manually: `ctrl+p` and search for "Obsidian Git: Pull". 

## Android
Now on to the most hacky part of them all: syncing your repository on Android!

Once you have your Zettelkasten on your mobile, you can access it, add and edit files with software like [iA / Writer](https://ia.net/writer) or [Epsilon Notes](http://epsilonexpert.com).

We will install the fantastic [termux](https://termux.com/) to get a Linux shell on Android. Then we will install `git` and `git-crypt`, and clone the repository like we would on Linux.

We'll add a handy commit and push and a pull shortcut that we can launch directly from the homescreen.

### Installing termux
First, we install `termux`. The play store version works fine, eventhough they recommend [F-Droid](https://f-droid.org/). Later, we'll install an add-on that adds scripts for pulling and pushing to our homescreen. This add-on is free on F-Droid but costs ca EUR 2.00 on the play store. Since one shouldn't mix play store and F-Droid and I had termux installed already, I just kept continuing using the playstore version.

The following commands, typed within termux, will install git and git-crypt, and also give termux access to your phone's files.

within termux : 
```bash
$ pkg install git git-crypt

# make storage available
$ termux-setup-storage

# this will give you the storage directory
```

Now we'll prepare for GitHub access.

### GitHub
First, we generate a new ssh key for Android.

In termux, we type:

```bash
$ ssh-keygen -t ed25519 -C "your_email@example.com"
```

When prompted for a passphrase, we just press enter.

Next, we add the ssh key to GitHub: [like described here](https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account):
- we sign in to Github
- we click our photo
- we select settings
- we click on "SSH and GPG keys"
- we click on "New SSH key"
- we go to termux and type `cat .ssh/id_ed25519.pub`
- we copy the key
- we paste it into the "key" field of the browser
- we click "Add SSH key"

### git-crypt
We need to copy the `git-crypt-key` file into termux. I zipped it, uploaded it to a safe space, and used Chrome on Android to download it. So my downloads folder contained `git-crypt-key.zip`. So in termux, I typed:

```bash
$ cd
$ unzip storage/downloads/git-crypt-key.zip
$ chmod 600 git-crypt-key
```


Next, we clone the repository:

```bash
$ GH_USER= your github username
$ GH_REPO= your github repository, e.g. zettelkasten 
$ git clone git@github.com:$GH_USER/$GH_REPO.git
```

Now we unlock it using `git-crypt`:

```bash
$ cd $GH_REPO
$ git-crypt unlock ../git-crypt-key
```

Once it's finished, we move it to the shared folder:
```bash
$ cd
$ mv $GH_REPO storage/shared/
```

Great, now you can access your notes from any Android app!

### Shortcuts for committing, pushing, and pulling

We'll create a few scripts:

**`repo.conf`:**
```bash
GH_REPO=zettelkasten
```

**`pull.sh`:**
```bash
source $HOME/repo.conf
cd $HOME/storage/shared/$GH_REPO
git pull
cd $HOME
bash -c "read -t 3 -n 1"
```

**`push.sh`:**
```bash
source $HOME/repo.conf
cd $HOME/storage/shared/$GH_REPO
git add .
git commit -m "android on $(date)"
git push
cd $HOME
bash -c "read -t 3 -n 1"
```

**`log.sh`:**
```bash
source $HOME/repo.conf
cd $HOME/storage/shared/$GH_REPO
git log
cd $HOME
bash -c "read -t 5 -n 1"
```

You can prepare and download them, just like we did with `git-crypt-key` or edit them directly in termux.

Next, we'll make them executable:

```bash
$ cd
$ chmod +x pull.sh push.sh log.sh
```

From now on, we can commit and push like this:

```bash
$ ./push.sh
```

And we can pull remote changes like this:

```bash
$ ./pull.sh
```

We can see what version we're on with:

```bash
$ ./log.sh
```

However, it will be even cooler, when we can push and pull directly from the homescreen of our phone.

### Adding shortcuts to the homescreen
First, we need to install `termux: widget` from the play store or F-Droid, just like we did with termux itself.

Next, we create the shortcuts in termux:

```bash
$ cd
$ mkdir .shortcuts
$ cd shortcuts
$ ln -s ../push.sh
$ ln -s ../pull.sh
```

After that, **after exitting termux**, you can open your launcher's widget menu, select `Termux:Widget` and place it on your home screen.

**Note:** The shortcuts will only work when termux is not running. To exit, type `exit` and press `[enter]`!
{: .notice--danger :}

There are two different variants:
- one shows a little text menu
- the other one allows you to place an icon per script

![homescreen](/assets/images//homescreen.jpg)

And here is my output of `log.sh` on Android:

![gitlog](/assets/images//gitlog.jpg)

Et voila! Now you have an encrypted GitHub repository for your Zettelkasten that you can use to sync all your devices!

---

## Research
Here are a few notes I took while researching different options:

---

- [git-crypt](https://github.com/AGWA/git-crypt) 
    - only encrypts single files, GPG based,  supports symmetric keys
    - gitattributes to define what files to encrypt / decrypt
        - can be tricky if you want all files to be encrypted
            - need to avoid .gitattributes etc
    - cannot re-encrypt once keys are revoked, etc
    - for entire repos, they recommend [git-remote-gcrypt](https://spwhitton.name/tech/code/git-remote-gcrypt/)

---

- [git-remote-gcrypt](https://spwhitton.name/tech/code/git-remote-gcrypt/)
    - > Using an arbitrary `<giturl>` or an `sftp://` URI requires uploading the entire repository history with each push. 
    - > every git push effectively has --force. Be sure to pull before pushing.
    - > git-remote-gcrypt can decide to repack the remote without warning, which means that your push can suddenly take significantly longer than you were expecting, as your whole history has to be reuploaded. This push might fail over a poor link.
    
---

- [git-secret](https://git-secret.io/) 
    - needs to .gitignore your real files
    - creates .secret files - doubling the number of files
    - needs git-secret reveal
    - shitty workflow

---

- [transcrypt](https://github.com/elasticdog/transcrypt)
    - looks OK
    - uses .gitattributes, too

---

- [this gist](https://gist.github.com/polonskiy/7e5d308ca6412765927a96bd74601a5e) looks promising
    - but what about: android
        - possible solution: termux

---

- [termux](https://termux.com/)
- [4 secrets management tools for Git encryption](https://opensource.com/article/19/2/secrets-management-tools-git)
- [Things You Must Know About git-crypt To Successfully Protect Your Secret Data](https://hackernoon.com/things-you-must-know-about-git-crypt-to-successfully-protect-your-secret-data-kyi3wi6)


