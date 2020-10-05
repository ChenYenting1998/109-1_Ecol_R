# Week 3 presentation
rm(list = ls())
# 1. ####
#RP5: create the following data frame 
#summarizing the results of a small experiment on 5 individuals 
#testing the efficiency of a specific diet 
#(drinking bubble tea only - feak data). 
before_diet <- c(104, 95, 87, 77, 112)
after_diet <- c(96, 91, 81, 75, 118)
individuals <- c("subject_1", "subject_2", 'subject_3', "subject_4", 'subject_5')
cbind(before_diet, after_diet, individuals)
da <- data.frame(before_diet, after_diet, row.names = names)
da

# 2.####
# Create another vector with the weight loss (in %) 
#associated with subject no. 
da$weight_loss <- (after_diet/before_diet)*100
da

# 3. ####
# What can you say on this bubble tea diet? 
# 4 ind. lose their weight
summary(da)
# mean weight drops by 4%

# Reformat the table by creating: 
# a variable "individual" with the identity of the five individuals
# a variable "diet" with two levels before and after
# a variable "weight" containing the weight before and after the diet.

# pivot_long
library(tidyr)
da$individual <- row.names(da)
nd1 <- pivot_longer(da, before_diet:after_diet,
             names_to = "diet" ,values_to = "weight")