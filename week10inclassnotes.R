# week 10 inclassnotes
rm(list = ls())
install.packages(c("Hmisc", "corrplot", "MASS","car"))

library(Hmisc)
library(corrplot)
library(MASS)
library(car)

# LINEAR MODEL
rairuoho <- read.table('C:\\Users\\tumha\\Desktop\\IONTU\\Ecological_Data_Analysis_in_R\\109-1_Ecol_R\\attentive-suricate\\Data\\rairuoho.txt', header = T)
cor.test(rairuoho$day6, rairuoho$day7)

# cor.test() does not operate on matrices
corr<-cor(rairuoho[,1:6])
corr

# lm()
plot(rairuoho$day6, rairuoho$day7)
abline(lm(rairuoho$day7~rairuoho$day6), col="red", lwd=2) 
# abline() can be any kind of line, not restricted to lm()

# analogy of ggplot2
library(ggplot2)
ggplot(rairuoho, aes(x = day6, y = day7)) + # the dataset and what vectors to extract ftom the dataset 
  geom_point() +# scattoer plot
  stat_smooth(method = "lm", col = "red") # adding a regression line

# theoretical backgrounds
# you can think that the desried result is the sum of multiple effects
# however, different effects can have different magnitudes of impact; therefore, the exsistince of coeffieitct
# also, there will be an error term cuz there might always be something we cannot predict nor control

# residual sum of squares (RSS) needs to be minimal 
# residual standard error (RSE); lower the better

# example 1:
model1 <- lm(Petal.Width ~ Petal.Length, data = iris)
model1
ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  geom_point() +
  stat_smooth(method = "lm", col = "blue")
# assessing your model by checking its statistical significance

summary(model1)
# few catagories
# Residuals: the residual value from quantiles (checking deviation); the  tilt of the regression line
#            if the median residual is far from zero, the quality of the model is probably garbage 

# Coefficients: (Inercept); Petal.Length
# confidence interval
confint(model1)

# Residual standard error: the measure of patterns in tha data that can't be explained by the model
#                          (smaller the better)
sigma(model1) # summoning the RSE
# percentage error
sigma(model1)*100/mean(iris$Petal.Width)

# multipled R-aquared: the proportion of the data that can be explained by the model
#                      Pearson correaltion coefficient squared in simple linear regression 
# AdjustedR-squared: adjusted for df


# F statistics: the overall significane of the model
#               whether at least one predictor has a non-zero effect

# how the t statistic is performed
# why t statistic? ==> mean comparision
# null hypothesis: no correlation (R = 0)

# Multiple linear regression
# several variables
model2 <- lm(Petal.Width ~ Petal.Length + Sepal.Width + Sepal.Length + Petal.Width , data = iris)
summary(model2)
# note that the intercept is not significant

# model selection
model3 <- lm(Petal.Width ~., data = iris[,1:4])
model4 <- lm(Petal.Width ~. -Sepal.Width, data = iris[,1:4])
model5 <-  update(model2,  ~. -Sepal.Length) # update function
# Bayesian information criterion (BIC)
# Akaike information critrion (AIC)
# lower the value, higher the fitness 
BIC(model3); BIC(model4);BIC(model5)

#Stepwise Selection based on AIC
step <- stepAIC(model3, direction='backward')
# backward: starts from full model, then removing varables sequentiallu
# forward:   starts from the simplest model, then adding varialbes
# both:

#interpretation
#  <none>             full model
# - Sepal.Length      excludeSepal.Length
# - Sepal.Width       exclude Sepal.Width
# - Petal.Length      exclude Petal.Length

# by removing each variables, you can see that the AIC value rises
# this indicates that the full model is the best model
summary(step)


model3 <- lm(Petal.Width ~., data = iris[,1:4])
plot(model3)
# 1. residual vs fitted value:
          # dotted line refers the idealized line
          # more horizontal the better
          # how far your residuals deviate from your model
# 2. QQ-plot:
          # departeure of normality
          # the quatile follows the normal distribution N(0, 1)
          # more diagonal the better
# 3. Scale-location plot
          # residuals satndardized and square-root transformed
          # more horizontal the better
          # sensitive to enlarging residuals
# 4. standardized residuals against leverage
          # 

# a problem in mulitplew regression
# ***multicollinearity***
# which means that the predictors ithemselves are correalted
# this effect could reduce the
# ways to avooid or reduce this problem
# abandon certain factors
# varaince inflation factor (VIF)
# VIF ~ 1: multicollinearlity nearly absent
# VIF > 5 or 10: multicollinearlity exists
# best to remove the highly correlated factors
vif(model3)

model6 <- lm(Petal.Width ~. -Petal.Length, data = iris[,1:4])
vif(model6)
