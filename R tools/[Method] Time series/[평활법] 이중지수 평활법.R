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