Untitled
================

# ts 객체

  - R 에서는 각 시간에 어떤 정보가 입력되었는지를 목록으로 생각할 수 있다.
  - 이러한 정보를 ts 객체로 저장할 수 있다.

<!-- end list -->

``` r
y_ts = ts(c(5,10,15,20,25),start=2015)
y_ts
```

    ## Time Series:
    ## Start = 2015 
    ## End = 2019 
    ## Frequency = 1 
    ## [1]  5 10 15 20 25

  - 시계열 데이터를 형성한것을 볼 수 있다.

-----

  - 1년이 아니라 월별데이터의 경우 빈도를 설정해 주어야 한다.
  - 빈도
      - 연 : 1
      - 분기 : 4
      - 월 : 12
      - 주 : 52

<!-- end list -->

``` r
# y_ts  = ts(z,start=2003,frequency=12)
```

# 시계열 시각화

  - Auto plot 을 이용하여 시계열 그래프를 그릴 수 있다.
  - 이 때에 ts 객체를 사용해서 그림을 그려야 한다.

<!-- end list -->

``` r
library(fpp2)
library(ggplot2)

autoplot(melsyd[,"Economy.Class"]) +
  ggtitle("이코노미석 탑승객: 멜버른-시드니") +
  xlab("연도") +
  ylab("탑승객(단위: 1000명)")
```

![](Anal_TS_Base_files/figure-gfm/unnamed-chunk-3-1.png)<!-- --> - 시계열
그래프를 통해서 몇가지 재미있는 사실을 알 수 있다.  
\- 1989 는 파업으로 인해 수송객이 없었다. - 1992 년은 수송객이 감소했던 기간으로, 이는 일부 이코노미 좌석을
비즈니스 좌석으로 교체하엿기 떄문 - 휴가철 효과로 인해 매 연초에 크게 하락하는 지점이 있다.

  - 위 같은 정보들도 모델이 고려할 수 있게 넣어야 할 것이다.

## 시계열 그래프

``` r
autoplot(a10) +
  ggtitle("당뇨병 약 매출") +
  ylab("매출(단위: 백만 달러)") +
  xlab("연도")
```

![](Anal_TS_Base_files/figure-gfm/unnamed-chunk-4-1.png)<!-- --> - 증가하는
추세를 확인 가능 - 계절성의 패턴도 또한 커진다는것을 같이 확인 가능했다.

``` r
autoplot(AirPassengers)
```

![](Anal_TS_Base_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

## 계절성 그래프

``` r
ggseasonplot(a10, year.labels = TRUE, year.labels.left = TRUE) +
  ylab("백만 달러") +
  xlab("월") +
  ggtitle("계절성 그래프: 당뇨병 약 매출")
```

![](Anal_TS_Base_files/figure-gfm/unnamed-chunk-6-1.png)<!-- --> - 계절성을
살펴보기 위해서, 년도별로 나타내 보았다. - 1월에 매출이 뛴다는 분명한 사실을 알 수 있다.

``` r
ggseasonplot(a10, polar = TRUE) +
  ylab("백만 달러") +
  xlab("월") +
  ggtitle("계절성 극좌표 그래프: 당뇨병 약 매출")
```

![](Anal_TS_Base_files/figure-gfm/unnamed-chunk-7-1.png)<!-- --> - 위와 같이
극좌표를 그려서 확인해 볼 수 있다. - 꾸준히 년도가 갈수록 증가했다는 사실을 알 수 있다.

## 산점도 그래프

  - About data
      - 2014년 호주 빅토리아 주의 30분 단위 전력 수요(기가와트) vs 기온(C) 이다.
      - 온도값은 빅토리아주의 가장 큰 도시인 멜버른에서 측정
      - 수요값은 주 전체에 대한 값
  - 두개의 시계열을 나란히 살펴봄으로써, 어떤 관계가 있는지 살펴볼 수 있다.

<!-- end list -->

``` r
autoplot(elecdemand[,c("Demand","Temperature")], facets=TRUE) +
  xlab("연도: 2014") + ylab("") +
  ggtitle("호주 빅토리아 주의 30분 단위의 전력 수요")
```

![](Anal_TS_Base_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

  - 또는 두개의 변수에 대해 산점도를 살펴봄으로서 변수간의 관계를 대충 살펴볼 수 있다.

<!-- end list -->

``` r
ggplot(data=as.data.frame(elecdemand),mapping = aes(Temperature, Demand)) +
  geom_point()+
  ylab("수요 (단위: 기가 와트GW)")+ 
  xlab("기온 (섭씨)")
```

## ![](Anal_TS_Base_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

  - About data
      - 호주 뉴 사우스 웨일즈 주에 있는 5개 지역의 분기별 방문 수

<!-- end list -->

``` r
autoplot(visnights[,1:5], facets=TRUE) +
  ylab("각 분기별 여행자 숙박일 수(단위: 백만 명)")
```

![](Anal_TS_Base_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

  - 산점도 행렬 + correlation 을 다음 GGally 패키지를 이용하여 볼 수 있다.

<!-- end list -->

``` r
library(GGally)
ggpairs(as.data.frame(visnights[,1:5]))
```

![](Anal_TS_Base_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

## 시차 그래프

``` r
ausbeer
```

    ##      Qtr1 Qtr2 Qtr3 Qtr4
    ## 1956  284  213  227  308
    ## 1957  262  228  236  320
    ## 1958  272  233  237  313
    ## 1959  261  227  250  314
    ## 1960  286  227  260  311
    ## 1961  295  233  257  339
    ## 1962  279  250  270  346
    ## 1963  294  255  278  363
    ## 1964  313  273  300  370
    ## 1965  331  288  306  386
    ## 1966  335  288  308  402
    ## 1967  353  316  325  405
    ## 1968  393  319  327  442
    ## 1969  383  332  361  446
    ## 1970  387  357  374  466
    ## 1971  410  370  379  487
    ## 1972  419  378  393  506
    ## 1973  458  387  427  565
    ## 1974  465  445  450  556
    ## 1975  500  452  435  554
    ## 1976  510  433  453  548
    ## 1977  486  453  457  566
    ## 1978  515  464  431  588
    ## 1979  503  443  448  555
    ## 1980  513  427  473  526
    ## 1981  548  440  469  575
    ## 1982  493  433  480  576
    ## 1983  475  405  435  535
    ## 1984  453  430  417  552
    ## 1985  464  417  423  554
    ## 1986  459  428  429  534
    ## 1987  481  416  440  538
    ## 1988  474  440  447  598
    ## 1989  467  439  446  567
    ## 1990  485  441  429  599
    ## 1991  464  424  436  574
    ## 1992  443  410  420  532
    ## 1993  433  421  410  512
    ## 1994  449  381  423  531
    ## 1995  426  408  416  520
    ## 1996  409  398  398  507
    ## 1997  432  398  406  526
    ## 1998  428  397  403  517
    ## 1999  435  383  424  521
    ## 2000  421  402  414  500
    ## 2001  451  380  416  492
    ## 2002  428  408  406  506
    ## 2003  435  380  421  490
    ## 2004  435  390  412  454
    ## 2005  416  403  408  482
    ## 2006  438  386  405  491
    ## 2007  427  383  394  473
    ## 2008  420  390  410  488
    ## 2009  415  398  419  488
    ## 2010  414  374

``` r
beer2 <- window(ausbeer, start=1992)
# Widow : 인덱스에 내가 따르기 위한 옵션
# start : 시계열 몇번째 원소부터 읽어드릴지 결정
# end : 어디까지 읽을지 결정
beer2 # 1992 년부터
```

    ##      Qtr1 Qtr2 Qtr3 Qtr4
    ## 1992  443  410  420  532
    ## 1993  433  421  410  512
    ## 1994  449  381  423  531
    ## 1995  426  408  416  520
    ## 1996  409  398  398  507
    ## 1997  432  398  406  526
    ## 1998  428  397  403  517
    ## 1999  435  383  424  521
    ## 2000  421  402  414  500
    ## 2001  451  380  416  492
    ## 2002  428  408  406  506
    ## 2003  435  380  421  490
    ## 2004  435  390  412  454
    ## 2005  416  403  408  482
    ## 2006  438  386  405  491
    ## 2007  427  383  394  473
    ## 2008  420  390  410  488
    ## 2009  415  398  419  488
    ## 2010  414  374

``` r
gglagplot(beer2) + 
  guides(colour=guide_legend(title="분기")) +
  ggtitle("")
```

![](Anal_TS_Base_files/figure-gfm/unnamed-chunk-13-1.png)<!-- --> - lag
4,8 의 경우 선형의 관계가 있음을 알 수 있다. - 이는 데이터가 4분기(1년), 8분기(2년) 마다 계절성이 강하다는것을
나타낸다

## acf 그래프

  - 자기상관 그래프

<!-- end list -->

``` r
ggAcf(beer2)
```

![](Anal_TS_Base_files/figure-gfm/unnamed-chunk-14-1.png)<!-- --> - 4 의
경우가 다른 시차보다 값이 높다. - 4 lag : 4개의 분기(년) 마다 나타나는 경향이 있다. - 2 lag : 2개의
분기 마다 큰 음수의 경향이 있다. - 이는 고점, 저점이 2개월마다 반복하면서 나타나기 때문이다.

# 분석 팁

  - 월별 일 수 조절
      - 월별 판매량 데이터가 있는데, 이 때애 나타나는 변동은 단순히 월별로 일 수가 달라서 생기는 경우일 수 있다.
      - 이런 경우를 제거하기 위해 monthdays 함수를 사용할 수 있다.

<!-- end list -->

``` r
dframe <- cbind(Monthly = milk,
                DailyAverage = milk/monthdays(milk))
colnames(dframe) <- c("월별", "일별 평균")
autoplot(dframe, facet = TRUE) +
  xlab("연도") + ylab("파운드") +
  ggtitle("젖소별 우유 생산량")
```

![](Anal_TS_Base_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

  - 인구 조절
      - 인구 변화에 영향을 받는 데이터를 1명당 데이터로 조절 가능하다.
      - 예시로 어떤 지역에서 1950\~1990 맥주 소비량을 조사한다고 하자. 이 기간에는 인구성장이 꾸준히 있었으므로
        당연히 맥주 소비량이 증가할 것이다. 이 때에 맥주 소비량을 인구로 나누어서 1명당 평균 맥주 소비량으로 새
        변수를 만들고 분석하는것이 더 의미있는 결론을 이끌어낼 것이다.
  - 인플레이션 조절
      - 돈의 가치에 영향을 받는 데이터도, 각 시점의 가치를 이용해 조절해야한다.
      - 정부 기관에서 가격 지수(소비자 가격지수)를 만드는데. 이를 이용해 normalizing 을 해야 할 것이다.
  - 분산 조절
      - log 변환 및 sqrt 변환으로 분산 안정화를 실시할 수 있다.
          - log 변환시 0보다 작은 값이 없게, 조절해주어야 한다.
      - 또는 Box-cox transformation 으로 분산 안정화를 실시할 수 있다.
      - 아래의 예시는 Box-cox Transformation 의 예시이다. 이를 통해서 계절성이 안정되어 있는 시계열을
        얻을 수 있다.
  - 최종 예측
      - 예측을 할 때에, 유의해야 할 사항은 우리가 구한 값은 변환을 한 값이라는 것이다. 꼭 예측값을 얻게 되면 원래
        scale 로 되돌려 주어야 한다.

<!-- end list -->

``` r
lambda <- BoxCox.lambda(elec)
autoplot(elec)
```

![](Anal_TS_Base_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

``` r
autoplot(BoxCox(elec,lambda)) 
```

![](Anal_TS_Base_files/figure-gfm/unnamed-chunk-16-2.png)<!-- -->

  - 더 안정된 모습을 볼 수 있다.

# Basic Analysis

  - Basic 으로 적용할 수 있는 Analysis 를 기본값으로 둔 후에, 다른 다양한 model 들을 fitting 이
    basic 모델과 비교하면 좋은 모델을 고를 수 있다.

![images](./Images/TS_Mean.PNG)

![images](./Images/TS_Naive.PNG)

![images](./Images/TS_Seasonal%20Naive.PNG)

![images](./Images/TS_Drift.PNG)

``` r
# Set training data from 1992 to 2007
beer2 <- window(ausbeer,start=1992,end=c(2007,4))
# Plot some forecasts
autoplot(beer2) +
  autolayer(meanf(beer2, h=11),
    series="평균", PI=FALSE) +
  autolayer(naive(beer2, h=11),
    series="단순", PI=FALSE) +
  autolayer(snaive(beer2, h=11),
    series="계절성 단순", PI=FALSE) +
  autolayer(rwf(beer2, h=11,drift = TRUE),
    series="Drift", PI=FALSE) +
  ggtitle("분기별 맥주 생산량 예측값") +
  xlab("연도") + ylab("단위: 백만 리터") +
  guides(colour=guide_legend(title="예측"))
```

![](Anal_TS_Base_files/figure-gfm/unnamed-chunk-17-1.png)<!-- -->

``` r
googfc1 <- meanf(goog200, h=40)
googfc2 <- rwf(goog200, h=40)
googfc3 <- rwf(goog200, drift=TRUE, h=40)
autoplot(subset(goog, end = 240)) +
  forecast::autolayer(googfc1, PI=FALSE, series="평균") +
  forecast::autolayer(googfc2, PI=FALSE, series="단순") +
  forecast::autolayer(googfc3, PI=FALSE, series="표류") +
  xlab("날짜") + ylab("종가(미국 달러)") +
  ggtitle("구글 일별 주가 (2013년 12월 6일까지)") +
  guides(colour=guide_legend(title="예측"))
```

![](Anal_TS_Base_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->

Accuracy 라는 method(forcast) 를 통해서, 내 예측을 평가할 수 있다.

``` r
googtest <- window(goog, start=201, end=240)
accuracy(googfc1, googtest)
```

    ##                         ME      RMSE       MAE        MPE     MAPE      MASE
    ## Training set -4.296286e-15  36.91961  26.86941 -0.6596884  5.95376  7.182995
    ## Test set      1.132697e+02 114.21375 113.26971 20.3222979 20.32230 30.280376
    ##                   ACF1 Theil's U
    ## Training set 0.9668981        NA
    ## Test set     0.8104340  13.92142

``` r
accuracy(googfc2, googtest)
```

    ##                      ME      RMSE       MAE       MPE      MAPE     MASE
    ## Training set  0.6967249  6.208148  3.740697 0.1426616 0.8437137 1.000000
    ## Test set     24.3677328 28.434837 24.593517 4.3171356 4.3599811 6.574582
    ##                     ACF1 Theil's U
    ## Training set -0.06038617        NA
    ## Test set      0.81043397  3.451903

``` r
accuracy(googfc3, googtest)
```

    ##                         ME      RMSE       MAE         MPE      MAPE     MASE
    ## Training set -5.998536e-15  6.168928  3.824406 -0.01570676 0.8630093 1.022378
    ## Test set      1.008487e+01 14.077291 11.667241  1.77566103 2.0700918 3.119002
    ##                     ACF1 Theil's U
    ## Training set -0.06038617        NA
    ## Test set      0.64732736  1.709275

# 예측 정확도 평가

  - 이 경우에도, 기본적으로 Training data 와 Test data 두 부분으로 나누어서 진행해야 한다.
  - 단 시계열 이기 떄문에 우리는 random 으로 데이터를 추출할 수는 없고, 맨 뒤 부분의 20% 정도를 TEST Set
    으로 설정한다.
  - 기본적으로 test data 는 약 20% 정도로 맞춘다.

![images](./Images/TS_Train%20Test.PNG)

## 일부분을 선택하는 함수

``` r
# window 를 통해서 1995년 이후의 데이터를 선택한 모습
window(ausbeer, start=1995)
```

    ##      Qtr1 Qtr2 Qtr3 Qtr4
    ## 1995  426  408  416  520
    ## 1996  409  398  398  507
    ## 1997  432  398  406  526
    ## 1998  428  397  403  517
    ## 1999  435  383  424  521
    ## 2000  421  402  414  500
    ## 2001  451  380  416  492
    ## 2002  428  408  406  506
    ## 2003  435  380  421  490
    ## 2004  435  390  412  454
    ## 2005  416  403  408  482
    ## 2006  438  386  405  491
    ## 2007  427  383  394  473
    ## 2008  420  390  410  488
    ## 2009  415  398  419  488
    ## 2010  414  374

``` r
# subset 을 통해서, 뒷부분의 20% 를 Test data 로 설정한 모습
subset(ausbeer, start=floor(0.8*length(ausbeer))) 
```

    ##      Qtr1 Qtr2 Qtr3 Qtr4
    ## 1999       383  424  521
    ## 2000  421  402  414  500
    ## 2001  451  380  416  492
    ## 2002  428  408  406  506
    ## 2003  435  380  421  490
    ## 2004  435  390  412  454
    ## 2005  416  403  408  482
    ## 2006  438  386  405  491
    ## 2007  427  383  394  473
    ## 2008  420  390  410  488
    ## 2009  415  398  419  488
    ## 2010  414  374

``` r
# tail 함수를 이용해서 뒷부분 20개의 함수를 선택할 수 도 있다.
tail(ausbeer, n = 20)
```

    ##      Qtr1 Qtr2 Qtr3 Qtr4
    ## 2005            408  482
    ## 2006  438  386  405  491
    ## 2007  427  383  394  473
    ## 2008  420  390  410  488
    ## 2009  415  398  419  488
    ## 2010  414  374

``` r
# 1분기 모든값을 선택
subset(ausbeer, quarter = 1)
```

    ## Time Series:
    ## Start = 1956 
    ## End = 2010 
    ## Frequency = 1 
    ##  [1] 284 262 272 261 286 295 279 294 313 331 335 353 393 383 387 410 419 458 465
    ## [20] 500 510 486 515 503 513 548 493 475 453 464 459 481 474 467 485 464 443 433
    ## [39] 449 426 409 432 428 435 421 451 428 435 435 416 438 427 420 415 414

## 시계열 Cross validation

  - 아래 그림에서 빨간색 데이터는 test data 이고, 파란색 데이터는 Training data 이다.
  - 예측 데이터는 테스트 데이터에 대한 평균으로 저장된다.

![images](./Images/TS_Cross%20validation.PNG)

  - 이를 구현하는 함수는 tsCV() 함수로 구현되다. -잔차 RMSE 와 CV 를 통해 얻은RMSE 를 비교하여 보자.

<!-- end list -->

``` r
# RMSE
e <- tsCV(goog200, # CV를 적용할 Full data 
          rwf, drift=TRUE, # 모델
          h=10, # 예측범위(10단계 후를 계측)
          initial = round(0.8*length(goog200))) # 80% 의 데이터가 있을때부터 cv 진행
sqrt(mean(e^2, na.rm=TRUE))
```

    ## [1] 23.1204

``` r
googfc3 <- rwf(goog200[1:190], drift=TRUE, h=10)
accuracy(googfc3,goog200[191:200])
```

    ##                        ME     RMSE      MAE         MPE      MAPE    MASE
    ## Training set 6.917244e-15 6.275812 3.853798 -0.01424908 0.8752871 1.02037
    ## Test set     6.982516e+00 7.963858 7.327003  1.32575943 1.3929620 1.93997
    ##                     ACF1
    ## Training set -0.06436653
    ## Test set              NA

  - 뒤의 190개의 sample 만을 이용한 후, 191\~200 개에 대해 예측을 진행한 경우의 RMSE 가 더 적은 값을
    가진다.
  - 하지만 그 정확도는 CV 가 더 좋을것이다.

# 시계열 분해

  - 시계열을 stl 이라는 방법으로 계절성과 트랜드를 분해해 볼 수 있다.
  - 분석에는 큰 도움이 되지 않으나, 어떤 식으로 시계열이 생겼고 분해 될 수 있는지에 대해 insight 를 제공해준다.

<!-- end list -->

``` r
elecequip %>%
  stl(t.window=13, s.window="periodic", robust=TRUE) %>%
  autoplot()
```

![](Anal_TS_Base_files/figure-gfm/unnamed-chunk-26-1.png)<!-- --> -
t.window : 추세-주기를 추정할 때 사용할 연이은 관측값의 갯수 (홀수) - s.window : 계절성분에서 각 값을
추정할때 사용할 관측값의 갯수 (홀수) - 두 값이 작을수록 급격하게 변화한다.
