

######################################################################29
##
## Page 29 Fast-learning R when you already are a programmer
##
#
# Some examples of R commands
#
 10^2 + 36

 a = 4
 a

 rm(list=ls()) ## removes all variables from memory

#
# Scalars, vectors and functions
#
b=c(3,4,5)
 mean(b)
 rnorm(15)
   set.seed(1) 
 rnorm(10)
 plot(rnorm(100))


#######################################################################30
##
## Page 30 Fast-learning R when you already are a programmer (II)
##
#
# You can run in batch mode
#
 source("Prog-01a.R")
#
#You can change  your working directory
#
 setwd("c\\project-2")
#
#
# Data structures: vectors
#
vec1 = c(1,4,6,8,10)
 vec1[5] ### careful Python lovers
 vec1[3] = 12
   vec2 = seq(from=0, to=1, by=0.25)
 sum(vec1)
 vec1+vec2

#######################################################################31
##
## Page 31 Fast-earning R when you already are a programmer (III)
##
#
# Data structures: matrices
#
 mat=matrix(data=c(9,2,3,4,5,6),ncol=3)
 mat
 mat[2,] ### careful Python lovers

#
# Data structures: data frames and lists
#   A data frame is a matrix with names above the columns. 
#    This is nice, because you can call and use one of the 
#    columns without knowing its position .

 t = data.frame(x = c(11,12,14),
      y = c(19,20,21), z = c(10,9,7))
   mean(t$z)
 mean(t[["z"]])
 L = list(one="a", two=c(1,2), five=seq(0, 1,length=5))
 names(L)
 L$two[2]

# note attach(t) and detach(t) for data frames


#######################################################################32
##
## Page 32 Miscelaneous
##
#
# Reading and writing data files
#
write.table(t, file="tst0.txt", row.names=FALSE)
write.csv(t, file="file1.csv",  sep=";",  dec=",")
read.table(file="tst0.txt", header=TRUE)

#
# Not available data
#
 vec = c(1,2,NA)
 max(vec, na.rm=TRUE)
 vec[is.na(vec)]<-99
 max(vec)

#
# Characters and dates
#
# as.date
# as.character
# as.numeric
 date1=strptime( c("20100225230000","20100226000000", "20100226010000"),format="%Y%m%d%H%M%S")



#######################################################################33
##
## Page 33 More on vectors and arrays
##
#
# Basic operators element-by-element
#  *, /, +, - 
#  Repetition, sequence
 a=c(1,2)
 rep(a, times=3)

 z<- array(1:24, dim=c(2,3,4))
 z
 dim(z)

#
#Factors   (Be careful!!!!!!)
#
 sex=c("M", "W", "W", "W", "W", "M", "M")
 sex=factor(sex)
 sex
 levels(sex)
 age=c(19, 20, 18, 18, 20, 21, 22)
 mean(age[sex=="W"])


#######################################################################34
##
## Page 34 Further tasks
##
#
 # Create tables of frequencies and marginals
 # Multidimensional tables , add names in rows and columns
 # Typical functions:  mean, sum, max, sd (standard deviation)
 # lapply (calculates a function for all Items in a list a returns a list)
 # sapply (returns a vector)
 # apply (only for rows  (1) or columns (2))
 # tapply (function separating by a factor)


a <- matrix(1:12, nrow=3, ncol=4) # fills by columns
                                  # byrow = TRUE for rows 
apply(a,1,sum)
apply(a,2,mean)
tapply(age, sex, mean)

