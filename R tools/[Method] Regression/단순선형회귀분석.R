# 단순선형회귀분석

?trees
attach(trees)

plot(Volume~Girth)
# 선형회귀의 시각적 타당성 검토
# 산점도를 그려보고 이 데이터가 선형성을 따르는지 검토해본다. 
# plot(Y~X) (X 설명변수, Y 반응변수 로 설정한다.)

cor(Girth, Volume)
# 상관계수 상관계수의 절대값이 1에 가까울수록 적합이 잘되는 회귀직선식을 얻을 수 있다.
# X 와 Y 의 변수가 1개씩인 단순선형회귀분석에서는 cor 가 상관계수가 된다.
# 여기세어는 0.96 이므로 1에 매우 가깝다. 즉 매우 큰 선형관계가 있다는 것을 알 수 있다.

fit <- lm(Volume~Girth)
# lm = linear model (선형모형)
# lm(Y~X) (X 설명변수, Y 반응변수 로 설정한다.)

summary(fit) ## 회귀계수의 t검정, 잔차분산의 추정값, 결정계수 R^2
#Call:
#lm(formula = Volume ~ Girth)

#Residuals: 잔차에 대한 5가지 요약통계량. 추세선과 각각 자료들이 얼마나 떨어져있는지에 대한 요약이다.
#  Min     1Q Median     3Q    Max 
#-8.065 -3.107  0.152  3.495  9.587 

#Coefficient 
#Estimate : 회귀분석을 통하여 나온 추정값 intercept 는 절편, Girth(X변수)는 기울기. 1이오를때마다 Volume(Y변수) 가 얼마나 증가하는값
#Std.Error : 회귀분석의 가정사항들을 모두 만족한다면,(추세식의 b0=절편, b1=기울기에 대해서 b0 ~ N(β0, var(b0)), b1 ~ N(β1, var(b1))
#가 성립한다. 각각의 표준편차를 std.error 라고 한다. sb1,sb2
#t-value : 각각 귀무가설을 b0=0 , b1= 0 으로 두고 이에대한 검정을 한 t value (귀무가설: b1=0, 대립가설 b1=not 0 검정)
#Pr(>|t|): 그에따른 p-value 이다. 이 값이 작을수록 b1= not 0 이라는 소리. 
#이 자료에서는 Girth 가 X변수로 설정되었으므로 아래 Girth 의 Pr(>|t|) 값이 작다는것은 기울기가 0이 아니라는 주장이 신빈성이 있다는뜻
#즉 Girth 와 Volume 은 연관성이 크다는것을 확인 가능하다.
#              Estimate     Std. Error  t value   Pr(>|t|)    
#(Intercept)   -36.9435     3.3651     -10.987   7.62e-12 ***  #inte
#  Girth         5.0659     0.2474      20.48    < 2e-16 ***   #
#  ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Residual standard error: 4.252 on 29 degrees of freedom    #잔차의 표준오차
#Multiple R-squared:  0.9353,	Adjusted R-squared:  0.9331   #R-SQURE값 multiple 은 ssr/sst 이며 adjusted 는 수정된값.
#F-statistic: 419.4 on 1 and 29 DF,  p-value: < 2.2e-16   #F 검정값 단순선형회귀일 경우 F값과 t 의 검정이 일치해서 의미는 없다.

abline(fit$coefficient[1],fit$coefficient[2]) 
# 그려진 plot 위에 추정된 회귀식을 그려넣는다. 

## 우리가 추정하는 절편과 기울기에 대한 95% 신뢰구간
confint(fit)

## 회귀식의 유의성 검정 - 분산분석표
anova(fit)
#          Df Sum Sq      Mean Sq     F value             Pr(>F)    
#Girth      1 7581.8=ssr  7581.8=msr  419.36=msr/mse      < 2.2e-16 *** 
#Residuals 29  524.3=sse  18.1=mse  
# F 검정은 우리가 세운 모델의 전체적인 유의성을 검정한다. 그 P-VALUE값=Pr(>F) 이 값이 매우 작으므로 우리가 세운 모델은 
# 유의하다고 볼 수 있다. 




## 예측
## Prediction Interval of Y at all values of the X-variable
predint <- predict(fit, interval="prediction")
plot()
lines(predint[,2]~Girth, type="l")  # 신뢰수준 95% 에서의 상한 그래프
lines(predint[,3]~Girth, type="l")  # 신뢰수준 95% 에서의 하한 그래프

## Prediction Interval of Y at Girth=10, 15, 20 
new <- data.frame(Girth=c(10, 15, 20))
predict(fit, new, interval="prediction") 
#fit 은 점추정값 , (lwr,upr)은 그에 따른 구간추정값

## Prediction Interval of Mean of Y at Girth=10, 15, 20
predict(fit, new, interval="confidence")
#fit 은 점추정값 , (lwr,upr)은 그에 따른 구간추정값

help("predict.lm") # predict 가 궁금하다면 이걸 치자.


## 잔차에 의한 진단(diagnostics)
## 잔차도
plot(Girth, fit$residuals, ylab="잔차")  #이 때에 x 변수는 x값이다.
abline(0,0)

## 잔차의 정규성 진단 - 줄기잎전시
stem(fit$residuals)