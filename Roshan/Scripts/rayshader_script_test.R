library(rayshader)

## the 'sf' package is used to read our boundary shapefile.
## the 'elevatr' package is used to get elevation data.
library(sf)
library(elevatr)
library(rgl)
library(raster)
library(sp)
library(maptools)
library(dplyr)
update.packages()

# read in Grand Canyon National Park boundaries
data <- st_read("Roshan/data/grca_tracts/GRCA_boundary.shp")

# Query for elevation data, masked by our 'location' specified as the 
# `data` object, defined above.
gcnp_elev <- get_elev_raster(data, z = 10, clip = "location")

# Convert our raster data in 
mat <- raster_to_matrix(gcnp_elev)



colors <- c("blue", "white", "red")
palette_func <- grDevices::colorRampPalette(colors)
palette <- palette_func(256)
shade <- height_shade(mat, texture = palette)
plot_3d(shade, heightmap = mat)

mat |>
  height_shade(texture = grDevices::colorRampPalette(colors)(256)) |>
  plot_3d(heightmap = mat) 

packageVersion("rayshader")

available <- available.packages()
available["rayshader", "Version"]

montereybay %>%
  height_shade() %>%
  plot_map()

montereybay %>%
  height_shade() %>%
  add_shadow(ray_shade(montereybay,zscale=50),0.3) %>%
  plot_map()
remove.packages("dplyr")
install.packages("dplyr",dependencies=TRUE)
