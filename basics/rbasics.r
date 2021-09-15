#COERSION - or typecasting
# might see NA when it does not work

library(dslabs)
data(murders)
sort(murders$total)

murders$state[1:10]
murders$abb[1:10]

# order abbreviation by total numbers
index <- order(murders$total)
murders$abb[index]

max(murders$total)    # highest number of total murders
i_max <- which.max(murders$total)    # index with highest number of murders
murders$state[i_max]    # state name with highest number of total murders

min(murders$total)    # smallest number of total murders
i_min <- which.min(murders$total)    # index with lowest number of murders
murders$state[i_min]    # state name with lowest number of total murders

# min number of population after sorting
pop <- murders$population
pop <- sort(pop)
min(pop)

# Access population from the dataset and store it in pop
pop <- murders$population
# Use the command order to find the vector of indexes that order pop and store in object ord
ord <- order(pop)
# Find the index number of the entry with the smallest population size
murders$state[ord]

# Find the index of the smallest value for population
which.min(murders$population)

# Which state has the smallest population
i <- which.min(murders$population)
states <- murders$state
states[i]

# Store temperatures in an object 
temp <- c(35, 88, 42, 84, 81, 30)
# Store city names in an object 
city <- c("Beijing", "Lagos", "Paris", "Rio de Janeiro", "San Juan", "Toronto")
# Create data frame with city names and temperature 
city_temps <- data.frame(name = city, temperature = temp)
# Define a variable states to be the state names 
states <- murders$state
# Define a variable ranks to determine the population size ranks 
ranks <- rank(murders$population)
ranks
# Create a data frame my_df with the state name and its rank
my_df <- data.frame(name = states, rank = ranks)
my_df


# Define a variable states to be the state names from the murders data frame
states <- murders$state
# Define a variable ranks to determine the population size ranks 
ranks <- rank(murders$population)
# Define a variable ind to store the indexes needed to order the population values
ind <- order(murders$population)
# Create a data frame my_df with the state name and its rank and ordered from least populous to most 
my_df <- data.frame(states = states[ind], ranks = ranks[ind])
my_df

# original sort order rank
#1 31        4   2     3
#2 4         15  3     1
#3 15        31  1     2
#4 92        65  5     5 
#5 65        92  4     4
# order = the position where the number is in the original order
# rank = the original number should be in this position


# Using new dataset - SUM & is.na
library(dslabs)
data(na_example)
# Checking the structure 
str(na_example)
# Find out the mean of the entire dataset 
mean(na_example)
# Use is.na to create a logical index ind that tells which entries are NA
ind <- is.na(na_example)
ind
# Determine how many NA ind has using the sum function (sum converts true to 1, false to 0)
# sum shows the number of true-s
sum(ind)

# Note what we can do with the ! operator
x <- c(1, 2, 3)
ind <- c(FALSE, TRUE, FALSE)
x[!ind]
# Create the ind vector
library(dslabs)
data(na_example)
ind <- is.na(na_example)
# We saw that this gives an NA
mean(na_example)
# Compute the average, for entries of na_example that are not NA 
x = mean(na_example[!ind])
x

#Practice
x <- c(1, "canada", 3)
x
class(x)

x <- 1:5
y <- as.character(x)
y
as.numeric(y)

#NA
x <- c("1", "b", "3")
as.numeric(x)

# seq with length.out (0,100,length.out=5)
# -- start with 0, max num is 100, increase the numbers by the same value
# -- so we only display 5 numbers between 0 and 100
x <- seq(0, 100, length.out = 5)
x
seq(0, 10, by = 2.5)

# Check the class of 1, assigned to the object a
class(1)

# Confirm the class of 1L is integer
class(1L)

#########
# SORTING
#########
x <- c(33, 1, 24, 14, 55, 2)
x
sort(x)
x
# order will show what position the number should be when sorted
order(x)
index <- order(x)
x
x[index]

#####
# VECTOR ARITHMETIC
#####
# Largest population state
murders$state[which.max(murders$population)]
max(murders$population)

# practice - convert inches to cm
heights <- c(69, 62, 66, 70, 73)
heights * 2.54

# how to obtain the murder rate
murder_rate <- murders$total / murders$population * 100000
murder_rate

# ordering the states by murder rate, in decreasing order
murders$state[order(murder_rate, decreasing = TRUE)]

# Assign city names to `city` 
city <- c("Beijing", "Lagos", "Paris", "Rio de Janeiro", "San Juan", "Toronto")
# Store temperature values in `temp`
temp <- c(35, 88, 42, 84, 81, 30)
# Convert temperature into Celsius and overwrite the original values of 'temp' with these Celsius values
temp <- 5/9 * (temp -32)
# Create a data frame `city_temps` 
city_temps <- data.frame(cities = city, tempC = temp)
city_temps

# COMPUTE SUM
# Define an object `x` with the numbers 1 through 100
x <- 1:100
# Compute the sum 
sum(x)
sum(1/x^2)

# Load the data - AVG murder rate in US
library(dslabs)
data(murders)
# Store the per 100,000 murder rate for each state in murder_rate
murder_rate <- murders$total / murders$population *100000
murder_rate
# Calculate the average murder rate in the US 
mean(murder_rate)
# min -> minimum value in the vector (array)
# which.min -> index of the min value 
######
# time in min (convert to hours)
# how many hours Olivia ran (time)
# what is the speed of Olivia's run
# who had the best speed
name <- c("Mandi", "Amy", "Nicole", "Olivia")
distance <- c(0.8, 3.1, 2.8, 4.0)
time <- c(10, 30, 40, 50)
time <- time / 60
time
df1 <- data.frame(name = name, time = time, speed = (distance / time))

# creating a data frame with stringAsFactors = FALSE
grades <- data.frame(names = c("John", "Juan", "Jean", "Yao"), 
                     exam_1 = c(95, 80, 90, 85), 
                     exam_2 = c(90, 85, 85, 90),
                     stringsAsFactors = FALSE)
grades
class(grades)
class(grades$names)

# Loading data
library(dslabs)
data(murders)
# Loading dplyr
library(dplyr)
# Redefine murders so that it includes a column named rate with the per 100,000 murder rates
murders <- mutate(murders, rate =  total / population * 100000)
# Defining rate
rate <-  murders$total/ murders$population * 100000
rate
# Redefine murders to include a column named rank
murders <- mutate(murders, rank = rate)
# with the ranks of rate from highest to lowest
murders <- mutate(murders, rank = rank(-rank))
murders

# Use select to only show state names and abbreviations from murders
str(murders)
select(murders, state, abb)
# Add the necessary columns
murders <- mutate(murders, rate = total/population * 100000, rank = rank(-rate))
# Filter to show the top 5 states with the highest murder rates
filter(murders, rank <= 5)

# Use filter to create a new data frame no_south
murders
no_south <- filter(murders, region != "South")
no_south
# Use nrow() to calculate the number of rows
nrow(no_south)
murders_nw <- filter(murders, region %in% c("Northeast", "West"))
murders_nw
# Number of states (rows) in this category 
nrow(murders_nw)

# add the rate column
murders <- mutate(murders, rate =  total / population * 100000, rank = rank(-rate))
# Create a table, call it my_states, that satisfies both the conditions 
my_states <- filter(murders, region %in% c("Northeast","West") & rate < 1)
my_states
# Use select to show only the state name, the murder rate and the rank
select(my_states, state, rate, rank)

# Load library
library(dplyr)
## Define the rate column
murders <- mutate(murders, rate =  total / population * 100000, rank = rank(-rate))
# show the result and only include the state, rate, and rank columns, all in one line, in that order
my_states <- filter(murders, region %in% c("Northeast", "West") & rate < 1) %>% 
  select(state, rate, rank)
my_states

# Loading the libraries & reset murders table & then do all functions in one command
library(dplyr)
data(murders)
# Create new data frame called my_states (with specifications in the instructions)
my_states <- murders %>% mutate(rate =  total / population * 100000, rank = rank(-rate)) %>% filter(region %in% c("Northeast","West") & rate < 1) %>% select(state, rate, rank)
my_states



