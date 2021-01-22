# Deep Learning for Survival Analysis in Credit Risk Modelling: A Benchmark Study
> This repository contains the python implementation for the expirment part in the master thesis, and also the datasets the has been used, for replication purposes. 

## Table of contents
* [Abstract](#abstract)
* [Screenshots](#screenshots)
* [Technologies](#technologies)
* [Setup](#setup)
* [Features](#features)
* [Status](#status)
* [Inspiration](#inspiration)
* [Contact](#contact)

## Abstract
Survival analysis is a hotspot in statistical research for modelling time-to-event information
with data censorship handling, which has been widely used in many applications such as
clinical research, information system and other fields with survivorship bias. Many works
have been proposed for survival analysis ranging from traditional statistic methods to machine
learning and deep learning methods. This paper examines novel deep learning techniques for
survival analysis in credit risk modelling context. After surveying through literature for deep
learning survival analysis models in various domains and categorizing them, we evaluate the
adequacy of six different models representing different categories, using two datasets of US
mortgages from separate sources. The performance of these models is evaluated using the
discrimination metric, concordance index.

## Requirements
The following package versions have been used to develop this work.
```
python 3.7.9
lifelines==0.25.4
pandas==1.1.4
pycox==0.2.1
scikit-learn==0.24.1
torch==1.7.0
matplotlib==3.3.3

DATE and Deephit:
tensorflow==1.15.0

DRSA: 
tensorflow==2.0.0
```
## Data
- [M1 (U.S mortgage data provided by International Financial Research)](http://www.internationalfinancialresearch.org)
- M2 (single-family US mortgage loans colected by Blumenstock et al., 2020 <a href="#references">[1]</a>).

## Technologies
* Tech 1 - version 1.0
* Tech 2 - version 2.0
* Tech 3 - version 3.0


## Technologies
* Tech 1 - version 1.0
* Tech 2 - version 2.0
* Tech 3 - version 3.0

## Setup
Describe how to install / setup your local environement / add link to demo version.

## Code Examples
Show examples of usage:
`put-your-code-here`

## Features
List of features ready and TODOs for future development
* Awesome feature 1
* Awesome feature 2
* Awesome feature 3

To-do list:
* Wow improvement to be done 1
* Wow improvement to be done 2

## Status
Project is: _in progress_, _finished_, _no longer continue_ and why?

## Inspiration
Add here credits. Project inspired by..., based on...

## Contact
Created by [@flynerdpl](https://www.flynerd.pl/) - feel free to contact me!

## References
  \[1\] Gabriel Blumenstock, Stefan Lessmann & Hsin-Vonn Seow (2020). Deep learning for survival and competing
risk modelling. *Journal of the Operational Research Society*.  \[[paper](https://doi.org/10.1080/01605682.2020.1838960)\]

  \[2\] Håvard Kvamme, Ørnulf Borgan, and Ida Scheel. Time-to-event prediction with neural networks and Cox regression. *Journal of Machine Learning Research*, 20(129):1–30, 2019. \[[paper](http://jmlr.org/papers/v20/18-424.html)\]

  \[3\] Jared L. Katzman, Uri Shaham, Alexander Cloninger, Jonathan Bates, Tingting Jiang, and Yuval Kluger. Deepsurv: personalized treatment recommender system using a Cox proportional hazards deep neural network. *BMC Medical Research Methodology*, 18(1), 2018. \[[paper](https://doi.org/10.1186/s12874-018-0482-1)\]
