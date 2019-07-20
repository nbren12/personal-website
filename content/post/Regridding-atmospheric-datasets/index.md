+++
date = "2017-03-09T11:51:28-05:00"
title = "Regridding atmospheric datasets"
highlight = true
math = false

tags = []

+++

I am currently working with model output from the cloud-resolving model SAM. The full-resolution datasets are often too-large to load into memory because I have over 16000 horizontal grid points, and it is more convenient to work with coarse-grained data. While, I can just boot up python and manually averaged the data, this is pretty unwieldy and there are many packages which already do this.

[This article](https://climatedataguide.ucar.edu/climate-data-tools-and-analysis/regridding-overview) contains a nice overview of the different kinds of regridding methods. For the coarse-graining method, so-called conservative mapping is probably what I want. That article does not list any specific software packages however, but it looks like NCL, CDO, ESMFpy, and SCRIP are well known in the field for regridding.

However, conservative remapping may not be good enough for my purposes if it only "conserves" first moments. I need a coarse-graining/remapping scheme which is a projection operator, which conserves second moments like kinetic energy or eddy flux quantities. As, I have discussed in previous posts, regression splines are natural projection based smoothing operation. For linear and higher polynomial order splines, the regression operation requires a global pseudoinverse calculation, which can be very expensive in theory.

## A potential interface for spline-based coarse graining

A convenient way to implement this coarsening operation is probably through an sklearn like interface in the following way:

```python 
spl = Spline(knots, dim, order=3, bc='periodic')

# needs an xarray dataarray A
spl.fit(A)

# saving spline object to disk and loading from disk
spl.save("spline.nc")
spl = Spline.from_disk("spline.nc")

# outputs a datarray
B = spl.predict(x, derivative=0)
```

I ended up making a similar interface in my grab-bag github
repo [gnl](https://github.com/nbren12/gnl/blob/master/gnl/xspline.py). Check it
out!

