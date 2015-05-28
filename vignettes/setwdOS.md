---
title: "Set working directory OS-dependent with `setwdOS`"
author: "Florian Detsch"
date: "28.05.2015"
output: html_document
---



Due to work-related,  system exclusive software, I got used to switching from Linux to Windows, and vice versa, quite often. Since rebooting the system under Linux every time I'd like to do some coding in between seemed inconvenient, I usually included a simple `switch` command in the beginning of my code to identify the current OS (via `Sys.info()[["sysname"]]` and set the working directory accordingly. These few lines of code are now available as a function, which might come in handy for folks switching between different OS as often as I do.

The usage is almost self-explanatory. 


```r
## os partition without file path extension
setwdOS()

## with file path extension
setwdOS(path_ext = "kilimanjaro/nubiscope")
```
