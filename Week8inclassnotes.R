students<-read.table('https://www.dipintothereef.com/uploads/3/7/3/5/37359245/students.txt',header=T, sep="\t", dec='.') # inspect the object created
str(students)

# there is a function in Excell called "pivot table"
# it can return descriptive statistics of the data set
install.packages("psych")
summary(students)
psych::describe(students)
# selecting groups
psych::describeBy(students, list(students$gender, students$population))

# quick count of the data
table(students$gender)
table(students$gender, students$shoesize)
prop.table (table(students$gender, students$shoesize)) # in probability


# three variables, with nicer formatting
ftable(students$gender, students$shoesize,students$population)

# data iris is the perfect data set for teaching statistics

mean()

apply() # the apply family
aggregate(students$height,list (students$gender),median) # ftom stats package
tapply(students$height,students$gender, median)

# usually people avoids using loops cuz its too clunkly for R. Its not efficient

# in class exercise RP11
data(iris)
boxplot(iris)
iris
library(tidyr)

colnames(iris)
unique(iris$Species)
se <- iris[iris$Species == "setosa",]
ve <- iris[iris$Species == "versicolor",]
vi <- iris[iris$Species == "virginica",]
colSums(se[-5])


library(ggplot2)
p1 <- ggplot(iris,aes(x = Species, y = Sepal.Width)) + geom_boxplot()
p2 <- ggplot(iris,aes(x = Species, y = Sepal.Length)) + geom_boxplot()
p3 <- ggplot(iris,aes(x = Species, y = Petal.Width)) + geom_boxplot()
p4 <- ggplot(iris,aes(x = Species, y = Petal.Length)) + geom_boxplot()
grid.arrange
# list() list out all the variables
iris %>% group_by(Species) %>% summarise_each(list(length))
aggregate(iris[,1:4], by = list(iris$Species), median)

# statistics
cor(students$height, students$shoesize) # for getting the corr value 
cor.test(students$height, students$shoesize) # doing the actual test (returning the p value) 
#cor.test( alternative = c("two.sided", "less", "greater"), method = c("pearson", "kendall", "spearman"))
ggplot(students, aes(x = height, y = shoesize)) + geom_point() + stat_smooth(method = "lm", col = "red")
# default is usually pearson, which is parametric
# for non-parametric alternatives, you can use spearman as well

students
ggplot(students, aes(x = height, y = shoesize)) + geom_point() + 
  stat_smooth(method = "lm", col = "red")
students1 <- students
students1$height[1] <- 200
ggplot(students1, aes(x = height, y = shoesize)) + geom_point() + stat_smooth(method = "lm", col = "red")
cor.test(students$height,students$shoesize)  
cor.test(students1$height,students1$shoesize)  

#chi square ####
# aka goodness of fit (whether the observed matches the expected)
die<-data.frame(obs=c(55,44,35,45,31,30), row.names=c('Cast1','Cast2','Cast3','Cast4','Cast5','Cast6'))
die #Is this die fair? Define H0 and H1.  
chisq.test(die)
# if the object inputted is a one row/column matrix or a vector,

# t test ####
# paired vs not paired
# compairng whether the means of two samples difer
# one sample sample vs true mean
t.test(students$height, mu = 170)
# two samples with equal variances
t.test(students$height~students$gender, var.equal = T) # male vs. females
# unequal variances (Welsh's two sample t test) go read some literature

# RP13
t.test() # note that if var.equal = F, Welch test will be performed

# non parametric tests for sample comparison
# Mann-Whitney, Wilcoxon


# normality test (whether your data can be inteperted as the Normal dis.)
shapiro.test(students$height)
# higher the p value, higher the normality (the probability the null hypothesis is correct)
qqnorm(students$height)
qqline(students$height)

# Variance test ####
# In parametrid tests, analysis of variance restricts on the normality of your sample
# to test the homogeneity of variances
bartlett.test() # strong sensitivity to normality
leveneTest() # slightly weaker than Bartlett
fligner.test() # weakest sensitivity among the three
