rm(list = ls())
# Subkect: Part of my thesis
# sampling sites on the Gaoping and Pearl River Shelf
# Requirement:
# 1. site coordinates
# 2. bathymetric data

# Strategy: 
# 1. plot maps with depths
# 2. adding coordinates
# 3  miscellaneous stuffs
library(marmap)
ba <- getNOAA.bathy(lon1=111,lon2=124, lat1=20,lat2=26,resolution=1)
# generate a color gradient function for plot.bathy
oc <- colorRampPalette(c('cyan', 'darkblue', "purple"))
oc # returns a function; type in numbers and then the function will do its work
te <- colorRampPalette(c("lightgreen", "darkgreen"))
plot.bathy(ba, # data
           image = T, # color the depth layers
           deepest.isobath = c(-6000, -300, -100, 0), # deepest isobath
           shallowest.isobath = c(-1000, -100, 0, 0), # shallowest isobath
           step = c(2000, 100, 20, 0), # distance btw two isobaths
           lwd = c(0.5, 1, 1, 2), # isobath line width
           lty = c(1,1,1,1), # isobath line type
           col = c("grey", "black", "black", "black"),
           drawlabels = c(T,T,T,F), #whether plot the depth of the isobaths
           land = T,
           bpal = list(c(0, max(ba), te(100)),c(min(ba), 0, rev(oc(100)))) ) # a list of depth bounds and colors
text(x = 121, y = 24, "Taiwan", cex = 1.6)
text(x = 116, y = 25, "China", cex = 1.6)

# input sample sites
library(readxl)
da <- read_xlsx("C:\\Users\\tumha\\Desktop\\Lab Work\\Field work\\LGD2006\\OR1_1242_LGD_2006_Station.xlsx",col_names = T)
ss <- data.frame(da$Station, da$Longitude, da$Latitude)
points(x = da$Longitude, y = da$Latitude, pch = 18, col = 2, cex = 2)
text(x = da$Longitude, y = da$Latitude+0.5, da$Station, col = 2, cex = 0.8, font = 2)



library(ggplot2) # install.packages('ggplot2')
library(ggspatial) #install.packages('ggspatial')
ggplot(data = ba)#+
  geom_sf()+
  geom_text()+
  coord_sf()


# map export
ggsave()