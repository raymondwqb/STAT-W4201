rm(list=ls())
library(MASS)
library(ggplot2)
#delete containing na value rows
Boston <- na.omit(Boston)

multilinear <- lm(medv ~ crim+zn+indus+nox+rm+age+tax, data=Boston)
sink("/Users/Qianbo/Downloads/HW4/lsresult.txt")
multilinear
sink()
sink("/Users/Qianbo/Downloads/HW4/multilinear.txt")
summary(multilinear)
sink()

#plot the mulilinear regression 
plot1<-ggplot(multilinear,aes(.fitted,.resid))+
  geom_hline(yintercept=0,color="grey50",size=0.5)+
  geom_point()+geom_smooth(size=0.5,se=FALSE)+
  ggtitle("Residuals vs Fitted")+xlab("Fitted values")+ylab("Residuals")

plot2<-ggplot(multilinear,aes(sample=.stdresid))+
  stat_qq()+geom_abline(color="grey50")+
  ggtitle("Normal Q-Q")+
  ylab("Standardized residuals")+xlab("Theoretical Quantiles")

plot3<-ggplot(multilinear,aes(.fitted,sqrt(abs(.stdresid))))+
  geom_point()+geom_smooth(se=FALSE)+
  ggtitle("Scale-Location")+
  xlab("Fitted values")+ylab(expression(sqrt("standardized residuals")))

plot4<-ggplot(multilinear,aes(.hat,.stdresid,size=.cooksd))+
  geom_point()+geom_smooth(se=FALSE,size=0.5)+
  ggtitle("Residuals vs Leverage")+scale_size_continuous(guide=FALSE)+
  xlab("Leverage")+ylab("Standardized residuals")

library(grid)
library(gridExtra)

grid.arrange(plot1,plot2,plot3,plot4,ncol=2)
png("/Users/Qianbo/Downloads/HW4/multilinear.png")
grid.arrange(plot1,plot2,plot3,plot4,ncol=2)
dev.off()

#check assumptions
#check Linear/functional form
#scatter plot of y vs x
s1<-ggplot(Boston,aes(crim,medv))+geom_point()
s2<-ggplot(Boston,aes(zn,medv))+geom_point()
s3<-ggplot(Boston,aes(indus,medv))+geom_point()
s4<-ggplot(Boston,aes(nox,medv))+geom_point()
s5<-ggplot(Boston,aes(rm,medv))+geom_point()
s6<-ggplot(Boston,aes(age,medv))+geom_point()
s7<-ggplot(Boston,aes(tax,medv))+geom_point()

png("/Users/Qianbo/Downloads/HW4/scatter1.png")
grid.arrange(s1,s2,s3,s4,s5,s6,s7,ncol=3)
dev.off()

#scatter plot of residuals vs fitted 
residplot<-ggplot(multilinear,aes(.fitted,.resid))+
  geom_point()+ggtitle("Residuals vs Fitted")+
  xlab("Fitted values")+ylab("Residuals")
ggsave('/Users/Qianbo/Downloads/HW4/resid.png')

#check Normality
#histogram of residuals
hist<-ggplot(multilinear,aes(.stdresid))+
  geom_histogram()+ggtitle("Histogram of Residuals")+xlab("Residuals")
hist
ggsave(file="/Users/Qianbo/Downloads/HW4/residhist.png")

#qq plot of standardized residuals
qqresid<-ggplot(multilinear,aes(sample=.stdresid))+
  stat_qq()+geom_abline(aes(intercept=0,scope=1),color="grey50",size=0.5)+
  ggtitle("Q-Q plot of std Residuals")
qqresid
ggsave(file="/Users/Qianbo/Downloads/HW4/residqq.png")

#shapiro test on residuals
residuals = resid(multilinear)
shapiro.test(residuals)
sink("/Users/Qianbo/Downloads/HW4/shapiro.txt")
shapiro.test(residuals)
sink()

#check Homoscedasticity
#scatter plot of residuals vs x
r1<-ggplot(multilinear,aes(crim,.resid))+geom_point()+ylab("Residuals")
r2<-ggplot(multilinear,aes(zn,.resid))+geom_point()+ylab("Residuals")
r3<-ggplot(multilinear,aes(indus,.resid))+geom_point()+ylab("Residuals")
r4<-ggplot(multilinear,aes(nox,.resid))+geom_point()+ylab("Residuals")
r5<-ggplot(multilinear,aes(rm,.resid))+geom_point()+ylab("Residuals")
r6<-ggplot(multilinear,aes(age,.resid))+geom_point()+ylab("Residuals")
r7<-ggplot(multilinear,aes(tax,.resid))+geom_point()+ylab("Residuals")

grid.arrange(r1,r2,r3,r4,r5,r6,r7,ncol=3)
png("/Users/Qianbo/Downloads/HW4/residx.png")
grid.arrange(r1,r2,r3,r4,r5,r6,r7,ncol=3)
dev.off()

#check Corrected errors
#dw test
library(car)
durbinWatsonTest(multilinear)
sink("/Users/Qianbo/Downloads/HW4/dwtest.txt")
durbinWatsonTest(multilinear)
sink()
#remedies 
#transform on data 
n1<-ggplot(Boston,aes(crim,log(medv)))+geom_point()
n2<-ggplot(Boston,aes(zn,log(medv)))+geom_point()
n3<-ggplot(Boston,aes(indus,log(medv)))+geom_point()
n4<-ggplot(Boston,aes(nox,log(medv)))+geom_point()
n5<-ggplot(Boston,aes(rm,log(medv)))+geom_point()
n6<-ggplot(Boston,aes(age,log(medv)))+geom_point()
n7<-ggplot(Boston,aes(tax,log(medv)))+geom_point()

png("/Users/Qianbo/Downloads/HW4/transform.png")
grid.arrange(n1,n2,n3,n4,n5,n6,n7,ncol=3)
dev.off()

# use least median square method do linear regression

lmslinear<-lmsreg(medv ~ crim+zn+indus+nox+rm+age+tax, data=Boston)
sink("/Users/Qianbo/Downloads/HW4/lmsresult.txt")
lmslinear
sink()






