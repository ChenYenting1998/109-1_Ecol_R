# Week 4 -- plotting
rm(list = ls())
plot(iris$Petal.Length)
plot(iris$Petal.Width)

?plot()
plot(iris$Petal.Length, iris$Petal.Width)
plot(dat = iris, Petal.Length~Petal.Width)
# tried pipe operator, didn't work

# Labelling 
plot(Petal.Length ~ Petal.Width, dat = iris,
     xlab = 'Petal width (cm)', # add label to x-axis 
     ylab = 'Petal length (cm)', # add label to y-axis 
     main = 'Petal width and length of iris flower') # add title to the plot 

# 
plot(Petal.Length ~ Petal.Width, dat = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     pch = 19,  # pch =  point character; 0~25 symbols
     cex=2,     # cex = enlarge the symbol of your plot
     col = rgb (0,0,0,0.10)) # set up symbol types and their color
?pch
# color can be directly called out "blue", "b", 
# use rgb to adjust/pick the color
# rgb(r, g, b, transparency)

# create distinctions 
col.iris<-ifelse(iris$Species=='setosa','purple',ifelse(iris$Species=='versicolor','blue','pink')) # create a vector of character with the name of the color we wanna use
col.iris

library(scales) # wtf is scales
plot(Petal.Length ~ Petal.Width, dat = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     pch = 19, cex=2, 
     col = alpha(col.iris, 0.2)) # set up symbol types and their color 
# col.iris already designates the color; uses alpha to determine its transparency

# adding legend
legend(x="bottomright", # topleft, topright, bottomleft
       # can also be specified by using xy coordinates
       pch= 19, cex=1.5,
       legend= c("versicolor","setosa", "virginica"),
       col=levels(as.factor(alpha(col.iris, 0.2)))) # the heart and soul of this line of code
levels(as.factor(col.iris)) # factorizes col.iris and extracts its levels
levels(as.factor(alpha(col.iris, 0.2))) # use alpha to modify its transparency
?alpha()

# las
# twists the xy labels horizontal or perpendicular
plot(Petal.Length ~ Petal.Width, dat = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     pch = 19, cex=2, las=1, # las = 0 (default), 1, 2, 3
     col = alpha(col.iris, 0.2)) # set up symbol types and their color 
legend(x="bottomright", pch= 19, cex=1.5, legend= c("versicolor","setosa", "virginica"), col=levels(as.factor(alpha(col.iris, 0.2))))

# cex
# cex can also control other variables' appearances
plot(Petal.Length ~ Petal.Width, dat = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     cex.axis=1.2,   # xy coordinate size
     cex.lab=1.5,    # xy label size
     cex.main=1.5,   # title size
     pch = 19, cex=3, las=1,  # cex itself controls point size
     col = alpha(col.iris, 0.2))

legend(x="bottomright", pch= 19, cex=1, legend= c("versicolor","setosa", "virginica"), col=levels(as.factor(alpha(col.iris, 0.2))))

# pairs
# this is DOPE
pairs(iris[1:4], pch = 19, cex = 1.2,col = alpha(col.iris, 0.2))

iris <- iris[order(iris$Petal.Width),] # first order; re order the table according the size of the Petal width

# type
# new data frame
blossom <- NULL
blossom$year <- 2010:2019 
blossom$count.alaska <- c(3, 1, 5, 2, 3, 8, 4, 7, 6, 9)
blossom$count.canada <- c(4, 6, 5, 7, 10, 8, 10, 11, 15, 17)
as.data.frame(blossom)
# "l" = line
plot(count.alaska ~ year, dat = blossom, type = "l", ylab = "No. of flower blossoming")
# "b" = both; use pch to modify dots
plot(count.alaska ~ year, dat = blossom, type = "b", pch = 19, ylab = "No. of flower blossoming")
# lty = line type; lwd = line width
plot(count.alaska ~ year,dat = blossom, type='b', pch=20,
     lty=1, lwd=2, col='red',
     ylab = "No. of flower blossoming") 
# add lines/ other data set
lines(count.canada ~ year,dat = blossom, type='b', pch=20,
      lty=3, lwd=0.5, col='blue')
# note that the plot is too small to include all the data points

# use range() to find the range
y.rng<-range(c(blossom$count.alaska, blossom$count.canada)) # use c() to combine both columns into a huge vector
y.rng #(returns two no.); c(a,b)
#ylim and xlim to define label range
plot(count.alaska ~ year,dat = blossom, type='l', ylim = y.rng,
     lty=2, lwd=1, col='red',
     ylab = "No. of flower blossoming") 
lines(count.canada ~ year,dat = blossom, # the range is already defined in the original plot
      lty=1, lwd=1, col='blue')

# Flow of building a plot
# define the range
# create an empty frame with plot(xlim = xrng, ylim = rngy, type = "n")
# add other features within plot() and other addins

# the advantage of this is you can specify anything according to different levels of data

# e.g.
# targeting two species: subsetting dataset and
iris.ver <- subset(iris, Species == "versicolor")
iris.vir <- subset(iris, Species == "virginica")
y.rng <- range( c(iris.ver$Petal.Length, iris.vir$Petal.Length) , na.rm = TRUE) 
x.rng <- range( c(iris.ver$Petal.Width, iris.vir$Petal.width) , na.rm = TRUE) 
# notice that na.rm is added to prevent failure

# create an empty frame
# how? type = "n"   none, don't plot anything

plot(Petal.Length ~ Petal.Width, dat = iris.ver,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     cex.axis=1.0, cex.lab=1.5, cex.main=1.5, type='n',
     xlim=x.rng,  ylim=y.rng)

# Add points for versicolor
points(Petal.Length ~ Petal.Width, dat = iris.ver, pch = 20,cex=2, 
       col = rgb(0,0,1,0.10))

# Add points for virginica
points(Petal.Length ~ Petal.Width, dat = iris.vir, pch = 20,cex=2, 
       col =  alpha('#fc03c6', 0.2)) 
# google "hexadecimal" or "color picker"
# it returns the color code of HTML

# Add legend
legend("topleft", c("versicolor", "virginica"), pch = 19, cex=1.2,
       col = c(rgb(0,0,1,0.10), alpha('#fc03c6', 0.2)))

# Boxplot
# summarizes the distribution of the data (quantile, median, outlier)
boxplot(iris$Sepal.Width, na.rm = TRUE)
boxplot(iris$Sepal.Width,
        iris$Sepal.Length, 
        iris$Petal.Width,
        iris$Petal.Length,  # names specifies the x labels 
        names = c("Sepal.Width", "Sepal.Length", "Petal.Length","Petal.Width"), 
        main = "Iris flower traits")
# horizontal = T
boxplot(iris$Sepal.Width,iris$Sepal.Length, iris$Petal.Width,iris$Petal.Length, names = c("Sepal.Width", "Sepal.Length", "Petal.Length","Petal.Width"), main = "Iris flower traits",outline = FALSE, horizontal = TRUE )
boxplot(Sepal.Width ~ Species,iris) 
# modifying boxplot
iris$Species.ord <- reorder(iris$Species,iris$Sepal.Width, median)
# reorder: changes the levels of the factor
levels(iris$Species.ord)
boxplot(Sepal.Width ~ Species.ord, iris)

# histograms

hists9
hist(iris$Sepal.Width, xlab = "Width of Sepal", main = NA)
hist(iris$Sepal.Width, xlab = "Width of Sepal", main = NA, breaks=10)

n <- 10  # Define the number of bin
minx <- min(iris$Sepal.Width, na.rm = TRUE)
maxx <- max(iris$Sepal.Width, na.rm = TRUE)
bins <- seq(minx, maxx, length.out = n +1)
hist(iris$Sepal.Width, xlab = "Width of Sepal", main = NA, breaks = bins)

# density plot
dens <- density(iris$Sepal.Width)
plot(dens, main = "Density distribution of the width of sepal")
# controllingband width
dens <- density(iris$Sepal.Width, bw=0.05)
plot(dens, main = "Density distribution of the width of sepal")

# QQ plot
# checking its normality
qqnorm(iris$Sepal.Width)
qqline(iris$Sepal.Width) # this is the theoretical line

# RP6
ra <- read.table('https://raw.githubusercontent.com/ChenYenting1998/attentive-suricate/master/Data/rairuoho.txt', header = T)
library(tidyr)
ral <- pivot_longer(ra, day3:day8 ,names_to = "day", values_to = "length")
ral$day <- gsub("day","", ral$day)

rngy <-range(ral$length) 
rngx <- as.numeric(range(ral$day))

plot(ral ,type = "n", 
     ylim = rngy,
     xlim = rngx,
     day~length)
points(day~length)

hist(ra$day7)
dens.rai <- density(ra$day7, bw=6)
plot(dens.rai, main = "Density distribution of thelength at Day 7")
qqnorm(ra$day7)
qqline(ra$day7)
boxplot(day7~treatment, data=ra) 
pairs(ra[,1:6])

# Graphical options
par() # parameters
# running this alone shows the default of all the parameters you can modify
par(mfrow=c(1,2))# define graphical parameter: 1 row, 2 columns
plot (1, 1, cex=15, pch=15) # 1st plot
plot (1, 1, cex=15, pch=19) # 2nd plot

# you can pre set all the stuff beforehand
par(mfrow = c(1,1), bg="#FCE8C5", mar=c(4,4,4,4), pch = 19, las=1, cex=1.2, cex.main=1.2, cex.axis=1,cex.lab=1)

plot(Petal.Length ~ Petal.Width, dat = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     col = alpha(col.iris, 0.2)) # set up symbol types and their color 

legend(x="bottomright", pch= 19, cex=0.8, legend= c("versicolor","setosa", "virginica"), col=levels(as.factor(alpha(col.iris, 0.2))))

# to initialize the graphical parameters
dev.off()

# other parameters
plot(1,1, pch = 6)
title (main='title', ylab='y-axis title', xlab = 'x-axis title')
text (x=1, y=1,'text')
mtext ('text', side=1, line=1) # margin text
abline (h=1)
abline (v=1)


# Exporting plots ####
# R can export plots in several file types
# image (unmodifiable): jpg, png...
# vector file (modifiable): pdf, PostScript

# no compression; resolution = 300 dpi
setwd("C:\\Users\\tumha\\Desktop\\IONTU\\Ecological_Data_Analysis_in_R\\109-1_Ecol_R")
tiff(filename = "iris_plot.tif", width = 5, height = 6, units = "in", compression = "none", res = 300)
# change tiff to pdf if you wanna save tit as a pdf
par(bg="#FCE8C5", mar=c(4,4,4,4), pch = 19, las=1, cex=1.2, cex.main=1.2, cex.axis=1,cex.lab=1)

plot(Petal.Length ~ Petal.Width, dat = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     col = alpha(col.iris, 0.2)) # set up symbol types and their color 

legend(x="bottomright", pch= 19, cex=0.8, legend= c("versicolor","setosa", "virginica"), col=levels(as.factor(alpha(col.iris, 0.2))))

dev.off()
