# using the colon syntax
v <- 1:10
v[1] <- 2
v
w <- 10:1
# modifying a range of values
w[w < 5] <- 1
w

#deleting a vector
u <- 1:5
u
u <- NULL
u

# vector arithmetic
v
w
v+w
v-w
v*w
v/w

# operating scalars
v + 1
v * 2

# combine vectors
u <- c(v,w)
u


10:1
-10:10

#using the c function
c(5, 7, 10, 99, v)
v
sum(v)
prod(v)
min(v)
max(v)

# sort vectors

v <- c(10,2,1,3,5,8,4,7,6,9)
sort(v)
sort(v, decreasing=TRUE)

w <- c("Steve", "Bob", "Jane", "Sally", "Alice")
sort(w)

u <- c(5, NA, 1, 3, NA, 4, 2)
# excludes NA values
sort(u)
# moves NA values at the end of the list
sort(u, na.last=TRUE)



#using seq
seq(from = 1.5, to = 22.5, by = 0.5)
seq(1.5, 22.5, 0.5)
seq(25, 103, length.out = 7)

# access elements
v[1]
v[0]
typeof(v)
length(v)

v
v[-2]  # excludes item #2
v[v > 5]  # range from item 6

x <- c("url"="www.example.com", "page"="indext.html")
x["url"]  # displays name and value
unname(x["url"])  # displays only the URL value
names(x) # displays only the names used in the vector

# lists

a <- list(2, "Steve", TRUE, FALSE, NA, 5.5, c(1,2))
a[1]
a[1:2]
a[[7]]
a[[7]][1]
typeof(a)
typeof(a[1])
typeof(a[[1]])

b <- list(a=c(1,2,3), b=c(4,5,6), c=c(7,8,9))
b
# access list contents by individual groups
b$a
b$b
b$c
b$a <- c(3,2,1)
#structure of list
str(b)
length(b)
# list apply
lapply(b,mean)
sapply(b, mean)

# creating matrices
M <- matrix(c(1,3,4,64,11,34), nrow=3, ncol=2, byrow=FALSE)
M
M[1,2] # row 1, column 2
M[1,] # row 1 with both columns
M[,2] # column 2

N <- matrix(c(10,10,10), nrow=3, ncol=1)
N
cbind(M,N) # adds column N to M
a <- c(M)
a
# diagonal matrix
diag(c(1,2,3))
diag(3)  # 3*3 identity matrix
diag(c(2,2,2,3))


M <- matrix(c(1,3,4,11,34,4,-1,0,5), nrow=3, ncol=3, byrow=FALSE)
M
det(M) # determinant
qr(M) # queue r
svd(M)
eigen(M)
solve(M) # inverse

N <- diag(c(2,2,2))
N
M*N # element wise
M%*%N  # full matrix operation, multiplication

# FACTORS dummy/categorical variables
fuel <- c("petrol", "diesel", "electric", "diesel",
          "electric", "petrol", "petrol", "diesel", "electric",
          "electric", "electric", "diesel", "diesel", "petrol")
fuel
ff <- factor(fuel)
ff

levels(ff)
levels(ff)[1]
nlevels(ff)
str(ff)
table(ff)
as.character(ff)
as.numeric(ff)

# DATA FRAMES
coffee <- data.frame(
  country = c("Brazil", "Vietnam", "indonesia", "Columbina", "Ethiopia"),
  production = c(43.4, 24.0, 8.6, 7.6, 6.0),
  percent = c(32.4, 17.9, 6.4, 5.7, 4.5),
  increasing = c(FALSE, TRUE, TRUE, FALSE, TRUE))
coffee
coffee[,2]
coffee["production"]
coffee[1,]
coffee[1,2]
coffee[1:2, 1:2]
str(coffee)
names(coffee)

mtcars
head(mtcars)
tail(mtcars)
dim(mtcars) # this data frame has 32 rows and 11 columns
nrow(mtcars) # number of rows
ncol(mtcars) # number of columns
summary(mtcars) # statistics of min/mean/max...

coffee_simple <- coffee[,1:2] # all rows, column 1 & 2
# coffee_simple <- coffee[,-3:-4] # same as above, all rows, removing column 3 & 4
coffee_simple
coffee_simple$production <- c(41.5, 25.0, 9.1, 8.2, 5.0)
coffee_simple
coffee_simple[1,2] <- 42.5
coffee_simple
coffee_simple["new_column"] <- c(1,2,3,4,5)
coffee_simple

myframe <- data.frame(
  Date = c("3/2/2022", "3/3/2022", "3/6/2022"),
  Asset = c("Forex", "Forex", "Futures"),
  Symbol = c("USD/JPY", "AUD/CAD", "AUD/USD")
)
myframe
mf <- myframe[,3] # display in a row
mf
mf <- myframe$Asset # display in a row
mf
mf <- myframe["Asset"]  # display in a column
mf
mf <- myframe[1:3,] # first 3 rows in all columns
mf
str(myframe)
str(mf)
mf <-myframe
mf
mf[1,2] <- "Stocks"
mf

