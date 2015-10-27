rm(list=ls())
data("ChickWeight")

#Categorize weight as Weight
ChickWeight$Weight<-rep(0,dim(ChickWeight)[1])
ChickWeight$Weight[ChickWeight$weight>215]<-1

#logistic regression with Diet and Weight on day 21 without adjust for Birth Weight
sub_day21<-subset(ChickWeight,Diet %in% c(1,4) & Time==21)
sub_day21$Group<-rep(0,dim(sub_day21)[1])
sub_day21$Group[sub_day21$Diet==1]<-1
log_day21<-glm(Weight~Group,family="binomial",data=sub_day21)

sink('/Users/raymond/Drive/STAT W4201/HW7/log_day21.txt')
summary(log_day21)
sink()

BirthWeight<-subset(ChickWeight,select=c(weight,Chick),Time==0)
names(BirthWeight)[names(BirthWeight)=="weight"]<-"BirthWeight"
sub_day21<-merge(sub_day21,BirthWeight,by.y = "Chick")

#logistic regression with Diet and Weight on day 21 with adjust for Birth Weight
log_day21_adjust<-glm(Weight~Group+BirthWeight,family="binomial",data=sub_day21)

sink('/Users/raymond/Drive/STAT W4201/HW7/log_day21_adjust.txt')
summary(log_day21_adjust)
sink()

#all groups 
sub_day21_all<-subset(ChickWeight,Time==21)
sub_day21_all$Group1<-rep(0,dim(sub_day21_all)[1])
sub_day21_all$Group1[sub_day21_all$Diet==1]<-1
sub_day21_all$Group2<-rep(0,dim(sub_day21_all)[1])
sub_day21_all$Group2[sub_day21_all$Diet==2]<-1
sub_day21_all$Group3<-rep(0,dim(sub_day21_all)[1])
sub_day21_all$Group3[sub_day21_all$Diet==3]<-1
log_day21_all<-glm(Weight~Group1+Group2+Group3,family="binomial",data=sub_day21_all)
sink('/Users/raymond/Drive/STAT W4201/HW7/log_day21_all.txt')
summary(log_day21_all)
sink()

#logistic regression with Diet and Weight on day 21 with adjust for Birth Weight
sub_day21_all<-merge(sub_day21_all,BirthWeight,by.y = "Chick")
log_day21_all_adjust<-glm(Weight~Group1+Group2+Group3+BirthWeight,family="binomial",data=sub_day21_all)
sink('/Users/raymond/Drive/STAT W4201/HW7/log_day21_all_adjust.txt')
summary(log_day21_all_adjust)
sink()

#L-1 regularized logistic regression with Diet and Weight on day 21 without adjust for Birth Weight
library(glmnet)
data<-as.matrix(subset(sub_day21,select = c("BirthWeight","Group")))
colnames(data)<-c("BirthWeight","Group")
l1log_day21<-glmnet(data,sub_day21$Weight,family="binomial")
cv_l1log_day21<-cv.glmnet(data,sub_day21$Weight,family="binomial")

png(filename = "/Users/raymond/Drive/STAT W4201/HW7/cv_l1log.png")
plot(cv_l1log_day21)
title(main = "L-1 Logistic Regression", line = 2.5)
dev.off()

lambda<-cv_l1log_day21$lambda.min
model<-cv_l1log_day21$glmnet.fit

coeff<-coef(model,lambda)
sink('/Users/raymond/Drive/STAT W4201/HW7/coeff.txt')
coeff
sink()


