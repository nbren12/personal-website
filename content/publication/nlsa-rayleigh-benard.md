+++
publication_types = ["2"]
abstract_short = ""
publication_short = "JCP"
publication = "Journal of Computational Physics"
authors = ["Noah D. Brenowitz", "Dimitris Giannakis", "Andrew J.Majda"]
title = "Nonlinear Laplacian spectral analysis of Rayleigh–Benard convection"
url_project = ""
image_preview = ""
url_pdf = ""
image = ""
highlight = true
math = false
date = "2016-06-15"
url_video = ""
selected = false
url_dataset = ""
url_code = ""
abstract = ""
url_slides = ""

[[url_custom]]
    name = "Link"
    url = "http://dx.doi.org/10.1016/j.jcp.2016.03.051"

+++

The analysis of physical datasets using modern methods developed in machine learning presents unique challenges and opportunities. These datasets typically feature many degrees of freedom, which tends to increase the computational cost of statistical methods and complicate interpretation. In addition, physical systems frequently exhibit a high degree of symmetry that should be exploited by any data analysis technique. The classic problem of Rayleigh Benárd convection in a periodic domain is an example of such a physical system with trivial symmetries. This article presents a technique for analyzing the time variability of numerical simulations of two-dimensional Rayleigh–Bénard convection at large aspect ratio and intermediate Rayleigh number. The simulated dynamics are highly unsteady and consist of several convective rolls that are distributed across the domain and oscillate with a preferred frequency. Intermittent extreme events in the net heat transfer, as quantified by the time-weighted probability distribution function of the Nusselt number, are a hallmark of these simulations. 

Nonlinear Laplacian Spectral Analysis (NLSA) is a data-driven method which is ideally suited for the study of such highly nonlinear and intermittent dynamics, but the trivial symmetries of the Rayleigh–Bénard problem such as horizontal shift-invariance can mask the interesting dynamics. To overcome this issue, the vertical velocity is averaged over parcels of similar temperature and height, which substantially compresses the size of the dataset and removes trivial horizontal symmetries. This isothermally averaged dataset, which is shown to preserve the net convective heat-flux across horizontal surfaces, is then used as an input to NLSA. The analysis generates a small number of orthogonal modes which describe the spatiotemporal variability of the heat transfer. A regression analysis shows that the extreme events of the net heat transfer are primarily associated with a family of modes with fat tailed probability distributions and low frequency temporal power spectra. On the other hand, the regular oscillation of the heat transfer is associated with a pair of modes with nearly uniform probability distributions. Physical mechanisms for the regular oscillation and the extreme heat transfer events are hypothesized based on an analysis of the spatio-temporal structure of these modes. Finally, proposals are made for this approach to be applied to the study of other problems in turbulent convection, including three-dimensional Rayleigh–Bénard convection and moist atmospheric convection.
