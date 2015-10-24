rm(list=ls())
library(MASS)
multilinear<-lm(medv~crim+zn+indus+nox+rm+age+tax,data=Boston)
summary(multilinear)

sink("/Users/Qianbo/Google Drive/STAT W4201/HW5/multilinear.txt")
summary(multilinear)
sink()

#VIF detect multicollinearity
anova_table<-anova(multilinear)
SS<-anova(multilinear)$"Sum Sq"
VIF<-1/(1-SS[-length(SS)]/sum(SS))
anova_table$"VIF"<-c(VIF,"")
sink("/Users/Qianbo/Google Drive/STAT W4201/HW5/anova.txt")
anova_table
sink()
VIF_bar<-mean(VIF)

#correlation matrix

names<-c("crim","zn","indus","nox","rm","age","tax")
explanatory<-as.matrix(Boston[names])
dependent<-as.matrix(Boston["medv"])
corr_mat<-cor(explanatory)
eigen_values<-eigen(corr_mat)$values
con_number<-max(eigen_values)/min(eigen_values)

#ridge regression
ridge_reg<-lm.ridge(medv~crim+zn+indus+nox+rm+age+tax,data=Boston)
ridge_coef<-ridge_reg$coef

#Lasso regression
library(glmnet)
names<-c("crim","zn","indus","nox","rm","age","tax")
explanatory<-as.matrix(Boston[names])
dependent<-as.matrix(Boston["medv"])

lasso_reg<-glmnet(explanatory,dependent)
cv_reg<-cv.glmnet(explanatory,dependent)
plot(cv_reg)

png(file="/Users/Qianbo/Google Drive/STAT W4201/HW5/lasso.png")
plot(cv_reg)
title("Lasso with CV plot",line = 2.5)
dev.off()

#choose model coefficient
lambda<-cv_reg$lambda.min
coeff<-coef(cv_reg,s="lambda.min")
predict_lasso<-predict(cv_reg,newx = explanatory,s="lambda.min")
MSE_lasso<-mean((dependent-predict_lasso)^2)

#stepwise regression
glm_model1<-glm(medv~1,data=Boston)
glm_model2<-glm(medv~crim+zn+indus+nox+rm+age+tax,data=Boston)

backward<-stepAIC(glm_model2,direction = "backward",scope=list(
  upper = glm_model2,lower = glm_model1),trace = F)

forward<-stepAIC(glm_model1,direction = "forward",scope=list(
  upper = glm_model2,lower = glm_model1),trace = F)

sink("/Users/Qianbo/Google Drive/STAT W4201/HW5/forward.txt")
forward
sink()
sink("/Users/Qianbo/Google Drive/STAT W4201/HW5/backward.txt")
backward
sink()

#calculate MSE
predict_back<-predict(backward,newx = explanatory)
predict_for<-predict(forward,newx = explanatory)
MSE_back<-mean((dependent-predict_back)^2)
MSE_for<-mean((dependent-predict_for)^2)