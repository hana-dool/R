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
# alpha = 평활상수. 그런데 alpha = NULL 이라고 할 때에는 MSE를 최소화 하는 평활상수를 자동으로 추정해서 사용
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