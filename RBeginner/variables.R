# variables

# integer
x <- 2L
typeof(x)
x1 <- 2
x1
# double
y <- 2.5
y
typeof(y)
#complex
z <- 3 + 2
typeof(z)
z
# character
a <- "h"
typeof(a)
a
#logical
q <- T
q
typeof(q)
q2 <- FALSE
q2
typeof(q2)

# USING VARIABLES
A <- 10
B <- 5
C <- A + B
C
var1 <- 2.5
var2 <- 4
result <- var1 / var2
result
answer <- sqrt(var2)
answer
# add strings together
greeting <- "Hello"
name <- "Bob"
message <- paste(greeting, name)
message

# LOGICAL VARIABLES and OPERATORS
# TRUE or FALSE  
# T or F
4 < 5
10 > 100
4 == 5
# Operators
# == != < > <= >= ! | & isTRUE(x)
result <- 1 < 5
result
typeof(result)

result2 <- !TRUE
result2
result3 <- !(5>1)
result3
result | result3
result & result3
isTRUE(result)

# WHILE LOOP
counter <- 1
while (counter <= 10) {
  print(counter)
  counter <- counter + 1
}

# FOR LOOP
for (i in 5:10) {
 print(i) 
}

# IF STATEMENT
# random variables in normal distribution
rnorm(1)
pnorm(1)

# nested IF, not a good solution
rm(answer)
x <- rnorm(1)
x
if(x > 1){
  answer <- "Greater than 1"
  answer
}else{
  if(x >= -1){
    answer <- "Between -1 and 1"
  }else{
    answer <- "Less than -1"
  }
}

# use ELSEIF instead above
# CHAINING STATEMENT
rm(answer)
x <- rnorm(1)
x
if(x > 1){
  answer <- "Greater than 1"
  answer
}else if(x >= -1){
  answer <- "Between -1 and 1"
  answer
}else{
    answer <- "Less than -1"
    answer
}

# HOMEWORK:
# LAW of LARGE NUMBERS
# Normal distribution
# bell curve: 0.1%(x<-3) - 2.1%(-3<x<-2) - 13.6% (-2<x<-1)- 34.1% (-1<x<0)
# cont: - 34.1% (0<x<1)- 13.6% (1<x<2) - 2.1% (2<x<3)- 0.1% (x>-3)
# Test the Law of Large Number for N random normally distributed numbers 
# with mean=0,stdev=1
# Create an R script that will count how many of these numbers fall between -1 & 1
# and divide by the total quantity of N
# You know that E(X) = 68.2%
# Check that Mean(Xn) >- E(X) as you rerun your script while increasing N
N <- 1000
counter <- 0
for(i in rnorm(N)){
  if(i >= -1 & i <= 1){
    counter <- counter + 1
  }
}
result <- counter / N
result

  
