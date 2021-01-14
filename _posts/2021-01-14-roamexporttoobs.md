---
title: "Converting Roam Research JSON export to Markdown, preserving block references"
categories:
  - Blog
tags:
  - roamresearch
  - obsidian
  - zettelkasten
classes: wide
---

Last night I decided to ditch [Roam Research](https://roamresearch.com) and switch my notes over to [Obsidian](https://obsidian.md). 

My main reasons were:

- I don't want my notes to be locked in a corporate database anymore.
- I don't like how terribly slow Roam is, especially at startup. 30 seconds are not uncommon.
- On my mobile, "quick capture" - which only ever could be perceived as quick if one is used to waiting for over 30s for roam to load - is broken: instead, the main roam page wants to load, giving me the forever-spinning logo while loading. It's really become unbearable.
- Many of Roam's features are available via commands in curly braces that are super proprietary. I didn't want to become locked in. Plain text and Markdown are futureproof.

Having created [Sublimeless_ZK](/projects/sublimeless_zk), the whole idea of a plain Markdown Zettelkasten (think: note archive if unfamiliar) has always been quite important to me - which I had to give up to give Roam Research a try. It feels good, having back control over my notes again.

Switching to Obsidian was quite pain free. Its Markdown converter can even convert many of Roam's specialities like todos, etc.

However, one really crucial thing is not contained in Roam's Markdown export: Block references. Links to specific blocks. In Roam, you can mention a block in a different document, embed it, or just link to it. In Obsidian, you can basically embed and link to it - using just Markdown, which is both extremely cool and more than I need.

The syntax used by Obsidian is remarkably clever and simple. Check this out:

```markdown
- this is an ordinary block in some list
- and this one is postfixed with a small id    ^the-block-id 

Now, when I want to reference this block, I just reference it like this [[#^the-block-id]].

If it were in a diferent file, I'd write [[otherfile#^the-block-id]].

Of course, embedding works, too:
![[otherfile#^the-block-id]]   -- note the !
```

Unfortunately, Roam's Markdown export does not contain enough metadata to reconstruct block references. However, its JSON export does.

So, to cut a long story short, last night I created [rj2obs](/projects/rj2obs). It takes Roam's JSON export and converts it into a directory of markdown notes. 

It mainly postfixes blocks that are referenced anywhere else with their Roam block id - and anywhere a block is referenced, it is copied from its originating page, with an appended link back to the original block. This gives you the best of both worlds: You can read the block in Markdown instead of seeing just a link, but you also see that the block originated somewhere else - and in preview mode, you can hover over the link to see the original paragrah in a pop-up.

Here is an example:

Originating file:

```markdown
- This is a typical roam list
- This line gets referenced   ^roam-block-id
```

Some other file:

```markdown
I am playing with block references.

- This line gets referenced  [[originating_file#^roam-block-id]]
```

On top of that, my converter does a few additional nifty things, for example renaming daily note files to ISO formatted dates (YYYY-MM-DD) for easier sorting, etc.

For more information, check it out on [GitHub](https://github.com/renerocksai/rj2obs).
