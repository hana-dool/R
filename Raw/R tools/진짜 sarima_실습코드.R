#install.packages("forecast")
library(forecast)





#실습5
AirPassengers
plot(AirPassengers) #시도표 그리기
#시도표를 보았을 때 12개월 주기로 반복되고 있음을 알 수 있다.
# 추세가 있어보인다.
# 분산도 점점 늘어나고있다.
# 추세/분산/계절성에 대한 조치가 필요해보인다.

plot(stl(AirPassengers, s.window="periodic"))
# 그림을 보니
# 계절성이 있다. / 추세가 있다.

logair<-log(AirPassengers) #분산안정화를 위해 log변환시킴
plot(logair) 

log_diff1_air<-diff(logair, lag=1)#  1차 차분  
plot(log_diff1_air)
#추세가 없어진듯 하다.
#그러나 아직까지 계절성은 존재하는듯 하다. (규칙적으로 반복되는 느낌)

plot(stl(log_diff1_air, s.window="periodic"))
#아직까지 계절성 존재

log_diff12_air<-diff(log_diff1_air,  lag=12) #계절차분시도
plot(log_diff12_air)
#이정도면 계절성이 없어진 듯 하다.
#정상시계열로 만들었다~

#모형의 식별
par(mfrow=c(2,1))
acf(log_diff12_air,main="ACF" )
pacf(log_diff12_air,main="PACF") 

# acf/ pacf 중 하나는 지수적감소일거다
# 그림이 이론상으로 잘 안나오므로 후보모형을 정하는 게 현명 
# pacf 를 2에서 절단 으로 보면 AR(1)
# ACF 를 2에서 절단으로 보면 MA(1)
# 둘다 지수적 감소로 보면 ARMA(1,1)

# 계절성의 경우 12번째것들만 봐서 고려해보자 
# PACF 는 지수적감소/ ACF는 2에서 절단 즉 MA(1)
# acf 와 pacf 를 보고 후보모형을 정하였다.

# SARIMA(p,1,q)*)(P,1,Q)12
# MA/AR(1) * MA(1) 일듯?

auto.arima(log_diff12_air) # 자동으로 차수및 모수결정
#결과를 보니 001/001 즉 MA(1),MA(1) 
#지금 lof_diff12_air 가 이미 차분/log 변환을 한 데이터라 d,D =0 이다.
# 각각의 계수를 R 에서 나타내주고 있다.

tsdiag(auto.arima(diff(logair)))

#모수추정
#(위에서 최적의 모형을 결정하였으므로 (011)(011)을 쓰자 )
fit<-arima(logair,c(0,1,1), seasonal=list(order=c(0,1,1),period=12))
#lofair 는 log 처리만 한 데이터
fit

#lodX_t ~ SARIMA((011)*(011)_12)

#진단
tsdiag(fit)
#1. 표준화된 잔차가 -3~3
#2 ACF 는 독립이여야하니까 0을 제외하고 다 0 BOUNDARY
#3 P-VALUE 계산시 모두 0.05 이상이다

#-> 즉 선택해도 상관 없겠네~

pred<-predict(fit, n.ahead=10*12)
#120개월을 예측
pred
ts.plot(AirPassengers, 2.718^pred$pred, lty=c(1,3))
# LOG 된 데이터를 예측한것이였으므로 / 2.718  을 다시 곱해주었다.
