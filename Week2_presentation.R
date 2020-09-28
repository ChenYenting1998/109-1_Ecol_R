rm(list = ls())
# load
ra <- read.table('https://raw.githubusercontent.com/vianneydenis/attentive-suricate/master/Data/rairuoho.txt', sep = "\t", header = T)
# Reformat the table in order to have the day as a variable with 6 levels together with another variable called length. 
ra$pot.serial.number <- 1:nrow(ra) # generates a new column for identification

library(tidyr)
rera <- ra %>% gather("Day", "Length", "day3", "day4", "day5", "day6", "day7", "day8")
# explanation
# there are two types of information within  the day columns: measuring date and mean grass length
# gather needs us to name the new columns for the two types of information first,
# then key in all the columns that needs to reshape.