---
# Documentation: https://wowchemy.com/docs/managing-content/

title: Correcting a 200 km resolution climate model in multiple climates by machine
  learning from 25 km resolution simulations
subtitle: ''
summary: ''
authors:
- Spencer K Clark
- Noah D Brenowitz
- Brian Henn
- Anna Kwa
- Jeremy McGibbon
- W Andre Perkins
- Oliver Watt-Meyer
- Christopher S Bretherton
- Lucas M Harris
tags: []
categories: []
date: '2022-09-01'
lastmod: 2022-10-07T00:25:04-07:00
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
publishDate: '2022-10-07T07:25:04.019339Z'
publication_types:
- '2'
abstract: Bretherton et al. (2022, https://doi.org/10.1029/2021MS002794)
  demonstrated a successful approach for using machine learning (ML) to help a coarse-resolution
  global atmosphere model with real geography (a ?200 km version of NOAA's FV3GFS)
  evolve more like a fine-resolution model, at the scales resolved by both. This study
  extends that work for application in multiple climates and multi-year ML-corrected
  simulations. Here four fine-resolution (25 km) 2 year reference simulations are
  run using FV3GFS with climatological sea surface temperatures perturbed uniformly
  by -4, 0, +4, and +8 K. A data set of state-dependent corrective tendencies is then
  derived through nudging the ?200 km model to the coarsened state of the fine-resolution
  simulations in each climate. Along with the surface radiative fluxes, the corrective
  tendencies of temperature and specific humidity are machine-learned as functions
  of the column state. ML predictions for the fluxes and corrective tendencies are
  applied in 5.25 years ?200 km resolution simulations in each climate, and improve
  the spatial pattern errors of land precipitation by 8%-28% and land surface temperature
  by 19%?25% across the four climates. The ML has a neutral impact on the pattern
  error of oceanic precipitation.
publication: '*J. Adv. Model. Earth Syst.*'
doi: 10.1029/2022ms003219
---
