# when running this, it'll prompt to select a file
# using file: ...sandbox>R_Udemy>P2-Mispriced-Diamonds.csv
mydata <- read.csv(file.choose())
# file from: 
#install.packages("ggplot2")
library("ggplot2")

ggplot(data=mydata[mydata$carat<2.5,], aes(x=carat, y=price, colour=clarity)) +
  geom_point(alpha=0.1) +
  geom_smooth()


