
library(tidyverse)
library(dslabs)
data("murders")


murders %>%
  ggplot(aes(population, total, label=abb, color=region)) +
  geom_label()

# assigning values to variables
a <- 1
b <- 2
c <- -1

# solving the quadratic equation x^2 + x -1 = 0
(-b + sqrt(b^2 - 4*a*c)) / (2*a)
(-b - sqrt(b^2 - 4*a*c)) / (2*a)


class(ls)
class(murders)

# structure of an object
str(murders)
head(murders)

# to access variables, use the '$'
# the ojbect is a vector or "array"
murders$population

# the name of the columns
names(murders)

# length of a table content
pop <- murders$population
length(pop)
class(pop)  

#logical vector
z <- 3 == 2
z
class(z)

#factors - categorical data - use levels to see categories
class(murders$region)
levels(murders$region)

region <- murders$region
value <- murders$total
region  <- reorder(region, value, FUN = sum)
levels(region)

# compare extracted data (can extract 2 different ways)
a <- murders$abb
b <- murders[["abb"]]
identical(a,b)

# funtion table takes a vector as input and returnds hte frequency of each unique element in the vector
# c function is to concatenate
x <- c("a", "a", "b", "b", "b", "c")
x
table(x)
stat(murders)

# use data set movielens
data("movielens")
str(movielens)
class(movielens$title)
class(movielens$genres)
nlevels((movielens$genres))


# The 2 solutions for the quadratic solutions of 2*x^2 - x -4 = 0
a <- 2
b <- -1
c <- -4
(-b+sqrt(b^2-4*a*c))/(2*a)
(-b-sqrt(b^2-4*a*c))/(2*a)
