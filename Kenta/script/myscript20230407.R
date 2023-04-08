library(tidyverse)
library(here)
library(dplyr)
library(kableExtra)
library(maps)
library(mapdata)
library(mapproj)
library(janitor)

cats_uk <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-31/cats_uk.csv')
cats_uk_reference <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-31/cats_uk_reference.csv')
UK <- map_data("world", region = "UK")

ggplot()+
  geom_polygon(data = UK,
               aes(x =long,
                   y= lat,
                   group=group),
               color="pink")+
  coord_map()+
  geom_point(data = cats_uk,
             aes(x = location_long,
                 y= location_lat,
                 color="where the cats were found"))+
  scale_x_continuous(limits = c(-6,-3)) + 
  scale_y_continuous(limits = c(50,51))
