<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#org9ed0e65">1. INBOX</a>
<ul>
<li><a href="#orgfb7b4b3">1.1. Boxlib</a>
<ul>
<li><a href="#orgf9df756">1.1.1. Boxlib iteration over MultiFabs</a></li>
</ul>
</li>
<li><a href="#orgaca9cb2">1.2. combining images into a grid</a></li>
<li><a href="#orgdfd37b2">1.3. MPI run scripts</a>
<ul>
<li><a href="#orgf3949be">1.3.1. mvapich and hdf5  with mpi4py</a></li>
</ul>
</li>
<li><a href="#orge96a0e5">1.4. anaconda and fish shell</a></li>
<li><a href="#org060286f">1.5. dotfile management using git</a>
<ul>
<li><a href="#org29e9906">1.5.1. magit compatibility</a></li>
</ul>
</li>
<li><a href="#org29ef117">1.6. common error message in org-mode</a></li>
</ul>
</li>
<li><a href="#org5e3d58f">2. Installation</a>
<ul>
<li><a href="#org0c5d0c5">2.1. Dedalus</a>
<ul>
<li><a href="#org6f8de48">2.1.1. Install dedalus on hpc</a></li>
<li><a href="#org1f2a079">2.1.2. Installing dedalus on cims linux desktop&#xa0;&#xa0;&#xa0;<span class="tag"><span class="broken">broken</span></span></a></li>
<li><a href="#org136cec2">2.1.3. dedalus on macbook</a></li>
</ul>
</li>
<li><a href="#org489ebab">2.2. mpi4py on mac</a></li>
<li><a href="#org4e9c1e4">2.3. Install NCL on macbook</a></li>
<li><a href="#orga242c32">2.4. Openmpi/PETSc on mac&#xa0;&#xa0;&#xa0;<span class="tag"><span class="working">working</span></span></a></li>
<li><a href="#org37faba4">2.5. Chombo</a></li>
<li><a href="#orgf09dc5e">2.6. Vagrant</a>
<ul>
<li><a href="#orge40ff81">2.6.1. Update <span class="timestamp-wrapper"><span class="timestamp">[2016-11-29 Tue]</span></span></a></li>
</ul>
</li>
</ul>
</li>
<li><a href="#org020f7e4">3. Zotero</a>
<ul>
<li><a href="#org6b205f3">3.1. zotfile settings</a></li>
<li><a href="#org41dbcf5">3.2. Remove orphaned zotfiles</a></li>
</ul>
</li>
<li><a href="#org709e256">4. Emacs</a>
<ul>
<li><a href="#org67f8ddf">4.1. add company backend for given mode</a></li>
<li><a href="#org1515af7">4.2. RTAGS</a></li>
<li><a href="#org028dffc">4.3. Org mode stuff</a>
<ul>
<li><a href="#orgaee6171">4.3.1. ipython</a></li>
<li><a href="#org4831b72">4.3.2. debug errors using org-lint</a></li>
</ul>
</li>
<li><a href="#org985baad">4.4. beamer slide titles in reftex toc</a></li>
</ul>
</li>
<li><a href="#orgb8558b7">5. Git</a>
<ul>
<li><a href="#orgbacf14f">5.1. Delete remote branch</a></li>
<li><a href="#orgda246a5">5.2. git subtree</a>
<ul>
<li><a href="#org40a83a4">5.2.1. Troubleshooting</a></li>
</ul>
</li>
</ul>
</li>
<li><a href="#org0f7c681">6. Python</a>
<ul>
<li><a href="#org16e37ab">6.1. Numpy/scipy</a>
<ul>
<li><a href="#org4cdb0fd">6.1.1. scipy.ndimage.correlate1d</a></li>
</ul>
</li>
<li><a href="#org307d244">6.2. Jupyter notebook incorrect executable</a></li>
<li><a href="#org661881a">6.3. Documenting python</a></li>
<li><a href="#org14efb08">6.4. testing python</a></li>
</ul>
</li>
<li><a href="#orge6a20c6">7. LaTeX</a>
<ul>
<li><a href="#orgc08bfbf">7.1. left justified captions</a></li>
<li><a href="#org88097a1">7.2. Float barrier before sections</a></li>
<li><a href="#org42bf566">7.3. Print page dimensions for making figures</a></li>
</ul>
</li>
<li><a href="#org927297f">8. Julia</a>
<ul>
<li><a href="#org1df7fe6">8.1. change package path</a></li>
<li><a href="#org2a57b71">8.2. Adding packages</a></li>
</ul>
</li>
<li><a href="#org9e66f1e">9. Fortran</a>
<ul>
<li><a href="#org1b0af05">9.1. Installing and using coarrays</a>
<ul>
<li><a href="#orgdb95857">9.1.1. Gfortran</a></li>
<li><a href="#orgf4f54d5">9.1.2. Intel</a></li>
</ul>
</li>
<li><a href="#orgbeae4df">9.2. Calling Fortran using CFFI</a></li>
<li><a href="#orgd13afbd">9.3. Fortran</a>
<ul>
<li><a href="#orgf8e02cd">9.3.1. Converting fixed source fortran to free</a></li>
</ul>
</li>
</ul>
</li>
<li><a href="#org9e4b268">10. Unix</a>
<ul>
<li><a href="#org80d6a2f">10.1. tar</a>
<ul>
<li><a href="#org9f97147">10.1.1. make tarball following symlink</a></li>
</ul>
</li>
<li><a href="#orgaab9e8e">10.2. Type 3 Fonts</a></li>
</ul>
</li>
<li><a href="#orga4448f6">11. Vignettes</a>
<ul>
<li><a href="#org40efd0c">11.1. TRMM</a>
<ul>
<li><a href="#org8022b23">11.1.1. TRMM Python</a></li>
</ul>
</li>
<li><a href="#org7c6da86">11.2. Automatic differentiation</a>
<ul>
<li><a href="#org764f8c3">11.2.1. Approaches</a></li>
<li><a href="#orgd760185">11.2.2. Sources</a></li>
</ul>
</li>
</ul>
</li>
<li><a href="#org865c85f">12. Refs</a></li>
</ul>
</div>
</div>
This is a root file for howto type things


<a id="org9ed0e65"></a>

# INBOX


<a id="orgfb7b4b3"></a>

## Boxlib


<a id="orgf9df756"></a>

### Boxlib iteration over MultiFabs

    void runScalarAdvection(GalerkinBoussinesq& solver) {
          solver.state.u.setVal(1.0);
          solver.state.v.setVal(1.0);
          solver.fillBoundaries();
    
    
          for (MFIter mfi(solver.state.u); mfi.isValid(); ++mfi){
              // X staggered variables have one more point in the x direction
              // const Box &tbx = mfi.growntilebox(); // This is the ghosted box
              const Box &tbx = mfi.growntilebox(); // This is the ghosted box
              const Box&  bx = mfi.validbox(); // This is the nonghosted box
    
              std::cout << "Valid Box Low/hi " << bx.loVect()[0] << " " << bx.hiVect()[0] << std::endl;
              std::cout << "Tile Box Low/hi " << tbx.loVect()[0] << " " << tbx.hiVect()[0] << std::endl;
          }
    
    
      }


<a id="orgaca9cb2"></a>

## combining images into a grid

    montage  -geometry x300  -tile 3x3 squall/*.png  squall.png


<a id="orgdfd37b2"></a>

## MPI run scripts


<a id="orgf3949be"></a>

### mvapich and hdf5  with mpi4py

    #!/bin/bash
    #PBS -N dedalus
    #PBS -l nodes=8:ppn=1,walltime=4:00:00
    
    module purge
    module load fftw/mvapich2/intel/3.3.4
    module load hdf5/intel/1.8.12
    source ~/py3k/bin/activate
    
    mpirun -np 4 python ~/dedalus/examples/ivp/2d_rayleigh_benard/rayleigh_benard.py


<a id="orge96a0e5"></a>

## anaconda and fish shell

Entered on <span class="timestamp-wrapper"><span class="timestamp">[2016-12-23 Fri 21:13]</span></span>

<file:///home/noah/.config/fish/config.fish>

Need to source the anaconda fish script, and add the anaconda binary dir to the
path:

    . ~/anaconda3/etc/fish/conf.d/conda.fish
    
    set -gx PATH /Users/noah/anaconda3/bin /usr/local/texlive/2014/bin/x86_64-darwin /Applications/Julia-0.5.app/Contents/Resources/julia/bin /Applications/Emacs.app//Contents/MacOS/bin $PATH

Then use

    conda activate ...

to activate environments.


<a id="org060286f"></a>

## dotfile management using git

<https://news.ycombinator.com/item?id=11070797>

I currently have the following aliases

    alias config='/usr/bin/env git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
    alias con='config'


<a id="org29e9906"></a>

### magit compatibility

I asked a question on emacs.stackexchange.com.


<a id="org29ef117"></a>

## common error message in org-mode

    org-babel-exp-process-buffer: Wrong type argument: stringp, nil


<a id="org5e3d58f"></a>

# Installation


<a id="org0c5d0c5"></a>

## Dedalus


<a id="org6f8de48"></a>

### Install dedalus on hpc

Use mvapich2 for mpi4py and fftw.

    module purge
    module load fftw/mvapich2/intel/3.3.4
    
    CC=mpicc CXX=mpicxx FFTW_PATH=$FFTW_ROOT MPI_PATH=$MPI_ROOT python setup.py build_ext --inplace


<a id="org1f2a079"></a>

### Installing dedalus on cims linux desktop     :broken:

This is a complicated processs because of the mpi dependency, and because it
needs an older version of mpi4py.

Use these modules

    module load fftw-3.3.4
    module load openmpi-intel
    module load intel
    
    export LD_LIBRARY_PATH=/opt/pkg/intel/current/composerxe/lib/intel64/:$LD_LIBRARY_PATH

1.  Install mpi4py (download from pypi)
    
        CC=mpicc python setup.py install
2.  Compile dedalus. This needs to be done with mpicc
    
        CFLAGS="-I/usr/local/pkg/fftw/fftw-3.3.4/include $CFLAGS" CC=mpicc python setup.py build_ext --inplace


<a id="org136cec2"></a>

### dedalus on macbook

    conda install cython docopt h5py matplotlib numpy scipy
    conda install -c mpi4py mpich mpi4py
    pip install pathlib hgapi


<a id="org489ebab"></a>

## mpi4py on mac

I get an annoying error message when using the default version of mpi4py.
According to this [thread](https://groups.google.com/forum/#!topic/mpi4py/ULMq-bC1oQA), the easiest way to fix this is by installing using

    conda install --channel mpi4py mpich mpi4py


<a id="org4e9c1e4"></a>

## Install NCL on macbook

See these [instructions](http://www.ncl.ucar.edu/Download/install.shtml).

Download ncl binaries from earthsystemgrid, and then download and extract Mac
os gcc binaries from <http://hpc.sourceforge.net>.

The homebrew included version of gcc does not work with openmp, and it takes
so long to recompile.


<a id="orga242c32"></a>

## Openmpi/PETSc on mac     :working:

Succesfully installed on <span class="timestamp-wrapper"><span class="timestamp">[2016-11-28 Mon]</span></span>!

I was getting errors installing hdf5 using homebrew. See this [github issue](https://github.com/Homebrew/homebrew-science/issues/4652#issuecomment-263315450).
Needed to run

    xcode-select -r

to reset my "DeveloperDirectory".

After much headache I had to do

    brew install hdf5 --with-fortran --c++11
    brew uninstall --ignore-dependencies netcdf
    brew install petsc

In that specific order. This doesn't seem very reproducible.


<a id="org37faba4"></a>

## Chombo

Many other changes needed

Had to change line 476 of AMRBoxesAndRanksIO.cpp to

    while ((ok = static_cast<bool>(getline(ifs, sline, '\n'))))


<a id="orgf09dc5e"></a>

## Vagrant

Version 1.8.7 was not able to add boxes for some stupid reason. Downgrade to
1.8.6. [link](https://releases.hashicorp.com/vagrant/1.8.6/)

Use vagrant box from ubuntu servers

    vagrant box add yakkety64 https://cloud-images.ubuntu.com/yakkety/current/yakkety-server-cloudimg-amd64-vagrant.box
    vagrant init yakkety64; vagrant up --provider=virtualbox


<a id="orge40ff81"></a>

### Update <span class="timestamp-wrapper"><span class="timestamp">[2016-11-29 Tue]</span></span>

Stopped working. use release version rather than the  daily build.

    vagrant box add yakkety64 https://cloud-images.ubuntu.com/releases/16.10/release/


<a id="org020f7e4"></a>

# Zotero

RTFM as usual. There is lots of good stuff in there about tags and related items.


<a id="org6b205f3"></a>

## zotfile settings

Use /%T as the naming scheme


<a id="org41dbcf5"></a>

## Remove orphaned zotfiles

1.  Change attachments directory in zotfile preferences
2.  Close prefs, select all items, right-click and choose "rename
    attachements". All the files will be moved to the temporary directory.
3.  Delete the files in the original directory. These are the orgphaned files.
4.  Repeat steps 1 and 2 to move the files back to their original location


<a id="org709e256"></a>

# Emacs


<a id="org67f8ddf"></a>

## add company backend for given mode

<span class="timestamp-wrapper"><span class="timestamp">[2016-11-30 Wed]</span></span>

See <https://github.com/syl20bnr/spacemacs/issues/4878>

    (setq company-ispell-available t) ; error without this
    (setq company-ispell-dictionary "english-word.txt)
    
    (defvar company-backends-text-mode '())
    (spacemacs|add-company-hook text-mode)
    (push 'company-ispell company-backends-text-mode)


<a id="org1515af7"></a>

## RTAGS

Install rtags using homebrew. Install [bear](https://github.com/rizsotto/Bear) which can be used to generate the

appropriate config files. This doesn't work, and is too complicated.


<a id="org028dffc"></a>

## Org mode stuff


<a id="orgaee6171"></a>

### ipython

    (require 'ob-ipython)

Use the `py` snippet for making a nice python cell with an automatic file name
for the image.

    #+BEGIN_SRC ipython :session :file /Users/noah/Dropbox/notes/py687968Xx.png :exports both
      %pylab inline
    
    
    
      plot(rand(100))
    #+END_SRC


<a id="org4831b72"></a>

### debug errors using org-lint


<a id="org985baad"></a>

## beamer slide titles in reftex toc

The trick is listed on this [website](http://emacsworld.blogspot.com/2008/03/getting-beamer-frame-titles-into-reftex.html). The reftex-variable can be changed in customize.


<a id="orgb8558b7"></a>

# Git


<a id="orgbacf14f"></a>

## Delete remote branch

See [this](http://stackoverflow.com/questions/2003505/how-to-delete-a-git-branch-both-locally-and-remotely) stack overflow answer. The command to run is

    git push origin --delete <branchName>


<a id="orgda246a5"></a>

## git subtree

See [this article](https://www.atlassian.com/git/articles/alternatives-to-git-submodule-git-subtree/) for a description of how to use git subtree.

-   To add a remote repo as a subtree:
    
        git subtree add --prefix .vim/bundle/tpope-vim-surround https://bitbucket.org/vim-plugins-mirror/vim-surround.git master --squash
-   To split a directory into it's own branch
    
        git subtree split --prefix=path/to/code -b split --squash


<a id="org40a83a4"></a>

### Troubleshooting

1.  Error message: "Working tree has modifications cannot add"

    Solution is to re-checkout the current branch
    
        git checkout <branchname>
    
    See [stackoverflow](http://stackoverflow.com/questions/3623351/git-subtree-pull-says-that-the-working-tree-has-modifications-but-git-status-sa).

2.  bad object

    Downloaded git 2.9, which fixed the issue.


<a id="org0f7c681"></a>

# Python


<a id="org16e37ab"></a>

## Numpy/scipy


<a id="org4cdb0fd"></a>

### scipy.ndimage.correlate1d

The origin parameter of this function is somewhat confusing. For odd-sized
filters, the origin specifies the center of the filter. For even-sized
stencils, the origin=0 means that the center of the filter is at n/2+1. See
the following examples

    In [17]: correlate1d(np.arange(5), [0, 1, 0,0], origin=0)
    Out[17]: array([0, 0, 1, 2, 3])
    
    In [18]: correlate1d(np.arange(5), [0, 0, 1,0], origin=0)
    Out[18]: array([0, 1, 2, 3, 4])
    
    In [19]: correlate1d(np.arange(5), [0, 1,0], origin=0)
    Out[19]: array([0, 1, 2, 3, 4])


<a id="org307d244"></a>

## Jupyter notebook incorrect executable

If jupyter is unable to import packages, be sure to check

    sys.executable

See this [github issue](https://github.com/jupyter/notebook/issues/397) for more details about how to fix the kernel spec.


<a id="org661881a"></a>

## Documenting python

This is the numpy documentation style guide
<https://github.com/numpy/numpy/blob/master/doc/HOWTO_DOCUMENT.rst.txt>


<a id="org14efb08"></a>

## testing python

Use either nosesests or docopt


<a id="orge6a20c6"></a>

# LaTeX


<a id="orgc08bfbf"></a>

## left justified captions

    \usepackage{caption}
    \captionsetup{justification=raggedright,
    singlelinecheck=false
    }


<a id="org88097a1"></a>

## Float barrier before sections

    \usepackage{placeins}
    
    \let\Oldsection\section
    \renewcommand{\section}{\FloatBarrier\Oldsection}
    
    \let\Oldsubsection\subsection
    \renewcommand{\subsection}{\FloatBarrier\Oldsubsection}
    
    \let\Oldsubsubsection\subsubsection
    \renewcommand{\subsubsection}{\FloatBarrier\Oldsubsubsection}


<a id="org42bf566"></a>

## Print page dimensions for making figures

Add the `layouts` package to the preamble, and copy the following text

    \usepackage{layouts}
    \begin{document}
    
    \noindent {\Large Useful values for making figures}\\
    \noindent Text width: \printinunitsof{in}\prntlen{\textwidth}\\
    Text height: \printinunitsof{in}\prntlen{\textheight}


<a id="org927297f"></a>

# Julia


<a id="org1df7fe6"></a>

## change package path

The homefolder on CIMS machines is so slow so it is better to use scratch.
This is accomplished using the JULIA<sub>PKGDIR</sub> environmental variable.


<a id="org2a57b71"></a>

## Adding packages

To find a user module, it needs to be in the path at JULIA<sub>PKGDIR</sub>. You can
use a symbolic link in this directory if you don't want the source code to
actually sit in some hidden folder.


<a id="org9e66f1e"></a>

# Fortran


<a id="org1b0af05"></a>

## Installing and using coarrays


<a id="orgdb95857"></a>

### Gfortran

1.  install [Open Coarrays](http://www.opencoarrays.org/)
2.  compile using `caf`
3.  run with `runcaf`


<a id="orgf4f54d5"></a>

### Intel

<https://software.intel.com/en-us/node/532830>

1.  source  the `bin/compilervars.sthermo_mod.f90thermo_mod.f90h` file.
2.  compile using `ifort -coarray`
3.  control number of images with FOR<sub>COARRAY</sub><sub>NUM</sub><sub>IMAGES</sub>


<a id="orgbeae4df"></a>

## Calling Fortran using CFFI

<http://scientific-software-diary.com/?p=29>


<a id="orgd13afbd"></a>

## Fortran


<a id="orgf8e02cd"></a>

### Converting fixed source fortran to free

Use [ftf.pl](https://bitbucket.org/lemonlab/f2f), which is a perl script.


<a id="org9e4b268"></a>

# Unix


<a id="org80d6a2f"></a>

## tar


<a id="org9f97147"></a>

### make tarball following symlink

this is useful for making a tar of a folder with a bunch of symlinks and can be
accomplished using the `-h` flag.

    tar chzf name.tar.gz some-dir/


<a id="orgaab9e8e"></a>

## Type 3 Fonts

Use the following to remove all Type 3 fonts from the current eps files. This is
necessary for submitting to QJRMS.

    for f in `ls -1 *.eps`
    do
        mv $f $f.bak
        gs -sDEVICE=epswrite -dNOCACHE -sOutputFile=${f} \
           -q -dbatch -dNOPAUSE $f.bak -c quit end
    done

See this [blog](http://www.helsinki.fi/~regan/BlogPost_MNRAS) post about Type 3 fonts.


<a id="orga4448f6"></a>

# Vignettes


<a id="org40efd0c"></a>

## TRMM


<a id="org8022b23"></a>

### TRMM Python

The TRMM 3b42 dataset is available through OpenDap, and can be easily loaded
using xray.

    %matplotlib inline
    import xray
    from datetime import datetime
    
    def date2url(date):
        out = date.strftime('http://disc2.nascom.nasa.gov/opendap/TRMM_L3/TRMM_3B42/%Y/%j/3B42.%Y%m%d.%H.7.HDF.Z')
    
        return out
    
    date = datetime(2015, 5, 10, 6)
    
    
    
    url = date2url(date)
    remote_data = xray.open_dataset(url)
    
    P = remote_data.precipitation.sel(nlon=slice(150, 200), nlat=slice(-10,10))
    P.T.plot()

![img](out.png)


<a id="org7c6da86"></a>

## Automatic differentiation

[This presentation](http://www.jcsda.noaa.gov/documents/meetings/2009summercoll/Errico1_IntroAdjoint.pdf) mentions:

1.  TAF. "Transformation of Algorithms in Fortran". Used by [mitGCM](http://mitgcm.org/public/pelican/online_documents/node171.html).
    1.  TAMC: Supposedly succeeded by TAF
2.  ADIFOR
3.  TAPENADE: mentioned in climate paper
4.  OpenAD

How does automatic differentiation work with randomized codes?

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Software</th>
<th scope="col" class="org-left">Languages</th>
<th scope="col" class="org-left">Used in AOS</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">TAF</td>
<td class="org-left">F95</td>
<td class="org-left">y</td>
</tr>


<tr>
<td class="org-left">Tapenade</td>
<td class="org-left">F90,C</td>
<td class="org-left">y</td>
</tr>


<tr>
<td class="org-left">[Adept](http://www.met.reading.ac.uk/clouds/adept/)</td>
<td class="org-left">C++</td>
<td class="org-left">y (at reading)</td>
</tr>


<tr>
<td class="org-left">[casadi](https://github.com/casadi/casadi/wiki)</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>

It seems that TAPENADE and TAF are most used for in AOS, probably
because they work with Fortran.


<a id="org764f8c3"></a>

### Approaches

-   Operator overloading generally requires rewriting some code.
-   Source code transformation is ideal for the SMCM

How would randomized codes work? Maybe have to fit parameters of the
DFMLE.


<a id="orgd760185"></a>

### Sources

-   [@bucker_automatic_2006] a book on automatic differentiation
-   [autodiff.org](http:www.autodiff.org): Has a lot of information, including a [list](http://www.autodiff.org/?module%3DApplications&category%3DPhysics) of
    applications of AD software in AOS


<a id="org865c85f"></a>

# Refs

<~/Dropbox/Papers/zotero.bib>

