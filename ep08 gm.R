# Episode 8: Plot Multiple Shapefiles
# https://ucsbcarpentry.github.io/2022-04-07-ucsb-r-geospatial/08-vector-plot-shapefiles-custom-legend/index.html

########################################################
## Load the Data
########################################################

library(sf)

library(ggplot2)

library(raster)

# Change this to match the directory where your data folder lives, 
# and where your R code script will live
setwd("~/github/2022-04-07-ucsb-r-geospatial-personal")

aoi_boundary_HARV <- st_read(
  "data/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp")

lines_HARV <- st_read("data/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp")

point_HARV <- st_read("data/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp")

########################################################
## Plotting Multiple Shapefiles
########################################################

ggplot() + 
  geom_sf(data = aoi_boundary_HARV, fill = "grey", color = "grey") +
  geom_sf(data = lines_HARV, aes(color = TYPE), size = 1) +
  geom_sf(data = point_HARV) +
  ggtitle("NEON Harvard Forest Field Site") + 
  coord_sf()

unique(lines_HARV$TYPE)

road_colors <- c("blue", "green", "navy", "purple")

ggplot() + 
  geom_sf(data = aoi_boundary_HARV, fill = "grey", color = "grey") +
  geom_sf(data = lines_HARV, aes(color = TYPE),
          show.legend = "line", size = 1) +
  geom_sf(data = point_HARV, aes(fill = Sub_Type), color = "black") +
  scale_color_manual(values = road_colors) +
  scale_fill_manual(values = "black") +
  ggtitle("NEON Harvard Forest Field Site") + 
  coord_sf()

ggplot() + 
  geom_sf(data = aoi_boundary_HARV, fill = "grey", color = "grey") +
  geom_sf(data = point_HARV, aes(fill = Sub_Type)) +
  geom_sf(data = lines_HARV, aes(color = TYPE), show.legend = "line",
          size = 1) + 
  scale_color_manual(values = road_colors, name = "Line Type") + 
  scale_fill_manual(values = "black", name = "Tower Location") + 
  ggtitle("NEON Harvard Forest Field Site") + 
  coord_sf()

?pch

ggplot() +
  geom_sf(data = aoi_boundary_HARV, fill = "grey", color = "grey") +
  geom_sf(data = point_HARV, aes(fill = Sub_Type), shape = 15) +
  geom_sf(data = lines_HARV, aes(color = TYPE),
          show.legend = "line", size = 1) +
  scale_color_manual(values = road_colors, name = "Line Type") +
  scale_fill_manual(values = "black", name = "Tower Location") +
  ggtitle("NEON Harvard Forest Field Site") + 
  coord_sf()

########################################################
## Challenge: Plot Polygon by Attribute
########################################################

# Using the NEON-DS-Site-Layout-Files/HARV/PlotLocations_HARV.shp shapefile, 
# create a map of study plot locations, with each point colored by the soil type (soilTypeOr). 
# How many different soil types are there at this particular field site? 
# Overlay this layer on top of the lines_HARV layer (the roads). 
# Create a custom legend that applies line symbols to lines and point symbols to the points.

plot_locations <- st_read("data/NEON-DS-Site-Layout-Files/HARV/PlotLocations_HARV.shp")

unique(plot_locations$soilTypeOr)

blue_orange <- c("cornflowerblue", "darkorange")

ggplot() + 
  geom_sf(data = lines_HARV, aes(color = TYPE), show.legend = "line") + 
  geom_sf(data = plot_locations, aes(fill = soilTypeOr), 
          shape = 21, show.legend = 'point') + 
  scale_color_manual(name = "Line Type", values = road_colors,
                     guide = guide_legend(override.aes = list(linetype = "solid", shape = NA))) + 
  scale_fill_manual(name = "Soil Type", values = blue_orange,
                    guide = guide_legend(override.aes = list(linetype = "blank", shape = 21, colour = NA))) + 
  ggtitle("NEON Harvard Forest Field Site") + 
  coord_sf()

# Modify the plot above. Tell R to plot each point, using a different symbol of shape value.

ggplot() + 
  geom_sf(data = lines_HARV, aes(color = TYPE), show.legend = "line", size = 1) + 
  geom_sf(data = plot_locations, aes(fill = soilTypeOr, shape = soilTypeOr),
          show.legend = 'point', size = 3) + 
  scale_shape_manual(name = "Soil Type", values = c(21, 22)) +
  scale_color_manual(name = "Line Type", values = road_colors,
                     guide = guide_legend(override.aes = list(linetype = "solid", shape = NA))) + 
  scale_fill_manual(name = "Soil Type", values = blue_orange,
                    guide = guide_legend(override.aes = list(linetype = "blank", shape = c(21, 22),
                                                             color = blue_orange))) + 
  ggtitle("NEON Harvard Forest Field Site") + 
  coord_sf()

########################################################
## Challenge: Plot Raster & Vector Data Together
########################################################

HARV_chmCrop<- 
  raster("data/NEON-DS-Airborne-Remote-Sensing/HARV/CHM/HARV_chmCrop.tif")

CHM_HARV_df <- as.data.frame(HARV_chmCrop, xy = TRUE)

ggplot() +
  geom_raster(data = CHM_HARV_df, aes(x = x, y = y, fill = HARV_chmCrop)) +
  geom_sf(data = lines_HARV, color = "black") +
  geom_sf(data = aoi_boundary_HARV, color = "grey20", size = 1) +
  geom_sf(data = point_HARV, pch = 8) +
  ggtitle("NEON Harvard Forest Field Site w/ Canopy Height Model") + 
  coord_sf()
