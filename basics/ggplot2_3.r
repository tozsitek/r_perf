# load heights data
library(tidyverse)
library(dslabs)
data(heights)

# heights %>% filter(sex=="Male")
# define p
p <- heights %>%
  filter(sex == "Male") %>%
  ggplot(aes(x = height))

# basic histograms
p + geom_histogram()
p + geom_histogram(binwidth = 1)

# histogram with blue fill, black outline, labels and title
p + geom_histogram(binwidth = 1, fill = "blue", col = "black") +
  xlab("Male heights in inches") +
  ggtitle("Histogram")
# Smooth density plots in ggplot2
p + geom_density()
p + geom_density(fill = "blue")

# QQplot- Quantile-quantile plots in ggplot2
# basic QQ-plot
p <- heights %>% filter(sex == "Male") %>%
  ggplot(aes(sample = height))
p + geom_qq()

# QQ-plot against a normal distribution with same mean/sd as data
params <- heights %>%
  filter(sex == "Male") %>%
  summarize(mean = mean(height), sd = sd(height))
p + geom_qq(dparams = params) +
  geom_abline()

# QQ-plot of scaled data against the standard normal distribution
heights %>%
  ggplot(aes(sample = scale(height))) +
  geom_qq() +
  geom_abline()

# define plots p1, p2, p3
p <- heights %>% filter(sex == "Male") %>% ggplot(aes(x = height))
p1 <- p + geom_histogram(binwidth = 1, fill = "blue", col = "black")
p2 <- p + geom_histogram(binwidth = 2, fill = "blue", col = "black")
p3 <- p + geom_histogram(binwidth = 3, fill = "blue", col = "black")

# arrange plots next to each other in 1 row, 3 columns
library(gridExtra)
grid.arrange(p1, p2, p3, ncol = 3)


### TEST / EXERCISE ###
library(dplyr)
library(ggplot2)
library(dslabs)
data(heights)
data(murders)
p <- ggplot(murders)
print(p)  # gives an empty plot
data("heights")
p <- heights %>% ggplot()
##
df1 = data.frame(murders)
names(df1)

# scatter plot
murders %>% ggplot(aes(population/10^6, total)) +
  geom_point()
murders %>% ggplot(aes(population/10^6, total, label=abb)) +
  geom_label(color = "blue")
murders %>% ggplot(aes(population, total, label = abb, color = region)) +
  geom_label()
p <- murders %>% ggplot(aes(population, total, label = abb, color = region)) + geom_label() 
## add layers to p here
p + scale_x_log10()+ 
  scale_y_log10() + 
  ggtitle("hello")

# histogram
p <- heights %>% 
  ggplot(aes(height))
## add a layer to p
p + geom_histogram(binwidth=1, fill = "blue")

# smooth density
heights %>% 
  ggplot(aes(height)) + 
  geom_density()
heights %>% 
  ggplot(aes(height, group = sex, color = sex)) + 
  geom_density()
heights %>% 
  ggplot(aes(height, fill = sex)) + 
  geom_density(alpha = 0.2) 
