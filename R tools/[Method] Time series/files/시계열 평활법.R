#[단순지수펼활법]#
#######1 데이터 살펴보기#######


balance<-read.csv("C:/Users/Han/Desktop/Statistics/R/R tools/R dataset/balance.csv",header=FALSE)
#csv 파일을 읽는 명령어. escel 로 불러오면 가끔 버그가 걸린다. 주의
#\ 를 / 로 바꾸어주어야 한다.
#데이터에 변수이름을 쓰려고한다면 1행에 데이터 이름 이 될 것이다. 즉 1 행에 데이터 이름이 있다없다를 알려주는것
#1행에 변수명이 없는 데이터이므로 header = FALSE (대문자로!)
head(balance)
#데이터의 앞쪽 부분을 보여준다. (상위 6개의 자료)
length(balance)
# 첫단계는 무족건 시도표를 (시각적으로) 그려보는것이다. 
# 그래야 계절성 추세성 등을 알 수 있다.


######2 데이터 시도표 그려보기 #####
balance<-ts(balance, start=1980, end=2016)
# 이 discrete data 를 time serise형태로 만드는 명령어
# 뒤 부분 start , end 는 x 변수의 시작지점, 끝지점 
# start 와 end 의 수가 data 의 lenth 와 일치해야 한다. 그렇지 않으면 자기가 임의로 데이터를 늘려서 사용
plot.ts(balance, xlab="YEAR", ylab="Balance on current account(million dollar)")
# plot.ts = ts 형태로 그려준다.. 
#시도표를 보았을 때, 증가의 추세를 보이는 것 같다.
#계절성은 없어보인다.


#####3 데이터 FITTING #####
#install.packages("forecast")
#R 을 이용해 단순지수평활법을 하고싶을때 
library(forecast)
#library - 활성화 함수. 즉 위 두줄은 항상 같이 움직인다. 
fit<-ses(balance, h=10,level=c(80,95),initial="simple", alpha=NULL) 
# ses = simple exponential smoothing = 단순지수평활법
# ses(data, 
# h = 예측하고자 하는 미래시차의 수
# level = 예측구간의 신뢰수준. 지금은 80,95% 둘다 해줘 라는 의미)
# initial = 초깃값 (S0) 방법은 두가지 optimal, simple
# simple = z1 을 초깃값으로 , optimal = ets 방법(default) likelihood function 이용. (자동으로 잡아줌)
# alpha = 평활상수. 그런데 alpha = NULL 이라고 할 때에는 SSE를 최소화 하는 평활상수를 자동으로 추정해서 사용
# fit$model 에서 확인 가능


##### 예측 및 분석#####
fit
# 마지막 년도가 2016 이였으므로 10개의 예측값이 나왔다. 
names(fit)
#fit 의 결과 안에 예측값만 들어있는게 아니라,여러가지가 있다는걸 보여준다
fit$model
# call : 내가 어떤 코드를 이용해서 구했는지
# smoothing parameters = alpha 값
# initial state = s0 (내가 simple 을 썻으므로 당연)
# 지금 alpha 가 1 인데, 이 의미는 데이터의 변화가 심하다는것.
# 최근에 증가한 영향을 많이 반영할때에 평활상수가 1에 가깝다.


fit$fitted
fit$residuals

plot(fit,ylab="Balance on current account(million dollar)", xlab="year", main="", fcol="white", type="o")
# 검은색 부분이 raw data
# fcol = font color , type = "O" (이건 각자선택)
lines(fitted(fit), col="blue",type="o",pch=17)
# lines -> 위에 그린 그림위에 겹치겠다.
# fiited(fit) 값은 예측된 값
lines(fit$mean) 
# 예측값의 평균값 
# 파란색 = 단순지수평활법 이용
# 끝에 음영으로 된 부분 = 95%, 80% 의 신뢰구간에 해당하는 부분.


#a 가 변화함에따라 그래프는 어떤식으로 예측하게될까?
fit1<-ses(balance, h=2,level=c(80,95), alpha=0.2)
fit2<-ses(balance, h=2,level=c(80,95), alpha=0.6)
fit3<-ses(balance, h=2,level=c(80,95), alpha=0.99)
# 1에 가깝게 되면 앞의 움직임을 좀 더 반영
# 0에 가까우면 평활이 평평 해진다.
fit1$model
fit2$model
fit3$model

plot(fit1, ylab="Balance on current account(million dollar)", xlab="year", main="", fcol="white", type="o")
lines(fitted(fit1), col="blue",type="o",pch=2)
lines(fitted(fit2), col="red",type="o",pch=3)
lines(fitted(fit3), col="green",type="o",pch=5)
lines(fit1$mean,col="blue",type="o",pch=2)
lines(fit2$mean,col="red",type="o",pch=3)
lines(fit3$mean,col="green",type="o",pch=5)

legend("topleft", lty=1, pch=c(1,2,3,5),col=c(1,"blue","red","green"), c("data", 
                                                                         expression(alpha==0.2),expression(alpha==0.6), expression(alpha==0.99)))
# 각각 a 선택에따라서 예측값이 달라진다. 
# 프로그램을 이용해 최적의 예측값을 찾아내자.




#이중지수평활법
airmiles
#airmiles 는 이미 tiem series data.
plot(airmiles)
#즉 PLOT 만 하면 시계열 데이터로 나온다.
#R 을 사용한 실습에서는 holt 방법을 쓰자.
#우리가 배운 방법과 매우 유사함.

?holt
fit<-holt(airmiles, h = 10, level = c(80, 95),exponential = FALSE,
          alpha = NULL, beta = NULL)
# holt 방법이라 holt 의 함수를 쓴다.
# 앞에서와 다르지 않다. 
# h : 예측하고자 하는 미래시차 수
# level : 예측구간의 신회수준 지정
# initial : initial = c("optimal", "simple"), 초깃값 선택법. optimal 은 ets 방법 , simple 은 z1선택
# exponential : 2중을 한다는 의미는 시계열을 그려보았을 떄에 추세가 있었기 때문이엿을 것이다..
# 이런 추세가 직선추세 같으면 FALSE (linear), 지수적인 증가추세 같으면 TRUE (exponential) 
# 둘중 뭘 선택하는것은 분석자마음대로이다. 
# alpha, beta 를 NULL 지정시 SSE 최소로 하게 구해진다. 

fit
names(fit)
fit$model
#MODEL 에 대해서 알려준다. 

plot(fit)
# raw data
lines(fitted(fit), col="blue",type="o",pch=17)
# 추정된 그래프 위에 겹쳐져서 그려진다.
lines(fit$mean)
#fitt 된 예측값의 평균값 

# 선형성을 잘 따라가고싶다면 이중지수를 쓰자.
# 파란부분 = 95% 의 신뢰구간.



#계절지수평활법
#hw(사용함수) holt wintes

guarantee<-read.csv("C:/Users/Han/Desktop/Statistics/R/R tools/R dataset/guarantee.csv",header=FALSE)
# csv 가 오류가 안생겨서 좋다.
head(guarantee)

guarantee<-ts(guarantee, start=c(2010,1),end=c(2016,12),frequency=12)
# start, end 지정. frequency 는 12달데이터로 되어있다는 의미.
# guarantee 가 엑셀에서 불려져와,  timeseries 로 바꾸어주어햐 한다. ( r 입장에서는 하나하나 데이터인지 아닌지 모르므로) 
guarantee

plot.ts(guarantee, xlab="time", ylab="supply of housing finance credit guarantee")
#시도표 시간이 지남에 따라 증가하는것 같다.
#계절성이 있어보인다...
#가법 승법 둘다 고려해보자.

#install.packages("forecast")
library("forecast")
fit1<-hw(guarantee, seasonal="additive", h=12, initial="optimal")
#hw (
# 데이터명
# h= 예측하고자 하는 미래시차의 수
# 주기가 분기면 4의 배수, 지금은 월별 데이터로 ,1년도주기같으므로 12정도로 하자.
# seasonal = additive 는 가법 , multiplicative = 승법
# alpha beta gamma 세개의 평활상수

fit2<-hw(guarantee, seasonal="multiplicative",h=12)

fit1$model
fit2$model
#평활상수 뭐로했는지 다 보여줌
#12달을 주기로 봤기때문에 각각의 달에 따른 계절성분 (s)가 오르락내리락함을 볼 수 있다.

#AIC AICC BIC 가 나온다. 시계열에서 얘네들은 2~3가지 모형에서 누가 제일 좋은지 뽑아야한다. 그 모형중에서 가장 적절한 모형을 선택하게 해주는 지표
#AIC 는 낮을수록 좋다. AICC BIC 세개가 다 낮으면 좋은것이다. 이를보면 가법이 더 좋아보인다. 
# S 가수평성분에 대해서 계절성분이 오르락내리락 ( +값 , - 값 ) 을 보이고있으므로 좋다고 할 수 있다. 


plot(fit1, ylab="supply of housing finance credit guarantee", fcol="white",xlab="time",main="")
lines(fitted(fit1),col="red", lty=2, type="o",lwd=2,pch=1)
lines(fitted(fit2),col="green", lty=3, type="o",lwd=2,pch=2)
# green 이 승법  / red 가 가법 / raw 데이터는 검정

#선형지수평활만 하면 smooth 한 선이라 도움이 안될 것.
#계절성을 모형에 넣어주는것이 예측에있어 오차를 줄여줄 것이다.
lines(fit1$mean,col="red",type="o",lty=2, lwd=2, pch=1)
lines(fit2$mean,col="green",type="o",lty=3, lwd=2, pch=2)
legend("topleft", lty=1:3, pch=c(16,1,2),col=1:3,  c("data","holter winters additive", "holter winters multiplicative"), cex=0.7)
