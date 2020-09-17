#################################################
##
## Poisson Regression
##
#################################################


#install.packages('ngspatial') # package 가 없으므로 install
library(ngspatial)
data(infant)
head(infant)
attach(infant)

fit.poi <- glm(deaths~safety + gini + low_weight + black + hispanic , family="poisson")
#일반화선형모형은 glm()함수를 사용한다. glm() 함수의 사용방법은 lm()함수와 유사하나 추가로 family라는 인수를 지정해준다. family에 따라 연결된 함수가 달라지는데 사용법은 다음과 같다.
#glm(formula, family=family(link=function), data)
#family는 종속변수의 분포에 따라 다음과 같은 것들을 사용할 수 있다. 종속변수의 분포가 정규분포인 경우 gaussian, 이항분포인 경우 binomial, 포아송분포인 경우 poisson,
#deaths 는 count variable 이므로 
#family index

summary(fit.poi) 

ls(fit.poi)
#list function 으로 안에 어떤것이 있나 알 수 있다.
fit.poi$coefficients

plot( fit.poi$residuals )
# up and down pattern






#################################################
##
## Logistic Regression
##
#################################################

##
## Read in data on grad school admissions
##
## admit = admission status (1=admitted, 0=not)
## gre = GRE score
## gpa = undergraduate GPA
## rank = "rank" of undergraduate institution
##         (four categories 1=best, 4=worst)

admissions <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
## website 에서 직접 읽게해준다.
## view the first few rows of the data
head(admissions)

pairs(admissions) 
# 산점도를 각 pairwise 하게 살펴보게 해준다. 


##
## logistic regression
##

fit=glm(admit~gre+gpa,family=binomial,data=admissions)
# logistic 일 때에는 family(y변수) 는 binoomial 이다.
summary(fit)
#즉 gre,gpa 의 coefficieant 가 positibe 이므로 , gre,gpa 값이 높을수록 합격할 확률이 높다고 할 수 있다.


##
## Let's do logistic regression with ONE predictor to see what is happening
##

fit2=glm(admit~gre,family="binomial",data=admissions)
# gre 와 admit 하나끼리의 관계만 보자!
summary(fit2)
#gre 는 poositive relation 으로 보인다.

## get estimated linear predictor
# X * beta 부분을 linear predictor 이라고 한다.
xvals=seq(220,800)
xvals 
newdata=data.frame(gre=xvals)
eta=predict(fit2,newdata=newdata,type="link")
eta
#newdata  # 예측을 수행할 새로운 데이터
#type : 예측 결과의 유형을 지정합니다. 
#type = "link" 일 경우 log-odds 값이 출력되며 (predict 된 모형에 따른) 
#type = "response"의 경우 E[Y|X]= 확률 p 값이 출력됩니다.(Y=1 or 0 이기 때문)

## get estimated mean
par(mfrow=c(1,2))
plot(xvals,eta,main="Linear Predictor",xlab="gre",ylab=expression(eta),type="l")
# xval 과 logit 의 관계를 그려낸다.logit 과의 관계는 선형이므로 직선을 그린다. 
# summary 에서 logit = -2.9 +0.0358x(xval) 의 추정식이 나왔으므로 이에따른 선형그림이다.
mu=predict(fit2,newdata=newdata,type="response")
# logit 이 아닌 확률값을 나타내려고 한다.
plot(xvals,mu,main="Mean Response as a Function of the Predictor",xlab="gre",ylab=expression(mu),ylim=c(0,1),type="l",lwd=3) 
# xval 값에 따른 확
points(jitter(admissions$gre),admissions$admit)
# 1값은 실제 통과된 사람, 0값은 탈락한 값
# 보기에 gre 가 커질수록 합격할 확률이 커져보인다. 

# mean response 가 증가 / linear predict 가 양수쪽 -> 방향이 1분위 방향

######   Multinomial Response Model Example Code  #######
# https://stats.idre.ucla.edu/r/dae/multinomial-logistic-regression/ #
rm(list=ls())

### Call libraries
library(foreign)
library(nnet)
library(ggplot2)
library(reshape2)

### Read the input file
# The data set contains variables on 200 students. 
# The response variable (Y) is prog, program type. , categorical variable. 2개 이상의 범주라 simple logistic 불가
# The predictor variables (X) are social economic status, ses, a three-level categorical variable and writing score, write, a continuous variable. 

ml <- read.dta("https://stats.idre.ucla.edu/stat/data/hsbdemo.dta")
with(ml, table(ses, prog))
# with - 관계를 보여준다. .
# with(데이터, table(변수))
with(ml, do.call(rbind, tapply(write, prog, function(x) c(M = mean(x), SD = sd(x)))))
ml
#tapply(벡터, 요인, 함수) 요인 수준별로 함수 명령어를 동시에 적용
#즉 지금은 mean 과 sd 를 요인들별로 계산해준것이다.
#academic class 의 mean of writing score 은 56으로 제일 높음을 알 수 있다.


### Fit multinomial logistic regression
ml$prog
# 얘를 보면 3개의 level 이 있다. 이 때에는 automatically 제일 앞에있는 general 을 reference 로 쓰게 된다.
# 하지만 새로 reference 를 지정하고싶다면
ml$prog2 <- relevel(ml$prog, ref = "academic") 
# reference category 를 academic 으로 지정하겠다는 뜻.

test <- multinom(prog2 ~ ses + write, data = ml)
#multinom 은 muti regression 을 해주는 function

### Summary 
summary(test)
# 2 covariates - ses(hight, middle, low) -> 2 dummy vaiable 을 만들어야 한다.,write
# 결국 3 covariates ( 2 dummy + writing)
# 절편을 포함한 4개의 값이 나오게 된다.
z <- summary(test)$coefficients/summary(test)$standard.errors
z
# individual covariatess 이 statiscally 유효한지 알아보는 function
# 구한것은 z statstics

# 2-tailed z test
p <- (1 - pnorm(abs(z), 0, 1)) * 2
p


## extract the coefficients from the model and exponentiate
test
exp(coef(test))

head(pp <- fitted(test))
# 어떻게 model 을 이용하였을 때 fitted 되는지 알 수 잇다. 
# 1 참가자에 대해 academic 에 참가할 확률 0.148 , general 은 0.3324 .... 
# 사실 이때 fiited 는 이미 존재한 데이터에 대한 예측이기 때문에 의미가 없다. 새로운 데이터에 대해 쓸때에 의미가 있다.

dses <- data.frame(ses = c("low", "middle", "high"), write = mean(ml$write))
dses
# 새로운 학생 1,2,3 을 만들었다. 이에 대해서 predict 를 하면
predict(test, newdata = dses, "probs")
#확률 proability 를 보여준다.
#3 학생에 대해 보면 ses 가 높으니 acadmic 갈 확률이 높아졌다.

dwrite <- data.frame(ses = rep(c("low", "middle", "high"), each = 41), write = rep(c(30:70), 3))
dwrite
# large data set 을 만들어봤다.

## store the predicted probabilities for each value of ses and write
pp.write <- cbind(dwrite, predict(test, newdata = dwrite, type = "probs", se = TRUE))
pp.write

## calculate the mean probabilities within each level of ses
by(pp.write[, 3:5], pp.write$ses, colMeans)
# 내가 구한 medel 에 의서한 확률값들
# by = Apply a Function to a Data Frame Split by Factors
# by(data, INDICES, FUN)

