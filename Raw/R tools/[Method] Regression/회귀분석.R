rm(list=ls()) 
#ls() = 이전에 save 했던 모든 object
#r 시작할때는 이 코드를 써서 이전의 흔적을 지우고 하자.

### Set working directory for the training data
getwd() # default directory
setwd("C:/Users/goran/Desktop/R/R tools/R dataset") # 새로운 directory 지정하기.

### Read the input file
mydata=read.csv('stock.csv',sep=",",header=TRUE)
attach(mydata) #attach 를 붙이면 mydata 가 계속 붙어있게 인식한다.
head(mydata)  # 몇개의 열만 살펴보기


### Fit multiple linear regression model 

head(mydata)
model <- lm(Stock ~ Interest + Unemployment + as.factor(Year) )
#as.factor 은 dummy variable 이다. year 은 2017, 2016 값이다(categorical) 
# 즉 if as.factor 를 쓰면 두개의 level 을 가진 값으로 나오게 된다.(값을 가진 숫자가 아닌)
# 즉 범주형 자료를 처리한것.
#model <- lm(Stock ~ Interest + Unemployment + as.factor(Month) ) 
#이경우는 month 범주를 처리한것.
as.factor(Year)
#2개의 level -> 
as.factor(Month)
#12개의 level 즉 12개의 dummy variable.

summary(model)
#output 을 제공한다. 

#Coefficients:
#Estimate Std. Error t value Pr(>|t|)  
#(Intercept)          1719.60     934.85   1.839   0.0807 .
#Interest              324.59     123.37   2.631   0.0160 *
#Unemployment         -231.48     127.72  -1.812   0.0850 .
#as.factor(Year)2017    28.89      66.42   0.435   0.6682  

#Interest 만 유의하다고 할 수 있다. 
#Interest 를 1unit 올리면 stock은 324 오른다고 기대할 수 있다.
#2016년보다 2017년이 stock은 28.89 높다고 할 수 있다.

### list objects
ls(model)
#ls라는 모델에서 제공하는것들의 list.
?lm
#lm 이라는 함수를 더 알고싶을때
yhat <- model$fitted.values 
#자료의 1~24개의 데이터와 회귀식을 이용해 predict 한 value 값이다.
yhat
res <- model$residuals 
res
#잔차 1~24개 데이터값에대한 잔차


#-------------- calculations by hand ----------------#
X <-  cbind(1,Interest,Unemployment, c(rep(1,12),rep(0,12)))
# 마지막은 dummy variable 2017=1 , 2016=0 으로 dummy variable 화 시킴
# 1은 intercept(절편)part 
y <-  Stock
dim(X)  

beta.hat <- solve(t(X)%*%X)%*%t(X)%*%y 
#solve = inverse matrix
#beta.hat = (X'X)^{-1}X'Y
beta.hat
model$coefficients
#package 값과 일치

#beta.hat = (X'X)^{-1}X'Y


sigmasq.hat <- as.numeric( t(y-X%*%beta.hat)%*%(y-X%*%beta.hat)/(24-4) )
#ERROR function = (y-Xbeta)'(y-Xbeta)
#(y-Xbeta.hat)'(y-Xbeta.hat)/n-p
#as.numeric 이 없으면 1by1 matrix 값이 나온다. 그래서 as.numeric 을 해줘야한다.

#sqrt((X'X)^{-1}sigmasq.hat)
solve(t(X)%*%X)*sigmasq.hat
#diagonal 은 variance 

sqrt(  diag(solve(t(X)%*%X))*sigmasq.hat  ) # standard error of reg
summary(model)
#error 값들이 매우 similar 하다.

### check assumptions
qqnorm(res)     # normality assumption
#straight line 의 형태가 되면 normality 를 만족한다고 한다.
plot(res)       # constant variance independence 
#pattern 은 보기에 up and down pattern 이 있다. independent 가 안된듯. 
#one reason = month 를 빼먹은것때문에 그런듯. 
# time 이 감에 따라 주기가있는것으로 보아 month 를 넣으면 year 은 0/1 밖에 없지만 month 는 1~12 의 다양한값이 들어갈 수 있어서 좀 더 나을듯
plot(res, yhat)
