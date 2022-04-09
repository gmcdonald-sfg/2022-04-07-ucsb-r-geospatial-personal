library(sf)

library(ggplot2)

aoi_boundary_HARV <- st_read(
  "data/NEON-DS-Site-Layout-Files/HARV/HarClip_UTMZ18.shp"
)

st_geometry_type(aoi_boundary_HARV)

st_crs(aoi_boundary_HARV)

st_bbox(aoi_boundary_HARV)

aoi_boundary_HARV

ggplot() +
  geom_sf(data = aoi_boundary_HARV,
          size = 3, color = "black", fill = "cyan1") +
  coord_sf()

lines_HARV <- st_read(
  "data/NEON-DS-Site-Layout-Files/HARV/HARV_roads.shp"
)

point_HARV <- st_read(
  "data/NEON-DS-Site-Layout-Files/HARV/HARVtower_UTM18N.shp"
)

class(lines_HARV)
class(point_HARV)

st_geometry_type(lines_HARV)

st_geometry_type(point_HARV)

st_crs(lines_HARV)

st_crs(point_HARV)

st_bbox(lines_HARV)

st_bbox(point_HARV)

nrow(lines_HARV)

nrow(point_HARV)
