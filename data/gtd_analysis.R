
library(openxlsx)
library(dplyr)
library(rworldmap)
library(jsonlite)
library(leaflet)
library(maps)
library(geojsonio)

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
                "latitude",
                "longitude",
                "attacktype1_txt",
                "targtype1",
                "targtype1_txt",
                "gname",
                "weaptype1",
                "weaptype1_txt",
                "nkill"))

# Grouped by year now
dat_samp_year <- dat %>%
  group_by(iyear) %>% arrange(iyear)

latlongs <- as.data.frame(dat_samp_year %>%
                            select(one_of("latitude","longitude")))
latlongs <- na.omit(latlongs)
colnames(latlongs) =  c("Year","latitude","longitude")

country_attacks <- as.data.frame(table(dat_samp_year %>%
                                         select(one_of("country_txt"))))

map_data = joinCountryData2Map(country_attacks, joinCode="NAME",nameJoinColumn="Country")

colnames(country_attacks) =  c("Year","Country","Freq")

sink("~/Documents/Dev/DataScience/Storytellers/data/attacks_year.json")
toJSON(country_attacks,pretty=T)
sink()
sink("~/Documents/Dev/DataScience/Storytellers/data/latlong_year.json")
toJSON(latlongs,pretty=T)
sink()
file.show("~/Documents/Dev/DataScience/Storytellers/data/latlong_year.json")
write.table(country_attacks,
            "~/Documents/Dev/DataScience/Storytellers/data/attacks_year.csv")
file.show("~/Documents/Dev/DataScience/Storytellers/data/attacks_year.csv")

attacks_2000 = latlongs %>%
  filter(Year==2000)

pal <- colorNumeric(
  palette = "Reds",
  domain = attacks_2000$Freq
)
map_world = map("world", fill = TRUE, plot = FALSE)
leaflet(data = map_world) %>%
  addTiles() %>%
  addPolygons(smoothFactor =0.2,fillOpacity = 1,color=pal(attacks_2000$Freq),
              stroke = FALSE) %>%
  addLegend("bottomright", pal = pal, values = attacks_2000$Freq,
            title = "Terrorist Attacks",
            opacity = 1
  )

