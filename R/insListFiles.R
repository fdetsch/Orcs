insListFiles <- function(path = ".", pattern = NULL, full.names = TRUE, 
                         recursive = FALSE) {
  
  tmp <- paste0(system.file(package = "Orcs"), "/extdata/tmp.sh")
  con <- file(tmp, open = "wt")

  ch_cmd <- paste0("ls ", 
                   if (recursive) "-R", 
                   path)
  
  ch_bash <- paste("#!/bin/bash", "unsetopt CASE_GLOB", ch_cmd, sep = "\n")
  writeLines(ch_bash, con = tmp, useBytes = FALSE)
  
  system(tmp)
  
  system(ch_cmd)
}