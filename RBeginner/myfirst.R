library(tidytext)

#for (i in 1:10) {
#    print("this is awesome.")
#
obs <- 100
x <- rnorm(obs, mean = 1, sd = 1)
y <- 2 * x + rnorm(obs)
w <- runif(obs)
m <- lm(y ~ x, weights = w)
coef(m)

result <- local({
    x <- rnorm(obs)
    y <- rnorm(obs)
    (x + y) * w
})


fun <- function(var1, var2){
    if (var1 > var2) {
       var3 <- var1 + var2
       var4 <- 1 + 2
       for (var5 in 1:10) {
           var1 + var2 + var3 + var5
       }
    } else {
        var1 - y
    }

}


fun(10, var2 = 20)

######
x <- c(0:10, 50)
xm <- mean(x)
c(xm, mean(x, trim = 0.10))

###
salary <- 100000
expenses <- 40000
savings <- salary - expenses
typeof(5L)
typeof(savings)
typeof(4i)
typeof('Hello World')
LETTERS
pi
month.name
month.abb

### Arithmetic & relational operations
### + - * /
### division for only integer part of division
16 %/% 3
### remainder of division
21 %% 6
### exponential
2 ** 8
2 ^ 8
# Boolean
101 >= 101.2
100 == 100  ## don't use == to compare floating point variables
sqrt(2) ** 2 - 2 ### this should be 0
sqrt(2)
a <- sqrt(2)
a ** 2
123.45 != 123




### Conditional operators
!FALSE
!TRUE
(12 > 5) || ( 11 > 100)
(12 < 5) || ( 11 > 100)

(12 > 5) && ( 11 > 100)
(12 > 5) && ( 11 < 100)

history.score <<- 55  ### global variable
history.score

z <- b <- 5  ### multiple assignments
z
b

### Built-in functions
print("hello")
print(z)
return.val <-print(24)
return.val
abs(-10)     ## absolute value
sqrt(1000)
ceiling(3.4) # smallest integer higher than 3
round(3.4) # round up over 3.5, round down under 3.5
ceiling(3.6)
round(3.6)
floor(3.6)
trunc(3.6)   ## drops the fraction, does not truncate the digits
some.string <- "I am having some fun"
substr(some.string, 1, 5)  # starting from 1 not from z
upper.string <- toupper(some.string)
upper.string
lower.string <- tolower(some.string)
lower.string
nchar(some.string)  # number of chars

### Numeric built-in functions
vector.a <- c(10, 20, 30,40, 50)   # c is for combined
vector.a
vector.length <- length(vector.a)
vector.length
vector.numbers.1 <- seq(1,10)
vector.numbers.1
length(vector.numbers.1)
vector.numbers.2 <- 10:15
vector.numbers.2
seq(3, 8, by=0.5)
seq(10,3)
seq(10,50, length=6)
seq(1,2, length=5)
# repeat
rep(10, times=10)
rep("R", 5)
rep(TRUE, 4)
rep(1:3, 2)
rep(1:4, each=2)
# Sample
student.test.scores <- c(55, 67, 34, 92, 95, 48, 83)
student.test.scores
mean(student.test.scores)
median(student.test.scores)
sd(student.test.scores) # n-1
summary(student.test.scores)
#Compare below two
all.equal(sqrt(2) ** 2 -2, 0) # TRUE
sqrt(2) ** 2 -2 == 0  # FALSE

# RECOGNIZING THE BASIC DATA TYPES in R
typeof(TRUE) # logical is one of the 6 canonical data types
typeof(10)
typeof(4.5)
typeof(10L)  # L is for integer
typeof("hello")
typeof(4 + 5i) # i = sqrt of negative 1
# typeof & class returns the same value - except double values vs numeric
# class is an internal storage, returns type of object that is stores
class(TRUE)
class(10)
class(10L)
class(Inf)
class("hello")
class(4 + 5i)
#
double.var <- 10
int.var <- 10L
boolean.var <- FALSE
complex.var <- 4 + 6i
charater.var <- "Hello R world"
is.numeric(double.var)
is.numeric(int.var)
is.integer(double.var)
is.integer(int.var)
is.logical(boolean.var)
double.var < 5
is.logical(double.var < 5)
is.character(charater.var)
is.complex(4)
is.complex(4 + 7i)
# type and version
string.hundred <- "100"
integer.hundred <- as.integer(string.hundred)
integer.hundred  # this is integer
numeric.hundred <- as.numeric(string.hundred)
numeric.hundred # this is double
converted.complex <- as.numeric(3 + 4i)
converted.complex  # discards the 4i or imaginary part
converted.complex <- as.character(3 + 4i)
converted.complex
