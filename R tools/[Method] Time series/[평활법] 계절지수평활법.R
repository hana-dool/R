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
