---
# Documentation: https://wowchemy.com/docs/managing-content/

title: Correcting coarse‐grid weather and climate models by machine learning from
  global storm‐resolving simulations
subtitle: ''
summary: ''
authors:
- Christopher S Bretherton
- Brian Henn
- Anna Kwa
- Noah D Brenowitz
- Oliver Watt-Meyer
- Jeremy McGibbon
- W Andre Perkins
- Spencer K Clark
- Lucas Harris
tags: []
categories: []
date: '2022-02-01'
lastmod: 2022-10-07T00:25:05-07:00
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ''
  focal_point: ''
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
publishDate: '2022-10-07T07:25:05.029782Z'
publication_types:
- '2'
abstract: Global atmospheric ?storm-resolving? models with horizontal grid
  spacing of less than 5 km resolve deep cumulus convection and flow in complex terrain.
  They promise to be reference models that could be used to improve computationally
  affordable coarse-grid global climate models across a range of climates, reducing
  uncertainties in regional precipitation and temperature trends. Here, machine learning
  of nudging tendencies as functions of column state is used to correct the physical
  parameterization tendencies of temperature, humidity, and optionally winds, in a
  real-geography coarse-grid model (FV3GFS with a 200 km grid) to be closer to those
  of a 40-day reference simulation using X-SHiELD, a modified version of FV3GFS with
  a 3 km grid. Both simulations specify the same historical sea-surface temperature
  fields. This methodology builds on a prior study using a global observational analysis
  as the reference. The coarse-grid model without machine learning corrections has
  too few clouds, causing too much daytime heating of land surfaces that creates excessive
  surface latent heat flux and rainfall. This bias is avoided by learning downwelling
  radiative flux from the fine-grid model. The best configuration uses learned nudging
  tendencies for temperature and humidity but not winds. Neural nets slightly outperform
  random forests. Forecasts of 850 hPa temperature gain 18 hr of skill at 3?7 days
  leads and time-mean precipitation patterns are improved 30% by applying the ML correction.
  Adding machine-learned wind tendencies improves 500 hPa height skill for the first
  five days of forecasts but degrades time-mean upper tropospheric temperature and
  zonal wind patterns thereafter.
publication: '*J. Adv. Model. Earth Syst.*'
doi: 10.1029/2021ms002794
---
