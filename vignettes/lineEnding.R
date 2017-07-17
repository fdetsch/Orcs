## ----pkg, echo=FALSE, message=FALSE--------------------------------------
library(Orcs)

## ----lineEnding, eval=FALSE----------------------------------------------
#  ## input file
#  infile <- file.path(system.file(package = "Orcs"), "DESCRIPTION")
#  
#  system(paste("file", infile))
#  # > /home/fdetsch/R/x86_64-pc-linux-gnu-library/3.2/Orcs/DESCRIPTION: ASCII text
#  
#  ## convert to dos line endings and write to output file
#  lineEnding(infile, outfile = "~/Desktop/DESCRIPTION4wd", to = "dos")
#  
#  system("file ~/Desktop/DESCRIPTION4wd")
#  # > /home/fdetsch/Desktop/DESCRIPTION4wd: ASCII text, with CRLF line terminators

