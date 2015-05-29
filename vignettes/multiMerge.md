---
title: "Merge multiple data frames with `multiMerge`"
author: "Florian Detsch"
date: "28.05.2015"
output: html_document
---



Merging multiple data frames in R is anything but straightforward and usually involves confusing loop structures. `multiMerge` elegantly avoids such bewildering code chunks by envoking `Reduce` upon a list of data frames. The function also features a set of auxiliary parameters that are passed on to `merge`. Note that the code is mainly taken from a related [blog post in StackOverflow](https://stackoverflow.com/questions/8091303/merge-multiple-data-frames-in-a-list-simultaneously). 


```r
## sample data
set.seed(10)
ls_df <- list(data.frame(a = 1:10, b = 1:10),
              data.frame(a = 5:14, c = 11:20),
              data.frame(a = sample(20, 10), d = runif(10)))

## merge data frames in one go
multiMerge(ls_df, by = "a", all = TRUE)
```

```
##     a  b  c          d
## 1   1  1 NA         NA
## 2   2  2 NA 0.35804998
## 3   3  3 NA         NA
## 4   4  4 NA 0.42880942
## 5   5  5 11 0.83613414
## 6   6  6 12 0.56773775
## 7   7  7 13         NA
## 8   8  8 14 0.11350898
## 9   9  9 15         NA
## 10 10 10 16         NA
## 11 11 NA 17 0.65165567
## 12 12 NA 18 0.59592531
## 13 13 NA 19         NA
## 14 14 NA 20 0.26417767
## 15 15 NA NA 0.05190332
## 16 18 NA NA 0.39879073
```
