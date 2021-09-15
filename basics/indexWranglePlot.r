library(learnr)
library(dslabs)
library(dplyr)
data("murders")

str(murders)
murder_rate <- murders$total / murders$population*100000
murder_rate
index <- murder_rate < 0.71
index <- murder_rate <= 0.71
index
# what are the states where the murder rate is less than or = to 0.71
murders$state[index]
sum(index)
# conditions settings (safe and west states)
west <- murders$region == "West"
safe <- murder_rate <= 1
index <- safe & west
murders$state[index]

##
# INDEX functions (which, match, %in%)
##
# use WHICH
index <- which(murders$state == "Massachusetts")
index 
murder_rate[index]

# murder rate for several states - use MATCH
index <- match(c("New York","Florida","Texas"),murders$state)
index
murders$state[index]
murder_rate[index]

# use %in%
x <- c('a','b','c','d','e')
y <- c('a','d','f')
y %in% x
x <- c(2, 3, 5)
y <- c(1, 2, 3, 4)
x%in%y
# are the following in the states column?
c('Boston', 'Dacota', 'Washington') %in% murders$state
# relation between match and %in% - below gives the same answer
match(c("New York", "Florida", "Texas"), murders$state)
which(murders$state%in%c("New York", "Florida", "Texas"))

# Store the murder rate per 100,000 for each state, in `murder_rate`
murder_rate <- murders$total / murders$population * 100000
# Store the `murder_rate < 1` in `low` 
low <- murder_rate < 1
low
# Get the indices of entries that are below 1
which(low)
# Names of states with murder rates lower than 1
murders$state[low]
# Create a vector ind for states in the Northeast and with murder rates lower than 1. 
ind <- murders$region == "Northeast" & murder_rate < 1
ind
# Names of states in `ind` 
murders$state[ind]
# Compute the average murder rate using `mean` and store it in object named `avg`
avg <- mean(murder_rate)
avg
# How many states have murder rates below avg ? Check using sum 
sum(murder_rate < avg)

# Store the 3 abbreviations in a vector called `abbs` (remember that they are character vectors and need quotes)
abbs <- c('AK','MI','IA')
abbs
# Match the abbs to the murders$abb and store in ind
ind <- match(abbs, murders$abb)
ind
# Print state names from ind
murders$state[ind]

# Store the 5 abbreviations in `abbs`. (remember that they are character vectors)
abbs <- c('MA','ME','MI','MO','MU')
abbs
# Use the %in% command to check if the entries of abbs are abbreviations in the the murders data frame
abbs%in%murders$abb

# Store the 5 abbreviations in abbs. (remember that they are character vectors)
abbs <- c("MA", "ME", "MI", "MO", "MU") 
# Use the `which` command and `!` operator to find out which index abbreviations are not actually part of the dataset and store in `ind`
ind <- which(!abbs%in%murders$abb)
ind
# Names of abbreviations in `ind`
abbs[ind]



####
# WRANGLING
###
##
# MUTATE - add a column to the table
#
murders <- mutate(murders, rate=total/population*100000)
head(murders)

# FILTER (table, condition)
filter(murders, rate <= 0.71)

# SELECT
new_table <- select(murders,state,region,rate)
filter(new_table, rate <= 0.71)

# put it all together with the PIPE or %>%
murders %>% select(state,region,rate) %>% filter(rate <= 0.7)
#practice
16 %>% sqrt() %>% log2()
16 %>% sqrt() %>% log(base = 2)
murders <- mutate(murders, rate =  total / population * 100000, rank = rank(-rate))
my_states <- filter(murders, region %in% c("Northeast", "West") & rate < 1)
select(my_states, state, rate, rank)
# in short for above:
mutate(murders, rate =  total / population * 100000, rank = rank(-rate)) %>%
  select(state, rate, rank)

# PRACTICE
# First, determine the average height in this dataset. 
# Then create a logical vector ind with the indices for those individuals who are above average height.
library(dslabs)
data(heights)
options(digits = 3)    # report 3 significant digits for all answers

heights
avg <- mean(heights$height)
avg
#filter(heights, heights$height > avg)
ind <- heights$height > avg
ind
sum(ind)

# How many individuals in the dataset are above average height and are female?
str(heights)
ind1 <- heights$height > avg & heights$sex == "Female"
ind1
sum(ind1)
# If you use mean() on a logical (TRUE/FALSE) vector, it returns the proportion of observations that are TRUE.
ind2 <- heights$sex == "Female"
ind2
mean(ind2)
# Determine the minimum height in the heights dataset.
minheight <- min(heights$height)
# Use the match() function to determine the index of the first individual with the minimum height.
ind3 <- match(minheight,heights$height)
ind3
# Subset the sex column of the dataset by the index in 4b to determine the individual’s sex.
heights$sex[ind3]
# determine the max height
maxheight <- max(heights$height)
maxheight
# Write code to create a vector x that includes the integers between the minimum and maximum heights (as numbers).
x <- as.numeric(minheight:maxheight)
x
# How many of the integers in x are NOT heights in the dataset?
y <- !x %in% heights$height
y
sum(y)
# Using the heights dataset, create a new column of heights in centimeters named ht_cm. 
# Recall that 1 inch = 2.54 centimeters. Save the resulting dataset as heights2.
heights1 <- mutate(heights, ht_cm = heights$height * 2.54)
heights1
# What is the height in centimeters of the 18th individual (index 18)?
heights1$ht_cm[18]
# What is the mean height in centimeters?
mean(heights1$ht_cm)
# Create a data frame females by filtering the heights1 data to contain only female individuals.
females <- filter(heights1, heights1$sex == "Female")
females
# How many females are in the heights1 dataset?
nrow(females)
# What is the mean height of the females in centimeters?
mean(females$ht_cm)

# The olive dataset in dslabs contains composition in percentage of eight fatty acids 
# found in the lipid fraction of 572 Italian olive oils:
library(dslabs)
data(olive)
head(olive)
plot(olive$palmitic, olive$palmitoleic)
# Create a histogram of the percentage of eicosenoic acid in olive.
hist(olive$eicosenoic)
# Make a boxplot of palmitic acid percentage in olive with separate distributions for each region.
boxplot(palmitic~region, data = olive)

