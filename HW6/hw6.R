rm(list=ls())
data('ChickWeight')
#avova on day 18
sub_day18<-subset(ChickWeight,Time==18)
anova_day18<-aov(data = sub_day18, weight ~ Diet)
summary(anova_day18)

sink('/Users/raymond/Drive/STAT W4201/HW6/anova.txt')
anova_day18
summary(anova_day18)
sink()

#anova adjust by LS mean on day 18
sub_day0<-subset(ChickWeight,Time==0)
sub_day18[,'birthweight']<-sub_day0$weight[match(sub_day18$Chick,sub_day0$Chick)]
group_mean<-aggregate(sub_day18$birthweight,list(sub_day18$Diet),mean)
colnames(group_mean)<-c('Diet','birthweight_mean')
sub_day18<-merge(sub_day18,group_mean,by.y = 'Diet')
anova_adjust_day18<-aov(data=sub_day18, weight ~ birthweight + Diet)

summary(aov(data=sub_day18, weight ~ birthweight + Diet))
summary(aov(data=sub_day18, weight ~ Diet + birthweight))
sink('/Users/raymond/Drive/STAT W4201/HW6/anova_adjust.txt')
anova_adjust_day18
summary(anova_adjust_day18)
sink()

#LS means
coef<-anova_adjust_day18$coefficients[2]
y_hat<-anova_adjust_day18$fitted.values
y_frame<-data.frame(yhat=y_hat,Diet=sub_day18$Diet)
yhat_mean<-aggregate(y_frame$yhat, list(y_frame$Diet),mean)
colnames(yhat_mean)<-c('Diet','yhat')
mu<-yhat_mean$yhat-coef*(group_mean$birthweight_mean-mean(sub_day18$birthweight))
lsmean_result<-cbind(group_mean,lsmean=mu)
sink('/Users/raymond/Drive/STAT W4201/HW6/LSmeans.txt')
lsmean_result
sink()

#Or simply use lsmeans function in library lsmeans
library(lsmeans)
lsmean<-lsmeans(anova_adjust_day18,'Diet')
sink('/Users/raymond/Drive/STAT W4201/HW6/LSmeans1.txt')
lsmean
sink()

library(ggplot2)
#check assumptions
#Normality
#Q-Q plot for residuals
residual<-data.frame(anova_day18['residuals'],sub_day18['Diet'])
normal_plot<-ggplot(data=residual,aes(sample=residuals))+
  stat_qq()+ggtitle('Normal Q-Q of residuals')+
  ylab('residuals')+xlab('Theoretical Quantiles')
resid_quantile<-quantile(residual$residuals,c(0.25,0.75))
norm_quantile<-qnorm(c(0.25,0.75))
slope<-diff(resid_quantile)/diff(norm_quantile)
inter<-resid_quantile[1]-slope*norm_quantile[1]
normal_plot+geom_abline(slope=slope,intercept=inter,linetype=2,color='red')
ggsave(filename = '/Users/raymond/Drive/STAT W4201/HW6/qqplot.png')

#histogram for residuals
histogram_plot<-ggplot(data=residual,aes(residuals))+
  geom_bar(binwidth=10,aes(y=..density..))+ggtitle("Histogram of residuals")+
  ylab('Freqency')+xlab('Residuals')
histogram_plot+geom_density(color='blue')
ggsave(filename = '/Users/raymond/Drive/STAT W4201/HW6/histogram.png')

#shapiro test on residuals
shapiro.test(residual$residuals)
sink('/Users/raymond/Drive/STAT W4201/HW6/normalcheck.txt')
shapiro.test(residual$residuals)
sink()

#nonparametric check iid assumption
#kruskal test on data
kruskal.test(weight~Diet,data=sub_day18)
sink('/Users/raymond/Drive/STAT W4201/HW6/identicalcheck.txt')
kruskal.test(weight~Diet,data=sub_day18)
sink()

#check constant variance
#bartlett test on data
bartlett.test(x=sub_day18$weight,g=sub_day18$Diet)
sink('/Users/raymond/Drive/STAT W4201/HW6/constantcheck.txt')
bartlett.test(x=sub_day18$weight,g=sub_day18$Diet)
sink()

#levene test on data
library(car)
leveneTest(y=sub_day18$weight,group=as.factor(sub_day18$Diet))
sink('/Users/raymond/Drive/STAT W4201/HW6/levene.txt')
leveneTest(y=sub_day18$weight,group=as.factor(sub_day18$Diet))
sink()

#check for parallelism
#two-way anova
anova_inter<-aov(weight ~ birthweight*Diet,data = sub_day18)
summary(anova_inter)
sink('/Users/raymond/Drive/STAT W4201/HW6/paracheck.txt')
summary(anova_inter)
sink()

#repeated measures
#anova on day 10, 18, 21
sub_repeat<-subset(ChickWeight,Time %in% c(10,18,21))
repeated<-aov(weight ~ Diet*Time+Error(Chick),data=sub_repeat)
write.table(sub_repeat,file = '/Users/raymond/Drive/STAT W4201/HW6/ChickWeight.csv',col.names=TRUE,row.names=FALSE,sep=",")

library(nlme)
repeat_data<-groupedData(weight ~ as.numeric(Diet)+as.numeric(Time)+as.numeric(Diet)*as.numeric(Time)|Chick, data = sub_repeat)
fitcs<-gls(weight~Diet+Time+Diet*Time,data=repeat_data,corr=corCompSymm(form = ~ 1|Chick))
summary(fitcs)
fitun<-gls(weight~Diet+Time+Diet*Time,data=repeat_data,corr=corSymm(form = ~ 1|Chick),weights=varIdent(form = ~ 1|Time))
summary(fitun)







