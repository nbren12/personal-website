---
# Documentation: https://wowchemy.com/docs/managing-content/

title: Correcting weather and climate models by machine learning nudged historical
  simulations
subtitle: ''
summary: ''
authors:
- Oliver Watt-Meyer
- Noah D Brenowitz
- Spencer K Clark
- Brian Henn
- Anna Kwa
- Jeremy McGibbon
- W Andre Perkins
- Christopher S Bretherton
tags: []
categories: []
date: '2021-08-01'
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
publishDate: '2022-10-07T07:25:05.156589Z'
publication_types:
- '2'
abstract: Due to limited resolution and inaccurate physical parameterizations,
  weather and climate models consistently develop biases compared to the observed
  atmosphere. Using the FV3GFS model at coarse resolution, we propose a method of
  machine learning corrective tendencies from a hindcast simulation nudged toward
  observational analysis. We show that a random forest can predict the nudging tendencies
  from this hindcast simulation with moderate skill using only the model state as
  input. This random forest is then coupled to FV3GFS, adding corrective tendencies
  of temperature, specific humidity and horizontal winds at each timestep. The coupled
  model shows no signs of instability in year-long simulations and has significant
  reductions in short-term forecast error for 500 hPa height, surface pressure and
  near-surface temperature. Furthermore, the root mean square error of the annual-mean
  precipitation is reduced by about 20%. Biases of other variables remain similar
  or in some cases, like upper-atmospheric temperature, increase in the year-long
  simulations.
publication: '*Geophys. Res. Lett.*'
doi: 10.1029/2021gl092555
---
