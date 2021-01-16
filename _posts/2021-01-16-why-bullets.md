---
title: "Why and how I wrote my own slideshow presentation software"
categories:
  - Blog
tags:
  - projects
  - presentations
classes: wide
---

link: [Bûllets](/projects/bullets) 

I created my favorite alternative to Powerpoint, a presentation software that satisfies my specific requirements, and even introduces an innovative feature dubbed **_"multiplayer presentations_**.

To better understand my motivation of ditching Powerpoint, I'll share some of the grievances I have with it before telling you all about this project.

_"This is probably going to be a rant..."_

## I don't like Powerpoint
TL/DR:
- user experience: bad, inconsistent across platforms
- inconsistent format when changing computer or OS or app or version
- low productivity compared to what I am used to
- common style of presentations is dull
- lacking presenting features I would like to see

I am not a fan of Powerpoint. I am not a fan of office software in general. It just keeps getting more and more complex, keeps surprising me with annoying bugs, and really works against my productivity. **It slows me down.** If, by contrast, you have never experienced working with a good text editor such as neovim or vscode, creating content in Markdown - you will probably never understand how lightweight and productive that can be. Editors don't get into your way as much as opinionated, bloated office products do. I feel really sad for anyone who is happy with Microsoft Office. They don't know what they're missing.

I hate the point-and-click, copy-and-paste style workflows, I strongly dislike shallow, style-over-substance Powerpoint presentations as much as I hate unproductive, unnecessary meetings, "pepped up" with meaningless bullet points.

The way we present has collapsed into just one style of presentation: Slides with bullets, charts, and pictures, with the odd video. Hardly any interaction at all.

As a programmer and researcher, I value precision. Powerpoint presentations still, in 2021, have a tendancy to change the way they look when opened on a different computer. Text positioning or text sizes are suddenly a bit off...

I also value support for multiple platforms. Microsoft currently offers many different versions of Powerpoint: The Windows app, the Android app, the iOS app, the web app - all come with a different set of features and if you don't have a Windows computer or Mac handy, you won't be able to access all the features you might need. 

I have spent countless hours trying to "fix the master slides" some creative person shoveled together, not caring about consistent formatting, producing templates that just work in the demo presentation but that are useless the moment you instantiate a template. Suddenly bullet points loose their formatting, change their symbol - and you end up just copying and pasting slides, merely changing texts, trying not to break anything. This workflow also encourages the creation of multi-master presentations. Copy in a slide from an older presentation and bam - you have inherited a few more master slides - and the real fun begins.

OK, let's stop ranting and start doing something about it. But **what** do I want?

## I want something different
My basic uses case an needa - let's outline them with some bullet points:

- simple slides with bullets
    - consistent formatting inside a presentation and across all platforms
    - easy slide creation with Markdown formatting
        - text files: enable version control tools such as git
- complex animations to illustrate complex stuff
- easy to take with me and present
    - no Powerpoint, no "Player" software needed
    - better than a simple PDF
    - clicker support
    - virtual laserpointer support
    - draw mode
- easy to share
    - no Powerpoint should be required
    - better than mere PDF, with PDF as fallback
- **INNOVATION: Multi remote presenter mode!** _("multiplayer mode")_
- Support for **non-linear presentations**

Yay, we have a requirement spec 😀! We'll get to those points later.

## Jonathan Blow's approach

So, a few of years ago, I watched Jonathan Blow from Thekla, Inc. [create his own slideshow program](https://www.youtube.com/watch?v=t2nkimbPphY&list=PLmV5I2fxaiCL9mYvYjUj0qTnYlK4qDhkn) on Twitch, for reasons similar to mine. Wow, that was refreshing! Jonathan is an indie game developer with quite a following and gives lots of talks - he clearly has the need for great presentation software.

In the livestreams, he argues how difficult it is to do simple changes like changing the backround color of a single slide and how Powerpoint, while growing more and more complex, does little what he actually needs or wants to do. What he had in mind was a presentation program that works fundamentally different than Powerpoint, something built for **non-linear presentations**: where you can branch off, e.g. in the Q&A time of your talk, into a database of useful slides you keep around, and give more interactive presentations than "a memorized bunch of words delivered to the audience".

This resonated well with me. Jonathan wrote his slideshow program in his own programming language, using (I think) OpenGL (GPU) for rendering, etc. The "slides" are defined in a simple text file, which still leaves open the option of creating a graphical slideshow designer later.  

Unfortunately, he never released his software, but I was intrigued. 

## How to write your own slideshow?
But how would I go about writing my own presentation software then? This lead to many questions and considerations:

- What should the end product be?
    - An executable? 
        - For which platforms? 
        - How to support multiple platforms? 
            - Cross compilation? 
            - Or web? 
            - Or both? 
    - What programming language to use? 
    - A framework or low level yet still cross platform? 
        - OpenGL? What about audio then? 
        - SDL?

## Godot engine to the rescue
This is where the idea of using a game engine crossed my mind. A game engine is a framework, usually combined with some sort of GUI editor, for creating computer games. Typically, the most common platforms are supported.

It didn't take long and I was hooked on the powerful, free and open source [Godot engine](https://godotengine.org).

Using a game engine, the basics of graphics rendering, animations, audio, and even networking are already covered - and my "game" could be exported to all major platforms (Windows, Mac, Linux) out of the box. What's more, an HTML export for releasing to the web is available, too. 

All this power comes in a mere 20 or so megabyte (!) download, is available on all platforms, and was totally usable under Linux on my Chromebook.

I saw a path forward, was hooked, and immersed myself into "game" programming using the Godot engine.

## Introducing: Bûllets
Here is what I came up with: 

![](https://github.com/renerocksai/bullets/raw/master/docs/bullets-start.png)

* What is Bûllets?
    * Bûllets is a slide show software powered by the Godot game engine
    * It helps you create beautiful presentations on all platforms (Windows, Mac, Linux) that are 100% self-contained and will look and feel the same on all platforms
    * Using plain text with optional easy markup for content makes slide creation a breeze
    * If you know how to code, you can create the most complex, interactive animations, with sound effects- or even embed Tetris into your slides.
    * You can share Bûllets presentations either as native programs or publish them to the web
    * PNG export is supported, too if you need a PDF version
    * Bûllets presentations are version control friendly and allow for GitHub collaboration
    * And yes, it works with your favorite wireless clicker, it even comes with a laser pointer! Try it out, press `<F>`!
    * It is a proof-of-concept
    * It is also a hack

The main ideas behind this project:
- You create the slide contents, bullet points, etc. using Markdown
    - ![](https://github.com/renerocksai/bullets/raw/master/docs/edittext.png)
- Yet, you have a graphical editor 
    - ![](https://github.com/renerocksai/bullets/raw/master/Bullets/img/godotscr2.png)
    - The editor is the Godot engine, a tiny download that doesn't need to be installed, and runs on all platforms.
    - The editor is customized for slideshow presentation editing
- When done, you export the presentation
    - into standalone executable programs for Windows or Mac or Linux
    - or to HTML for use in the browser
        - if you know how to upload it, e.g. to GitHub (free), then you don't even need to take the presentation with you

So you can just show up anywhere and run or browse to your slideshow program and be sure that it will look and behave exactly as you intended it to be.

You can also share your interactive slideshows, ideally via the web - as sending executable programs is out of fashion these days - or create a PDF version.

While the [GitHub project page](https://github.com/renerocksai/bullets) and the [demo presentation](https://renerocksai.github.io/bullets/bullets.html) go into more details, I want to share a few highlights.


### Showing off: Platformer with touch controls in the slideshow
With regards to interactive presentations and complex animations, this is where a game engine really shines. Below you see a demo of a **fully functioning 2D platformer mini game** running inside a slide of a presentation. It even detects when you're on a device with a touch screen - and displays touch controls:

![](https://github.com/renerocksai/bullets/raw/master/docs/gametime.png)

Needless to say, all this **also runs in the browser**, as do all other features.

### Supporting clickers, controllers, and virtual laserpointers
Of course, Bûllets supports "clickers", those little remote controls. Being inspired from the computer games context, you can also control your slides with your favorite gamepad or game controller.

It also features a virtual laserpointer that you can vary in size:

![](https://github.com/renerocksai/bullets/raw/master/docs/laserpoint.png)

### Drawing on slides!
To add interactivity, and for illustrating areas of you slides, Bûllets lets you draw on slides:

![](https://github.com/renerocksai/bullets/raw/master/docs/drawmode.png)

### Embedding audio and video
Here is an example screenshot of an embedded video:

![](/assets/images/videoslide.png)

### The innovative finale: multiplayer mode!
This feature is part of the reason why I created Bûllets: Especially these days, where we have to present from home, I was faced by a struggle:

Giving a conference talk together with my colleague, we would usually have her share her screen, and me narrating my part of the presentation, where I had to give her auditive cues as to when to advance to the next slide or play an audio, etc.

If there only was a way where I could remote-control her presentation... Well, now there is: Multiplayer-mode

![](https://github.com/renerocksai/bullets/raw/master/Bullets/img/trial.png)

In this mode, up to 3 presenters can join a "room" on a server, directly from within the presentation, like so:

![](https://github.com/renerocksai/bullets/raw/master/Bullets/img/multi3.png)

Once connected, all of them get assigned different laserpointer and drawing colors, and all of them can control the presentation. This makes taking over a part of the presentation remotely absolutely pain-free.

Here is a video demoing multiplayer mode:

{% include video id="Z10a3eewbVU" provider="youtube" %}

This feature is a bit more involved, as it requires copying the server executable onto a server machine that's accessible over the internet. But you only have to deploy one server to run an unlimited number of "rooms".

## So, is this for everyone?
Probably not. Most people shy away from using anything but Microsoft Office and might not have my specific needs or have a higher pain threshold than I have. Also, as with all new tools, there"s a bit of a learning curve involved with it, you'd have to learn to get arund in the Godot editor, and I cannot provide support for it.

However, here is a video showing how simple it is to get started, if you're technically inclined:

{% include video id="PSlo6nRRmZM" provider="youtube" %}

Anyone really should use the tools they're comfy with, and if you have found a tool that works for you, more power to you!

---

If you want to learn more, check out:
- the [GitHub project](https://github.com/renerocksai/bullets)
- the [demo presentation](https://renerocksai.github.io/bullets/bullets.html) featuring a 2D platformer game slide 
- or the [presentation](https://renerocksai.github.io/rrisc/bullets) I prepared for a talk on my [RRISC CPU](/projects/rrisc)! 
    - BTW [this](https://renerocksai.github.io/rrisc/rrisc_cpu_slides.pdf) is the PDF output of that presentation.
- An introductory [video tutorial](https://www.youtube.com/watch?v=PSlo6nRRmZM)
- A video of [multiplayer mode in action](https://www.youtube.com/watch?v=PSlo6nRRmZM)



