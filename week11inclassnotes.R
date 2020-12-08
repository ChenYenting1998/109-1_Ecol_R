# week 11
rm(list = ls())

# the condition of your data ####
# a balalnced data set (all the groups are present)
# e.g. 1a, 1b, 1c /// 2a, 2b, 2c

# not balanced
# e.g. 1a, 1b, 1c /// 2a, 2b  (missing 2c)

# the point is, it is good to have a balanced data ;)


# introduction to ANOVA####
iris.lm<-lm(Petal.Width ~ Species, data=iris)
library(ggplot2)
ggplot(iris) + aes(x = Species, y = Petal.Width) + geom_boxplot()
summary(iris.lm)

anova(iris.lm)

# TBH, anova has so many variations (there is a whole book disscussing this)
# We are going to discuss about one type of ANOVA
# (That is why studying the theories of statistics is so important)
# Full-factorial between subjects ANOVA

# Independent factors: specific experimental conditions

# analysis of variance ####
# uses variances to determine whether there is a significant difference between means
# (a really weird choice for naming this method)
# concept: between groups & within group variances
# if within > between ==> probably there is no difference between the groups

# anova in 4 steps ####
# 1. create a anova object
a <- aov()

# 2. summary (this step would only tell us whether there is difference between groups)
summary(a)

# 3. posthoc if necessary (to examine which pair of groups has significant differnce)
# (note that different conditions requires different post hoc methods)
TukeyHSD(a)

# 4. us lm to check the linear relationship between the groups
# check the coefficients, the magntitudes of differences between the groups
a.lm <- lm()
summary(a.lm)

# one way anova
# consider the effect of one factor only

# two-way anova
# consider the two factors at the same time
# no interaction: formula: y = a + b

# interaction: formula: y = a * b (be careful that not all variables have interactions)
# draw a plot beforehand
# if the interaction term is significant, some people would prefer to ignore individual terms (since the interaction affects the outcome)

# RP15 
interact_plot(fitiris, pred = Petal.Length, modx = Species, plot.points=T)

model1 <- lm(Petal.Width ~ Petal.Length + Species, iris)
model2 <- lm(Petal.Width ~ Petal.Length * Species, iris)

summary(model1)
summary(model2)


ggplot(iris) + aes(x = Petal.Length, y = Petal.Width, color = Species) + geom_point() +
  stat_smooth(method = "lm") +
  title(main = "RP15", xlab = "Petal Length", ylab = "Petal Width")

# ANCOVA
car::Anova(model2, type = 3)
# note that: Anova() with an upper case & type 3
# WTF is ancova...

# Type I, II, III of anova
# If your data is unbalanced ==> use type II or tYpe III
?aov() # this has the assumption that your data is balanced

# according to help:
# "aov is designed for balanced designs"
# to check balance: replications()
# si, what about unbalanced data?
to use Anova()
# 1. create a lm() object



# Know your data####
# types of distribution
# Gaussian
# Binomial
# Poisson (Count data; rare events)
# ===> Different distributions, different types of tests

# More often in ecology, normal distribution cannot be found in our data
# GLM for poisson and Binomial
shag <- read.csv("C:\\Users\\tumha\\Desktop\\IONTU\\Ecological_Data_Analysis_in_R\\attentive-suricate\\Data/shagLPI.csv", header = TRUE)
head(shag)
shag$year <- as.numeric(shag$year)  #  year should be a numeric variable
shag.hist <- ggplot(shag, aes(pop)) + geom_histogram() 
shag.hist

shag.m <- glm(pop ~ year, family = poisson, data = shag)
summary(shag.m)

shag.p <- ggplot(shag, aes(x = year, y = pop)) +
  geom_point(colour = "#483D8B") +
  geom_smooth(method = glm, colour = "#483D8B", fill = "#483D8B", alpha = 0.6) +
  scale_x_continuous(breaks = c(1975, 1980, 1985, 1990, 1995, 2000, 2005)) +
  labs(x = " ", y = "European Shag abundance")
shag.p
