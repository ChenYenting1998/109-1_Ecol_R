# Week 2 in class notes
# Data exploration and manipulation

# remember cntrl + L cleans your console

library(datasets)
library(help = "datasets") # run this line for a complete list of datasets
rm(list = ls())
data("iris") # data() automatically creates an object in the environment 
iris # the dataset is recorded per ind.
     # calling out all the data is usually not a good idea (the dataset can be huge)
ls() # gives the names of objects in the environment
fix(iris) # returns a modifiable spreadsheet
          # btw, DO NOT modify the original data
summary(iris) # descriptive statistics for the individual columns
class(iris) # returns the class of the object
            # vector, matrix, dataframe, list, etc
str(iris) # returns the structure of the dataset

# Try develop the habit of examining the data first before data exploration

#####
students<-read.table('https://www.dipintothereef.com/uploads/3/7/3/5/37359245/students.txt',header=T, sep="\t", dec='.')
#extracting columns
# note that the type of data you extracted can be different
students$gender 
students[,3] 
students["gender"] # note thae this returns part of the data frame

# numerical
# character
# integer: can be numerical or character

#####sub-setting data
# define a condition and create a filter to remove redundant data
students$gender == "female" # a logical argument
f <- students$gender == "female" # creates a filter
females <- students[f,] # use the condition "f" on the row of the dataset "students"
dim(females) # returns the dimension of the datatset (no. of observations and variables)
dim(students) # the dim fuction is actually a bit futile cuz its results are shown in the environment
colnames(students)
rownames(students)
rownames(females)<- c("Vanessa", "Vicky", "c", "d", "e") # c stands for combine

##### inclass practice
species <- unique(iris$Species) # extracting the names of the species; using unique() is kinda cheating lol
no1 <- iris$Species == species[1] # creating filters for each of the species
no2 <- iris$Species == species[2]
no3 <- iris$Species == species[3]
set <- iris[no1,] # use the filters to sub-set the data set
ver <- iris[no2,]
vir <- iris[no3,]


#
levels(iris$Species) # returns the levels of the data, a substitute for unique()
                     # would only work if the data has levels (nominal)

##### Sampling
install.packages("dplyr")
library(dplyr)
View(mean) # to check the source code, View (V capitalized)
# or you cana just type insert the function without the parentheses, and the console will print it out for u

# create a fliter by randonmly sampling
sample
stuf<- sample(nrow(students), 2)
stuf # returns 2 randomly sampled nrows of students
students[stuf,] #this then works as a filter

# now you got two ways for sub-setting data

# not only you can use logical vectors to weed out undesired data
# you can also apply different methods to manipulate your data

#####Sorting
order()
ind1 <- order(students$height) # generates an order according individual heights; this works as a filter
students[ind1,] # dafault: small -> large (cool af)
ind2 <- order(-students$height) # - works as sorting from large to small; or use the decrease argument
students[ind2,] # reverses the order

##### re-coding
colors <- ifelse(students$gender == "male","blue", "red") # quick tut of ifelse() 
students$colors <- ifelse(students$gender == "male","blue", "red") # generates a new column according to the data within
students # way quicker than using cbind
# other logical operators
#  !  &  <=  >=  ==  != |

#####inclass practice
students$gender <- ifelse(students$gender == "blue", "male", "female")
students$colors <- NULL # you can use NULL to remove column
iris$colors <- ifelse(iris$Species == "setosa", "purple", ifelse(iris$Species == "versicolor", "blue", "pink"))
# so you can use iris$(stuff you you wanna add) to add a new column
# didn't know that you can put a condition within a condition
# ifelse within a ifelse
head(iris)
iris[order(-iris$Sepal.Width),]

#other useful functions for subsetting
subset
with
within

#####dplyr
# basically everything we just learn can be done quicker in dplyr
library(dplyr)
#select
selected <- select(iris, Sepal.Width, Sepal.Length)
head(selected) #head for just checking if the new dataframe looks fine 
select(iris, Sepal.Length:Petal.Length) # subset all the columns
select(iris, 2:5) # numbers are fine
select(iris, c(1,3,5)) #c() is okay
select(iris, -Species) # use minus for removing columns

#filter
filter(iris, Species == "setosa")
filter(iris, Species == "versicolor"& Sepal.Width >=3)

#mutate
col1 <- mutate(iris, Greater.Half = Sepal.Width > 0.5 *Sepal.Width) # generates a new column with certain conditions

#arrange
arrange(col1, Sepal.Width) # arrange the order according to the selected column
# note that the serial numbers of each data also changes

summarize(col1)

# group_by
gp <- group_by(iris,Species)
mm <- summarize(gp, Mean.Sepal = mean(Sepal.Width))
mm

#pipe operator
# allows us to use multiple functions together
# magnificent in decreasing code length
# this is where dplyr becomes handy
iris %>% group_by(Species) %>% summarize(Mean.length = mean(Sepal.Length))

# trivia
# source:https://uc-r.github.io/pipe
# their are many options for doing complex coding
# nested options: a traditional way to combine multiple functions, yet its readability is shit
# multiple object option: a clear way to demonstrate your thought process,
#                         yet the length of your code expands and a shit load of objects will be created during the process
# %>%: does not save unnecessary objects and remains its readability.
#      %>% can be useful in plots, too

# the pipe operator comes from the package magrittr
# go check that out
library(magrittr)


install.packages('tidyr')
library(tidyr)
gather()
