RegModel.1 <-lm(balance~age, data=Bank1)

summary(RegModel.1)

plot( Bank1$age, Bank1$balance)

Bank1$agesq=Bank1$age*Bank1$age
RegModel.2 <-lm(balance~age+agesq+loan, data=Bank1)
summary(RegModel.2)

summary(Bank1$balance)

Bank2<-subset(Bank1, balance>100)

RegModel.3 <-lm(balance~age+agesq+loan, data=Bank2)
summary(RegModel.3)

####  Exit save YES
