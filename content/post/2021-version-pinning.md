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
draft: true

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

This post describes how to make your software development (and science)
easily reproducible, and therefore save you time and reduce stress. I use
motivating examples from the scientific python world, but the principles
apply to any kind of software development. I also mention many specific tools
(I love learning new tools), but I try to give appropriate context and
stress common themes.

Like many newer computing platforms (e.g. Web 2.0), the scientific python ecosystem is powerful, but there is constant churn in the underyling code ecosystem.
Marquee packages like [pandas] and [xarray] are constantly being improved---and sometimes broken.
For example, pandas finally issued a major release (v1.0.0) in July, a crowning achievement...which happened to break [xarray](https://github.com/pydata/xarray/issues/3736), a bug which was fixed in v1.0.1.
It's not just python.
For example, I first setup this blog a couple years ago with [hugo](https://gohugo.io/), and forgot what version I used and didn't take any notes. 
When I started writing this post, I installed hugo on my new desktop, and...promptly hit obscure error messages. 
Turns out my blog is compatible with v0.55 of hugo, but not v0.68...go figure.
These tedious errors which break working code are extremely frustrating, and can be very challenging to debug.

In this way, the open source ecosystem presents some challenges to scientific reproducibility that did not exist in more stable proprietary environments.
To be honest, I expect the typical scientist using MATLAB will be able to reproduce their computational experiments in 5 years without much work.
They likely don't use many external packages, and stick to the APIs available in their platform.
On the other hand, even experienced python users might not know how to insulate their projects from the maelstrom of open source development---and may not even understand the need. 
I know I didn't until a few months ago.
Also, experienced python users are often more likely to seek out bleeding-edge software.
Hopefully this motivates you to develop a strategy for managing dependencies in your software projects.


You should especially fear the dependencies of your dependencies, known as
*transitive dependencies*.
For instance, we were using the [scikit-image] library for simple image processing for months succesfully, when suddenly our code broke because a dependency of scikit-image called "pooch" issued a buggy release.
Seriously, what is pooch?
Perhaps the most famous example is the chaos that ensued when a disgruntled developer removed [a trivial 17-line function](https://arstechnica.com/information-technology/2016/03/rage-quit-coder-unpublished-17-lines-of-javascript-and-broke-the-internet/) from javascripts package manager, breaking crucial web infrastructure like Facebook's React.
Dependencies also have copyright implications. If you depend on open-source
code released with a copyleft license like
[GPL](https://www.gnu.org/licenses/gpl-3.0.en.html) you may not be able to release your software with a more permissive license.[^6]
Additional dependencies also decreases the security of your code by
increasing "surface-area" open to attack.
Clearly dependency management needs to account for transitive dependencies.

Any software project can be made more robust by
1. reducing the number of dependencies
2. depending only on mature/stable libraries
3. de-couple the library code from its dependencies (e.g. don't call `np.xxxx` in 1000 places). 
4. copy/pasting small code snippets from external libraries (license permitting). Our "pooch" woes happened because we depend on a single easily copied 50-line function.
Use the same strategy to manage dependencies as you use to avoid getting COVID-19: interact only with your household (your code), keep a social distance with friends (especially helpful dependencies), and avoid large groups of strangers.

Beyond this, applications and libraries require different dependency management strategies. 
Applications are pieces of software that are intended to be *executed* by a user to produce a specific result. 
For example, the web-servers behind amazon.com are applications.
So are the [data analysis code for my last paper] and the [Community Earth System Model](https://www.cesm.ucar.edu/).
On the other hand, libraries are software artifacts that are shared and *imported* into other pieces of code, such as applications.
For example, I used the python library [PyTorch] in my last paper, and CESM uses the netCDF library to save data.

Libraries are useless if they don't work with other libraries, and will likely be used in a variety of contexts.
To take well known scientific python libraries as an example, if pandas only worked with numpy v1.15.0, but scikit-learn required numpy v1.14.2, then scikit-learn and pandas could not be installed together.
Because of this, libraries usually only loosely constrain their dependencies (e.g. use versions more recent than numpy 1.15).
These constraints are NOT a promise that the library will work in
your software environment since no library developer can test their library
against all conceivable combinations of dependencies satisfying these loose
constraints.
Users will inevitably have to step through this mine-field themselves.

On the other hand, application developers often have complete control where their application runs.
In the scientific context, often the "application developer" writing the data analysis code and the scientific "user" are the same person.
In the broader context, the modern Software as a Service (SaaS) provider
usually uses a client-server architecture where the client is on a restricted
platform (e.g. the browser, iOS, etc) and the server completely
controlled by the service provider.
This, and the fact that applications are the end-users of libraries, gives
most application developers one additional power tool. They can simply *freeze* the churning ocean of their dependencies by
pinning or locking the versions of those libraries used. [^1]
The remainder of this blog suggests some tools you can use to do this. 

## Features for Managing Dependencies

The goal of dependency pinning is to be able to determinstically recreate the software environment of an application from a text file (e.g. requirements.txt) in version control.
Dependency management systems also allow need to allow users to update
packages.
Packages versions often need to be updated for security reasons or to take
advantage of a new feature.
Naturally, upgradeability seems at odds with version pinning, and some of the tools mentioned below take this into account.

### Installing Packages

The intended audience of this article is likely familiar with some kind of package manager. These are the tools used to install the external packages.
These generally fall into two categories.
Some are python-specific like `pip`, and others can also manage non-python dependencies e.g. `apt-get` or `conda`.
For example,
```
pip install numpy
```
will install numpy and all it's dependencies.

In many cases, a single package manager might not be enough, so one will need to use the system package manager to install tools like compilers, and `pip` to install python packages. This is the problem `conda` is trying to solve, but it is not immune itself since there are still packages on PyPi that do not have anaconda packages.
Therefore, interoperability with `pip` is important.

### Dependency Resolution

Dependency resolution involves installing all the dependencees required by a
given package. An even more complicated problem occurs when two packages depend
on the same library. What version of this library should they choose? Some
package managers put great care
into solving the dependency graph such that all version constraints advertised
by any package in the installed set are satisfied. For instance, what if
package A requires package Z of version >= 1.1 and package B requires Z of
version <=2, then the tool will install any version between 1.1 and 2. This
feature captures some bugs and can help ensure that the APIs used are
consistent, which is why package managers like new versions of pip[^4] and conda include version
constraint resolvers.

Of course, sometimes packages lie, and fail to work with every version of a
dependency that they claim to. Therefore, the process of satisfying all the
version constraints as at best a heuristic that frequently works. Someone needs
to actually test that this set of installed versions works. You can do this via
your own tests, but we are lucky that numerous organizations do this hard work
for us by releasing and maintaining distributions of packages that are tested
to work together. For example, the [Debian Linux
Distribution](https://www.debian.org/) has thousands of python packages
available and only issues [stable
releases](https://www.debian.org/releases/stable/) every few years that only
have small security patches. Therefore, running `apt-get install python3-xarray
python3-sklearn` on a Debian 10.7 computer will install a nearly identical set
packages until the debian project stops hosting the packages in 20 years or
so[^3].  Similarly, you can install specific versions of the [Anaconda Python
Distribution](https://repo.anaconda.com/archive/).

Most tools have the ability to print out a list of installed packages and their
versions. For instance, one can call `pip freeze`, `conda env export`, or `apt
list --installed` depend on your system.  Saving the output of these commands
to a textfile, checked into version control, then ensures that our version
control system contains a comprehensive description of our installed environment,
which easily allows us to rollback changes or find which commits introduce
breaking changes (e.g. using git bisect).

#### Abstract vs concrete dependencies

Recent trends in python packaging tools point towards separating concrete and
abstract dependencies in different text files under version control. Abstract
dependencies are loose requirements like `numpy >=0.5`, which don't include
specific version numbers or dependencies. These are easy to update, but cannot
be used to determinstically recreated a software environment. New tools like
pipenv, poetry, or pip-tools use dependency resolution to compile abstract
dependencies into comprehesive lists of dependencies with specific versions,
known as a "lock" file. The idea that the lock file gives reproducibility, and
the abstract dependencies give updateability.

### Environment Management

Dependencies are even harder to manage because changes to a computers
installed environment cannot be easily rolled-back if something breaks. In
other words, the software environment of computer has "state" that cannot
easily reproduced from a short text file, and without care, your computer
will become a snowflake---beautiful, but unique and impossible to recreate.

The state typically takes a few forms:
- The contents of working memory (RAM) (e.g. environmental variables like PATH)
- Contents of the hard drive (e.g. installed libraries and applications)
- Services over TCP ports (e.g. running a database or web server).
- Connections with the operating system kernel

Restarting a computer is such a powerful debugging tool because it removes a
large amount of state stored in the RAM of your computer. However, it is not
easy to rollback modifications to persistent state such as the contents of
`/usr/bin`. For this reason, tools that prevent the accumulation of this state are
increasingly bundled with package managers. 

Generally, these take two approaches. The more common approach isolates the
installed environment of an application to a sub-environment which can easily
be deleted and re-built if something goes wrong. For python-only projects,
[virtualenvs] are the standard way to create such isolated environments.
[conda] extends the virtualenv concept to include non-python dependencies
while docker containers[^5] and virtual machines create entirely isolated
computers-within-a computer.

There are several tools for doing this which have varying degrees of isolation. In rough order:
- Language specific tools like  only isolate python dependencies.
- [conda] environments extend virtualenvs but also handle many non-python libraries.
- Linux chroots and docker containers cannot see the file system or
environmental variables of the broaders system by default, but use the same kernel as the host operating system.[^5]
- Virtual Machines go a step further and even isolate operating system.
Generally speaking, the more isolated a sub-environment it is, the more
laborious it is to use and virtualenvs are very simple. 
- Another machine entirely
As you can see, the earlier items in this list are easier to use. Taken to
extreme, you might need to buy a new super-computer and rehire the
now-retired sysadmin to replicate your collaborators' environment. 

"Functional" package managers like [Nix] prevent the accumulation of system
state, by making it "immutable". For instance, instead of installing `rsync`
to `/usr/bin/`, Nix will install it to a read-only directory
`/nix/store/syapqz1bwxgicwbd6dkcdlxfqn8g6din-rsync-3.1.3/bin`. The random
string of characters is a hash of all the inputs required to build `rsync`,
which gaurantees that this location will be unique. For example, a new
version of rsync will result in a different hash and new installation
location.

Environmental Management tools are only useful if they can be readily and
easily recreated. When did you last do this? If it was a long time ago, your
development is probably not very reproducible. Ideally, this should happen
automatically on a regular basis. You could use continuous integration or
simply delete your local conda environment on a weekly basis. For this to be
convenient, you will need to automate installation procedure by writing some text files that describe and build your software environment.

It is easier to do this when you use tools like docker that couple
environment creating process with the application build/testing cycle. For
pure python projects, I recommend testing your project regularly with
[tox](https://tox.readthedocs.io/en/latest/) forces you to run your tests
inside of a python virtualenv.

## A "tar"-ible decision

If you can, choose your dependencies so that you can use the simplest
dependency management tools.
This often means using programming language libraries rather than command
line utilities or shell scripts. For example, suppose part of your python
software project needs to extract files from a tar archive. Since most of us
are most familiar with the
`tar` command line tool we would often start a script like this:
```
import subprocess

subprocess.check_call(['tar', 'xf', "--exclude", "unwanted/data", "my_data])
```
However, now your program depends on the system tool "tar", which [differs on Linux and Mac](https://unix.stackexchange.com/questions/101561/what-are-the-differences-between-bsdtar-and-gnu-tar). If your collaborator used some Mac-specific flag, you might even need to buy a new laptop since you can't legally install Mac OS on non-apple hardware. Using python's built in [tarfile](https://docs.python.org/3/library/tarfile.html) might force you to learn a new way to untar archives, but it lets you choose the simplest possible environment management (e.g install python 3.7).

## Conclusions

Using code written be others can save you a lot of time, but we are generally
better at managing our own code. Many of you diligently check in our code into
version control systems like git, but do not at all control (or even list)
the code that is written by third-parties. Focusing on personal-code
management vs external-code makes sense in more stable ecosystems like
Matlab. In such ecosystems, your personal code will change more than the
external code, so it makes sense to devote more attention to it by learning
git. Focusing exclusively on personal code management does not work in faster
moving worlds like scientific Python.

Managing external depencies is harder than managing personal code for a few
reasons. First, there is infinitely more external code than personal code.
Second, there is no single universally agreed upon dependency management
tool. While git is a universal tool that works for all software projects,
each language ecosystem and operating system has a different package
manager.

You should strive to capture the state of this external code in your
personal-code management system. Git manages text files, but it doesn't
manage all the files on your computer's hard drive. Therefore you need a tool
to reliably build a computer from a from text file. To do this reliably, you
need to combine installation like pip and environment management tools like
virtualenvs. Tools that bundle these functionalities make it easier to do,
and automation (e.g. continuous integration) ensures that your tool actually
works.

Dependency management, software development, and science are tightly coupled.
In particular, you should minimize the number of dependencies and decouple
your code from those dependencies. Library developers need to be particularly
disciplined since they cannot know exactly what external code will be
combined with their code. While application developers (e.g. someone
performing a specific scientific analysis) can choose what external code they
use, they do need to worry about security, licensing, and reproducibility. 

In general, the software development industry is better at reproducibility
than science because lack of scientific reproduciblity has less tangible
cost. For example, Google will lose millions of dollars of ad revenue if they
can't quickly recover from a crashing system, but no one will probably know
if you can't regenerate the plots for your last paper. The scientific
community can learn from industry, but might need to choose its science
carefully if they want it to be reproducible.

In particular, current high-performance computer environments seem inherently
unreproducible. These are the ultimate "snowflake" machines. We give them
that have cute names and never rebuild them from scratch, so how could we
expect them to be isomorphic to a text file that can be checked into version
control? This is sometimes necessary--it's not easy to "reproduce" the Large
Hadron Collider either---but we should try to move as scientific and software
development as possible onto reproducible systems like the cloud.

# 1. Outline

1. Introduction
    a. Pointed question. Do you python users think your setup is more or less reproducible than your MATLAB-using colleagues?
    a. story to engage interest (pooch)
    a. Fear dependencies of dependencies.
    b. Pandas v1.0 breaks xarray.
    c. This blog didn't work with hugo version 0.78, it needs 0.55.
    d. Scientific python is a particularly unstable development environment.
2. Application vs library development.
    a. application developers want their code to always work in contexts that they control
    (their laptop, super computer, cloud infrastructure).
    b. Library developers want their code to in contexts they do not control (some pip users personal laptop).
    c. Scientific programmers are usually much more like application
       developers---they want to perform some data analysis and publish results.
       Relatively few of us are actually developing libraries used by a broad
       group of people.
    d. Most github repositories illustrate the best practice for library development, but it is much harder to find good practices for one-off analysis projects.
3. What: Best practices for application developers
    a. The web industry and the DevOps movement are far ahead of
       science in terms reproducibile software development because lack of
       reproducibility costs a lot of money. Contracts require over 99.9%
       up-time for websites like google, and github. If one of these sites goes
       down, employees need to be able to fix the problem and restart the
       service (including provisioning infrastructure) as fast as possible.
       They also need to be able to release new code to their servers on a
       reasonable time frame, and cannot afford to waste time because some [random package breaks](https://qz.com/646467/how-one-programmer-broke-the-internet-by-deleting-a-tiny-piece-of-code/).
    b. [12 Factor App](https://12factor.net/)
    c. Conciously select external dependencies. Minimize the number of
      libraries you use and avoid the bleeding edge. In software development,
      there is always a tension between not repeating yourself and introducing
      couplings that can ruin your day. The pooch dependencies problem happened
      because we used scikit-image for a single 50-line function. In
      retrospect, we should have copy-pasted or reimplemented it.
    d. transitive dependencies (i.e. dependencies of dependencies).
    d. Pin the versions of all dependencies. Unlike library developers, a
       typical application developer usually has control over the software
       environment their code runs in. Therefore, they can ensure their code
       continues to work by explicitly listing all the external dependencies in
       some text file. A commit of your source code
       should be isomorphic to an installed software environment.

4. Tools for reproducible scientific python environments:
  1. "Distributions" or "Releases"

     Many major linux distributions do this hard work for you, and the packages
     available by default in Debian, Ubuntu, CentOS or other distributions have
     been carefully vetted, frozen to a particular version, and only receive
     updates that fix critical flaws like a security bug. Therefore, on a Debian
     8.1 system,
     ```
     apt-get update && apt-get install -y python3-xarray python3-cartopy
     ```
     will result in a functionally identical [^2] software environment for years to come. If you don't have admin access to your computer, and don't trust your sysadmin to maintain a reproducible environment you can use a fixed release of anaconda and make a note in your README:

        # note the date in the URL
        curl  https://repo.anaconda.com/archive/Anaconda3-2020.11-MacOSX-x86_64.sh | bash

    These distributions are like walled gardens containing all your
    dependencies and their dependencies. Any attempt to venture outside can
    completely destroy the walls protecting your reproducible setup. Even a
    simple `pip install requests==1.0.0` could install many dependencies of
    `requests` with completely unpinned versions.

  2. Concrete vs abstract dependencies.
  3. Package-managers:
    1. language specific: pip, conda
    2. system: apt-get, conda
    3. conda and pip are not enough `conda install xarray` will not result in the same installed environment in 1 year.
  4. Isolation tools:
     1. docker
     2. virtual environments,
     3. anaconda environments
     4. Docker, virtual environments, and anaconda environments do not ensure
        reproducibility on their own. These are tools for isolating dependencies of
        a given software project from the host system. While docker does build
        an artifact called the "docker image" that can be downloaded and used to
        reproduce an analyis, without special attention, it usually cannot be
        rebuilt determinstically from the text file that is checked into version
        control (e.g. the Dockerfile). In many cases these environment isolation
        tools are bundled into package managers like poetry and conda.
  5. Poetry, pip-compile, pip help maintain lock files and more abtract lists of dependencies.
  6. nix


5. Conclusions
   1. Scientific users should gauge their appetite for new tools and adjust
      their dependency management needs accordingly. Scientists who don't
      like or don't have the time to learn new tools like poetry, docker, or
      nix should 1) minimize their number of dependencies and 2) stick to the
      set of packages maintained on their platform by other trusted people
      (e.g. Debian/Ubuntu developers or your super computers sysadmin).

[^1]: For some reason, I was not really aware of this until recently. I think part of the reason is that many of us learn software development best practices by emulating what popular libraries like xarray and scikit-learn do, and these libraries don't pin their dependencies for the reasons discussed above.

[^2]: This system likely won't be truly deterministic in the sense that 
      it is bit-for-bit identical, but any changes should be non-breaking and minimal.

[^3]: As of Jan 14, 2021, binaries from Debian Bo (1.3) released in 1997 are still being [archived](https://www.debian.org/distrib/archive).

[^4]: Included as of v40.3

[^5]: This is true on Linux. On Mac's docker runs inside of virtual machine.
[^6]: This applies to the dependencies of your dependecies as well. It is not uncommon for an open source project to "lie" about its license; for example, by declaring a permissive license like MIT, but having a dependency containing GPL code.

[Nix]: https://nixos.org/

[Conda]: https://docs.conda.io/en/latest/
[virtualenvs]: https://docs.python.org/3/tutorial/venv.html