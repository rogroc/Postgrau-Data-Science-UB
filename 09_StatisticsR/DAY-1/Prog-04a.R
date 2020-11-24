x <- 1:15 
if (sample(x, 1) <= 10)  { 
          print("x is less than 10") 
      }   else { 
          print("x is greater than 10") 
      } 

ifelse(x <= 10, "x less than 10", "x greater than 10")

y <- if (sample(x, 1) < 10) { 5 } else { 0 } 

for (i in 1:10) { 
          print(i)
          } 
