rm(list = ls())
# week 8 assignment
# part 1:
setwd("C:\\Users\\tumha\\Desktop\\IONTU\\Ecological_Data_Analysis_in_R\\109-1_Ecol_R\\attentive-suricate\\Data")
ra <- read.table('rairuoho.txt', header = T)
cor.test(ra$day6, ra$day7)       

# part 2:
# scheme:
# calculate the t value
# subtract the t distribution value
my.t.test <- function(a, b){ # assumption: both dataset shares the same equal variance
  amd <- abs((mean(a)-mean(b))) # absolute.mean.difference
  sqe <- sqrt((var(a)/length(a)) + (var(b)/length(b))) # sqrted error
  t <- amd/sqe
  print(t)
  if(qt(0.025, 2) <= t & t <= qt(0.975, 2)){ # a = 0.05
    print("no statistical significance")
  }else{
    print("statisitcallly significant")
    }
}

qt(0.025, 2)
my.t.test(ra$day3, ra$day6)


library(dplyr)
group_by()
?t.test

