library(maptools)
data(wrld_simpl)
wrld_simpl

plot(wrld_simpl,xlim=c(100,130),ylim=c(-20,50),col='olivedrab3',bg='lightblue')


setwd('C:\\Users\\tumha\\Desktop\\IONTU\\Ecological_Data_Analysis_in_R\\attentive-suricate')

install.packages('rgdal')
library(rgdal)
par(mfrow=c(1,2))
run1 <- readOGR(dsn="Data/run.gpx",layer="tracks")
plot(run1, main='Line') # my running activity
run2 <- readOGR(dsn="Data/run.gpx",layer="track_points")
plot(run2, main='Points')

writeOGR(wrld_simpl,dsn="Data", layer = "world_test", driver = "ESRI Shapefile", overwrite_layer = TRUE)


dev.off()

plot(wrld_simpl,xlim=c(115,128) ,ylim=c(19.5,27.5),col='#D2B48C',bg='lightblue') # TW map
coords <- matrix(c(121.537290,120.265541, 25.021335, 22.626524),ncol=2) # NTU and SYS univ. 
coords <- coordinates(coords) # assign values as spatial coordinates
spoints <- SpatialPoints(coords) # create SpatialPoints
df <- data.frame(location=c("NTU","SYS")) # create a dataframe
spointsdf <- SpatialPointsDataFrame(spoints,df) # create a SpatialPointsDataFrame
plot(spointsdf,add=T,col=c('black','black'),pch=19,cex=2.2) # plot it on our map
text(121,24, 'TAIWAN', cex=1)


plot(wrld_simpl,xlim=c(-130,-60),ylim=c(45,80),col='#D2B48C',bg='lightblue')
coords <- matrix(c(-110,-102,-102,-110,-110,60,60,49,49,60),ncol=2)
l <- Line(coords)
ls <- Lines(list(l),ID="1")
sls <- SpatialLines(list(ls))
df <- data.frame(province="Saskatchewan")
sldf <- SpatialLinesDataFrame(sls,df)
plot(sldf,add=T,col='#3d2402', cex=2)
text(-114, 55, 'Saskatchewan', srt=90, cex=0.7)
text(-114, 63, 'CANADA', cex=1)

download.file("https://www.dipintothereef.com/uploads/3/7/3/5/37359245/twn_adm.zip", destfile="Data/taiwan_shape.zip") # download file
unzip('taiwan_shape.zip',exdir="Data/taiwan_shape_unzip") # unzip it 
taiwan <- readOGR(dsn = "Data/taiwan_shape_unzip",layer = "TWN_adm0")
plot(taiwan)
plot (taiwan, axes=T, xlim=c(121,122), ylim=c(24,25.5), bg=colors()[431],col='grey') # add colors


install.packages("raster")
library(raster)
TWN <- getData('GADM', country="TWN", level=1) # data Taiwan
plot(TWN,col="grey",xlim=c(119,122.5), ylim=c(21.5,25.5), bg=colors()[431], axes=T)
KAO <- TWN[TWN$NAME_1=="Kaohsiung",]
plot(KAO,col="gray 33",add=TRUE)


plot(TWN,col="grey",xlim=c(121,122), ylim=c(24,25.5), bg=colors()[431], axes=T)
coords <- matrix(cbind(lon=c(121.2,121.6,121.8),lat=c(25,25.1,24.5)),ncol=2)
coords <- coordinates(coords)
spoints <- SpatialPoints(coords)
df <- data.frame(location=c("City 1","City 2","City 3"),pop=c(138644,390095,34562))
spointsdf <- SpatialPointsDataFrame(spoints,df)
scalefactor <- sqrt(spointsdf$pop)/sqrt(max(spointsdf$pop))
plot(spointsdf,add=TRUE,col='black',pch=16,cex=scalefactor*5) 
# add location of NTU
points(121.537290,25.021335, type="p", pch=18, col=2, cex=2)
# add text
text(121.437290,24.921335,"NTU", col='red', font=2)
# add scale
maps::map.scale(x=121.8, y=24.15)
# add north arrow

plot(TWN,col="grey",xlim=c(121,122), ylim=c(24,25.5), bg=colors()[431], axes=T)
coords <- matrix(cbind(lon=c(121.2,121.6,121.8),lat=c(25,25.1,24.5)),ncol=2)
coords <- coordinates(coords)
spoints <- SpatialPoints(coords)
df <- data.frame(location=c("City 1","City 2","City 3"),pop=c(138644,390095,34562))
spointsdf <- SpatialPointsDataFrame(spoints,df)
scalefactor <- sqrt(spointsdf$pop)/sqrt(max(spointsdf$pop))
plot(spointsdf,add=TRUE,col='black',pch=16,cex=scalefactor*5) 
# add location of NTU
points(121.537290,25.021335, type="p", pch=18, col=2, cex=2)
# add text
text(121.437290,24.921335,"NTU", col='red', font=2)
# add scale
maps::map.scale(x=121.8, y=24.15)
# add north arrow
GISTools::north.arrow(xb=122.25,yb=24.5, len=0.06, lab='N')
GISTools::north.arrow(xb=122.25,yb=24.5, len=0.06, lab='N')


#install.packages("sf")
library(ggplot2)
library(sf)
theme_set(theme_bw()) # the night mode of ggplot 
install.packages("rnaturalearth")
install.packages("rnaturalearthdata")
library("rnaturalearth")
library("rnaturalearthdata")
library(rgeos)
world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)
ggplot(data = world) + geom_sf() # the grid line diconnects with the map
ggplot(data = world) + geom_sf() + coord_sf(expand = F) # turn off the expansion for matching grid lines with the map
ggplot(data = world) + geom_sf(color = "black", fill = "lightgreen") + coord_sf(expand = F)
ggplot(data = world) +
  geom_sf(aes(fill = pop_est)) +
  coord_sf(expand = FALSE) +
  scale_fill_viridis_c(option = "plasma", trans = "sqrt") # don't know what is last line is


library(ggspatial)
ggplot(data = world) +
  geom_sf() +
  annotation_scale(location = "br", width_hint = 0.4) +
  annotation_north_arrow(location = "br", which_north = "true", 
                         pad_x = unit(0.5, "cm"), pad_y = unit(1, "cm"),
                         style = north_arrow_fancy_orienteering) +
  coord_sf(xlim = c(118, 128), ylim = c(17, 27), expand = FALSE)


gbif.res <- occ_search(scientificName = "Urocissa caerulea", limit = 1200)

map_ggplot(gbif.res) +
  coord_sf(xlim = c(120, 123), ylim = c(21, 26), expand = FALSE)

install.packages('marmap')
library(marmap)
TW.bathy <- getNOAA.bathy(lon1=118,lon2=124, lat1=21,lat2=26,resolution=1) # don't put too wide / resolution: 1 







#### so fucking tired
# make a map
# assignment
