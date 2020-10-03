# Week 3 presentation
# create a vector
rm(list = ls())
before_diet <- c(104, 95, 87, 77, 112)
after_diet <- c(96, 91, 81, 75, 118)
da <- data.frame(before_diet, after_diet)
# create weight loss data (in %)
da$weight_loss <- (after_diet/before_diet)*100
da

# add ind as a variable
subject <- rep("subject",nrow(da))
no. <- 1:nrow(da)
subject <- paste(subject, no., sep = "_")
da$individual <- subject

# 4 ind. lose their weight
summary(da)
# mean weight drops by 4%

# reformat the data
# creating a new column for identity
# add a new variable for two levels
library(tidyr)
nd <- pivot_longer(da, before_diet:after_diet,
             names_to = "diet" ,values_to = "weight")
