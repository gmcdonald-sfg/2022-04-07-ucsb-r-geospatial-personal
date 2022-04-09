library(sf)
library(ggplot2)
library(raster)

road_color <- c("blue","green","navy","purple")

ggplot() +
  geom_sf(data = aoi_boundary_HARV,
          fill = "grey",
          color = "gray") +
  geom_sf(data = lines_HARV,
          aes(color = TYPE),
          size = 1) +
  geom_sf(data = point_HARV,
          aes(fill = Sub_Type),
          shape = 15) +
  ggtitle("NEON Harvard Forest Field Site") +
  coord_sf() +
  scale_color_manual(values = road_color,
                     name = "Line type") +
  scale_fill_manual(values = "black",
                    name = "Tower Location")

?pch

plot_locations <- st_read(
  "data/NEON-DS-Site-Layout-Files/HARV/PlotLocations_HARV.shp"
)

unique(plot_locations$soilTypeOr)

blue_orange <- c("cornflowerblue","darkorange")

ggplot() +
  geom_sf(data = lines_HARV,
          aes(color = TYPE)) +
  geom_sf(data = plot_locations,
          aes(fill = soilTypeOr),
          shape = 21) +
  scale_color_manual(name = "Line type",
                    values = road_color) +
  scale_fill_manual(name = "Soil type",
                    values = blue_orange)
