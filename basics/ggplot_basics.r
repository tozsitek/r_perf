library(tidyverse)
library(dslabs)
data(heights)
name(heights)  # displays columns
x <- heights$height
unique(x)
length(unique(x))
tab <- table(x)  # table function for frequency
tab
# For values reported only one tab will be 1. Use logicals and the function sum to count 
# the number of times this happens.
sum(tab==1)
head(heights)

##
## CDF -> Cumulative distribution Function
## Function that reports the proportion of data below a value of a:
## F(a) = Pr(x <+ a)  // Pr -> proportion
# distribution
prop.table(table(heights$sex))

# CDF can be calculated, like: 
# a <- seq(min(my_data), max(my_data), length = 100)    # define range of values spanning the dataset
#cdf_function <- function(x) {    # computes prob. for a single value
#  mean(my_data <= x)
#}
#cdf_values <- sapply(a, cdf_function)
#plot(a, cdf_values)

## Calculate standard deviation
x <- 6
average <- sum(x) / length(x)
average
SD <- sqrt(sum( (x-average)^2) / length(x))
SD

index <- heights$sex=="Male"
x <- heights$height[index]
x
average <-mean(x)
SD <-sd(x)
c(average=average, SD=SD)

# define standard unit
z = ( x - average ) / SD
z <- scale(x)
z

#  From course material
#########
# calculate the mean and standard deviation manually
average <- sum(x)/length(x)
SD <- sqrt(sum((x - average)^2)/length(x))

# built-in mean and sd functions - note that the audio and printed values disagree
average <- mean(x)
SD <- sd(x)
c(average = average, SD = SD)

# calculate standard units
z <- scale(x)

# calculate proportion of values within 2 SD of mean
mean(abs(z) < 2)

## pnorm -> cumulative distribution for the normal distribution
## F(z) = pnorm(a, avg, s)
## avg height is 70.5
1 - pnorm(70.5, mean(x), sd(x))

plot(prop.table(table(x)), xlab="a = Height in inches", ylab = "Pr(X =a)")

## NORMAL approximation works pretty well in below case
## it would not work too well with values of 69.99 and 70.01 when data is not rounded
# using actual data
mean(x <= 68.5) - mean(x <= 67.5)
mean(x <= 69.5) - mean(x <= 68.5)
mean(x <= 70.5) - mean(x <= 69.5)
# using approximation
pnorm(68.5, mean(x), sd(x)) - pnorm(67.5, mean(x), sd(x))
pnorm(69.5, mean(x), sd(x)) - pnorm(68.5, mean(x), sd(x))
pnorm(70.5, mean(x), sd(x)) - pnorm(69.5, mean(x), sd(x))

##
x <- heights$height[heights$sex == "Male"]
x
avg <- mean(x)
stdev <- sd(x)
mean(x <= 72) - mean(x <= 69)
# pnorm(value, mu, sigma)
# normal distribution
pnorm(72, avg, stdev) - pnorm(69, avg, stdev)
# approximation
exact <- mean(x > 79 & x <= 81)
approx <- pnorm(81, avg, stdev) - pnorm(79, avg, stdev)
val <- exact/approx

# what percent of seven footers are in the National Basketball Association (NBA).
# avg men height is 69 inches -> mu
# standard deviation is 3 -> sigma
# value is 7*12 (7 footer)
# p = proportion
# We know that there are about 1 billion men between the ages of 18 and 40 in the world, the age range for the NBA.
# Can we use the normal distribution to estimate how many of these 1 billion men are at least seven feet tall?
p <- 1 - pnorm(7*12, 69, 3)
N <- round(p * 10^9)
10 / N
# Repeat the calculations performed in the previous question for Lebron James' height: 6 feet 8 inches. 
# There are about 150 players, instead of 10, that are at least that tall in the NBA.
## Change the solution to previous answer
p <- 1 - pnorm(80, 69, 3)
N <- round(p * 10^9)
150/N


## QUANTILES
## cutoff points that divide a dataset into intervals with set probabilities.
## the q-th quantile is the value at which q% of the observations are equal to or less than that value.
# quantile(data, q)
summary(heights$height)
p <- seq(0.01, 0.99, 0.01)
#quantile(data, p)
percentiles <- quantile(heights$height, p)
percentiles[names(percentiles) == "25%"]
percentiles[names(percentiles) == "75%"]



