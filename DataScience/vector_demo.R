# using the colon syntax
v <- 1:10
v

10:1
-10:10

#using the c function
c(5, 7, 10, 99, v)


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



