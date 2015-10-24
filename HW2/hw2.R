#Problem 1
library(MASS)
Blue<-crabs$CL[crabs$sp=="B"]
Orange<-crabs$CL[crabs$sp=="O"]

#t test
t.test(Blue,Orange)
sink("/Users/raymond/Desktop/STAT W4201/HW2/ttest1.txt")
t.test(Blue,Orange)
sink()

#wilcoxon rank sum test
wilcox.test(Blue,Orange)
sink("/Users/raymond/Desktop/STAT W4201/HW2/wilcoxtest1.txt")
wilcox.test(Blue,Orange)
sink()

#bootstrap test
zObs<-(mean(Blue)-mean(Orange))/sqrt(var(Blue)/length(Blue)+var(Orange)/length(Orange))
OrangeNew<-Orange+mean(Blue)-mean(Orange)
set.seed(123)
zSam<-rep(NA,1000)
for(i in 1:1000){
  BlueSam<-sample(Blue,length(Blue),replace=T)
  OrangeSam<-sample(OrangeNew,length(OrangeNew),replace=T)
  zSam[i]<-(mean(BlueSam)-mean(OrangeSam))/sqrt(var(BlueSam)/length(BlueSam)+var(OrangeSam)/length(OrangeSam))
}
pValue<-sum(abs(zSam)>=abs(zObs))/length(zSam)

#Problem 2
#qqplot check normality assumption
library(ggplot2)
qqplot<-ggplot(crabs,aes(sample=CL))
qqplot+stat_qq(aes(color=sp))+ggtitle("Q-Q plot of CL")
ggsave(file="/Users/raymond/Desktop/STAT W4201/HW2/qqplot.png")

#boxplot check outliers
box<-ggplot(crabs,aes(sp,CL))
box+geom_boxplot()+ggtitle("Boxplot of CL")
ggsave(file="/Users/raymond/Desktop/STAT W4201/HW2/boxgroup.png")

#test normality
shapiro.test(Blue)
shapiro.test(Orange)
sink("/Users/raymond/Desktop/STAT W4201/HW2/normaltest.txt")
shapiro.test(Blue)
shapiro.test(Orange)
sink()

#test independence of two vars
cor.test(Blue,Orange)
sink("/Users/raymond/Desktop/STAT W4201/HW2/cortest.txt")
cor.test(Blue,Orange)
sink()

#check skewness
library(e1071)
s1<-skewness(Blue)
s2<-skewness(Orange)
k1<-kurtosis(Blue)
k2<-kurtosis(Orange)
#Problem 3
#in <21 group
expected1<-90*64/177
excess1<-38-90*64/177
var1<-90*87*64*113/(177*177*176)
zstat1<-excess1/sqrt(var1)
pValue1<-1-pnorm(zstat1)

#in 21-25 group
expected2<-212*159/459
excess2<-65-212*159/459
var2<-212*247*159*300/(459*459*458)
zstat2<-excess2/sqrt(var2)
pValue2<-1-pnorm(zstat2)

#in >25 group
excess3<-30-72*86/230
var3<-72*158*86*155/(230*230*229)
zstat3<-excess3/sqrt(var3)
pValue3<-1-pnorm(zstat3)
#calculate total excess
excesstot<-excess1+excess2+excess3
vartot<-var1+var2+var3
zstattot<-excesstot/sqrt(vartot)

#calculate odds in <21 group
odds_g1<-38*61/(52*26)
pic_g1<-(38+61)/177
se0_g1<-sqrt(1/(90*pic_g1*(1-pic_g1))+1/(87*pic_g1*(1-pic_g1)))
se_g1<-sqrt(1/38+1/52+1/26+1/61)
zstat_g1<-log(odds_g1)/se0_g1
pValue_g1<-1-pnorm(zstat_g1)
CI_g1<-exp(log(odds_g1)+1.96*c(-se_g1,se_g1))

#calculate odds in 21-25 group
odds_g2<-65*153/(147*94)
pic_g2<-(65+153)/459
se0_g2<-sqrt(1/(212*pic_g2*(1-pic_g2))+1/(247*pic_g2*(1-pic_g2)))
se_g2<-sqrt(1/65+1/147+1/94+1/153)
zstat_g2<-log(odds_g2)/se0_g2
pValue_g2<-1-pnorm(zstat_g2)
CI_g2<-exp(log(odds_g2)+1.96*c(-se_g2,se_g2))

#calculate odds in >25 group
odds_g3<-30*102/(42*56)
pic_g3<-(30+102)/230
se0_g3<-sqrt(1/(72*pic_g3*(1-pic_g3))+1/(158*pic_g3*(1-pic_g3)))
se_g3<-sqrt(1/30+1/42+1/56+1/102)
zstat_g3<-log(odds_g3)/se0_g3
pValue_g3<-1-pnorm(zstat_g3)
CI_g3<-exp(log(odds_g3)+1.96*c(-se_g3,se_g3))

#Problem 4
logodds<-log(149*68/(129*48))
pic<-(149+129)/(197+197)
se0<-sqrt(1/(197*pic*(1-pic))+1/(197*pic*(1-pic)))
se<-sqrt(1/149+1/129+1/48+1/68)
zstat<-logodds/se0
pValue<-1-pnorm(zstat)
CI<-logodds+1.96*c(-se,se)










