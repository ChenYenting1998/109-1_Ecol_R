#2020.09.15 Class
#checking the version of R
library(installr)
if(!require(installr))
  (install.packages("installr"))
check.for.updates.R()
updateR()
# downloading the packageg "Approximate Bayesian Computation"
install.packages("abc")
library(abc)

#install the package "vegan"
install.packages("vegan")
library(vegan) #vegan is the most famous package in ecology

# CRAN Task view####
# CRAN Task view has listed some packages and their usage.
# pretty neat. I see differential equations, multivariate, machine learning, etc.

# DIsscussing problems####
# stack overflow is a good archive for discussing problems in R

# the (probably) most useful package is "stats", which is pre-installed for all R users

#learn how to read R Documentation/ Help

# different packages might contain functions that hace the same name.

# wordking directory ####
# R reads and saves files to the current WDu unless you type the file's whole route 
getwd() # tells us where our wd right now
setwd("C:\\Users\\tumha\\Desktop\\海研_上課教材\\Ecological Data Analysis in R") # sets a new route to a new WD

# Remove ####
a <- c("qwer", "wer")
rm(a)

# clean your console ####
# use ctrl + L to clean your console

# File reading ####
# R can read numerous files
# Excel is not a good file format for R; Its too large and complicated for R to digest and represent
# .txt is great for R, thou
?read.table() #read table allows you to read .txt files
# read.table( file,                 Location of the file
#             header = T/F,         Do you have the name of columns 
#             sep = "\t",           How are the signals of changing a column (\t = tabulation as the separation marker)
#             dec = ".")            What is the characters usesd as decimals (Trivia: French uses comma for decimals)

#### R studio####
# Rstudio is a script edit software

#### The class's resource ####
# its in github