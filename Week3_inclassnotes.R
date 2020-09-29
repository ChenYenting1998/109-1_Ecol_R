# Week 3 
# Data type and structure
rm(list = ls())

library(tidyr)
# very important packages for data manipulation
rairuoho<-read.table('https://raw.githubusercontent.com/vianneydenis/attentive-suricate/master/Data/rairuoho.txt',header=T, sep="\t", dec=".")
head(rairuoho)

# the old/retired function
rairuoho %>% gather(key = Day, value = Length, day3:day8)
# the new function
rairuoho %>% pivot_longer(day3:day8, names_to = "Day", values_to = "Length")

# reshaping practice
tw_coral<- read.table('https://raw.githubusercontent.com/vianneydenis/attentive-suricate/master/Data/tw_corals.txt', header = T, sep = "\t")
# tw_coral is a wide data
tw_coral_long <- tw_coral %>% pivot_longer(Southern_TW:Northern_Is, names_to = "Region", values_to = "Richness")
tw_coral_long
tw_coral_wide <- tw_coral_long %>% pivot_wider(names_from = "Region", values_from = "Richness")
tw_coral_wide

# another practice
income <- read.table('https://raw.githubusercontent.com/vianneydenis/attentive-suricate/master/Data/metoo.txt', header = T, sep = "\t", dec = ".")
income # the comparision of salary between countries

########################################
#### Data object type and structure ####
########################################
?mode()
?typeof()


x <- c(1.0, -3.4, 2, 140.1)
mode(x)
typeof(x)
y <- 4

typeof(y)
typeof(4L) # adding an uppercase L behind the number returns integer                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  

#so tired
# numerical; integer; character;

# data types:
#### Factors ####
# nominal
# levels
a <- c("M", "F", "F", "U", "F", "M", "M", "M", "F", "U") # a itself is a character
af <- as.factor(a)
af
typeof(af) # not sure why this is identified as an integer
attributes(af) # attributes contains $class and $levels
class(af) # returns the class
levels(af) # returns the levels
factor(a, levels = c("U", "F", "M"))

#practice with iris
#subset( dataset,
#       conditions; logics)
iris.sel<- subset(iris, Species == "setosa" | Species == "virginica") # let's subset two species
levels(iris.sel$Species) # three levels are still their, yet only two of them are present in our sub setted data

boxplot(Petal.Width ~ Species, iris.sel, horizontal = TRUE) # with the informations of levels, there will be three speceis
# to prevent this, you need to drop levels
iris.sel$Species <- droplevels(iris.sel$Species) # go check what droplevels actually does
levels(iris.sel$Species)
boxplot(Petal.Width ~ Species, iris.sel, horizontal = TRUE) # with the informations of levels, there will be three speceis

boxplot(iris$Sepal.Width)
# note that boxplot itself focuses on frequency and the quantiles of the information
# what we add after only asks R to specify on factors.
boxplot(iris$Species, iris$Petal.Width, iris, horizontal = TRUE) # with the informations of levels, there will be three speceis
# line above doesnot work
# cuz 

colnames(iris)
iris.sel %>% boxplot(iris$Sepal.Width, iris$Species, horizontal = T)
