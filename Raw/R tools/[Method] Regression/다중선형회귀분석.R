##########
#다중성형회귀 분석의 순서#
#1. 데이터 생성하기
#2. 산점도를 먼저 보고 선형성,이상치 예측하기
#3. lm 함수로 다중회귀 분석하기(R^2, 모형에대한 F검정, 각 계수들에대한 t검정)
#4. 잔차도,산점도,잔차히스토그램 등을 이용하여 진단하기
#5. 진단한 결과 문제점이 보이면, 처방 후 다시 반복

####### 데이터 전처리 ########


mydata <- matrix( c( 16, 19,  18, 20,  24,  26,  30, 32,  31, 34,
                      5,  6,   7,  8,   9,  11,  12, 13,  14, 15,
                      2,  1.9, 4,  5.6, 6.1, 6.2, 7,  7.2, 8,  9), 
                  nrow=10, ncol=3) 
mydata
# byrows 가 default 인 false 이기 때문에 이 값은 col 순서대로 들어가는 matrix 가 된다. 즉
#      [,1] [,2] [,3]
#[1,]   16    5  2.0
#[2,]   19    6  1.9
#[3,]   18    7  4.0
#[4,]   20    8  5.6
#[5,]   24    9  6.1
#[6,]   26   11  6.2
#[7,]   30   12  7.0
#[8,]   32   13  7.2
#[9,]   31   14  8.0
#[10,]  34   15  9.0

colnames(mydata) <- c("매출액", "광고비", "설비투자")  
# matrix 의 열이름, 행이름을 바꾸는 명령어이다. 이 때에는 colname 을 저렇게 바꾼다는 뜻.

mydata <- data.frame(mydata)
# matrix 인 상태에서는 data 분석을 할 수가 없다. 즉 data.frame 으로 바꿔줌
attach(mydata)




###### 데이터 분석 전 살펴보기 ######

#산점도
pairs(mydata) 
#각 변수들끼리 pair 를 지어서 산점도를 그린다.

cor(mydata) # 각 관계들에 대한 상관계수 값을 도출한다. cov(A,B) = cov(B,A)
###  다중회귀: 매출액 = f(광고비, 설비투자)

#install.packages("corrplot")
library(corrplot)
corrplot(cor(mydata),method='number') # 각 관계들에 대한 상관계수 값을 그래프 위에 나타낸다.


##### 데이터 분석 ########

#다중회귀분석
fit <- lm(매출액 ~ 광고비 + 설비투자) # 이때에 ~ 옆의 + 는 설명변수들이다.
fit <- lm(매출액 ~. , data=mydata)
# 이렇게  설명변수가 많을때에는 옆에다 ~. 만 쓰면 나머지 변수들을 모두 설명변수로 보겠다는 것이다.), 위와 같은뜻


# 별첨 (다중선형회귀의 분산분석표)
fit1 <- lm(매출액~1)
anova(fit1,fit)
anova(update(fit1,~1),fit)
# 이렇게 다중선형회귀의 분산분석표를 확인할 수 있다.
#     Res.Df    RSS     Df   Sum of Sq      F        Pr(>F)    
#1      n       (SST)                                  
#2      n-k-1   (SSE)   (k)    (SSR)       (MSR/MSE)   4.195e-06 ***  #n=관찰값의 수, k= 설명변수의 수


summary(fit)
#Call:
#  lm(formula = 매출액 ~ ., data = mydata)
#
#Residuals:
#  Min      1Q  Median      3Q     Max 
#-1.5477 -0.8391 -0.1286  1.0417  1.5139    #잔차들에 5개의 통계량.
#
#Coefficients:
#              Estimate   Std. Error  t value  Pr(>|t|)    
#(Intercept)   6.0985     1.3618      4.478    0.002872 **    #절편에 대한 검정
#  광고비      2.2567     0.4048      5.575    0.000838 ***   #광고비 계수에 대한 개별t검정 
#  설비투자   -0.6430     0.5913     -1.088    0.312805       #설비투자 계수에 대한 개별t검정
#
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
#Residual standard error: 1.263 on 7 degrees of freedom
#Multiple R-squared:  0.9709,	Adjusted R-squared:  0.9626  
#F-statistic: 116.8 on 2 and 7 DF,  p-value: 4.195e-06        #모델의 총체적 검정

#다중선형회귀에서는 드디어 F검정(총체적인 model 의 검정) 과 t검정(개별 x변수의 계수)에 대한 검정이 각각 다르다. 
#F 검정은 h0= 모든 설명변수의 계수가 0 , h1= 설명변수의 모든 계수가 다 0은 아니다.
#t 검정은 하나의 xi 에 대해서, h0= xi 의 계수는 0, h1= xi 의 계수는 0이 아님 
## 우리가 추정하는 절편과 기울기에 대한 95% 신뢰구간

confint(fit)


########## 데이터 진단 ########
#잔차도 
#잔차도로 진단가능한것
#1. 오차의 등분산성 (위배시 나팔형태) (처방: 변수변환)
#2. 모형의 선형성   (위배시 곡선형태) (처방: 변수변환)
plot(fit$fitted, fit$residuals, xlab="매출액-hat", ylab="잔차", main="잔차그림")
abline(0,0)

#잔차히스로그렘
#잔차히스토그램으로 진단 가능한것
#1. 오차의 정규성 (위배시 종모양 아님) (처방 : 변수변환)
stem(fit$residuals)
hist(fit$residuals)

#산점도
#산점도로 진단가능한것
#1. 이상치의 존재 (멀리 떨어진점) (처방: 데이터 삭제)
#2. 다중공산성    (개별 x변수끼리 직선에 가까운 선형관계) (처방 : x변수 삭제)
pairs(mydata) # 일반적인 산점도
##install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
chart.Correlation(mydata, histogram=TRUE) # corr 과 히스토그램이 결합된 산점도

#공산성의 진단
#1. 산점도행렬에서 x변수끼리 거의 선형관계(이경우 광고비와 설비투자)
#2. f검정에서는 모델이 유의하다고 나오지만, 개별 t 검정에서는 어떤 x변수가 비유의적일때) (이경우 설비투자)
#3. x변수 하나를 뺄 때와 추가할때 다른 x변수들의 기울기 추정값이 많이 변동시 


################ 예제 2 가변수

설비투자가변수 <- c(rep(0,4), rep(1,6))
mylm <- lm(매출액 ~ 광고비 + 설비투자가변수)
mylm
anove(mylm)
summary(mylm)

par(mfcol=c(1,3))
plot(매출액[설비투자가변수==0] ~ 광고비[설비투자가변수==0], 
     xlim=c(5,15), ylim=c(16,34), pch=19, xlab="광고비", ylab="매출액")
title("설비투자가변수=0")
lines(x<-c(4,9), y=8.04+1.57*x)    # ablin(8.04, 1.57) 로 교체 가능
text(9, 18, "y=8.04+1.57x")
plot(매출액[설비투자가변수==1] ~ 광고비[설비투자가변수==1], 
     xlim=c(5,15), ylim=c(16,34), pch=19, xlab="광고비", ylab="매출액")
title("설비투자가변수=1")
lines(x<-c(8,16), y=10.13+1.57*x)    # ablin(8.04, 1.57) 로 교체 가능
text(9.5, 30, "y=10.13+1.57x")
plot(매출액 ~ 광고비, xlab="광고비", ylab="매출액")
title("전체자료")
points(광고비[설비투자가변수==0], 매출액[설비투자가변수==0], pch=19) 
lines(x<-c(4,9), y=8.04+1.57*x)
text(9, 18, "y=8.04+1.57x")
lines(x<-c(8,16), y=10.13+1.57*x, lty=3)
text(9.5, 30, "y=10.13+1.57x")



### [[[[[[[2차항 추가하기]]]]]]]]]]

#철강공정에서 x = 철 제련시 온도 y = 제품의 강도라 하자.

x <- c(250, 260, 270, 280, 290, 300, 310, 320, 330, 340)
y <- c( 45,  51,  56,  70,  72,  86,  81,  67,  53,  40)

#데이터 분석 전, 자료 살펴보기
plot(x,y, xlab="온도", ylab="강도")


######### 1차 회귀
mylm1 <- lm(y~x)

anova(mylm1)
summary(mylm1)# 단순선형회귀 분석 참고.
abline(mylm1$coefficient[1],mylm1$coefficient[2]) # 그래프 추가
# curve(mylm1$coeff[1] + mylm1$coeff[2]*x, add=T) # 이렇게 추가해도 된다.
title(main="1차 회귀") # 제목 추가.

#x 축이 y의 추정값인 잔차도
plot(mylm1$fitted, mylm1$residuals, xlab="y-hat", ylab="r", main="1차 회귀 잔차그림")
abline(0,0)

#x 축이 x(설명변수)인 잔차도.
plot(x, mylm1$residuals, xlab="x", ylab="r", main="1차 회귀 잔차그림")
abline(0,0)

#잔차도가 n 형태를 띄고 있다. 즉 이차항을 추가하여 다시 고려해 보자.


##########2차항 추가하기
xx <-x*x # xx 를 x^2 의 값을 가지도록 새로 정의하자.
mylm <- lm(y~x+xx) # 2차항 추가

anova(mylm)
summary(mylm) # 각 x, xx 에 대한 검정

plot(x,y)
curve(mylm$coeff[1] + mylm$coeff[2]*x + mylm$coeff[3]*x^2, add=T)
title(main="2차 다항회귀")

plot(mylm$fitted, mylm$residuals, xlab="y-hat", ylab="r", main="2차 다항회귀 잔차그림")
abline(0,0)

plot(x1,x1x1)

######## 삼차항 추가
x3 <- x^3
mylm3 <- lm(y~x+xx+x3)

plot(x,y, xlab="온도", ylab="강도", main="3차 다항회귀")
curve(mylm3$coeff[1] + mylm3$coeff[2]*x + mylm3$coeff[3]*x^2
                     + mylm3$coeff[4]*x^3, add=T )

anova(mylm3)
summary(mylm3)

plot(mylm3$fitted, mylm3$residuals,xlab="Y-hat", ylab="잔차", main="3차 다항회귀 잔차그림")
abline(0,0)

