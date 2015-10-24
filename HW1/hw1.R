rm(list=ls())

#input raw data file
file<-file("/Users/raymond/Desktop/STAT W4201/HW1/data.txt","r")
data<-readLines(file)
index<-which((1:length(data))%%2==1)
salary<-as.numeric(data[index])
sex<-data[-index]
close(file)
data<-data.frame(Salary=salary,Sex=sex)

#boxplot for the combined data
library(ggplot2)
combined<-ggplot(data,aes("Combined Sex",Salary))
combined+geom_boxplot()+labs(x="Sex",title="Boxplot of combined Salary")
ggsave(file="/Users/raymond/Desktop/STAT W4201/HW1/boxcombined.png")

stem(data$Salary)
sink("/Users/raymond/Desktop/STAT W4201/HW1/stemCombined.txt")
stem(data$Salary)
sink()

#explore if missing values
any(is.na(data$Salary))

#boxplot for Grouped data
Group<-ggplot(data,aes(Sex,Salary))
Group+geom_boxplot()+ggtitle("Boxplot of Salary")
ggsave(file="/Users/raymond/Desktop/STAT W4201/HW1/boxgroup.png")

#stem-leaf plot for Grouped data
stem(data$Salary[data$Sex=="FEMALE"])
stem(data$Salary[data$Sex=="MALE"])
sink("/Users/raymond/Desktop/STAT W4201/HW1/stemFemale.txt")
stem(data$Salary[data$Sex=="FEMALE"])
sink()
sink("/Users/raymond/Desktop/STAT W4201/HW1/stemMale.txt")
stem(data$Salary[data$Sex=="MALE"])
sink()


#scatter plot for Grouped data
Group+geom_point(aes(color=factor(Sex)))+scale_color_discrete(name="Sex")+ggtitle("Scatter of Salary")
ggsave(file="/Users/raymond/Desktop/STAT W4201/HW1/scatter.png")

#histogram for two groups
hist<-ggplot(data,aes(Sex))
hist+geom_histogram()+ggtitle("Histogram of Sex Group")
ggsave(file="/Users/raymond/Desktop/STAT W4201/HW1/histogram.png")
Female<-data$Salary[data$Sex=="FEMALE"]
Male<-data$Salary[data$Sex=="MALE"]
summary(data$Salary[data$Sex=="FEMALE"])
summary(data$Salary[data$Sex=="MALE"])

#estimate density for two groups
epdf<-ggplot(data,aes(Salary))
epdf+geom_density(aes(color=Sex))+ggtitle("density of Salary")
ggsave(file="/Users/raymond/Desktop/STAT W4201/HW1/epdf.png")

#qqplot for two groups
qqplot<-ggplot(data,aes(sample=Salary))
qqplot+stat_qq(aes(color=factor(Sex)))+ggtitle("Q-Q plot of Sex Group")+scale_color_discrete(name="Sex")
ggsave(file="/Users/raymond/Desktop/STAT W4201/HW1/qqplot.png")

#calculate sd for two groups
SD1<-sd(Female)
SD2<-sd(Male)

#jackknife calculate two groups
#MALE group
library(bootstrap)
jmean_Male<-jackknife(Male,mean)
jsd_Male<-jackknife(Male,sd)
jmed_Male<-jackknife(Male,median)
jIQR_Male<-jackknife(Male,IQR)
jvar_Male<-jackknife(Male,var)

#FEMALE group
jmean_Female<-jackknife(Female,mean)
jsd_Female<-jackknife(Female,sd)
jmed_Female<-jackknife(Female,median)
jIQR_Female<-jackknife(Female,IQR)
jvar_Female<-jackknife(Female,var)

#Bootstrap calculate two groups
#MALE group
set.seed(123)
bMeanMale<-bootstrap(Male,100,mean)
bMeanMale_bias<-mean(bMeanMale$thetastar)-mean(Male)
bMeanMale_var<-var(bMeanMale$thetastar)
bMedMale<-bootstrap(Male,100,median)
bMedMale_bias<-mean(bMedMale$thetastar)-median(Male)
bMedMale_var<-var(bMedMale$thetastar)
bsdMale<-bootstrap(Male,100,sd)
bsdMale_bias<-mean(bsdMale$thetastar)-sd(Male)
bsdMale_var<-var(bsdMale$thetastar)
bvarMale<-bootstrap(Male,100,var)
bvarMale_bias<-mean(bvarMale$thetastar)-var(Male)
bvarMale_var<-var(bvarMale$thetastar)
bIQRMale<-bootstrap(Male,100,IQR)
bIQRMale_bias<-mean(bIQRMale$thetastar)-IQR(Male)
bIQRMale_var<-var(bIQRMale$thetastar)

#FEMALE Group
bMeanFemale<-bootstrap(Female,100,mean)
bMeanFemale_bias<-mean(bMeanFemale$thetastar)-mean(Female)
bMeanFemale_var<-var(bMeanFemale$thetastar)
bMedFemale<-bootstrap(Female,100,median)
bMedFemale_bias<-mean(bMedFemale$thetastar)-median(Female)
bMedFemale_var<-var(bMedFemale$thetastar)
bsdFemale<-bootstrap(Female,100,sd)
bsdFemale_bias<-mean(bsdFemale$thetastar)-sd(Female)
bsdFemale_var<-var(bsdFemale$thetastar)
bvarFemale<-bootstrap(Female,100,var)
bvarFemale_bias<-mean(bvarFemale$thetastar)-var(Female)
bvarFemale_var<-var(bvarFemale$thetastar)
bIQRFemale<-bootstrap(Female,100,IQR)
bIQRFemale_bias<-mean(bIQRFemale$thetastar)-IQR(Female)
bIQRFemale_var<-var(bIQRFemale$thetastar)

















