#Step 1
install.packages("devtools")
library("devtools")
devtools::install_github("klutometis/roxygen")
install.packages("roxygen2")
library(roxygen2)
setwd("..")
create("R4DSUB")

#Step 2 copy functions to R folder

#Step 3 document functions and create documents
setwd("./R4DSUB")
document()

#Setup 3b Build, create binary

#Step 4 install
setwd("..")
install("R4DSUB")

#Read to use
?PredictiveModel1
