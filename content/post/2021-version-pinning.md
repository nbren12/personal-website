---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Managing dependencies for reproducible (scientific) software"
subtitle: "Fear the dependencies of your dependencies"
summary: ""
authors: []
tags: []
categories: []
date: 2021-01-02T14:34:30-08:00
lastmod: 2021-01-02T14:34:30-08:00
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---
Using code written by others can save a lot of time, but we are generally better at managing our own code. We diligently commit our code into version control systems like git and write automated tests, but do not at all control (or even list) the code that is written by third-parties. Focusing on personal-code management vs external-code makes sense when the external code changes much less frequently than your internal code. When using a stable commercial product like Matlab, your personal code will likely change more than the external code, so it makes sense to devote more attention to it by learning git. However, an exclusive focus on managing your own code does not work in faster moving worlds like scientific Python.

Like many newer computing platforms (e.g. Web 2.0), the scientific Python ecosystem is powerful, but there is constant churn in the underlying code ecosystem.
Marquis packages like [pandas] and [xarray] are constantly being improved---and sometimes broken.
For example, pandas finally issued a major release (v1.0.0) in July, a crowning achievement...which happened to break [xarray](https://github.com/pydata/xarray/issues/3736), a bug which was fixed in v1.0.1.
It's not just python.
For example, I first set up this blog a couple of years ago with [hugo](https://gohugo.io/) and forgot what version I used and didn't take any notes. 
When I started writing this post, I installed Hugo on my new desktop, and...promptly hit obscure error messages. 
Turns out my blog is compatible with v0.55 of Hugo, but not v0.68...go figure.
These tedious errors which break working code are frustrating and challenging to debug.

In this way, the open-source ecosystem presents some challenges to scientific reproducibility that did not exist in more stable proprietary environments.
To be honest, I expect the typical scientist using MATLAB will be able to reproduce their computational experiments in 5 years without much work.
They likely don't use any external packages, and stick to the APIs available in their platform.
On the other hand, even experienced python users might not know how to insulate their projects from the maelstrom of open source development---and may not even understand the need. 
I know I didn't until a few months ago.
Also, experienced python users are often more likely to seek out bleeding-edge software.
Hopefully, this motivates you to develop a strategy for managing dependencies in your software projects.

You should especially fear the dependencies of your dependencies, known as
*transitive dependencies*.
For instance, we were using the [scikit-image] library for simple image processing for months successfully, when suddenly our code broke because a dependency of scikit-image called "pooch" issued a buggy release.
Seriously, what is pooch?
Perhaps the most famous example is the chaos that ensued when a disgruntled developer removed [a trivial 17-line function](https://arstechnica.com/information-technology/2016/03/rage-quit-coder-unpublished-17-lines-of-javascript-and-broke-the-internet/) from javascript's package manager, breaking crucial web infrastructure like Facebook's React.
Dependencies also have copyright implications. If you depend on open-source
code released with a copyleft license like
[GPL](https://www.gnu.org/licenses/gpl-3.0.en.html) you may not be able to release your software with a more permissive license.[^6]
Dependencies also harm the security of your code by
increasing "surface-area" open to attack [^7].
Clearly transitive dependencies need to be managed as well.

# Dependency Management Strategies

Managing external dependencies is harder than managing personal code for a
few reasons. First, there is much more external code than personal
code. Second, there is no single universally agreed-upon dependency
management tool like `git` for personal code management. However, the same
strategies used to build robust personal code can also be used for
other people's code.

Any software project can be made more robust by
1. being simpler (e.g. reducing the number of things it does/number of dependencies)
2. widely reusing only dependable/stable code (e.g. avoid v0.1.0 libraries)
3. loose coupling (e.g. avoid call `np.xxxx` in 1000 places). 

Overall, you can manage dependencies using the same strategy you use to avoid getting COVID-19: interact only with your household (your code), keep a social distance with friends (especially helpful dependencies), and avoid large groups of strangers.

It's harder to manage dependencies spanning multiple ecosystems (e.g. the Linux shell, python, or other languages).
A common way this happens is when a python or other script calls a command line tool like `tar`. This can be a really `tar`-ible decision.
For example, familiarity with `tar` may drive you to write something like this:
```
import subprocess

subprocess.check_call(['tar', 'xf', "--exclude", "unwanted/data", "my_data])
```
but now your program depends on a system tool which [differs on
Linux and
Mac](https://unix.stackexchange.com/questions/101561/what-are-the-differences-between-bsdtar-and-gnu-tar), so this script may not work if you upgrade your laptop or share it with a colleague.
It's much better to learn how to use python's builtin [`tarfile`](https://docs.python.org/3/library/tarfile.html) library.

Applications and libraries manage their dependencies differently. 
Applications are pieces of software that are intended to be *executed* by a user to produce a specific result. 
For example, the web-servers behind amazon.com are applications.
So is the [data analysis code for my last paper](https://github.com/nbren12/uwnet) and the [Community Earth System Model](https://www.cesm.ucar.edu/).
On the other hand, libraries are software artifacts that are shared and *imported* into other pieces of code, such as applications.
For example, I used the python library [PyTorch](https://pytorch.org/) in my last paper, and CESM uses the netCDF library to save data.

Library developers cannot control the environments where their code is executed,and libraries are useless if they don't work with other libraries.
To take well known scientific python libraries as an example, if pandas only worked with numpy v1.15.0, but scikit-learn required numpy v1.14.2, then scikit-learn and pandas could not be installed together.
Because of this, libraries usually only loosely constrain their dependencies (e.g. use versions more recent than numpy 1.15).
These constraints are NOT a promise that the library will work in
your software environment since no library developer can test their library
against all conceivable combinations of dependencies satisfying these loose
constraints.
Users will inevitably have to step through this mine-field themselves.

Application developers, on the other hand, often have complete control where their application runs.
In the scientific context, often the "application developer" writing the data analysis code and the scientific "user" are the same person.
In the broader context, the modern Software as a Service (SaaS) provider
usually uses a client-server architecture where the client is on a restricted
platform (e.g. the browser, iOS, etc) and the server is completely controlled
by the service provider.
This, and the fact that applications are the end-users of libraries, gives
most application developers the power to simply *freeze* the churning ocean
of their dependencies by pinning or locking the versions of those libraries
used. [^1]

I now turn to the tools that developers can use to manage their dependencies.

## Features for Managing Dependencies

### Installing Packages

You have likely installed software with a *package manager*.
These generally fall into two categories.
Some are python-specific like `pip`, and others can also manage non-python dependencies e.g. Linux's `apt-get` or Anaconda's `conda`.
For example,
```
pip install numpy
```
will install NumPy and all its dependencies.

In many cases, a single package manager might not be enough, so one will need to use the system package manager to install tools like compilers, and `pip` to install python packages. This is the problem `conda` is trying to solve, but it is not immune itself since there are still packages on PyPi that do not have anaconda packages.
Therefore, interoperability with `pip` is important.

### Dependency Resolution

Dependency resolution involves installing all the dependencies required by a
given package. An even more complicated problem occurs when two packages depend
on the same library. What version of this library should they choose? Some
package managers put great care
into solving the dependency graph such that all version constraints advertised
by any package in the installed set are satisfied. For instance, if
package A requires package Z of version >= 1.1 and package B requires Z of
version <=2, then the tool will install any version between 1.1 and 2. This
feature captures some bugs and can help ensure that the APIs used are
consistent, which is why package managers like new versions of pip[^4] and conda include version
constraint resolvers.

Of course, sometimes packages lie, and fail to work with every version of a
dependency that they claim to. The process of satisfying all the
version constraints is only a heuristic. Someone needs
to actually test that this set of installed versions works. You can do this via
your own tests, but we are lucky that numerous organizations do this hard work
for us by releasing and maintaining distributions of packages that are tested
to work together. For example, the [Debian Linux
Distribution](https://www.debian.org/) has thousands of python packages
available and only issues [stable
releases](https://www.debian.org/releases/stable/) every few years that only
have small security patches. Therefore, running `apt-get install python3-xarray
python3-sklearn` on a Debian 10.7 computer will install a nearly identical set
packages until the Debian project stops hosting the packages in 20 years or
so[^3].  Similarly, you can install specific versions of the [Anaconda Python
Distribution](https://repo.anaconda.com/archive/).

Most tools have the ability to print out a list of installed packages and their
versions. For instance, one can call `pip freeze`, `conda env export`, or `apt
list --installed` depending on your system.  Saving the output of these commands
to a text file, checked into version control, ensures that your version
control system contains a comprehensive description of our installed environment.
This makes it easy to rollback any changes.

#### Abstract vs concrete dependencies

Modern python packaging specify concrete and abstract dependencies in
separate files. Abstract dependencies are loose requirements like `numpy >=0.5`, which don't include specific version numbers or dependencies. These
are easy to update, but cannot be used to deterministically recreate a
software environment. New tools like [poetry](https://python-poetry.org/)
resolve abstract dependencies into comprehensive lists of dependencies with
specific versions, known as a "lock" file. The lock file gives
reproducibility, and the abstract dependencies give updateability.

No matter the tool, the workflow is the same. For instance, if you started with a clean python installation you could install the abstract requirements "numpy" and "matplotlib" with pip like this:
```
pip install numpy matplotlib
```
and then save the *concrete* requirements to disk like this:
```
pip freeze > requirements.txt
```
On my machine this requirements file looks like this:
```
cycler==0.10.0
kiwisolver==1.3.1
matplotlib==3.3.4
numpy==1.20.0
Pillow==8.1.0
pyparsing==2.4.7
python-dateutil==2.8.1
six==1.15.0
```
You can see that this file includes *transitive* dependencies of matplotlib and numpy and pinned versions numbers. Luckily numpy and matplotlib are nice libraries, and don't have many dependencies.
In this example the requirements file is the "lock" file, and the command installation the "abstract" dependencies.
More advanced tools like poetry simply do a bit more automation and handholding around this two-file structure for managing python dependencies.
If you learn nothing else from this blog post, please learn to save both your abstract and concrete dependencies into version control.

### Environment Management

Dependencies are even harder to manage because changes to a computer's
installed environment cannot be easily rolled-back if something breaks. In
other words, the software environment of the computer has "state" that cannot
easily reproduced from a short text file. Without care your computer will
become a snowflake---beautiful but unique and impossible to recreate.

The state typically takes a few forms:
- The contents of working memory (RAM) (e.g. environmental variables like PATH)
- Contents of the hard drive (e.g. installed libraries and applications)
- Services over TCP ports (e.g. running a database or webserver).
- Connections with the operating system kernel

Restarting a computer fixes so many problems because it removes a large
amount of state stored in the RAM of your computer. However, it is not easy
to rollback modifications to persistent state such as the contents of
`/usr/bin`. For this reason, tools that prevent the accumulation of this
state are increasingly bundled with package managers.

Generally, these take two approaches. The more common approach isolates the
installed environment of an application to a sub-environment which can easily
be deleted and re-built if something goes wrong. For Python projects,
[virtualenvs] are the standard way to create such isolated environments.
[conda] extends the virtualenv concept to include non-python dependencies
while docker containers[^5] and virtual machines create entirely isolated
computers-within-a computer. Taken to extreme, you might need to buy a new
super-computer and rehire the now-retired sysadmin to replicate your
collaborator's environment.

"Functional" package managers like [Nix] prevent the accumulation of system
state, by making it "immutable". For instance, instead of installing `rsync`
to `/usr/bin/`, Nix will install it to a read-only directory
`/nix/store/syapqz1bwxgicwbd6dkcdlxfqn8g6din-rsync-3.1.3/bin`. The random
string of characters is a hash of all the inputs required to build `rsync`,
which guarantees that this location will be unique. For example, a new
version of rsync will result in a different hash and new installation
location.

Environment management tools are only useful if they can be readily and
easily recreated. When did you last time you installed all dependencies from
scratch? If it was a long time ago, your development is probably not very
reproducible. Ideally, this should happen automatically on a regular basis.
You could use continuous integration or simply delete your local conda
environment on a weekly basis. For this to be
convenient, you will need to automate the installation procedure by writing some text files that describe and build your software environment.

It is easier to do this when you use tools like docker that couple
environment creating process with the application build/testing cycle. For
pure Python projects, I recommend testing your project regularly with
[tox](https://tox.readthedocs.io/en/latest/), a tool which creates virtual
environments and runs tests within them.

## Conclusions

You should strive to capture the state of all the code you use in your
personal-code management system. External dependencies are code too, but are
harder to manage than personal code. Git manages text files, but it doesn't
manage all the files on your computer's hard drive or the internet. Therefore
you need a tool to reliably build your program's execution environment from a
text file. Tools that bundle package and environment management features make
this easier to do, and automation (e.g. continuous integration) ensures that
your tool actually works.

Dependency management, software development, and science are tightly coupled.
In particular, you should minimize the number of dependencies and decouple
your code from those dependencies. Library developers need to be particularly
disciplined since they cannot know exactly what external code will be
combined with their code. While application developers (e.g. someone
performing a specific scientific analysis) can choose what external code they
use, they do need to worry about security, licensing, and reproducibility. 

[^1]: I was not really aware of this until recently. I think part of the reason is that many of us learn software development best practices by emulating what popular libraries like xarray and scikit-learn do, and these libraries don't pin their dependencies for the reasons discussed above.

[^2]: This system likely won't be truly deterministic in the sense that 
      it is bit-for-bit identical, but any changes should be non-breaking and minimal.

[^3]: As of Jan 14, 2021, binaries from Debian Bo (1.3) released in 1997 are still being [archived](https://www.debian.org/distrib/archive).

[^4]: Included as of v40.3

[^5]: This is true on Linux. On Mac's docker runs inside of virtual machine.
[^6]: This applies to the dependencies of your dependencies as well. It is not uncommon for an open-source project to "lie" about its license; for example, by declaring a permissive license like MIT, but having a dependency containing GPL code.
[^7]: A security researcher [recently hacked](https://www.bleepingcomputer.com/news/security/researcher-hacks-over-35-tech-firms-in-novel-supply-chain-attack/) into some big companies by uploading some packages to python's and javascript's package management services. 

[Cheyenne]: https://www2.cisl.ucar.edu/resources/computational-systems/cheyenne
[Nix]: https://nixos.org/
[Conda]: https://docs.conda.io/en/latest/
[virtualenvs]: https://docs.python.org/3/tutorial/venv.html
[pandas]: https://pandas.pydata.org/
[xarray]: http://xarray.pydata.org/en/stable/