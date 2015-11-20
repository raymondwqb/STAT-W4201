rm(list = ls())
library(survival)
data("colon")

#Meier Estimator for treatment Lev & Lev+5FU
survival_colon <- subset(colon,etype==2 & rx %in% c("Lev","Lev+5FU"))
fit_trt<- survfit(formula = Surv(time, status) ~ rx, data = survival_colon, type = "kaplan-meier")
sink('/Users/raymond/Drive/STAT W4201/HW9/meiersum.txt')
summary(fit_trt)
sink()

#Plot the survival curve
png(filename = "/Users/raymond/Drive/STAT W4201/HW9/meiercurve.png")
plot(fit_trt,lty = c(1,2),col = c("red","blue"))
title(main="Survival Curve for Treatment")
title(main="Kaplan-Meier Estimator",line=0.5)
legend("topright",c("Lev","Lev+5FU"),col=c("red","blue"),lty=c(1,3))
dev.off()

#Estimate the median
sink('/Users/raymond/Drive/STAT W4201/HW9/meier.txt')
fit_trt
sink()

#Log-rank test for difference
log_rank<-survdiff(Surv(time, status) ~ rx, data=survival_colon)

sink('/Users/raymond/Drive/STAT W4201/HW9/logrank.txt')
log_rank
sink()

#Cox proportional hazards model
survival_colon$rx_d<-as.numeric(survival_colon$rx=="Lev")
cox<-coxph(Surv(time,status)~rx_d+age+sex,data=survival_colon)
sink('/Users/raymond/Drive/STAT W4201/HW9/cox.txt')
summary(cox)
sink()





