---
layout: splash
permalink: /
hidden: true
title: "@renerocksai"
header:
  overlay_color: "#5e616c"
  overlay_image: /assets/images/glasses1.png
#  caption: some caption
excerpt: "Ramblings about Science & Technology"
# intro: 
#   - excerpt: ''
author_profile: true
---
<!-- {% include feature_row id="intro" type="center" %} -->

# Hello, world!
Hi, my name is Rene Schallner. 

<p>You can read <b><a href="/about" style="color:#cd0f2d">more about me here</a></b>. See also <b><a href="/blog" style="color:#cd0f2d;">my blog</a></b>. Or <b><a href="/projects" style="color:#cd0f2d">check out my projects</a></b>.</p>  

<div class="text-center text-small page__footer-follow"> <ul class="social-icons"> {% if site.data.ui-text[site.locale].follow_label %} <li><strong>{{ site.data.ui-text[site.locale].follow_label }}</strong></li> {% endif %} {% if site.footer.links %} {% for link in site.footer.links %} {% if link.label and link.url %} <li><a href="{{ link.url }}" rel="nofollow noopener noreferrer"><i class="{{ link.icon | default: 'fas fa-link' }}" aria-hidden="true"></i> {{ link.label }}</a></li> {% endif %} {% endfor %} {% endif %} <li><a href="{% if site.atom_feed.path %}{{ site.atom_feed.path }}{% else %}{{ '/feed.xml' | relative_url }}{% endif %}"><i class="fas fa-fw fa-rss-square" aria-hidden="true"></i> {{ site.data.ui-text[site.locale].feed_label | default: "Feed" }}</a></li> </ul> </div>

---

# Selected Articles

- [Why and how I created my own presentation software](/blog/why-bullets)
- [How a CPU works](/blog/y-how-cpu-works)

---

# Selected Projects
- [My handmade RRISC CPU](/projects/rrisc)
- [My mobile computer vision logo detection glasses](/projects/brille)
- [Bûllets - my own slideshow presentation software with multi-player support](/projects/bullets)
- [0xeefe - easy encryption for everyone](/projects/0xeefe)

--- 

# Selected Topics

## CPUs, microprocessors
- [How a CPU works](/blog/y-how-cpu-works)
- [My handmade RRISC CPU](/projects/rrisc)

## Write your own software 
- [Why and how I created my own presentation software](/blog/why-bullets)
- [Bûllets - my own slideshow presentation software with multi-player support](/projects/bullets)
- [Sublimeless_ZK - my Zettelkasten software](/projects/sublimeless_zk)
- [0xeefe - easy encryption for everyone](/projects/0xeefe)

## Digital Zettelkasten
- [Why I switched from Roam Research to Obsidian](/blog/why-obsidian)
- [Converting Roam Research JSON export to Markdown, preserving block references](/blog/roamexporttoobs/)
- [Syncing your Obsidian vault to Android via an encrypted GitHub repository](/blog/obsidian-encrypted-github-android)
- [Sublimeless_ZK - my Zettelkasten software](/projects/sublimeless_zk)
- [Sublime_ZK - my SublimeText Zettelkasten plugin](/projects/sublime_zk)

