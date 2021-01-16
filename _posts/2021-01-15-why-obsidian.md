---
title: "Why I switched from Roam Research to Obsidian"
categories:
  - Blog
tags:
  - roamresearch
  - obsidian
  - zettelkasten
classes: wide
---

[Yesterday](/blog/roamexporttoobs) I wrote about how to get your notes out of  [Roam Research](https://roamresearch.com) for use in e.g. [Obsidian](https://obsidian.md) and got asked why I would switch from Roam to Obsidian. Here are my reasons.

Don't get me wrong, there are many things to like about Roam Research. It has brought new and fresh ideas into the areas of (personal) knowledge management, digital Zettelkasten, etc. I am grateful for that. Interesting, thriving communities have formed, networks have been created, even a semi-ironic cult was formed. 

It is also not an entirely bad app, with many really good underlying concepts. I still think the concept of "blocks" / paragraphs instead of entire files being the atomic unit of information and reference is both extremely valuable and the right way to go. 

I am also thankful for the habit-forming feature of "daily notes", incentivizing to take unstructured notes in your journal and associate them with topics by adding links / tags, never having to worry about where to put your notes, thoughts, and ideas. They can all start out in the daily notes and, if need arises, be taken to their own page later. Roam Research enables many powerful workflows, as is also reflected by the number of online courses and training programs about how to use Roam. 

That said, Roam Research is not the only app out there that enables such powerful workflows, and, in my opinion, Obsidian is a very good option, too.

Bear in mind, I know a thing or two about note taking apps intended for Zettelkasten use. I had started out creating the infamous [sublime_zk](https://github.com/renerocksai/sublime_zk) plugin for enabling Zettelkasten mode in SublimeText, and after that created the standalone app [sublimeless_zk](https://github.com/renerocksai/sublimeless_zk). Judged by the e-mails and GitHub issues I receive, both of them are still in use and loved by their users. However, after a while I had to move on, not having enough time to mainain, further develop, and create release packages for all supported platforms. Especially since Apple actively fights free software that is not part of their pay-to-get-in AppStore. (On top of that, after about a year of use, my MacBook's butterfly keyboard died - which was the final bit it needed for me to switch back to Linux for good.). Luckily enough, we now have Obsidian. Given its pace of development and their plugin system, it is a really good, and most importantly, actively maintained alternative to my own tools.

Back to Roam, I even liked it so much that I had joined their "believer" plan, paying USD 500 for 5 years of access to their software as a service and to access my own notes. I was totally lured in. 

However, thoughts kept bubbling up, annoyances started to accumulate, and eventually it was time to make a decision: Was it a good idea to continue to use Roam Research? Isn't that Obsidian thing that keeps popping up in my news feeds an option? Or should I just take an intensive break from everything and implement block level referencing, backlinks, and all the other ideas that had accumulated over time into my own tools?

After quick a look at Obsidian, it was easy to conclude that I could spare myself from a lot of work. Great!

But what exactly were the reasons that made me switch? They came in three major categories:
- more or less little annoyances
    - performance
    - mobile experience is broken
- privacy / ownership of data
    - database vs files
- lock-in to proprietary format (bad for a lifetime of work)

# The Annoyances
There were the things that I really didn't like about Roam: Its performance. And a really horrible mobile experience. Roam Research is not a real app, it is a web app. With all the consequential benefits and downsides.  To me, it never really _felt_ right to launch a browser in order to access my notes.

Some shortcuts wouldn't work on my Chromebook - and speaking of keyboard shortcuts: there is a clear focus on Mac keyboards in nearly all their communications (_"oh, just press cmd+opt blah"_) which tells a lot about their experience of shipping software.  

Roam takes an awful long time to start up, showing you a spinning logo. If you leave the browser tab or window running forever, that's not so much of an issue, until the next "reload to update". But on mobile, it is a desaster. Quickly jotting down a note is impossible. Roam eventually released their "Quick capture" feature where a simplified version of Roam would pop up in your browser, letting you jot down notes quickly - but even loading this "quick" feature involved a spinning logo for multiple seconds. Eventually, on my mobile, it broke. 

Sometimes you just need to get into your notes on mobile. And with a guestimated 80% chance, from then on, "quick capture" is gone. The browser remembers you want the full roam, so it just foregoes offering you the "quick capture" feature. At some stage, Quick capture re-appeared and from then on it was always a guessing game whether it would work this time or not.

Once in the "real Roam", tapping tiny bullet points - while there were some improvements made from the initial version - is still not a joy. Formatting assistance in terms of a well-thought-out customized virtual keyboard? Let's not ask for too much.

I don't want to be too critical about the user experience, as Roam is still relatively young and they have illustrated time and again that their strategy seems to be: "hack on new features", polish them later. Better something is kind of usable for 80% of the time than 20% of polish. Somehow that even makes sense.


# The fundamental issues
Apart from the one or other annoyance, I see real issues with using Roam Research: 

1. You don't own your data
2. Privacy is only promised
3. Your data is stored in some sort of database
4. Proprietary format and formatting

## You don't own your data
This really became a bigger and bigger show stopper for me. When you build a Zettelkasten or similar personal knowledge system, you basically put together a lifes's work. It is made for the long game. And this is where the problems start.

How future-proof is it to hand over your data to a gatekeeping company? A startup? In 20 years, will there still be a Roam Research, will you still like it or be able to afford the $15 or $30 per month? Do you have an exit strategy? How good and how usable is Roam's export after all? What if Roam gets hacked or their cloud data gets encrypted by a trojan? With daily news about pretty much every major company and cloud system getting hacked, this is at least not totally unrealistic, even if Roam would never be a target of hackers. Are you prepared for all your notes suddenly being in the public eye due to a "leak"? This is not too far-fetched either. Roam's sharing feature at least technically exposes the entire database of the sharer, not just the shared notes. Do you have at least a backup **and** recovery strategy? 

This got me thinking. Let's compare the Roam situation with what I had before: a folder containing my plain text notes, formatted with well-established Markdown syntax, synced to my cloud provider of choice with optional encryption, now even version controlled in a git repository I host on my main Linux box. 

Apart from the obvious benefits of me owning my own files, git, Markdown and local files not requiring an internet connection, this also enables easy mass-update of notes with a little script or a sophisticated text editor. Changing date formats in all notes? No problem. Search and replace in all notes? No problem. Switching ``[[YYYYMMDDHHMM]]`` Zettelkasten links to `[[Some note]]` wiki links? Easy! Converting to "real" Markdown links `[Some note](/path/to/the/note)` for use in static site generators? A breeze! Creating a beautiful PDF with academic references sourced from your BibTex file? One keystroke away. You get the idea. 

Conclusion: I prefer to own my own data.

## Privacy is only promised
This is often overlooked and it depends on how paranoid you are. But Roam's employees can, but promise not to, access everything you put into Roam. While I don't think anyone might be particularly interested in reading my notes or even tempering with them, I still like the idea of knowing that my notes are as safe (from other eyes) as all my other files on my computer. How safe that is depends of course - but on my Chromebook and Linux box, I am confident enough they are less exposed than in a Roam database.

Which brings me to the next topic:

## Your data is stored in a database
There are implications to storing notes in a database. For example, if you want to export them back into Markdown files (as part of your exit or backup and recovery strategy), you have to transform database data into Markdown, split into files. Now, how do you go about fancy block references then? Roam's Markdown export is far from perfect. The formatting is in its own Roam dialect of Markdown, versions are gone, and any notion of block reference disappears, for example. 

Luckily, Roam offers two more options: some new EDN format that looks like Datalog which I know nothing about and a JSON export. The JSON export at least contains enough metadata to re-construct block references. And even more luckily, Obsidian have come up with a brilliant way to realize block references in plain text, so a Roam JSON to Obsidian converter is possible - I wrote about my solution [here](/blog/roamexporttoobs) - but how easy is that for you to do when the time comes?

In my research, I discovered another potential third party solution via some [roam42](https://github.com/roamhacker/roam42) Roam plugin -but haven't checked it out, it seems to be a bit involved, too. At least compared to a fictional Markdown export that "just works", i.e. lets you download a zip archive of your notes, in proper Markdown, preserving block references.

## Roam's proprietary features
Roam is powerful. You can mix notes with kanban boards, queries, pomodoro timers and what not. These features are available via commands in rather cryptic notations involving lots of curly braces. But how future-proof is that?

The more you use these features - provided you really need them and don't come up with alternatives - the more you lock yourself into forever using Roam Research, with all the implications that has.

In twenty years time, maybe there's another tool out there - but you might not be able to switch because it would be too hard to convert all the curly brace commands - if they can be converted at all. 

This requires personal, individual decisions about balance, future-proofness and where to draw the line. 

I, personally, concluded: I don't need kanban boards in my notes. I can satisfy my querying needs with the search features of Obsidian, the command line - and maybe some other kind of text editor -- easily done, since my notes are just plain text files in a folder. Files that any text editor or text processor can read. On top of that, as I mentioned earlier, I rather prefer being able to write or use some little conversion tool for integration into a static website or creating a beautiful PDF from my notes.

## Conclusion
Most of my arguments might seem personal and be irrelevant to you and that is fine with me. More power to you! Roam is a fascinating tool and I hope I haven't bashed it too much because it really deserves a lot of credit.

However, as I described above, there are some fundamental issues I have with Roam and that is why I switched. 

I am really happy and quite excited about Obsidian and its development - and am more reliefed that I had thought that I am back in charge and control over my own notes.

Check it out and decide for yourself: [Obsidian.md](https://obsidian.md)
