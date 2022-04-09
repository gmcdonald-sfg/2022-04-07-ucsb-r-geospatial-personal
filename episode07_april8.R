library(sf)

library(dplyr)

library(ggplot2)

point_HARV

lines_HARV

ncol(lines_HARV)

names(lines_HARV)

head(lines_HARV)

ncol(point_HARV)

ncol(aoi_boundary_HARV)

point_HARV$Ownership

names(point_HARV)

lines_HARV$TYPE

unique(lines_HARV$TYPE)

footpath_HARV <- lines_HARV %>%
  filter(TYPE == "footpath")

footpath_HARV

ggplot() +
  geom_sf(data = footpath_HARV,
          aes(color = OBJECTID),
          size = 1.5) +
  ggtitle("NEON Harvard Forest Field Site",
          subtitle = "Footpaths") +
  coord_sf()


stonewall_HARV <- lines_HARV %>%
  filter(TYPE == "stone wall")

ggplot() +
  geom_sf(data = stonewall_HARV,
          aes(color = factor(OBJECTID)),
          size = 1.5) +
  ggtitle("NEON Harvard Forest Field Site",
          subtitle = "Stone walls") +
  coord_sf()

unique(lines_HARV$TYPE)

road_color <- c("blue", "green", "navy","purple")

ggplot() +
  geom_sf(data = lines_HARV,
          aes(color = TYPE)) +
  scale_color_manual(values = road_color) +
  labs(color = "Road type") +
  ggtitle("NEON site roads")
