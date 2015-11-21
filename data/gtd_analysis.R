
library(openxlsx)

# Read in GTD database from 1992 to 2010
dat <- read.xlsx("~/Downloads/gtd_0615dist/gtd_92to10_0615dist.xlsx",
                 sheet=1,colNames=T,detectDates=T)

