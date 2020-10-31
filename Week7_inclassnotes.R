# Week 7 inclass notes
# loops and stuff
for(i in 1:100) {
  print("Hello world!")
  print(i*i)
}


foo <- seq (1,100,by=2) # a sequence  1, 3, ..., 99
n<-length(foo) # the size of the sequence: 50
foo.squared <- NULL # an empty object; remember that NULL is useful to create a new object
for (i in 1:n) { # our counter
  foo.squared[i] = foo[i]^2 # the task the fist value of foo.squared will receive the fist value of foo
}

foo.df<-data.frame(foo,foo.squared) # we combine both sequences in a data.frame
plot (foo.df$foo~foo.df$foo.squared) # we plot both sequences together
plot(foo.df$foo, foo.df$foo.squared)
# note what the ~ expression means: y ~ x
# without the ~, the function reads (x,y)

# R considers objects as whole vectors, you can do this instead:
plot(foo, foo^2)

# so..., are loops useful?
# Of course, loops recycles functions wihtin the {} on different objects
# expecially when the functions are complex
# example: modelling population growth
gen <- 10 # 10 generations
N <- rep(0, gen)
N[1] <- 2 # first gen = 2
for (i in 2 : gen) {  # note that i in 2:gen, N[0] does not exist
  N[i] <- N[i-1]*2
}
plot(N, xlab = "Generation",type = "b")

# writing a function
# and put a fop loop within
rm(list = ls())
pop.growth <- function(growth.rate, num.gen){
  generation <- 1:num.gen
  N <- NULL
  N[1] <- 2
  for(i in 2:num.gen){
    N[i] <- N[i-1]*growth.rate
  }
  plot(generation, N)
}

par(mfrow = c(2,2))
for(i in 2:5){
  pop.growth(i, 10)
}

# turnign the population growth model into an animation
install.packages("animation")
library(animation)
grow3 <- function (growth.rate) { 
  num_gen<-10
  generation<-1:num_gen
  N <- rep (0,num_gen)
  N[1] <- 1
  for (i in 2:num_gen) {
    N[i]=growth.rate*N[i-1]
  }
  plot(N~generation, xlim=c(0,10), ylim=c(0,100000), type='b', main=paste("Rate =", growth.rate))
}# note that there are limits of the axises in order to make the plot look consistent
saveGIF({ # from the package animation
  for(i in 2:10){
    grow3(i)
  }
}
)


install.packages("gganimate")
library(gganimate)
library(ggplot2)
demo <- NULL
demo$count <- N
demo$generation <- 1:10
demo <- as.data.frame(demo)
p <- ggplot(demo, aes(x = generation, y = count, size = 2)) +
  geom_point(show.legend = F, alpha = 0.7) +
  scale_color_viridis_d() +
  scale_size(range = c(0,12)) +
  labs(x = "Generation", y = "Individuals")
p + transition_time(generation)+
  labs(title = "Generation:{frame_time}") +
  shadow_wake(wake_length = 0.2, alpha = F)

# exercise 1:
# logistic growth
logpop <- function(num.gen, growth.rate){
  N <- NULL
  Generation <- 1:num.gen
  N[1] <- 10
  for (i in 2:num.gen) {
  N[i] = N[i-1] + (growth.rate*N[i-1]*((100-N[i-1])/100)) 
  }
  plot(Generation, N , main = paste("Growth rate = ", growth.rate),
       xlab = "Generation", ylab = "Count", type = "b",
       xlim = c(0,50), ylim = c(0,130))
}
logpop(50, 1.8)

library(animation)
saveGIF(for (i in 1:10) {
  logpop(50, 1+(i*0.1))
})
saveGIF(for (i in 1:10) {
  logpop(50, i)
})

par(mfrow= c(1,1))




