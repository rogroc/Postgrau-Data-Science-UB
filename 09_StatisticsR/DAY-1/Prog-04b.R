add <- function(a, b) { 
            return(a + b) 
              } 
vector <- c(3, 4, 5, 6) 
sapply(vector, add, 1) 

# Functions with pre defined values
temp <- function(a = 1, b = 2) { return(a + b) }
 
# Functions usually return the last value it computed
f <- function(x) { if (x < 10) { 0 } else { 10 } } 

# This is a constructor function, i.e. a function that creates another one.
make.power <- function(n) { pow <- function(x) { x^n }}
 
cube <- make.power(3) 
square <- make.power(2) 
cube(3)
