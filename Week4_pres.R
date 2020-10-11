rm(list = ls())
da <- ldeaths # A time series data of monthly deaths from lung diseases in UK from 1974 to 1979; contains both sexes
md <- mdeaths # male deaths
fd <- fdeaths # female deaths

# Total deaths, male deaths, female deaths####
plot(da,
     main = "Monthly Deaths From Lung Diseases in UK (1974-1979)",
     xlab = "Year",
     ylab = "Death Count",
     ylim = range(da,md,fd),
     type = "n")

lines(da, col = "Purple", lwd = 3) #total deaths
lines(md, col = "Blue", lwd = 3) # male deaths
lines(fd, col = "Red", lwd = 3) # female deaths
legend(x = "topright", legend = c("Total Deaths", " Male Deaths", "Female Deaths"),
       col = c("Purple", "Blue", "Red"),
       lwd = 3)
dev.off()

# Comparison of no. of deaths between years ####
# needs to find a way to extract the months and years from the time series data
month.abb # returns abbreviated month names
month.name # returns complete month names
# these two are very useful. Gotta remember this lol

time <- list(month.abb, unique(floor(time(da)))) 
# time() extracts time from a time series data
# floor() runs a filter; turning all numbers into integers
# unique() filters out repeated elements
# a series of function to store time data into a list (so matrix()'s dimnames can load them)

# merges time data and no. of deaths back together
# creates a new data frame 
nd <- as.data.frame((matrix(da, 12, dimnames = time)))
nmd <- as.data.frame((matrix(md, 12, dimnames = time)))
nfd <- as.data.frame((matrix(fd, 12, dimnames = time)))

#
par(mfrow = c(2,2))

# total
plot(nd[,1], # blank plot
     main = "Comparison of Total Lung Disease Deaths Between Years",
     type = "n",
     ylab = "No. of Deaths",
     xlab = "Months",
     ylim = range(nd))
for (i in 1:ncol(nd)) { # for loop for drawing all the years
  lines(nd[,i], col = i, lwd = 3)
}

legend(x = "topright", legend = colnames(nd), # legend
       col = 1:ncol(nd), lwd = 3)

# Male
plot(nmd[,1], # blank plot
     main = "Comparison of Male Lung Disease Deaths Between Years",
     type = "n",
     ylab = "No. of Deaths",
     xlab = "Months",
     ylim = range(nmd))
for (i in 1:ncol(nmd)) { # for loop for drawing all the years
  lines(nmd[,i], col = i, lwd = 3, lty = 3)
}
legend(x = "topright", legend = colnames(nmd), # legend
       col = 1:ncol(nmd), lwd = 3, lty = 3)

# Female
plot(nfd[,1], # blank plot
     main = "Comparison of Female Lung Disease Deaths Between Years",
     type = "n",
     ylab = "No. of Deaths",
     xlab = "Months",
     ylim = range(nfd))

for (i in 1:ncol(nfd)) { # for loop for drawing all the years
  lines(nfd[,i], col = i, lwd = 3, lty = 4)
}  
legend(x = "topright", legend = colnames(nfd), # legend
       col = 1:ncol(nfd), lwd = 3, lty = 4)

# total + male + female
plot(nfd[,1], # blank plot
     main = "Comparison of Female Lung Disease Deaths Between Years",
     type = "n",
     ylab = "No. of Deaths",
     xlab = "Months",
     ylim = range(nd, nfd))
for (i in 1:ncol(nd)) { # for loop for drawing all the years
  lines(nd[,i], col = 1, lwd = 3)
}
for (i in 1:ncol(nmd)) { # for loop for drawing all the years
  lines(nmd[,i], col = 2, lwd = 3, lty = 3)
}
for (i in 1:ncol(nfd)) { # for loop for drawing all the years
  lines(nfd[,i], col = 3, lwd = 3, lty = 4)
}  
legend(x = "topright", legend = c("Total Deaths", "Male Deaths", "Female Deaths"), # legend
       col = 1:3, lwd = 3, lty = c(1,3,4))

par

