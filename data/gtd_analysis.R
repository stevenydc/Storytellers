
library(openxlsx)
library(dplyr)
library(rworldmap)
library(rjson)

# Read in GTD database from 1992 to 2010
dat <- read.xlsx("~/Downloads/gtd_0615dist/gtd_92to10_0615dist.xlsx",
                 sheet=1,colNames=T,detectDates=T,skipEmptyRows = T)

# Subsets data for columns of interest
dat_sub <- dat %>%
  select(one_of("iyear",
                "imonth",
                 "iday",
                 "country",
                 "country_txt",
                 "attacktype1_txt",
                 "targtype1",
                 "targtype1_txt",
                 "gname",
                 "weaptype1",
                 "weaptype1_txt",
                 "nkill"))

# Just looking at a particular year, 2001 for convenience
dat_samp_year <- dat %>%
  filter(iyear == 2001)

country_attacks <- as.data.frame(table(dat_samp_year %>%
                                         select(one_of("country_txt"))))
colnames(country_attacks) =  c("Country","Freq")

map_join = joinCountryData2Map(country_attacks,joinCode="NAME",
                               nameJoinColumn = "Country",verbose = T)
sink("~/Documents/Dev/DataScience/Storytellers/data/test_freq.json")
toJSON(country_attacks)
sink()
file.show("~/Documents/Dev/DataScience/Storytellers/data/test_freq.json")
