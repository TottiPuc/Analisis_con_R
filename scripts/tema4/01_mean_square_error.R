dat <- read.csv("../data/tema4/rmse.csv")

rmse <- sqrt(mean((dat$price - dat$pred)^2))
rmse

plot(dat$price , dat$pred, xlab = "actual", ylab = "Predicho")
abline(0,1)

rmse <- function(actual, predicho){
  return(sqrt(mean((actual - predicho)^2)))
}

rmse(dat$price, dat$pred)
