PredictiveModel1<-function(mydataset,myformula){
  mod1<-glm(myformula, mydataset, family=binomial)
  return(mod1)
}
PredictiveModel2<-functon(mydataset, myregressors, myy){
  forest<-randomForest(as.factor(myy)~myregressors,data=mydataset, importance=TRUE, ntree=100)
  return(forest)
}
