rm(list = ls())
setwd("C:\\Users\\tumha\\Desktop\\IONTU\\Ecological_Data_Analysis_in_R\\attentive-suricate")
# default map tools
library('maptools')
data(wrld_simpl)
plot(wrld_simpl)
plot(wrld_simpl, xlim = c(13, 100), ylim = c(12,15),col='olivedrab3',bg='lightblue')
?wrld_simpl

# reading GPS data
# exports in the format of .gpx
library(rgdal)
# readOGR
par(mfrow = c(1,2))
run1 <- readOGR(dsn = "Data/run.gpx", layer = "tracks")
str(run1)
plot(run1, main = "line")
run2 <- readOGR(dsn = "Data/run.gpx", layer = "track_points")
plot(run2, main= "Points")
dev.off()
# writeOGR
writeOGR(wrld_simpl, dsn = "Data", layer = "world_test", driver = "ESRI Shapefile", overwrite_layer = T)
world_shp <- readOGR(dsn = "Data",layer = "world_test")
plot(world_shp)

# spatial data types
# plotted in points
plot(wrld_simpl,xlim=c(115,128) ,ylim=c(19.5,27.5),col='#D2B48C',bg='lightblue') # TW map
coords <- matrix(c(121.537290,120.265541, 25.021335, 22.626524),ncol=2) # NTU and SYS univ. 
coords <- coordinates(coords)
spoints <- SpatialPoints(coords) # matrix -> coordinates -> spatial data type
spoints
df <- data.frame(location = c ("NTU", "SYS")) # name of the points
spointsdf <- SpatialPointsDataFrame(spoints, df) 
plot(spointsdf, add = T, col = c('black', "black"))
text(121,24, "TW")

# plotted in lines
plot(wrld_simpl,xlim=c(-130,-60),ylim=c(45,80),col='#D2B48C',bg='lightblue')
coords <- matrix(c(-110,-102,-102,-110,-110,60,60,49,49,60),ncol=2)
coords
l <- Line(coords)
ls <- Lines(list(l),ID="1")
sls <- SpatialLines(list(ls))
df <- data.frame(province="Saskatchewan")
sldf <- SpatialLinesDataFrame(sls,df)
plot(sldf,add=T,col='#3d2402', cex=2)
text(-114, 55, 'Saskatchewan', srt=90, cex=0.7)
text(-114, 63, 'CANADA', cex=1)

# plotted in polygons
plot(wrld_simpl,xlim=c(-130,-60),ylim=c(45,80),col='#D2B48C',bg='lightblue')
coords <- matrix(c(-110,-102,-102,-110,-110,60,60,49,49,60),ncol=2)
p <- Polygon(coords)
ps <- Polygons(list(p),ID="1")
sps <- SpatialPolygons(list(ps))
df <- data.frame(province="Saskatchewan")
spdf <- SpatialPolygonsDataFrame(sps,df)
plot(spdf,add=T,col='#45220d') 
text(-114, 55, 'Saskatchewan', srt=90, cex=0.7)
text(-114, 63, 'CANADA', cex=1)
text(-103, 46, 'UNITED STATES', cex=1)
text(-40, 78, 'GREENLAND', cex=1)
text(-35, 55, 'Atlantic Ocean', cex=1, col='#071238')


#
download.file("https://www.dipintothereef.com/uploads/3/7/3/5/37359245/twn_adm.zip", destfile="Data/taiwan_shape.zip") # download file
unzip('taiwan_shape.zip',exdir="Data/taiwan_shape_unzip") # unzip it 
taiwan <- readOGR(dsn = "Data/taiwan_shape_unzip",layer = "TWN_adm0")
plot(taiwan)
plot(taiwan, axes = T, xlim=c(120,123), ylim=c(24,25.5), bg = colors()[431], col = 'grey')

# raster
# a functoin called getData allows user to download data from GADM
library(raster)
TWN <- getData('GADM', country="TWN", level=1) # data Taiwan
JPN <- getData('GADM', country="JPN", level=1) # data Japan
plot(JPN,axes=T,bg=colors()[431],col='grey')
class(TWN)
TWN$NAME_1 # shows all the provinces in taiwan
plot(TWN,col="grey",xlim=c(119,122.5), ylim=c(21.5,25.5), bg=colors()[431], axes=T)
KAO <- TWN[TWN$NAME_1=="Kaohsiung",]
plot(KAO,col="gray 33",add=TRUE)

# customiztions
plot(TWN,col="grey",xlim=c(121,122), ylim=c(24,25.5), bg=colors()[431], axes=T)
coords <- matrix(cbind(lon=c(121.2,121.6,121.8),lat=c(25,25.1,24.5)),ncol=2)
coords <- coordinates(coords)
spoints <- SpatialPoints(coords)
df <- data.frame(location=c("City 1","City 2","City 3"),pop=c(138644,390095,34562))
spointsdf <- SpatialPointsDataFrame(spoints,df)
scalefactor <- sqrt(spointsdf$pop)/sqrt(max(spointsdf$pop)) # works as a equation here
plot(spointsdf,add=TRUE,col='black',pch=16,cex=scalefactor*5) 
# add location of NTU
points(121.537290,25.021335, type="p", pch=18, col=2, cex=2)
# add text
text(121.437290,24.921335,"NTU", col='red', font=2)
# add scale
maps::map.scale(x=121.8, y=24.15)
# add north arrow
GISTools::north.arrow(xb=122.25,yb=24.5, len=0.06, lab='N')

# ggplot2
# although ggplot2 does not have specific tools to create maps
# a new package "sf" (a newer version of the package "sp")
# has functions that ggplot2 can use.
library(ggplot2)
theme_set(theme_bw())
library(sf)
library("rnaturalearth")
library("rnaturalearthdata")
world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)
ggplot(world) + geom_sf()

ggplot(data = world) +
  geom_sf() +
  coord_sf(expand = FALSE)

ggplot(data = world) +
  geom_sf() +
  coord_sf(expand = FALSE) + # this line is for preventing the map's edge
  xlab("Longitude") + ylab("Latitude") +
  ggtitle("World map", subtitle = paste0("(", length(unique(world$name)), " countries)"))

ggplot(data = world) + 
  geom_sf(color = "black", fill = "lightgreen") +
  coord_sf(expand = FALSE)

ggplot(data = world) +
  geom_sf(aes(fill = pop_est)) + # works as a normal geom_ function
  coord_sf(expand = FALSE) +
  scale_fill_viridis_c(option = "plasma", trans = "sqrt") # changes color
