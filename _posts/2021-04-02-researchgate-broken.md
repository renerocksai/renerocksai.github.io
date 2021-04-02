---
title: "ResearchGate Citation Downloads considered Broken"
permalink: /blog/researchgate-broken
categories:
  - Articles
  - Blog
tags:
  - research
  - citations
classes: wide
---

Thanks to their SEO, [ResearchGate](https://researchgate.net) articles top my search results when searching for specific scientific papers. Reference and citation managers like [Zotero](https://www.zotero.org) happily use the _citation download_ feature of sites like ResearchGate, to automatically pull citation information for later use in publications.

However, this comes with a caveat: what if the citation information on ResearchGate is wrong or incomplete?

This happened to me just a few hours ago: our working student, [Sophia](https://www.linkedin.com/in/sophia-baier-b01a641ba/), had been putting the final touches on our paper - and I reviewed it. It's not the first time I checked her draft. Still, this time, almost by accident, I stumbled over an entry in the references section that drew my attention: it was published on pages 153-168 in volume 17 of May 2016.

"But what journal?" I asked myself. And why is this information missing anyway? Who tampered with the _BibTex_ file? I went down a rabbit hole in the investigation that followed - until I found: it's Zotero! No, **it's ResearchGate**!

For some strange reasons, the _"Download Citation"_ feature of ResearchGate seems to be broken. 

**Note to self:** **ALWAYS**, and **CAREFULLY** check the references section! 😊

# Examples from the paper at hand
I investigated the incorrect citations in our paper and always found the root cause in incomplete citation information provided by ResearchGate's "Download Citation" feature. Here are the first two examples, right from our references section:

## Example 1

Following the [ResearchGate Citation Download Link](https://www.researchgate.net/publication/304929591_The_impact_of_presentation_mode_and_product_type_on_online_impulse_buying_decisions/citation/download), we get this:

```bibtex
@article{article,
author = {Liao, C. and To, P.-L and Wong, Y.-C and Palvia, P. and Kakhki, M.D.},
year = {2016},
month = {05},
pages = {153-168},
title = {The impact of presentation mode and product type on online impulse buying decisions},
volume = {17}
}
```

After some googling around, I found the missing information:

```bibtex
	journal={Journal of Electronic Research},
```

## Example 2
Here, the [ResearchGate Citation Download Link](https://www.researchgate.net/publication/228808592_The_effects_of_emotion_of_voice_in_synthesized_and_recorded_speech/citation/download) leads to this:

```bibtex
@article{article,
author = {Nass, Clifford and Foehr, Ulla and Somoza, Michael},
year = {2001},
month = {01},
pages = {},
title = {The effects of emotion of voice in synthesized and recorded speech}
}
```

The exact name of the _booktitle_ was a bit harder to come by, but eventually, thanks to Google, I managed to find it:

```bibtex
booktitle = { {AAAI} symposium emotional and intelligent II: the tangled knot of social cognition},
```

# Even our own papers!
I started to wonder: what if this is a systematic error? Would it even apply to our papers? So I went to my ResearchGate page (that I hadn't touched in ages) and looked at "my" list of publications, containing the papers I co-authored.

I was shocked to find out that they all featured the same bug.

## Paper 1
First comes _Image Captioning with Clause-Focused Metrics in a Multi-modal Setting for Marketing_. When you follow the [ResearchGate Citation Download Link](https://www.researchgate.net/publication/332681699_Image_Captioning_with_Clause-Focused_Metrics_in_a_Multi-modal_Setting_for_Marketing/citation/download), you get this:

```bibtex
@inproceedings{inproceedings,
author = {Harzig, Philipp and Zecha, Dan and Lienhart, Rainer and Kaiser, Carolin and Schallner, Rene},
year = {2019},
month = {03},
pages = {419-424},
title = {Image Captioning with Clause-Focused Metrics in a Multi-modal Setting for Marketing},
doi = {10.1109/MIPR.2019.00085}
}
```

**The `booktitle=` is missing**.

If you follow the DOI, you will get to [IEEE Xplore](https://ieeexplore.ieee.org/document/8695365) where the "Cite This" button actually works:

```bibtex
@INPROCEEDINGS{8695365,
author={P. {Harzig} and D. {Zecha} and R. {Lienhart} and C. {Kaiser} and R. {Schallner}},  
booktitle={2019 IEEE Conference on Multimedia Information Processing and Retrieval (MIPR)},   
title={Image Captioning with Clause-Focused Metrics in a Multi-modal Setting for Marketing},   
year={2019},  
volume={},  
number={},  
pages={419-424},  
doi={10.1109/MIPR.2019.00085}
}
```

## Paper 2
Next, we check out _Multimodal Image Captioning for Marketing Analysis_ with the
[ResearchGate Citation Download Link](https://www.researchgate.net/publication/326047558_Multimodal_Image_Captioning_for_Marketing_Analysis/citation/download):

```bibtex
@inproceedings{inproceedings,
author = {Harzig, Philipp and Brehm, Stephan and Lienhart, Rainer and Kaiser, Carolin and Schallner, Rene},
year = {2018},
month = {04},
pages = {158-161},
title = {Multimodal Image Captioning for Marketing Analysis},
doi = {10.1109/MIPR.2018.00035}
}
```

**The `booktitle=` is missing**.

Again, [IEEE Xplore](https://ieeexplore.ieee.org/document/8396991) works:

```bibtex
@INPROCEEDINGS{8396991,  
author={P. {Harzig} and S. {Brehm} and R. {Lienhart} and C. {Kaiser} and R. {Schallner}},  
booktitle={2018 IEEE Conference on Multimedia Information Processing and Retrieval (MIPR)},   
title={Multimodal Image Captioning for Marketing Analysis},   
year={2018},  
volume={},  
number={},  
pages={158-161},  
doi={10.1109/MIPR.2018.00035}
}
```

## Paper 3
Last, we check _Visual and Textual Sentiment Analysis of Brand-Related Social Media Pictures Using Deep Convolutional Neural Networks_, with the 
[ResearchGate Citation Download Link](https://www.researchgate.net/publication/320361270_Visual_and_Textual_Sentiment_Analysis_of_Brand-Related_Social_Media_Pictures_Using_Deep_Convolutional_Neural_Networks/citation/download):

```bibtex
@inproceedings{inproceedings,
author = {Paolanti, Marina and Kaiser, Carolin and Schallner, Rene and Frontoni, Emanuele and Zingaretti, Primo},
year = {2017},
month = {10},
pages = {402-413},
title = {Visual and Textual Sentiment Analysis of Brand-Related Social Media Pictures Using Deep Convolutional Neural Networks},
isbn = {978-3-319-68559-5},
doi = {10.1007/978-3-319-68560-1_36}
}
```

**The `booktitle=` is missing**.

Following the DOI and clicking on [cite as](https://link.springer.com/chapter/10.1007%2F978-3-319-68560-1_36#citeas), gives us the complete information:

> Cite this paper as:
> 
> Paolanti M., Kaiser C., Schallner R., Frontoni E., Zingaretti P. (2017) Visual and Textual Sentiment Analysis of Brand-Related Social Media Pictures Using Deep Convolutional Neural Networks. In: Battiato S., Gallo G., Schettini R., Stanco F. (eds) Image Analysis and Processing - ICIAP 2017. ICIAP 2017. Lecture Notes in Computer Science, vol 10484. Springer, Cham. https://doi.org/10.1007/978-3-319-68560-1\_36

# The Exception
Curious about how widespread the issue is, I went on. I had a look at the publications (on ResearchGate) of my colleague, [Carolin Kaiser](https://www.nim.org/en/about-us/team/dr-carolin-kaiser), who has published far more than I have.

The first hit is the paper _"Social media monitoring: What can marketers learn from Facebook brand photos?"_ published in the _Journal of Business Research_.

Here, the [ResearchGate Citation Download](https://www.researchgate.net/publication/335808395_Social_media_monitoring_What_can_marketers_learn_from_Facebook_brand_photos/citation/download) works:

```bibtex
@article{article,
author = {Kaiser, Carolin and Ahuvia, Aaron and Rauschnabel, Philipp and Wimble, Matt},
year = {2019},
month = {09},
pages = {},
title = {Social media monitoring: What can marketers learn from Facebook brand photos?},
volume = {117},
journal = {Journal of Business Research},
doi = {10.1016/j.jbusres.2019.09.017}
}
```

# The Exception to the Exception
So I checked out another paper of hers _"Visual eWOM: Are Facebook Brand Photos a Sign of Brand Love?"_ from the _2016 AMA Summer Marketing Educators' Conference in Atlanta, GA_, which comes next in line on ResearchGate, when we skip the already mentioned ones.

Using the [ResearchGate Citation Download](https://www.researchgate.net/publication/303310227_Visual_eWOM_Are_Facebook_Brand_Photos_a_Sign_of_Brand_Love/citation/download)

```bibtex
@inproceedings{inproceedings,
author = {Kaiser, Carolin and Ahuvia, Aaron and Rauschnabel, Philipp and Wimble, Matt},
year = {2016},
month = {08},
pages = {},
title = {Visual eWOM: Are Facebook Brand Photos a Sign of Brand Love?}
}
```

shows the same deficiency as my other examples:

**The `booktitle=` is missing**.

# Conclusion
Something on ResearchGate is seriously broken. Some of the papers with missing citation information **even show the conference or journal** on the ResearchGate page [like in our paper 1 example](https://www.researchgate.net/publication/332681699_Image_Captioning_with_Clause-Focused_Metrics_in_a_Multi-modal_Setting_for_Marketing):

{% include figure image_path="/assets/images/2021-04-02_13-34-broken-researchgate.png" caption="Image (c) ResearchGate" %}

However, this information does not seem to make it into the downloadable citations easily. I don't know if this is caused by an error in their extraction method when generating citation records, as I have no clue how ResearchGate produces the citations.

However, it is essential to know that ResearchGate citations are not trustworthy. Suppose you use them and don't check the references section in your paper. In that case, the quality of this section and with it the overall quality of your essay might suffer unnecessarily.

What are your experiences? Are you affected by this, too? Let me know on [Twitter](https://twitter.com/renerocksai).




