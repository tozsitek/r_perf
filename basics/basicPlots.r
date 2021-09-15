library(dplyr)
library(dslabs)
data(murders)

population_in_millions <- murders$population/10^6
total_gun_murders <- murders$total
plot(population_in_millions, total_gun_murders)

# Create new data frame called my_states (with specifications in the instructions)
my_states <- murders %>% mutate(rate =  total / population * 100000, rank = rank(-rate)) %>% filter(region %in% c("Northeast","West") & rate < 1) %>% select(state, rate, rank)
my_states
murders <- mutate(murders, rate = total / population * 100000, rank = rank(-rate) )
murders

# histogram
hist(murder$rate)
murders$state[which.max(murders$rate)]

# BOXPLOT
boxplot(rate~region, data = murders)
# Create a boxplot of state populations by region for the murders dataset
boxplot(population~region, data=murders)

# Plot with log10
# Load the datasets and define some variables
library(dslabs)
data(murders)
population_in_millions <- murders$population/10^6
total_gun_murders <- murders$total
plot(population_in_millions, total_gun_murders)
# Transform population (not population in millions) using the log10 transformation and save to object log10_population
log10_population<- log10(murders$population)
# Transform total gun murders using log10 transformation and save to object log10_total_gun_murders
log10_total_gun_murders <- log10(murders$total)
# Create a scatterplot with the log scale transformed population and murders 
plot(log10_population, log10_total_gun_murders)
