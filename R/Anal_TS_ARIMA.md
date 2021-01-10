Arima
================

# 정상 시계열

  - 추세성, 계절성, 순환성이 보이지 않는다.
  - 자료 변화의 폭이 일정하다.
  - 시간에 따라 상이한 자기 상관적 패턴을 나타내는 구간이 없다.

# 비정상 판단

  - ACF 가 매우 \# 정상화
  - 차분
      - 1차 차분
      - 2차 이상의 차분은 거의 하지 않는다.(큰 효과가 없고, 모델만 복잡해지기 떄문)
      - 계절 차분
          - m 이 계절 주기라고 하자. 그러면 y\_(t+m) - y\_t 의 변환을 계절차분이라 한다.
          - 계절 차분을 실시할 경우 계절성에 의한 주기 변동이 크게 줄어든다.
      - 단위근 검정
          - 차분이 필요한지 아닌지에 대한 검정을 실시할 수 있다.
  - 변환
      - log, sqrt 등, 점점 진폭이 커지는 시계열의 경우 이러한 변환을 통해서 변화의 폭을 일정하게 해서 정상
        시계열로 만들 수 있다.
      - box cox 를 이용할 수도 있다.

# AR 모델

![images](./Images/TS_AR.png)

  - AR 모델은 이전의 관측값이 이후 자신의 관측값에 영향을 준다는 아이디어
  - 자기 자신의 과거값에 기반한 변동을 추정한다.
  - 하지만 과거값의 변동보다 훨씬 변동이 큰 경우 부적합

# MA 모델

![images](./Images/TS_MA.png)

  - ‘과거값’ 이 아니라 과거값이 설명하지 못한 ‘오차’ 즉. 예측하지 못했던 변동값이 현재 항에 영향을 준다는 아이디어
  - ‘변화’ 에 더 초점을 둔 아이디어이다.

# ARIMA 모델

![images](./Images/TS_ARIMA.png)

![images](./Images/TS_ARIMA2.png)

  - 우선 ARMA 모델은 위 두 부분을 합친 모델이다.
  - 하지만 여전히 불규칙 시계열 데이터를 예측하지 못하는 단점이 있다.(기본적으로 정상 시계열을 잘 예측함)
  - 그래서 차분으로, 시계열을 정상시계열로 만든 뒤에 ARMA 모델을 적용하는것이 ARIMA 모델이다.
  - ARMA(AR계수,차분,MA계수)

## EX

``` r
library(forecast)
```

    ## Warning: package 'forecast' was built under R version 4.0.3

    ## Registered S3 method overwritten by 'quantmod':
    ##   method            from
    ##   as.zoo.data.frame zoo

``` r
library(fpp2)
```

    ## Warning: package 'fpp2' was built under R version 4.0.3

    ## -- Attaching packages -------------------------------------------------- fpp2 2.4 --

    ## √ ggplot2   3.3.2     √ expsmooth 2.3  
    ## √ fma       2.4

    ## Warning: package 'fma' was built under R version 4.0.3

    ## Warning: package 'expsmooth' was built under R version 4.0.3

    ## 

``` r
autoplot(uschange[,"Consumption"]) +
  xlab("연도") + ylab("분기별 백분율 변화")
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

``` r
fit <- auto.arima(uschange[,"Consumption"], seasonal=FALSE)
fit
```

    ## Series: uschange[, "Consumption"] 
    ## ARIMA(1,0,3) with non-zero mean 
    ## 
    ## Coefficients:
    ##          ar1      ma1     ma2     ma3    mean
    ##       0.5885  -0.3528  0.0846  0.1739  0.7454
    ## s.e.  0.1541   0.1658  0.0818  0.0843  0.0930
    ## 
    ## sigma^2 estimated as 0.3499:  log likelihood=-164.81
    ## AIC=341.61   AICc=342.08   BIC=361

![images](./Images/TS_ARIMA_R.png)

  - 이 때에 위의 auto.arima 가 궁금할 텐데,

![images](./Images/TS_Auto%20arima.png)

  - 위와 같이 자동화 되어서 p,d,q 를 각각 조절하면서 AIC 기준으로 최적의 모델을 찾으려고 노력한다.
  - 우리만의 모델을 쓰고 싶다면 Arima() 함수를 이용하면 된다.

<!-- end list -->

``` r
Arima(uschange[,"Consumption"],order=c(2,0,2))
```

    ## Series: uschange[, "Consumption"] 
    ## ARIMA(2,0,2) with non-zero mean 
    ## 
    ## Coefficients:
    ##          ar1      ar2      ma1     ma2    mean
    ##       1.3908  -0.5813  -1.1800  0.5584  0.7463
    ## s.e.  0.2553   0.2078   0.2381  0.1403  0.0845
    ## 
    ## sigma^2 estimated as 0.3511:  log likelihood=-165.14
    ## AIC=342.28   AICc=342.75   BIC=361.67

  - 직접 order 으로 Arima(2,0,2) 를 적용한 모습. 좀 더 AIC 가 증가한것을 볼 수 있다.

<!-- end list -->

``` r
fit %>% forecast(h=10) %>% autoplot(include=80) +
  ggtitle("0이 아닌 평균을 가지는 ARIMA(1,0,3)로부터 얻은 예측값") + ylab("소비")
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-4-1.png)<!-- --> -
Fitting 한 모델을 forcast 를 통해서 예측하고, plot 으로 그린 모습

``` r
coef(fit) # 계수
```

    ##         ar1         ma1         ma2         ma3   intercept 
    ##  0.58853911 -0.35278959  0.08456844  0.17389966  0.74540707

``` r
forecast(fit) # 예측
```

    ##         Point Forecast       Lo 80    Hi 80      Lo 95    Hi 95
    ## 2016 Q4      0.7295391 -0.02852627 1.487605 -0.4298219 1.888900
    ## 2017 Q1      0.8146003  0.03575392 1.593447 -0.3765425 2.005743
    ## 2017 Q2      0.7871287 -0.00990340 1.584161 -0.4318267 2.006084
    ## 2017 Q3      0.7699619 -0.05999835 1.599922 -0.4993528 2.039277
    ## 2017 Q4      0.7598586 -0.08120674 1.600924 -0.5264398 2.046157
    ## 2018 Q1      0.7539123 -0.09096547 1.598790 -0.5382168 2.046041
    ## 2018 Q2      0.7504127 -0.09578161 1.596607 -0.5437298 2.044555
    ## 2018 Q3      0.7483531 -0.09829681 1.595003 -0.5464862 2.043192

``` r
checkresiduals(fit)
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

    ## 
    ##  Ljung-Box test
    ## 
    ## data:  Residuals from ARIMA(1,0,3) with non-zero mean
    ## Q* = 5.9016, df = 3, p-value = 0.1165
    ## 
    ## Model df: 5.   Total lags used: 8

``` r
autoplot(forecast(fit))
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

# 계절 ARIMA (SARIMA)

![images](./Images/TS_SARIMA.png)

  - 위 그림의 예시에서 y\_t 앞 (1-B)(1-B^4) 의 차분은, y 를 정상 시계열로 만들기 위한 변환, 그리고 B^4
    로 구성된 계절성 ARMA 와 B 로 구성된 ARMA 의 곱을 통해서 계절적회귀와 시간적 회귀 둘다 고려할 수 있게된다.
  - 에러(변동) 과 과거값 의 사항을 계절성과 이전시점의 ARMA 곱을 통해서 모두 고려 가능하게 된다.

## EX

  - 1996 년부터 2011 년까지 분기별 유럽 소매 거래 데이터를 이용하자.

<!-- end list -->

``` r
autoplot(euretail) + ylab("소매 지수") + xlab("연도")
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

``` r
auto.arima(euretail)
```

    ## Series: euretail 
    ## ARIMA(0,1,3)(0,1,1)[4] 
    ## 
    ## Coefficients:
    ##          ma1     ma2     ma3     sma1
    ##       0.2630  0.3694  0.4200  -0.6636
    ## s.e.  0.1237  0.1255  0.1294   0.1545
    ## 
    ## sigma^2 estimated as 0.156:  log likelihood=-28.63
    ## AIC=67.26   AICc=68.39   BIC=77.65

  - (0,1,3)(0,1,1)\[4\] : 계절성은 4, 계설성은MA(1),일반모형은MA(3) 차분은 각각 1번씩 임을 알 수
    있다.

## EX2

``` r
#scv 파일 읽기
data <- read.csv("Data/Timedata.csv",header=FALSE)
head(data)
```

    ##    V1
    ## 1 4.0
    ## 2 3.9
    ## 3 3.5
    ## 4 3.2
    ## 5 4.0
    ## 6 4.6

``` r
#-------------- 라이브러리 ---------------#
library(tseries)
```

    ## Warning: package 'tseries' was built under R version 4.0.3

``` r
library(fUnitRoots)
```

    ## Warning: package 'fUnitRoots' was built under R version 4.0.3

    ## Loading required package: timeDate

    ## Warning: package 'timeDate' was built under R version 4.0.3

    ## Loading required package: timeSeries

    ## Warning: package 'timeSeries' was built under R version 4.0.3

    ## Loading required package: fBasics

    ## Warning: package 'fBasics' was built under R version 4.0.3

``` r
library(forecast)
```

  - 라이브러리를 import 하자.

<!-- end list -->

``` r
#-----------------데이터 시계열 데이터로 만들기 ---------------#

# 주기를 가지는듯 하므로 주기가 12인 데이터로 만들자.
data_1 <- ts(data) # 나중에 그래프 그릴떄 필요
data<-ts(data,frequency = 12) # 월별 데이터일때, 즉 주기가 12
```

  - 데이터의 주기를 12로 설정한다.

<!-- end list -->

``` r
#-----------------그래프 그려보기 ---------------#
# 계설성 확인하기 (이떄는 12)
plot(data_1,xaxt = "n")
axis(1, at = seq(12, 108, by = 12))
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

  - 계절성과 추세를 나누어보자.

<!-- end list -->

``` r
# 계절성 / 추세 나누는 그래프
plot(stl(data[,1], s.window="periodic"))
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

  - ACF/PACF 로 확인하기

<!-- end list -->

``` r
#------------ ACF/PACF 로 비정상 데이터임을 확인하기 ------#
acf(data,main="ACF", lag=36)
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

``` r
pacf(data,main="PACF", lag=36)
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-15-2.png)<!-- --> -
데이터를 보았을 때, lag 가 확 줄어드는게 아니라, 변동하면서 줄어든다. - 비정상적임을 확인 가능

``` r
#-----------------분산안정화----------------#
data_sqrt<-1/sqrt(data)
ts.plot(data_sqrt)
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-16-1.png)<!-- --> - 갈수록
줄어드는 그 진폭이 줄어드는 형태였기 때문에, 분산 안정화를 1/sqrt 로 시행

``` r
#-----------------추세 정상화를 위한 차분하기-------------------#
data_sqrt_diff1 <- diff(data_sqrt, difference = 1)
data_sqrt_diff2 <- diff(data_sqrt, difference = 2)

par(mfrow=c(3,1))
plot.ts(data_sqrt)
plot.ts(data_sqrt_diff1)    # 1차차분 선정
plot.ts(data_sqrt_diff2)
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-17-1.png)<!-- --> - 차분을
진행해보앗을 때, 1차 차분으로도 어느정도 정상화가 진행되었다. - 그러므로 1차 차분을 진행

``` r
#------------------ 계절 차분하기 ---------------#
data_sqrt_diff1_S<-diff(data_sqrt_diff1, lag=12)
par(mfrow=c(1,1))
plot.ts(data_sqrt_diff1_S)
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-18-1.png)<!-- --> -
계절성이 12일 마다 있었기 때문에 계절차분을 진행하였다.

``` r
#--------- 정상시계열로 변환되었는지 확인하기 ------#
adfTest(data_sqrt_diff1_S) # adf test 
```

    ## Warning in adfTest(data_sqrt_diff1_S): p-value smaller than printed p-value

    ## 
    ## Title:
    ##  Augmented Dickey-Fuller Test
    ## 
    ## Test Results:
    ##   PARAMETER:
    ##     Lag Order: 1
    ##   STATISTIC:
    ##     Dickey-Fuller: -7.8749
    ##   P VALUE:
    ##     0.01 
    ## 
    ## Description:
    ##  Sun Jan 10 16:31:59 2021 by user: goran

``` r
pp.test(data_sqrt_diff1_S)
```

    ## Warning in pp.test(data_sqrt_diff1_S): p-value smaller than printed p-value

    ## 
    ##  Phillips-Perron Unit Root Test
    ## 
    ## data:  data_sqrt_diff1_S
    ## Dickey-Fuller Z(alpha) = -125.84, Truncation lag parameter = 3, p-value
    ## = 0.01
    ## alternative hypothesis: stationary

  - adf,pp test 의 결과 둘다 정상시계열임을 알 수 있었다.

<!-- end list -->

``` r
#----------- 최종 데이터 변환(예비모델 생성) --------#
data_1 <- data_sqrt_diff1_S

#------------- acf / pacf -------------------------#
par(mfrow=c(1,1))
acf(data_1,main="ACF", lag=36)
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-20-1.png)<!-- -->

``` r
pacf(data_1,main="PACF", lag=36)
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-20-2.png)<!-- --> -
어느정도 안정된거 같기도 하다.

``` r
#-------------auto arima 적용--------------------#
# 위 acf/ pacf 를 보고 ar/ma 추정할때 참고.
auto.arima(data_sqrt)
```

    ## Series: data_sqrt 
    ## ARIMA(2,0,0)(0,1,1)[12] with drift 
    ## 
    ## Coefficients:
    ##          ar1     ar2     sma1   drift
    ##       0.6530  0.2172  -0.5503  0.0018
    ## s.e.  0.0991  0.0993   0.1277  0.0005
    ## 
    ## sigma^2 estimated as 0.0002806:  log likelihood=255.75
    ## AIC=-501.51   AICc=-500.84   BIC=-488.68

  - Auto armima 를 통해 어떠한 Arima 모델을 써야하는지 알 수 있다.
  - 이 떄에 선정 기준은 AIC 이다.

<!-- end list -->

``` r
#--------------- 모형 적합하기 -------------------#
# 예비모델 생성했을 시 FIT 이 많아진다.
#SARIMA(0,1,1)x(0,1,1) MODEL
fit<-Arima(data_sqrt,c(0,1,1), seasonal=list(order=c(0,1,1),period=12))
fit
```

    ## Series: data_sqrt 
    ## ARIMA(0,1,1)(0,1,1)[12] 
    ## 
    ## Coefficients:
    ##           ma1     sma1
    ##       -0.2865  -0.5539
    ## s.e.   0.0952   0.1259
    ## 
    ## sigma^2 estimated as 0.0002902:  log likelihood=250.86
    ## AIC=-495.73   AICc=-495.46   BIC=-488.06

``` r
#----------------모델의 진단--------------------#
tsdiag(fit)
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-23-1.png)<!-- -->

``` r
#1. 표준화된 잔차가 -3~3 정도면 괜찮다.
#2 ACF 는 독립이여야하니까 0을 제외하고 다 0boundary 안에 있어야 한다.
#3 P-VALUE 계산시 모두 0.05 이상이다
#-> 즉 선택해도 상관 없겠네~
```

``` r
#-------------- 모델의 예측 -----------------#
#원데이터의에 대한 12개의 예측치를 예측
pred<-predict(fit, n.ahead=12)
predict(fit, n.ahead=12)
```

    ## $pred
    ##          Jan       Feb       Mar       Apr       May       Jun       Jul
    ## 10 0.6835023 0.6846387 0.6843676 0.7047098 0.6821885 0.6524283 0.5927974
    ##          Aug       Sep       Oct       Nov       Dec
    ## 10 0.5699312 0.6229381 0.6921466 0.7022400 0.7249338
    ## 
    ## $se
    ##           Jan        Feb        Mar        Apr        May        Jun        Jul
    ## 10 0.01703508 0.02092627 0.02419966 0.02708023 0.02968255 0.03207442 0.03429990
    ##           Aug        Sep        Oct        Nov        Dec
    ## 10 0.03638954 0.03836552 0.04024460 0.04203978 0.04376137

``` r
pred
```

    ## $pred
    ##          Jan       Feb       Mar       Apr       May       Jun       Jul
    ## 10 0.6835023 0.6846387 0.6843676 0.7047098 0.6821885 0.6524283 0.5927974
    ##          Aug       Sep       Oct       Nov       Dec
    ## 10 0.5699312 0.6229381 0.6921466 0.7022400 0.7249338
    ## 
    ## $se
    ##           Jan        Feb        Mar        Apr        May        Jun        Jul
    ## 10 0.01703508 0.02092627 0.02419966 0.02708023 0.02968255 0.03207442 0.03429990
    ##           Aug        Sep        Oct        Nov        Dec
    ## 10 0.03638954 0.03836552 0.04024460 0.04203978 0.04376137

``` r
x<-1/(pred$pred)^2
answer<-c(x)
answer
```

    ##  [1] 2.140524 2.133423 2.135114 2.013629 2.148776 2.349278 2.845688 3.078614
    ##  [9] 2.576975 2.087391 2.027818 1.902844

``` r
par(mfrow=c(1,1))
ts.plot(data, 1/(pred$pred)^2, lty=c(1,3))
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-24-1.png)<!-- -->

``` r
#----------------- 최종값 ------------------#
answer
```

    ##  [1] 2.140524 2.133423 2.135114 2.013629 2.148776 2.349278 2.845688 3.078614
    ##  [9] 2.576975 2.087391 2.027818 1.902844

## EX3

``` r
# Consider the qcement data beginning in 1988
cement <- window(qcement, start=1988)
# Use 20 years of the qcement data beginning in 1988
train <- window(cement, end=c(2007,4))
fit.arima <- auto.arima(train)
fit.arima
```

    ## Series: train 
    ## ARIMA(1,0,1)(2,1,1)[4] with drift 
    ## 
    ## Coefficients:
    ##          ar1      ma1   sar1     sar2     sma1   drift
    ##       0.8886  -0.2366  0.081  -0.2345  -0.8979  0.0105
    ## s.e.  0.0842   0.1334  0.157   0.1392   0.1780  0.0029
    ## 
    ## sigma^2 estimated as 0.01146:  log likelihood=61.47
    ## AIC=-108.95   AICc=-107.3   BIC=-92.63

``` r
checkresiduals(fit.arima)
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-25-1.png)<!-- -->

    ## 
    ##  Ljung-Box test
    ## 
    ## data:  Residuals from ARIMA(1,0,1)(2,1,1)[4] with drift
    ## Q* = 3.3058, df = 3, p-value = 0.3468
    ## 
    ## Model df: 6.   Total lags used: 9

``` r
(fit.ets <- ets(train))
```

    ## ETS(M,N,M) 
    ## 
    ## Call:
    ##  ets(y = train) 
    ## 
    ##   Smoothing parameters:
    ##     alpha = 0.7341 
    ##     gamma = 1e-04 
    ## 
    ##   Initial states:
    ##     l = 1.6439 
    ##     s = 1.031 1.0439 1.0103 0.9148
    ## 
    ##   sigma:  0.0581
    ## 
    ##        AIC       AICc        BIC 
    ## -2.1967020 -0.6411464 14.4774845

``` r
checkresiduals(fit.ets)
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-26-1.png)<!-- -->

    ## 
    ##  Ljung-Box test
    ## 
    ## data:  Residuals from ETS(M,N,M)
    ## Q* = 6.3457, df = 3, p-value = 0.09595
    ## 
    ## Model df: 6.   Total lags used: 9

``` r
a1 <- fit.arima %>% forecast(h = 4*(2013-2007)+1) %>%
  accuracy(qcement)
a1
```

    ##                        ME      RMSE        MAE        MPE     MAPE      MASE
    ## Training set -0.006205705 0.1001195 0.07988903 -0.6704455 4.372443 0.5458078
    ## Test set     -0.158835253 0.1996098 0.16882205 -7.3332836 7.719241 1.1534049
    ##                     ACF1 Theil's U
    ## Training set -0.01133907        NA
    ## Test set      0.29170452 0.7282225

  - arima 의 추정에 대한 accuracy

<!-- end list -->

``` r
a2 <- fit.ets %>% forecast(h = 4*(2013-2007)+1) %>%
  accuracy(qcement)
a2
```

    ##                       ME      RMSE        MAE        MPE     MAPE      MASE
    ## Training set  0.01406512 0.1022079 0.07958478  0.4938163 4.371823 0.5437292
    ## Test set     -0.13495515 0.1838791 0.15395141 -6.2508975 6.986077 1.0518075
    ##                     ACF1 Theil's U
    ## Training set -0.03346295        NA
    ## Test set      0.53438371  0.680556

  - ets 추정에 따른 accuracy
  - ets 가 test 에 대해서 좀 더 좋아보인다?

<!-- end list -->

``` r
cement %>% ets() %>% forecast(h=12) %>% autoplot()
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-29-1.png)<!-- -->

``` r
cement %>% auto.arima() %>% forecast(h=12) %>% autoplot()
```

![](Anal_TS_ARIMA_files/figure-gfm/unnamed-chunk-29-2.png)<!-- --> - ETS
와 Auto arima 의 추정을 서로 비교해 볼 수 있다.
