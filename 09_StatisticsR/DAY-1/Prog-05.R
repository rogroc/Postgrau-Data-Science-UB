install.packages("ggplot2")
library("ggplot2")
gapminder <- read.csv('gapminder.csv', stringsAsFactors = F)
gapminder_1982 <- subset(gapminder, year == 1982)
plot(lifeExp ~ gdpPercap, data = gapminder_1982, log = "x")
mycol <- c(Asia = "tomato", Europe = "chocolate4", Africa = "dodgerblue2", 
           Americas = "darkgoldenrod1", Oceania = "green4"
)
plot(lifeExp ~ gdpPercap, data = gapminder_1982, log = "x",
     col = mycol[continent]    
)
#' Scale a transformed variable to a given range
#'
#' @param var variable to scale
#' @param f function to transform var before scaling
#' @param r range to which variable should be scaled
#'
#' @example
#' x = rnorm(10)
#' mycex(x, square, c(1, 10))
mycex <- function(var, r, f = sqrt){
  x = f(var)
  x_scaled = (x - min(x))/(max(x) - min(x))
  r[1] + x_scaled * (r[2] - r[1])
}
plot(lifeExp ~ gdpPercap, data = gapminder_1982, log = "x",
     col = mycol[continent],
     cex = mycex(pop, r = c(0.2, 10))
)
trend <- lm(lifeExp ~ log10(gdpPercap), data = gapminder_1982)
plot(lifeExp ~ gdpPercap, data = gapminder_1982, log = "x",
     col = mycol[continent],
     cex = mycex(pop, r = c(0.2, 10))
)
abline(trend)

plot(lifeExp ~ gdpPercap, data = gapminder_1982, log = "x",
     col = mycol[continent],
     cex = mycex(pop, r = c(0.2, 10))
)
#install.packages("plyr")
library("plyr")
d_ply(gapminder_1982, .(continent), function(d){
  trend <- lm(lifeExp ~ log10(gdpPercap), data = d)
  abline(trend, col = mycol[d$continent[1]])
})

