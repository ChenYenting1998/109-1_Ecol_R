rm(list = ls())
setwd('C:\\Users\\tumha\\Desktop\\IONTU\\Ecological_Data_Analysis_in_R\\109-1_Ecol_R')
ls<- read.csv('Production_Livestock_E_All_Data/Production_Livestock_E_All_Data_NOFLAG.csv', header = T)

lsl<- tidyr::pivot_longer(ls, 8:65, names_to = "Year", values_to = "Head") # livestock long
lsl$Year <- as.integer(gsub("Y","", lsl$Year)) # remove the "Y" in the year 
head(lsl)

library(ggplot2)

str(lsl)
unique(lsl$Area)
unique(lsl$Item)

# Asia: Pigs
# Filter
Afil <- lsl$Area %in% c("World", "Asia", "Central Asia","Eastern Asia","Southern Asia", "South-Eastern Asia", "Western Asia") # Asia filter
Pfil <- lsl$Item == "Pigs"# Pigs filter
# A glimpse of its basic structure
ggplot(lsl[Afil & Pfil,], aes(x = Year, y = Head, color = Area)) + 
  geom_point() 

# Refining
ggplot(lsl[Afil & Pfil,], aes(x = Year, y = Head, color = Area)) + 
  geom_line(lwd = 1.5) +
  ylab("Pig Stocks (Head)")+
  scale_x_continuous(n.breaks = 12) +
  scale_y_continuous(labels = scales::unit_format(suffix = "m", scale = 0.000001,sep ="")) +
  scale_colour_manual(values = c("Black", "Yellow","Red", "Green", "Brown","Pink", "Blue"))
# Asia produces roughly 50% of pig stocks for the world.

head(lsl[Afil & Pfil,])
