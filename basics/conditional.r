library(dslabs)
data(murders)
data("na_example")

sum(is.na(na_example))
# replace 'na' entries with 0
no_nas <- ifelse(is.na(na_example), 0, na_example)
sum(is.na(no_nas))

# any and all functions - "is any true" or "is all true"
z <- c(TRUE, TRUE, FALSE)
any(z)
all(z)
z <- c(FALSE, FALSE, FALSE)
any(z)
all(z)
z <- c(TRUE, TRUE, TRUE)
any(z)
all(z)

murder_rate <- murders$total / murders$population*100000
ind <- which.min(murder_rate)
ind
if(murder_rate[ind] < 0.25){
  print(murders$state[ind]) 
} else{
  print("No state has murder rate that low")
}

# the ifelse() function works similarly to an if-else conditional
a <- 0
ifelse(a > 0, 1/a, NA)

# the ifelse() function is particularly useful on vectors
a <- c(0,1,2,-4,5)
result <- ifelse(a > 0, 1/a, NA)
result

# function average (it's also mean)
avg <- function(x){
  s <- sum(x)
  n <- length(x)
  s/n
}
x <- 1:100
avg(x)
identical(mean(x), avg(x))

s <-1:5
avg(s)

# the general form of a function
#my_function <- function(VARIABLE_NAME){
#  perform operations on VARIABLE_NAME and calculate VALUE
#  VALUE
#}

# functions can have multiple arguments as well as default values
avg <- function(x, arithmetic = TRUE){
  n <- length(x)
  ifelse(arithmetic, sum(x)/n, prod(x)^(1/n))
}

s <- c('a', 'b', 'c')
z <- 5:10
avg(s)
avg(z)

# for loops
compute_s_n <- function(n){
  x <- 1:n
  sum(x)
}

# simple for loop
for(i in 1:5){
  print(i)
}

# for-loop for our summation
m <- 25
s_n <- vector(length = m) # create an empty vector
for(n in 1:m){
  s_n[n] <- compute_s_n(n)
  print(n)
}
# creating plot for above
n <-1:m
plot(n, s_n)

# a table of values comparing our function to the summation formula
plot(n, s_n)
lines(n, n*(n+1)/2)

# in R instead of using for loops use
# apply, sapply, tapply, mapply
# other functions to learn:
# split, cut, reduce, quantile, indentical, unique

# Assign the state abbreviation when the state name is longer than 8 characters 
new_names <- ifelse(nchar(murders$state)>8, murders$abb, murders$state)

# Create function called `sum_n`
# Use the function to determine the sum of integers from 1 to 5000
sum_n <- function(n){
  x <- 1:n 
  sum(x)
}
n <- 5000
sum_n(n)

# Create `altman_plot` 
altman_plot <- function(x, y){
  plot(x + y, y - x)
}

# Run this code 
x <- 3
my_func <- function(y){
  x <- 5
  y+5
}
# Print the value of x 
my_func(x)


# Here is a function that adds numbers from 1 to n
example_func <- function(n){
  x <- 1:n
  sum(x)
}
# Here is the sum of the first 100 numbers
example_func(100)
# Write a function compute_s_n with argument n that for any given n computes the sum of 1 + 2^2 + ...+ n^2
compute_s_n <- function(n){
  x <- 1:n
  sum(x^2)
}
# Report the value of the sum when n=10
compute_s_n(10)


# Define a function and store it in `compute_s_n`
compute_s_n <- function(n){
  x <- 1:n
  sum(x^2)
}
# Create a vector for storing results
s_n <- vector("numeric", 25)
s_n
# write a for-loop to store the results in s_n
for(i in 1:25){
  s_n[i] <- compute_s_n(i)
  print(n)
}

# Define the function
compute_s_n <- function(n){
  x <- 1:n
  sum(x^2)
}
# Define the vector of n
n <- 1:25
# Define the vector to store data
s_n <- vector("numeric", 25)
for(i in n){
  s_n[i] <- compute_s_n(i)
}
#  Create the plot 
# Plot s_n (on the y-axis) against n (on the x-axis).
plot(n,s_n)
# Check that s_n is identical to the formula of n(n+1)(2n+1)/6
identical(s_n, n*(n+1)*(2*n+1)/6)
