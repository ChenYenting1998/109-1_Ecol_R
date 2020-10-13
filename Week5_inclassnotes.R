# week 5 inclassnotes
# outline: 
# lattice package
# ggplot2 package

# lattice package is out-of-date
install.packages("lattice")
library(lattice)

# it appears that the plotting scheme of lattice is
# function (y~x | plot division factors, data, layout)

# density plot
densityplot(~Petal.Length| Species, iris, plot.points = "",layout = c(1,3))
# histogram
histogram(~ Petal.Length| Species, iris, plot.points = "", nint = 20, layout=c(1,3))
# note that the table should be in long form
# in fact, many plotting package needs the data to be in long form
# QQ-plot
qqmath(~ Petal.Length| Species, iris, plot.points = "", nint = 20, layout=c(3,1))
#boxplot
iris$variety<-rep(c(rep('pure',25), rep('hybrid',25)),3) # dummy variable
bwplot(Petal.Length ~  variety|Species, iris, layout = c(3,1))

# Scatter plot
xyplot(Sepal.Length + Sepal.Width ~ Petal.Length + Petal.Width | Species,
       data = iris, scales = "free", layout = c(2,2), type = c("p","g"),
       auto.key = list(x = .6, y = .7, corner = c(0,0)))

xyplot(Sepal.Length + Sepal.Width + Petal.Width ~ Petal.Length  | variety+Species,
       data = iris[order(iris$Petal.Length),], scales = "free", layout = c(3, 2), type=c("l"),
       auto.key = T)
# variety + species, type = "l"

# ggplot
rm(list = ls())
library(ggplot2)
# ggplot scheme:
# ggplot: data input
# aesthetics: column selection for xy axis and others  
# geometry: points, lines and thier properties etc

# FAOSTAT
# agriculture data of all around the world (except taiwan thou :P)
dat1 <- read.table('https://raw.githubusercontent.com/ChenYenting1998/attentive-suricate/master/Data/FAO_grains_NA.csv', header = T, sep = ",")
library(tidyr)
library(dplyr)
# data manipulation
dat1w <- dat1 %>%  # flitering out redundant data and transforming the long data into a wide data
         filter(Information == "Yield (Hg/Ha)",
                Country == "United States of America",
                Crop %in% c("Oats", "Maize", "Barley", "Buckwheat", "Rye")) %>%
         select(Year, Crop, Value) %>%
         spread(key = Crop, value = "Value")
dat1l <- gather(dat1w, key = "Crop", value = "Yield", 2:6)
dat1l2 <- dat1 %>%
          filter(Information == "Yield (Hg/Ha)", 
                 Crop %in% c("Oats", "Maize", "Barley", "Buckwheat","Rye")) %>%
          select( Year, Crop, Country,  Yield = Value)  # Note that we are renaming the Value field
dat2 <- read.table('https://raw.githubusercontent.com/ChenYenting1998/attentive-suricate/master/Data/Income_education.csv', header = T, sep = ",")

ggplot(dat1l, aes(x = Year, y = Yield)) + geom_point()
# geom_point can input colour, pch, cex, alpha
ggplot(dat1l, aes(x = Year, y = Yield, color = Crop)) + geom_point()
ggplot(dat1l, aes(x = Year, y = Yield, color = Crop)) + geom_line()
# x= and y = can be omitted
ggplot(dat1l, aes(Year, Yield, color = Crop)) + geom_line()

ggplot(dat1w, aes(x = Year, y = Oats)) + geom_line() 
ggplot(dat1w, aes(x = Year, y = Oats)) + 
  geom_line(linetype = 2, colour = "blue", size=0.4)
# note that color in aes; colour in geom_
ggplot(dat2, aes(x = B20004013, y = B20004007)) + geom_point(alpha = 0.3) 

# geom_hex is useful for dealing with large range data
install.packages('hexbin')
library(hexbin)
ggplot(dat2, aes(x = B20004013, y = B20004007)) + 
  geom_hex(binwidth = c(1000, 1000))

#geom_boxplot
ggplot(dat1l, aes(x = Crop, y = Yield)) + geom_boxplot(fill = "bisque") 

#geom_violin
ggplot(dat1l, aes(x = "", y = Yield)) + geom_violin(fill = "bisque") 

# geom_histogram
# binwidth    vs.   bins
ggplot(dat1w, aes(x = Oats)) + geom_histogram(fill = "grey50", binwidth = 1000)
ggplot(dat1w, aes(x = Oats)) + geom_histogram(fill = "grey50", bins = 10)

# geom_bar
ggplot(dat2, aes(State)) + geom_bar() # regarding freq vs. catagories

install.packages("forcats")
library(forcats)
ggplot(dat2, aes(fct_infreq(State,ordered = TRUE))) + geom_bar()
ggplot(dat2, aes(fct_rev(fct_infreq(State,ordered = TRUE)))) + geom_bar()

dat2.ct <- dat2 %>% group_by(State) %>% 
           summarize(Counties = n())
dat2.ct

# dot plot
ggplot(dat2.ct , aes(x = Counties, y = State)) + geom_point()
 # joining geometries
ggplot(dat2, aes(x = B20004013, y = B20004007)) + 
  geom_point(alpha = 0.3, color='#4f4b4b') + 
  geom_smooth(method = "lm", color='green') # method = "lm', "glm"
geom_smooth

# tweaking ggplot2
# basically, if there is anything you wanna modify, 
# use + to combine functions for
# original plot
ggplot(dat2, aes(x = B20004013, y = B20004007)) + geom_point(alpha = 0.3)

# after several modification
ggplot(dat2, aes(x = B20004013, y = B20004007)) + geom_point(alpha = 0.3) + 
  ggtitle("ABC123") + # title
  xlab("Female income ($)") + # x axis title
  ylab("Male income ($)") + # y axis title
  scale_x_continuous(breaks = c(10000, 30000, 50000),labels = c("$10,000", "$30,000", "$50,000")) # x axis marking and labeling
 
#
ggplot(dat2, aes(x=B20004013, y=B20004007)) + geom_point(alpha=0.3) +
  xlab("Female income ($)") + ylab("Male income ($)") + # title of the x and y axis
  scale_x_continuous(labels=scales::unit_format(suffix="k", scale=0.001, sep="")) + # adjustment of x unit labelling
  scale_y_continuous(labels=scales::unit_format(suffix="k", scale=0.001, sep="")) + # adjustment of y unit labelling
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) # rotation of x axis unit label

#
ggplot(dat2.ct, aes(x = fct_reorder(State, Counties), y = Counties, fill = Income)) +
  geom_bar(stat = "identity") + 
  scale_fill_gradient2(low = "darkred", mid = "white",  high = "darkgreen", midpoint = 30892) # color gradient

#
ggplot(dat1l, aes(Year, Yield, col = Crop)) + 
  geom_line() +
  scale_colour_manual(values = c("red", "orange", "green", "blue", "yellow")) # designating colors

# faceting
# facet_wrap: one categorical data might suffice; more than two ==> hard to read
ggplot(dat1l2, aes(x = Year, y = Yield, color = Crop)) + geom_line() + 
  facet_wrap( ~Country, nrow = 1)
#
ggplot(dat1l2, aes(x = Year, y=Yield)) + geom_line() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
  facet_wrap(Crop ~ Country, nrow = 1, labeller = label_wrap_gen(width = 12))

# facet_grid
ggplot(dat1l2, aes(x = Year, y = Yield)) + geom_line() + 
  facet_grid( Crop ~ Country)

p1 <- ggplot(dat1l2, aes(x = Year, y = Yield, color = Crop)) + geom_line() + 
  facet_wrap( ~ Country, nrow = 1) +
  scale_y_continuous(labels = scales::comma_format())
p1
setwd('C:\\Users\\tumha\\Desktop\\IONTU\\Ecological_Data_Analysis_in_R\\109-1_Ecol_R')
ggsave("fig0.png", plot = p1, width = 6, height = 2, units = "in", device = "png")

p2 <- ggplot(dat1l2, aes(x = Year, y = Yield, color = Crop)) + geom_line() + 
  facet_wrap( ~ Country, nrow = 1) +
  scale_y_continuous(labels = scales::comma_format()) +
  theme(axis.text    = element_text(size = 8, family = "mono"), #theme to control fonts
        axis.title   = element_text(size = 11, face = "bold"), # font size,  face = "bold", "italic"
        strip.text   = element_text(size = 11, face="italic", family = "serif"), # family = "font"
        legend.title = element_text(size = 10, family = "sans"),
        legend.text  = element_text(size = 8,  color = "grey40"))

ggsave("fig1.png", plot = p2, width = 6, height = 2, units = "in")
