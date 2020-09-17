
#### Outline:
####  1. Simulating data and splitting into train / test sets
####  2. Ridge regression
####  3. Lasso regression
####  4. Comparison of MSPE on test set
####  5. Ridge / Lasso for GLMs (logistic regression example)


#######################################################
##
## (1) Simulating 50 predictors and one response
##     v1-v10 are important (즉 coefficient 1~10 이 0이 아니란 뜻)
##     v11-v50 are not (beta11 ~ beta50 = 0 이라는)
##
#######################################################

## note that each predictor has mean zero and sd=1
N=150
P=50
X=matrix(NA,nrow=N,ncol=P)
# x= design matrix

##
## do this for correlated predictors
##
#covmat=matrix(rnorm(P^2,sd=2),nrow=P)
#covmat=covmat+t(covmat)
#U=eigen(covmat)$vectors
#D=diag(rexp(P,rate=10))
#covmat=U%*%D%*%t(U)
##
## Do this for uncorrelated predictors
##
covmat=diag(P)

library(mvtnorm)
for(i in 1:N){
  X[i,]=rmvnorm(1,mean=rep(0,P),sigma=covmat)
}
X=data.frame(X)
head(X)
#위는 그냥 multi norminal distribution 으로 x 값들을 넣은것.
 
## true betas
betas.true=c(1,2,3,4,5,-1,-2,-3,-4,-5,rep(0,P-10))
# 앞 10개에 대해서는 ture value 이므로 값을 넣었고, 
# 나머지 40개에 대해선 쓸모없는 value 이므로 0을 넣었다.

?rmv

## simulating "y"
sigma=15.7
X=as.matrix(X)
y=X%*%betas.true+rnorm(N,mean=0,sd=sigma)
#X%*%betas.true 는 Y=Beta1 X + ERROR(rnorm(N,mean=0,sd=sigma))이다.

#X = independent value
#y = dependent value


## splitting into "train" and "test" data


alldata=data.frame(cbind(y,X))
head(alldata) 
names(alldata)[1] <- "y"
head(alldata)
train=alldata[1:100,] # 66% 가 traing data set
test=alldata[101:150,] # 33% 가 test data set

dim(train)
#1 response / 50 independent 이므로 100*51

## linear regression
fit=lm(y~.,data=train)
#100개만 이용함.
summary(fit)

#ls(fit)

#fit$coefficients
#coef(fit)
#2개는 같음.

betas.lm=coef(fit)
yhat.lm=predict(fit,newdata=test)
mspe.lm=mean((test$y-yhat.lm)^2)
mspe.lm 
# 이 값은 다를것이다. (random 이라. set.seed(3) 을 하면 r.d 이 같아지므로 값이 같아짐)


#######################################################
##
## (2) ridge regression
##
#######################################################


## first check VIFs
library(car)
vif(fit)
# vif 가 10보다 크면, 이는 multicollinearity 문제가 있다는 뜻이다.
# 지금은 없어보인다.사실 multicol 문제가 없으니 ridge를 꼭 할 필요는 없을듯.

# vif란? 
# vif_k 는 변수의 다중공산성의 정도를 의미한다.
# 그래서 각각의 변수들을 대상으로 계산한다.
# vif_1의 경우 x1 ~ x2,....x50 회귀분석을 시행한다
# 그에 따른 r^2 r값을 구하고, vif_k = 1/1(1-r^2) 을 계산한다. 
# 즉 x1 과 다른변수의 상관성이 크다-> r^2 increased -> vif increaesed

library(glmnet)
## alpha=0 gives ridge regression
## alpha=1 gives lasso regression

## fit ridge (trying 100 different lambda values)
rr=glmnet(x=as.matrix(train[,-1]),y=as.numeric(train[,1]),alpha=0,nlambda=100)
#train 의 첫 column 은 y value 이므로
#nlambda=100 는 100개의 서로다른 lambda 값을 넣겠다는뜻.
plot(rr,xvar="lambda",main="Ridge Regression Betas for Different Values of the Tuning Parameter")

## use 10-fold crossvalidation to find the best lambda
cv.rr=cv.glmnet(x=as.matrix(train[,-1]),y=as.numeric(train[,1]),alpha=0,nfolds=10,nlambda=100)
#cv.rr=cv.glmnet(x=as.matrix(train[,-1]) x값(y제외)
#,y=as.numeric(train[,1]) # y값
#,alpha=0(),
# nfolds=10 # n-fold 하겠다는뜻
#,nlambda=100) # lambda 의 수. 100개를 보겠다는뜻


## getting cvmspe from best value of lambda
cvmspe.rr=min(cv.rr$cvm)
cvmspe.rr

## get lambda and best rr fit
lambda.rr=cv.rr$lambda.min
lambda.rr

## some plots
par(mfrow=c(1,2))
plot(cv.rr)
abline(v=log(lambda.rr))
plot(rr,xvar="lambda",main="Ridge Regression Betas for Different Values of the Tuning Parameter")
abline(v=log(lambda.rr))

log(lambda.rr)
# 이값 에서 제일 적은값을 가짐을 알 수있다.


## beta estimates for best lambda
betas.rr=coef(cv.rr,s="lambda.min")
#RIDGE 
plot(betas.rr,betas.lm,xlim=c(-6,6),ylim=c(-6,6))
abline(0,1)
# Y = OLS(Ordinary lse) 의 coefficient 값들.
# x = RIDGE 의 Coefficient 값들
# 비교해보면 OLS 시의 CORFFICIENT 가 더 큼을 알 수 있다.
betas.rr
# 0게 가깝지만 0 은 아니다.

#mspe 가 얼마나 작아졌는지 확인하기.
yhat.rr=predict(cv.rr,s="lambda.min",newx=as.matrix(test[,-1]))
mspe.rr=mean((test$y-yhat.rr)^2)

mspe.rr
mspe.lm 

#즉 mspe 가 줄어들고 있다!

#######################################################
##
## (3) lasso regression
##
#######################################################

## alpha=0 gives ridge regression
## alpha=1 gives lasso regression

## fit lasso (trying 100 different lambda values)
lasso=glmnet(x=as.matrix(train[,-1]),y=as.numeric(train[,1]),alpha=1,nlambda=100)
par(mfrow=c(1,2))
plot(lasso,xvar="lambda",main="Lasso Regression Betas for Different Values of the Tuning Parameter")
plot(rr,xvar="lambda",main="Ridge Regression Betas for Different Values of the Tuning Parameter")

## use 10-fold crossvalidation to find the best lambda
cv.lasso=cv.glmnet(x=as.matrix(train[,-1]),y=as.numeric(train[,1]),alpha=1,nfolds=10)

## get lambda and best lasso fit
lambda.lasso=cv.lasso$lambda.min
lambda.lasso

## getting cvmspe from best value of lambda
cvmspe.lasso=min(cv.lasso$cvm)

## some plots
par(mfrow=c(1,2))
plot(cv.lasso)
abline(v=log(lambda.lasso))
plot(lasso,xvar="lambda")
abline(v=log(lambda.lasso))
# 많은 independent variable 이 0으로 가는것을 볼 수 있다.

## beta estimates for best lambda
betas.lasso=coef(cv.lasso,s="lambda.min")
betas.lasso
#lasso 를 통해 추측한 결과 많은 값들이 0 이 나왔다.
#즉 0 이 나온값들은 크게 중요하지 않다는 뜻.
betas.true
betas.lasso # 1~10이 의미있는변수라고 설정하였다.
betas.rr #ridge 는 0이안나와서 제외하기힘든듯.
#betas.lasso 는 그래도 1~10중에 어느정도 맞는것을 찾은듯....

yhat.lasso=predict(cv.lasso,newx=as.matrix(test[,-1]),s="lambda.min")
mspe.lasso=mean((test$y-yhat.lasso)^2)

mspe.lasso
mspe.rr
# rr 이 제일 작다.
mspe.lm

#remember! current model 에 대해 잘 fit 하는것도 목적이지만
# 잘 predict 하는것도 아주 중요하다.

#######################################################
##
## (4) Comparison of MSPE on test set
##
#######################################################

mspe.lm
mspe.rr
mspe.lasso



#######################################################
##
## (5) GLM with ridge / lasso 
##
#######################################################

## simulate logistic regression

N=150
P=50

X=matrix(rnorm(N*P),nrow=N,ncol=P)
## true betas
betas.true=c(1,2,3,4,5,-1,-2,-3,-4,-5,rep(0,P-10))

## simulating "y"
# LOGISTIC 을 위해 Y 를 BINARY DATA 로 하고싶다.
X=as.matrix(X)
eta.true=X%*%betas.true 
pi.true=1/(1+exp(-eta.true))
# TRUE 확률이 나온다. 이 값에 따라서 추정하면
y=rbinom(N,size=1,prob=pi.true)
#rbinom(3,1,c(0.1,0.5,1))
#위값이면 B(1,0.1) B(1,0.5) B(1,1) 의 상황에서 각각 한개씩 뽑는다는 이야기

# 비슷하게 RPOIS 를 써서 할 수 도 있다. 

## lasso (Alpha =1)
lasso=glmnet(x=X,y=y,family="binomial",alpha=1,nlambda=100)
## use 10-fold crossvalidation to find the best lambda
cv.lasso=cv.glmnet(x=X,y=y,alpha=1,nfolds=10)

## get lambda and best lasso fit
lambda.lasso=cv.lasso$lambda.1se
lambda.lasso

## some plots
par(mfrow=c(1,2))
plot(cv.lasso)
abline(v=log(lambda.lasso))
plot(lasso,xvar="lambda")
abline(v=log(lambda.lasso))

## beta estimates for best lambda
betas.lasso=coef(cv.lasso)
betas.lasso

#1~10 의 변수가 의미있는(사실) 값이다. lasso 의 결과 1~10개의 변수중 많은것이 의미있게 나온것 을 볼 수 있다.
