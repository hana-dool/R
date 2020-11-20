setwd('C:/Users/goran/Desktop/Git_Hub/R/R tools/[Method] Anova')

ch4 = read.csv('ch4.csv', header=TRUE)
head(ch4)
boxplot(Chol ~ Drug, data = ch4, col = "lightgray",
        medlwd=1, main="Boxplots of Drug1 - Drug4",
        names=c("Drug1","Drug2","Drug3","Drug4"))
means <- tapply(ch4$Chol,ch4$Drug,mean)
points(means,pch=18)
mtext("means are indicated by solid circles")

ch4$Drug <- as.factor(ch4$Drug)
ch4.aov <- aov(Chol~Drug, data = ch4)
summary(ch4.aov)

#install.packages('ggplot2')
require(ggplot2)
ggplot(ch4, aes(x=Group, y=Chol, group=Drug)) +
  geom_line(aes(linetype=Drug, colour=Drug))+
  geom_point()

#RCBD output
ch4$Group =  factor(ch4$Group)
ch4.rcbd.aov <- aov(Chol~Drug + Group, data = ch4)
summary(ch4.rcbd.aov)

residuals <- resid(ch4.rcbd.aov)
Fitted <- fitted(ch4.rcbd.aov)
plot(Fitted, residuals, xlab="Fitted Value", ylab="Residual",
     pch=20, main="Residuals vs the Fitted Values")
abline(0,0, lty = 2)
mtext('response is Chol')

qqnorm(residuals, datax = TRUE, ylab="Normal Scores", 
       xlab="Residual", main="Normal Probability Plot of the Residuals")
qqline(residuals, datax = TRUE)
mtext('response is Chol')

#########################################################################################
ch4 = read.csv('ch4-1.csv', header=TRUE)
head(ch4)
ch4$material = factor(ch4$material)
ch4$operator = factor(ch4$operator)
ch4$Treatments = factor(ch4$Treatments)
ch4$assemblies = factor(ch4$assemblies)

##latin square output
latin_sq =  lm(burning.rate ~ material+operator+Treatments, ch4)
anova(latin_sq)

##graeco latin square output 
graeco_latin_sq =  lm(burning.rate ~ material+operator+Treatments+assemblies, ch4)
anova(graeco_latin_sq)

#########################################################################################
## BIBD
ch4 = read.csv('ch4-2.csv', header=TRUE)
ch4$Treatments = factor(ch4$Treatments)
ch4$Block = factor(ch4$Block)
ch4

#intrablock analysis (adjusted estimate of treatment effect) 
aov_treat = anova(lm(Response ~ Block+Treatments,ch4))
aov_treat
print(paste('adjusted treat SS:',(aov_treat$`Sum Sq`)[2]))
print(paste('unadjusted block SS:', (aov_treat$`Sum Sq`)[1]))
            
#interblock analaysis(adjusted estimate of block effect)
aov_block = anova(lm(Response ~ Treatments+Block,ch4))
aov_block
print(paste('unadjusted treat SS:',(aov_block$`Sum Sq`)[1]))
print(paste('adjusted block SS:', (aov_block$`Sum Sq`)[2]))
