library(tidyverse)
library(here)
library(dplyr)
library(kableExtra)
library(maps)
library(mapdata)
library(mapproj)
library(janitor)
library(moveVis)
library(move)

cats<- cats_uk%>%
  select(location_long, location_lat, timestamp)%>%
  drop_na()
 

view(cats_uk)

data("cats_uk", package= "movieVis" )

m <- align_move(move_data, res = 4, unit = "mins")

# if your tracks are present as data.frames, see df2move() for conversion

# align move_data to a uniform time scale
m <- align_move(cats_uk, res = 4, unit = "mins")

# create spatial frames with a OpenStreetMap watercolour map
frames <- frames_spatial(m, path_colours = c("red", "green", "blue"),
                         map_service = "osm", map_type = "watercolor", alpha = 0.5) %>% 
  add_labels(x = "Longitude", y = "Latitude") %>% # add some customizations, such as axis labels
  add_northarrow() %>% 
  add_scalebar() %>% 
  add_timestamps(type = "label") %>% 
  add_progress()

frames[[100]] # preview one of the frames, e.g. the 100th frame

# animate frames
animate_frames(frames, out_file = "moveVis.gif")

cats_uk <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-31/cats_uk.csv')
cats_uk_reference <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-31/cats_uk_reference.csv')
UK <- map_data("world", region = "UK")

view(cats_uk)

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
