# like arrays
# use 'c' or concatenate to create a vector
# for characters, double or single quotes can be used
codes <- c(380, 124, 818)
codes

country <- c('italy', 'hungary', 'denmark')
class(country)
country

#names
codes <- c(italy=380, canada=124, egypt=818)
codes
class(codes)
names(codes)

# same as above
codes <- c("italy" = 380, "canada" = 124, "egypt" = 818)
codes

# assign names
codes <- c(380, 124, 818)
country <- c("italy", 'canada', "egypt")
names(codes) <- country
codes

#sequences 1-start, 10-end, 2-jump by
seq(1,10)
seq(1,10,2)
1:10
# will be integer
class(1:10) 
# will be numeric
class(seq(1,10,0.5))

# subsetting - or index
codes
codes[2]
# multi-entry vector as an index, show record #1 and #3
codes[c(1,3)]
# show records 1-2 and 1-4
codes[1:2]
codes[1:4]

codes["canada"]
codes[c("egypt","italy")]






