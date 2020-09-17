#install.packages("forecast") #data generating 할 때에 필요한 library
library(forecast)

##################AR(1)##########################3
AR1<-arima.sim(list(ma=0.5), n=200) # sim = simulation 
# list(ar 쓸지, ma 쓸지 결정한 후 = 0.5(모수, 갯수가 1개이므로 ar(1) 으로 자동인식), 갯수(n)=200 )
# 파이가 0.5 이므로 정상시계열
# 파이가 1/-1 에 가까우면 비정상시계열처럼 보인다.

# 이제 위에서 AR1 을 생성했음을 잊고, 데이터를 우리가 받았다고 해보자.
ts.plot(AR1, main="AR(1)")
# 데이터가 0 에서 오르락내리락. 
# 분산은 시간이 지나도 일정함을 볼 수 있다. 
# 즉 정상시계열

par(mfrow=c(1,2))
acf(AR1, main="ACF of AR(1)")
pacf(AR1, main="PACF of AR(1)")
# ACF  :지수적 감소 
# PACF :2에서 절단 즉 AR(1) 로 분석하는것이 타당해보인다..

####note####
# ma=0.9 로 설정하면 acf 가 매우 천천히 떨어지게 된다. 
# 이론상은 0.9이므로 정상이지만 거의 1에 가깝기 때문에 ACF 가 비정상처럼 보인다.
# 그래서 이걸 비정상으로보고 차분할 수 도 있을것이다. (판단이 논란의 여지가 있음)
# 하지만 phi 가 어느정도 1에 가까우면 비정상으로 판단이되는지의 기준이없기 때문에 주관적으로 판단해야한다. 


########################## MA(1)생성 ############################
MA1<-arima.sim(list(ma=0.7), n=200)

ts.plot(MA1, main="MA(1)")
# 별 추세도 없고 분산, 평균 일정해보이므로 정상시계열 같다.

par(mfrow=c(1,2))
acf(MA1, main="ACF of MA(1) ")
pacf(MA1, main="PACF of MA(1) ")
# ACF 는 2에서 절단
# PACF 는 지수적 감소 
# 즉 MA(1) 의 모형이 적절해보인다.

##note## 
# 약간 애매한 경우 후보모형을 만들고
# 모수절약의 법칙과 AIC 등을 고려하여 선택한다.

################ARMA(1,1)생성################
x<-arima.sim(list(ar=0.8, ma=-0.6), n=200)
# arma 를 생성하고싶은 경우 list 옆에 ar,ma 를 각각 지정해주면 된다.

ts.plot(x, main="x")
#  시도표를 보니 정상적인 형태이다.
# 추가적으로 단위근 검정 등을 시행할수도 있다.

par(mfrow=c(1,2))
acf(x, main="ACF")
pacf(x, main="PACF") 
# ACF는 지수적감소
# PACF 도 지수적감소 
# 사실 이 경우 애매할 수 있기떄문에 후보모형을 제시해야한다.
# 원래는 ARMA 는 어디서부터 감소인지에 따라 P,Q 가 결정되지만 이를 결정하기 힘들다
# arma(1,1),arma(2,1),arma(1,2) 안에서 거의 해결이 되기때문에 p,q 가 3 이내 에서 예측하도록 하자.
# AIC . BIC , 모수추정의 원칙 을 고려해서 
# AIC, BIC 가 비슷하면 모수절약에 따라 AR(3) 보다는 ARMA(1,1) 선택
# 사실 ARMA 모형은 예측이 매우 힘들다. 그래서 ARMA(1,1) -> AR(2,1),AR(1,2)... 로 차수를 높혀가며 AIC 등을 비교하면서 하기도 한다.

#NOTE## 
# 절단의 경우 거의 3에서 끊긴다. 그 이상은 지수적 감소라고 보는게 낫다.


##########################
##########실습예제##########
##########################

Y<-arima.sim(list(order=c(2,0,0), ar=c(0.5, 0.2)), n=200)
# Order = c(p,d,q) 지금 p=2 이므로 AR(2)

#################모형의 식별 ###############
ts.plot(Y)
# 정상적인 시계열 모양같다.(주관적)
# 단위근검정 (각종 TEST) (객관적) 
# 들을 이용해 정상성을 판단할 수 있다.

par(mfrow=c(1,2))
acf(Y, main="ACF ")
pacf(Y, main="PACF ")
# ACF 는 지수적 감소(# 절단은 거의 5 이내) 
# PACF 는 3에서 절단 즉 AR(2) 
# 후보모형 : arma(1,1) 도 가능할거같아! AIC,BIC 비교 ㄱㄱ

###################모수의 추정#################
fit1 <- arima(Y, c(2, 0, 0)) #arima(p,q,d)
fit1
# ar1 = phi_1 , ar2= phi_2 , intercept = 데이터의 평균
# 각 모수의 standard error 도 제시됨
# AIC, log likelihood  도 같이 나온다. 
# 모형 비교시AIC,BIC 가 더 낮은값을 선택

fit1 <- arima(Y, c(2, 0, 0), method=c("CSS-ML")) # default 값
fit1
fit1 <- arima(Y, c(2, 0, 0), method=c("ML"))
fit1
fit1 <- arima(Y, c(2, 0, 0), method=c("CSS"))
fit1

#################모형의 진단 (#white noise 가 정말 N(0,SIGMA^2?))#########
tsdiag(fit1,gof.lag=24) 
#gof = goodness of fit 
#즉 fit 이 잘 됫나안됫는지 lage 24 까지 표현해줘!

#1 resifual 을 표준화한것. -2~2 정도 안에 큰 패턴없이 띠모양이면 굳

#2 white noise 는 서로 독립이여야하므로, acf 는 lag 에따라 0 이여야함 (독립)

#3 ljung box test -> h_0 : 독립 , h_1 : 상관성이 있다.
#모두 p-value 가 0.05 이므로 독립.


############모형의 예측###################3
#method1
f20<-predict(fit1, n.ahead=20) 
# 앞의 20개까지의 값을 예측해줘.

f20 # se 에 각자의 standard error 가 나온다.
U<-f20$pred+f20$se
L<-f20$pred-f20$se
U
L

# method 2
forecast(fit1,h=20)
# 얘는 신뢰구간도 같이있어서 very good~
plot(forecast(fit1,h=20))


#######################################################
#참고: 차수를 자동으로 찾아주는 기능##########################
#######################################################
# install.packages("forecast")
library(forecast)
auto.arima(Y) # arma 를 자동으로 찾아줘~
# r 자체에서 ar(1) .... ma(1) ... arma(1,1) ... 차수 10정도까지의 조합을 모두 다한다.
# 그 중에서 aic 가 가장 작은녀석을 찾아준다.
# 내 생각을 점검할 때에 추가적으로 확인하는 용도로 사용하면 좋다.
# aic , aicc, bic 제공
#############################


#실습2
x<-arima.sim(list(ma=0.7), n=200)
ts.plot(x)
# 아 정상시계열같다.

#모형의 식별
par(mfrow=c(2,1))
acf(x, main="ACF ")
pacf(x, main="PACF ")
# 음.... MA(1) 같은데?


#모수의 추정
fit1 <- arima(x, c(0, 0, 1))
fit1
# INVERCEPT = 데이터의 평균

#note R 에서는 추정된 COEFFICIENT 는 +로 들어간다.
#이 경우 Z_t = E_t + (ma1의 추정값)E_t-1
#일반적인 모형식 쓸떄에는  Z_t = E_t - theta_1*E_t-1 였지만

auto.arima(x)


#모형의 진단
tsdiag(fit1,gof.lag=24)
# 독립인 white noise 같네...


#모형의 예측
f20<-predict(fit1, n.ahead=20)
f20
U<-f20$pred+f20$se
L<-f20$pred-f20$se
U
L

forecast(fit1,h=20)
plot(forecast(fit1,h=20))
# MA(1) 은 미래 1시차까지밖에 예측하지 못한다.
# 그래서 예측시 1 이후는 모두 0에 있음을 알 수 있다.


#실습3
ARMA<-arima.sim(list(ar=0.5, ma=0.8), n=200)
ts.plot(ARMA)
#정상인거같다.

par(mfrow=c(1,2))
acf(ARMA)
pacf(ARMA)
# 후보 : ARMA(1,1) MA(2) ... 다 해보고 AIC,BIC 가 낮은거 선택하자.

# MA(2) Fitting
fit1 <- arima(ARMA, c(0, 0, 2))
fit1
# ARMA(1.1) Fitting
fit2 <- arima(ARMA, c(1, 0, 1))
fit2 # 이경우의 aic 가 더 작으므로 얘가 더 나을듯.

#모형의 진단.
summary(fit2)
auto.arima(ARMA) 
tsdiag(fit2,gof.lag=36)

# 모형의 예측
forecast(fit2,h=20)
plot(forecast(fit1,h=20))


#실습4
data<-read.table("C:/Users/Han/Desktop/Statistics/R/R tools/R dataset/stock2.csv")
head(data)


#install.packages("tseries")
library(tseries)

stock<-ts(data)
plot.ts(stock) #시도표 그리기
# 시간이 가니까 갑자기 후욱 올라간다. 조치가 필요할듯.

par(mfrow=c(2,1))
acf(stock,main="ACF", lag=36)
pacf(stock,main="PACF", lag=36)
#ACF 도 지수적감소가 아니라 슬슬 감소한다. 

#분산안정화를 위한 log변환
logstock<-log(stock)
plot(logstock)

#여전히 추세가 남아있어 log변환 후 1차 차분시도
diff_logstock<-diff(logstock, lag=1)
plot(diff_logstock)
#이제 정상같다.

# acf, pacf
par(mfrow=c(2,1))
acf(diff_logstock,main="ACF", lag=36)
pacf(diff_logstock,main="PACF", lag=36, ylim=c(-0.2,1))
# 아니 다 절단되어있다.
# 절단을 1에서봐야되나?? 말도안되!
# 임의로 AR(1) 을 할수도 없을텐데??

# 도저히 모를거같을 때 - > 기계에게 맡기자..
# 모형 선택
auto.arima(diff_logstock) # 자동으로 차수및 모수결정
# ARIMA(2,0,2) 추천. 

fit3<-arima(logstock,c(2,1,2)) #AUTO.ARIMA에서 알려준대로
# log 변환만 한 것을 arima 로 추정
# 이떄에 차분(1번) 한것을 얘는 고려한 상태가 아니므로 C(2,1,2)
fit3
# 사실 위 auto 와 차이는없음 c(2,0,2) 를 위에서 추천해주엇으므로


#잔차검정
tsdiag(fit3)
#잔차 white noise 같아 ^^


#예측값 포함된 plot (logscale)
forecast(fit3)
plot(forecast(fit3))

#predict 로 그려보자~ ( 원래 scale 로 보고싶으면 predict 를 활용해야한다.)
pred<-predict(fit3, n.ahead=20)
pred
ts.plot(stock, 2.718^pred$pred, lty=c(1,3)) #lty = linestyle
# 원래 시도표는 실선, 예측값은 점선
# 앞의 forcast 는 log 변환에서의 예측값이고
# 우리는 log 변환값이 궁금한게 아니므로 2.718^pred$pred 을 취해주었다.


#실습5
AirPassengers
plot(AirPassengers) #시도표 그리기
plot(stl(AirPassengers, s.window="periodic"))


logair<-log(AirPassengers) #분산안정화를 위해 log변환시킴
plot(logair)

log_diff1_air<-diff(logair)  #1차분시도
plot(log_diff1_air)

plot(stl(log_diff1_air, s.window="periodic"))

log_diff12_air<-diff(log_diff1_air, differences=12) #계절차분시도
plot(log_diff12_air)

par(mfrow=c(2,1))
acf(log_diff12_air,main="ACF" )
pacf(log_diff12_air,main="PACF") 


auto.arima(log_diff12_air) # 자동으로 차수및 모수결정

tsdiag(auto.arima(diff(logair)))

fit<-arima(logair,c(0,1,1), seasonal=list(order=c(0,1,1),period=12))
fit

tsdiag(fit)

pred<-predict(fit, n.ahead=10*12)
pred
ts.plot(AirPassengers, 2.718^pred$pred, lty=c(1,3))

