# Episode 7: Explore and Plot by Vector Layer Attributes
# https://ucsbcarpentry.github.io/2022-04-07-ucsb-r-geospatial/07-vector-shapefile-attributes-in-r/index.html

########################################################
## Load the Data
########################################################

library(sf)

library(dplyr)

library(ggplot2)

setwd("~/github/2022-04-07-ucsb-r-geospatial-personal")

aoi_boundary_HARV <- st_read(
  "data/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp")

lines_HARV <- st_read("data/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp")

point_HARV <- st_read("data/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp")

########################################################
## Query Vector Feature Metadata
########################################################

point_HARV

ncol(lines_HARV)

names(lines_HARV)

head(lines_HARV)

########################################################
## Challenge: Attributes for Different Spatial Classes
######################################################## 

# 1. How many attributes does each have?

ncol(point_HARV)

ncol(aoi_boundary_HARV)

# 2. Who owns the site in the point_HARV data object?

point_HARV$Ownership

# 3. Which of the following is NOT an attribute of the point_HARV data object?

names(point_HARV)

# “Country” is not an attribute of this object.

########################################################
## Explore Values within One Attribute
########################################################

lines_HARV$TYPE

unique(lines_HARV$TYPE)

########################################################
## Subset Features
######################################################## 

footpath_HARV <- lines_HARV %>% 
  filter(TYPE == "footpath")

footpath_HARV

nrow(footpath_HARV)

ggplot() + 
  geom_sf(data = footpath_HARV) +
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Footpaths") + 
  coord_sf()

ggplot() + 
  geom_sf(data = footpath_HARV, aes(color = factor(OBJECTID)), size = 1.5) +
  labs(color = 'Footpath ID') +
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Footpaths") + 
  coord_sf()

########################################################
#### SKIP THIS CHALLENGE

########################################################
## Challenge: Subset Spatial Line Objects Part 1
########################################################

# Subset out all boardwalk from the lines layer and plot it.

boardwalk_HARV <- lines_HARV %>% 
  filter(TYPE == "boardwalk")

nrow(boardwalk_HARV)

ggplot() + 
  geom_sf(data = boardwalk_HARV, size = 1.5) +
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Boardwalks") + 
  coord_sf()

########################################################
#### DO THIS CHALLENGE

########################################################
## Challenge: Subset Spatial Line Objects Part 2
########################################################

# Subset out all stone wall features from the lines layer and plot it. For each plot, color each feature using a unique color.

stoneWall_HARV <- lines_HARV %>% 
  filter(TYPE == "stone wall")

nrow(stoneWall_HARV)

ggplot() +
  geom_sf(data = stoneWall_HARV, aes(color = factor(OBJECTID)), size = 1.5) +
  labs(color = 'Wall ID') +
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Stonewalls") + 
  coord_sf()

########################################################
## Customize Plots
########################################################

unique(lines_HARV$TYPE)

road_colors <- c("blue", "green", "navy", "purple")

ggplot() +
  geom_sf(data = lines_HARV, aes(color = TYPE)) + 
  scale_color_manual(values = road_colors) +
  labs(color = 'Road Type') +
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Roads & Trails") + 
  coord_sf()

########################################################
#### SKIP THIS SECTION

########################################################
## Adjust Line Width
########################################################
line_widths <- c(1, 2, 3, 4)

ggplot() +
  geom_sf(data = lines_HARV, aes(color = TYPE, size = TYPE)) + 
  scale_color_manual(values = road_colors) +
  labs(color = 'Road Type') +
  scale_size_manual(values = line_widths) +
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Roads & Trails - Line width varies") + 
  coord_sf()

########################################################
#### SKIP THIS CHALLENGE

########################################################
## Challenge: Plot Line Width by Attribute
########################################################

unique(lines_HARV$TYPE)

line_width <- c(1, 3, 2, 6)

ggplot() +
  geom_sf(data = lines_HARV, aes(size = TYPE)) +
  scale_size_manual(values = line_width) +
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Roads & Trails - Line width varies") + 
  coord_sf()

########################################################
## Add Plot Legend
########################################################

ggplot() + 
  geom_sf(data = lines_HARV, aes(color = TYPE), size = 1.5) +
  scale_color_manual(values = road_colors) +
  labs(color = 'Road Type') + 
  ggtitle("NEON Harvard Forest Field Site", 
          subtitle = "Roads & Trails - Default Legend") + 
  coord_sf()

ggplot() + 
  geom_sf(data = lines_HARV, aes(color = TYPE), size = 1.5) +
  scale_color_manual(values = road_colors) + 
  labs(color = 'Road Type') +
  theme(legend.text = element_text(size = 20), 
        legend.box.background = element_rect(size = 1)) + 
  ggtitle("NEON Harvard Forest Field Site", 
          subtitle = "Roads & Trails - Modified Legend") +
  coord_sf()

new_colors <- c("springgreen", "blue", "magenta", "orange")

ggplot() + 
  geom_sf(data = lines_HARV, aes(color = TYPE), size = 1.5) + 
  scale_color_manual(values = new_colors) +
  labs(color = 'Road Type') +
  theme(legend.text = element_text(size = 20), 
        legend.box.background = element_rect(size = 1)) + 
  ggtitle("NEON Harvard Forest Field Site", 
          subtitle = "Roads & Trails - Pretty Colors") +
  coord_sf()

########################################################
#### SKIP THIS CHALLENGE

########################################################
## Challenge: Plot Lines by Attribute
########################################################

class(lines_HARV$BicyclesHo)

unique(lines_HARV$BicyclesHo)

lines_removeNA <- lines_HARV[!is.na(lines_HARV$BicyclesHo),] 

lines_showHarv <- lines_removeNA %>% filter(BicyclesHo == "Bicycles and Horses Allowed")

ggplot() + 
  geom_sf(data = lines_HARV) + 
  geom_sf(data = lines_showHarv, aes(color = BicyclesHo), size = 2) + 
  scale_color_manual(values = "magenta") +
  ggtitle("NEON Harvard Forest Field Site", subtitle = "Roads Where Bikes and Horses Are Allowed") + 
  coord_sf()

########################################################
#### DO THIS CHALLENGE

########################################################
## Challenge: Plot Polygon by Attribute
########################################################

state_boundary_US <- 
  st_read("data/NEON-DS-Site-Layout-Files/US-Boundary-Layers/US-State-Boundaries-Census-2014.shp")

state_boundary_US

unique(state_boundary_US$region)

colors <- c("purple", "springgreen", "yellow", "brown", "navy")

ggplot() +
  geom_sf(data = state_boundary_US, aes(color = region), size = 1) +
  scale_color_manual(values = colors) +
  ggtitle("Contiguous U.S. State Boundaries") + 
  coord_sf()
