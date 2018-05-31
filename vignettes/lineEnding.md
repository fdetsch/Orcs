---
title: "`lineEnding` and the clash of operating systems"
author: "Florian Detsch"
date: "2018-05-31"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{`lineEnding` and the clash of operating systems}
  %\VignetteEngine{knitr::knitr}
  %\VignetteEncoding{UTF-8}
---



Complementing the utility of `setwdOS`, another tool I came to develop in the 
context of OS-dependent programming and, more specifically, line endings is 
introduced in the following. Those who have worked with numerous people on one 
and the same project, e.g. hosted on GitHub or Subversion, might have already grown 
familiar with the topic: line endings are automatically adjusted to your local 
OS, rendering the otherwise practical 'track changes' functionality useless. 
Obviously, this makes it very hard for your collaborators to understand the 
actual changes you made to a particular file since every single line is marked 
as modified. 

I came to face this issue when dealing with version control on Subversion and 
couldn't help but develop this short code snippet in order for my collaborators 
to track my changes. GitHub seemingly offers a built-in option to manipulate 
[global settings for line endings](https://help.github.com/articles/dealing-with-line-endings/), 
but I haven't tried this so far. Anyway, my manual approach goes by the name 
`lineEnding` and requires 

* input filename(s) or 
* a regular expression for pattern matching (see `list.files`),
* optional output filename(s) and 
* the direction of conversion, i.e. from UNIX to DOS (`to = "dos"`), or vice 
versa (`to = "unix"`).

Note that the code relies on the `dos2unix` external software tool which can 
easily be installed on Linux via 


```bash
sudo apt-get install dos2unix
```

or downloaded directly from the [project website](http://dos2unix.sourceforge.net/) 
for any other OS. Once everything is set up, try the following brief example to 
clarify what I was trying to explain and demonstrate the usefulness of 
`lineEnding`:


```r
## input file
infile <- file.path(system.file(package = "Orcs"), "DESCRIPTION")

system(paste("file", infile))
# > /home/fdetsch/R/x86_64-pc-linux-gnu-library/3.2/Orcs/DESCRIPTION: ASCII text

## convert to dos line endings and write to output file
lineEnding(infile, outfile = "~/Desktop/DESCRIPTION4wd", to = "dos")

system("file ~/Desktop/DESCRIPTION4wd")
# > /home/fdetsch/Desktop/DESCRIPTION4wd: ASCII text, with CRLF line terminators
```
