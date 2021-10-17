# define p
library(tidyverse)
library(dplyr)
library(ggplot2)
library(dslabs)
data(murders)

# ggplot(data = murders)
# above is the same as:
murders %>% ggplot()
# assign a graph object to the object p
p <- ggplot(data = murders)
# p is a ggplot object
class(p)
# to see the plot: print(p) or simply type p
#p

murders %>% ggplot() +
  geom_point(aes(x = population/10^6, y = total))

# add points layer to predefined ggplot object
p <- ggplot(data = murders)
p + geom_point(aes(population/10^6, total))

# add text layer to scatterplot
# label = abb: label comes from the dataset abb column
p + geom_point(aes(population/10^6, total)) +
  geom_text(aes(population/10^6, total, label = abb))


### TINKERING
## Change the size of the point
p + geom_point(aes(population/10^6,total),size = 3) +
  geom_text(aes(population/10^6, total, label = abb))
## nudge_x moves labels to the right - state labels
p + geom_point(aes(population/10^6,total),size = 3) +
  geom_text(aes(population/10^6, total, label = abb),nudge_x = 1)
## GLOBAL aes mapping
## args(ggplot)
## Simplify the code: mapping inside the ggplot function
p <- murders %>% ggplot(aes(population/10^6, total, label = abb))
p + geom_point(size = 3) +
  geom_text(nudge_x = 1.5)
## local mappings overwrite the global ones
# local aesthetics override global aesthetics
p + geom_point(size = 3) +
  geom_text(aes(x = 10, y = 800, label = "Hello there!"))

## SCALES, LABELS, COLORS
##
# log base 10 scale the x-axis and y-axis
# then add labels and title
# make all points blue
## p + geom_point(size = 3, color = "blue")
# color points by region
## p + geom_point(aes(col = region), size = 3)
p <- murders %>% ggplot(aes(population/10^6, total, label = abb))
p + geom_point(aes(col = region), size = 3) +
  geom_text(nudge_x = 0.075) +
  scale_x_continuous(trans = "log10") +
  scale_y_continuous(trans = "log10") +
  xlab("Population in millions (log scale)") +
  ylab("Total number of murders (log scale)") +
  ggtitle("US Gun Murders in 2010")


## ADD a LINE with AVG murder rate
# define AVG murder rate
r <- murders %>%
  summarize(rate = sum(total) / sum(population) * 10^6) %>%
  pull(rate)
# basic line with average murder rate for the country
p <- p + geom_point(aes(col = region), size = 3) +
  geom_abline(intercept = log10(r))    # slope is default of 1
# change line to dashed and dark grey, line under points
p<- p + 
  geom_abline(intercept = log10(r), lty = 2, color = "darkgrey") +
  geom_point(aes(col = region), size = 3)
## CHANGE legend TITLE
p <- p + scale_color_discrete(name = "Region")    # capitalize legend title
