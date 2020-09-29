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
# In general, deal with factors carefully
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
levels(iris.sel$Species) # three levels are still their, yet only two of them are present in our sub-setted data

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

# Date ####
# won;t be covered in this week
# to my personal exp, its a huge pain in the ass

# NA & NULL####
# NA: not available
# NULL: does not exist/ cannot be measured
x <- c(23, NA, 1.2, 5)
y <- c(23, NULL, 1.2, 5)
mean(x)
mean(y) # NULL will be escaped (I mean that y was been divided by 3 rather than 4)
mean(x, na.rm = T) # must input na.rm = T for things to work

#### Data structure ####
# vector (a.k.a. atomic vector)
#        simplest data form in R
#        c() to combine values
#        consists the same type of values
#        numerical vec., character vec.,
#        unidirectional (in a mathematical sense)
#        mixing data types within the vector would only return as character vecs.


# matrix and array
#        you know, for linear algebra stuffs
#        use matrix() to generate matrices  
m <- matrix(runif(9,0,10), nrow = 3, ncol = 3)
m # quick reminder: runif stands for random uniform dis.
#        for higher dimensional data, use array
m <- array(runif(27,0,10), c(3,3,3))
m
#        it is possible for matrices and arrays for storing numerical and character data
#        and of course, they cannot store both at the same time

# data frame
#         just think this as a combination of vectors that does not exclude different types of data
name   <- c("a1", "a2", "b3")
value1 <- c(23, 4, 12)
value2 <- c(1, 45, 5)
dat    <- data.frame(name, value1, value2)
dat
#          rownames(); colnames

# list
#         this boi stacks all the stuff together into one object
A <- data.frame(
  x = c(7.3, 29.4, 29.4, 2.9, 12.3, 7.5, 36.0, 4.8, 18.8, 4.2),
  y = c(5.2, 26.6, 31.2, 2.2, 13.8, 7.8, 35.2, 8.6, 20.3, 1.1) )
B <- c(TRUE, FALSE)
C <- c("apples", "oranges", "round")
lst <- list(A = A, B = B, C = C) # Note that we specifies the names of the objects
str(lst)
names(lst)
lst$A 
lst[[1]] # analogous to lst$A
class(lst[[1]])
#          Lists actually do not have the need to name their sub-objects
lst.notags <- list(A, B, C)
lst.notags
names(lst.notags) # returns NULL

M <- lm( y ~ x, A)
str(M) # str() can return a shit load of information
names(M) # the names/labels of the information
str(M$qr) # a list within a list, motherfucker...

M$qr$tol # it is possible to use the dollar sign within a dollar sign

#### coercing data ####
y <- c("23.8", "6", "100.01","6")
y
class(y)
y.c <- as.numeric(y)
y.c
as.numeric(y) # note that this func. sets all the numbers with the same decimals
as.integer(y) # its pretty interesting that this func. simply removes all the decimals
as.character(y)
as.factor(y)
as.logical()