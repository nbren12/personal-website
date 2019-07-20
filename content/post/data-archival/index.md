+++
date = "2017-02-15T10:57:46-05:00"
highlight = true

math = false
tags = []
title = "Data archival strategy"

+++

At work, my datafiles are split accross several different machines with different filesystems. These are

1. My desktop
2. my laptop
3. NYU HPC 
4. NYU Abu Dhabi HPC

In this post, I outline a strategy for archiving my data, and tracking where what is on different servers. My previous strategy, which I used on a few projects, was to archive the data individually within each project. This has the advantage of making the data shareable, but does not scale well when multiple different projects share a particular data source. This is especially a problem if the data is quite large.

I think it makes more sense to keep all data in one location, and then provide a coherent way to access the different datasets in a coherent fashion. So it makes sense to put everything in a git-annex repository which is shared between several servers. Previously I have had issues using git-annex, so I do not think it is a good tool for managing the files from individual projects, where frequent edits are necessary. However, I think it would be a great tools for managing a single infrequently altered data repository which is distributed across several machines.

