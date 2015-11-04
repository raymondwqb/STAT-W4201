rm(list=ls())
library(Sleuth2)
data(ex2224)
Nuclear<-ex2224
levels(Nuclear$System)<-c("containment","nuclear","power conversion","safety","process auxiliary")
levels(Nuclear$Operator)<-c("air","solenoid","motor-driven","manual")
levels(Nuclear$Valve)<-c("ball","butterfly","diaphragm","gate","globe","directional control")
levels(Nuclear$Size)<-c("<2","2-10","10-30")
levels(Nuclear$Mode)<-c("closed","open")
for (names in names(Nuclear)){
  if (class(Nuclear[[names]])!="numeric"){
    Nuclear[[names]]<-as.factor(as.numeric(Nuclear[[names]]))
  }
}

#loglinear poisson regression 
glmpoisson<-glm(Failures~System+Operator+Valve+Size+Mode,offset=log(Time),data=Nuclear,family="poisson")
summary(glmpoisson)

sink('/Users/raymond/Drive/STAT W4201/HW8/glmpoisson.txt')
glmpoisson
summary(glmpoisson)
sink()

# goodness of fit test
Goodness_of_Fit<-cbind(res.deviance = sprintf("%.8f",glmpoisson$deviance),df = glmpoisson$df.residual, p.value = sprintf("%.8f",(1-pchisq(glmpoisson$deviance,glmpoisson$df.residual,lower.tail = FALSE))))

sink("/Users/raymond/Drive/STAT W4201/HW8/glmgoodness.txt")
cat("Goodness of Fit Test \n \n")
write.table(Goodness_of_Fit,row.names = FALSE,quote = FALSE,sep="   ")
sink()

sink("/Users/raymond/Drive/STAT W4201/HW8/glmchisq.txt")
anova(glmpoisson,test="Chisq")
sink()

#lasso log linear poisson regression
#data matrix transformation of dummy variables
library(glmnet)

NuclearData<-subset(Nuclear,select=c("Failures","Time"))
for (names in names(Nuclear)[1:5]){
  for (factor in levels(Nuclear[[names]])[-1]){
    NuclearData[[paste(names,factor,sep="")]]<-as.numeric(Nuclear[[names]]==factor)
  }
}
NuclearMat<-as.matrix(NuclearData[,-c(1,2)])
set.seed(123)
glmpoisson_l1<-glmnet(NuclearMat,NuclearData$Failures,offset=log(NuclearData$Time),family="poisson")
glmpoisson_l1_cv<-cv.glmnet(NuclearMat,NuclearData$Failures,offset=log(NuclearData$Time),family="poisson")

#plot the best lambda
png(filename = "/Users/raymond/Drive/STAT W4201/HW8/glmpoisson_l1_cv.png")
plot(glmpoisson_l1_cv)
title(main = "L-1 log-linear Poisson Regression", line = 2.5)
dev.off()

#get model coefficients
lambda<-glmpoisson_l1_cv$lambda.min
model<-glmpoisson_l1_cv$glmnet.fit
coeff<-coef(model,lambda)
sink('/Users/raymond/Drive/STAT W4201/HW8/glmpoisson_l1_cv.txt')
coeff
sink()


