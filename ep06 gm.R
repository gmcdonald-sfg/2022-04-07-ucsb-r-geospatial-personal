# Episode 6: Open and Plot Shapefiles
# https://ucsbcarpentry.github.io/2022-04-07-ucsb-r-geospatial/06-vector-open-shapefile-in-r/index.html
# First, download the data, and save it to the data folder
# Download from https://ndownloader.figshare.com/articles/2009586/versions/10
# Unzip files

########################################################
## Import Shapefiles
########################################################

# Nice link for what vector data is
# https://datacarpentry.org/organization-geospatial/02-intro-vector-data/

library(sf)
library(ggplot2)

# Change this to match the directory where your data folder lives, 
# and where your R code script will live
setwd("~/github/2022-04-07-ucsb-r-geospatial-personal")

aoi_boundary_HARV <- st_read(
  "data/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp")

########################################################
## Shapefile Metadata & Attributes
########################################################

########################################################
## Spatial Metadata
########################################################

st_geometry_type(aoi_boundary_HARV)

st_crs(aoi_boundary_HARV)

st_bbox(aoi_boundary_HARV)

aoi_boundary_HARV


########################################################
## Spatial Data Attributes
########################################################

########################################################
## Plot a Shapefile
########################################################

ggplot() + 
  geom_sf(data = aoi_boundary_HARV, size = 3, color = "black", fill = "cyan1") + 
  ggtitle("AOI Boundary Plot") + 
  coord_sf()

########################################################
## Challenge: Import Line and Point Shapefiles
########################################################


lines_HARV <- st_read(
  "data/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp")

point_HARV <- st_read(
  "data/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp")

# 1. What type of R spatial object is created when you import each layer?
class(lines_HARV)

class(point_HARV)

st_geometry_type(lines_HARV)

st_geometry_type(point_HARV)

# 2. What is the CRS and extent for each object?

st_crs(lines_HARV)

st_crs(point_HARV)

st_bbox(point_HARV)

st_bbox(lines_HARV)

# 3. Do the files contain points, lines, or polygons?

lines_HARV

st_geometry_type(lines_HARV)

point_HARV
st_geometry_type(point_HARV)

# 4. How many spatial objects are in each file?

nrow(lines_HARV)
lines_HARV

nrow(point_HARV)
point_HARV

