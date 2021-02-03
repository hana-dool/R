NA\_imputation
================

  - 결측치가 존재하게 되면 R 에서는계산도 하지 않게 될 뿐더러 많은 통계패키지를 적용할 수 없다. <br>
  - hair et al.(2006) 에 의하면 결측치 비율에 따라 추천하는 처리 방법이 있다.
      - 10% 미만 : 제거, 어떠한 방법이든지 상관없음
      - 10\~20% : hot deck, regression, Model based
      - 20% 이상 : model based method, regression
  - Missing value는 3가지가 존재하는데
      - Missing comlpletely at random(MCAR) : 동전던지기 처럼 완전한 랜덤
      - Missing at random(MAR) : missing data 가 observed data 에 depend
        하지만 non observed 데이터에는 의존하지 않음
      - Missing not at random(MNAR) : Non-ignorable missing 으로서 not
        observed,observed data 에 depend 하는 missing 데이터
  - 이 때에 Missing 이 MAR 이면, 데이터로부터 효율적인 Imputation 이 가능하겠지만 MNAR 의 경우
    처리하기가 쉽지 않다.
  - 통계적 방법을 쓰려면 ignorable(MCAR,MAR) 이라 가정하고 하는 경우가 많다. (그러면 식이 단순해짐)
  - NA 를 처리하는 방법은 매우 많다.
      - 통계적 분포를 가정한 뒤 EM 알고리즘이나, Mice 패키지 등을 사용해서 대체할 수 있다.
      - KNN 방법을 쓸 수 있다.
          - 이 때 variable 이 많게되면 그 성능에 문제가 있게된다.
          - 그래서 FA, PCA 등으로 Dimension reduction 이후에 진행하기도 한다.
      - CIA 가정으로 Regression 을 쓸 수 있다.
          - CIA 가정이란, conditional indipendence assumption 으로서, 예를 들어 변수
            X,Y,Z가 있다고 하자. 그리고 Y,Z 에 NA가 섞여 있다고 하자.
          - 세 변수는 완벽히 독립은 아닐것이다.(실제 데이터가 그렇듯) 하지만 (Y|X)ㅛ(Z|X) 가
            보장된다면(CIA 가정) X 의 데이터만으로 Y에 Regression 을 적합시켜서 Z 값
            없이 Y 의 NA를 채울 수 있을것이다.
          - 위 가정은 Test 할 수 없다는게 단점이다. 현실적인 Insight 에 합리적이 되게 CIA 가정을
            이용해야 할 것이다.
  - Na 를 채우려면 우선 다음과 같은 고려를 해야할 것이다.
      - 모을수 있는 데이터는 모두 모은다.
          - ex) 지하철 승하차 인원이 2015년 1\~4월 이 NA 라 하자. 그에 반해 버스 승차하 인원은
            2015년 1\~9월 데이터만 있다고 하자. 그렇다면 둘이 비슷한 성질을 가짐을 이용해서 지하철 승하차
            인원을 버스 승하차 인원을 이용해 채울 수 있을것
      - Variable 끼리 어떤 관계가 있는지 충분한 사전지식을 수집한다.
          - 예로 BMI 는 Weight/height^2 이다. 이는 BMI 는 키와 몸무게로 채울 수 있는 변수임을 알
            수 있다.
      - 충분한 EDA 를 통해서 규칙을 발견해라.
          - 예를들어 차의 2000년,2001년 평점이 NA 라 하자. EDA 를 통해서 브랜드의 ‘종류’ 에 따라
            평점이 비슷하다는 결과가 나오면, 브랜드별로 Grouping 한 뒤에 NA 를 채울 수
            있을것이다.

# Built in 함수

먼저 매우 기초적인 방법들을 살펴보자.

## 결측치 살펴보기

``` r
load(file = "./Data/acs.rda")
library('MASS')

#summary : summary 를 해도 NA 의 수를 모두 나타내준다.
summary(acs)
```

    ##       age            sex            cardiogenicShock      entry          
    ##  Min.   :28.00   Length:857         Length:857         Length:857        
    ##  1st Qu.:55.00   Class :character   Class :character   Class :character  
    ##  Median :64.00   Mode  :character   Mode  :character   Mode  :character  
    ##  Mean   :63.31                                                           
    ##  3rd Qu.:72.00                                                           
    ##  Max.   :91.00                                                           
    ##                                                                          
    ##       Dx                  EF            height          weight      
    ##  Length:857         Min.   :18.00   Min.   :130.0   Min.   : 30.00  
    ##  Class :character   1st Qu.:50.45   1st Qu.:158.0   1st Qu.: 58.00  
    ##  Mode  :character   Median :58.10   Median :165.0   Median : 65.00  
    ##                     Mean   :55.83   Mean   :163.2   Mean   : 64.84  
    ##                     3rd Qu.:62.35   3rd Qu.:170.0   3rd Qu.: 72.00  
    ##                     Max.   :79.00   Max.   :185.0   Max.   :112.00  
    ##                     NA's   :134     NA's   :93      NA's   :91      
    ##       BMI          obesity                TC             LDLC      
    ##  Min.   :15.62   Length:857         Min.   : 25.0   Min.   : 15.0  
    ##  1st Qu.:22.13   Class :character   1st Qu.:154.0   1st Qu.: 88.0  
    ##  Median :24.16   Mode  :character   Median :183.0   Median :114.0  
    ##  Mean   :24.28                      Mean   :185.2   Mean   :116.6  
    ##  3rd Qu.:26.17                      3rd Qu.:213.0   3rd Qu.:141.0  
    ##  Max.   :41.42                      Max.   :493.0   Max.   :366.0  
    ##  NA's   :93                         NA's   :23      NA's   :24     
    ##       HDLC             TG             DM                HBP           
    ##  Min.   : 4.00   Min.   : 11.0   Length:857         Length:857        
    ##  1st Qu.:32.00   1st Qu.: 68.0   Class :character   Class :character  
    ##  Median :38.00   Median :105.5   Mode  :character   Mode  :character  
    ##  Mean   :38.24   Mean   :125.2                                        
    ##  3rd Qu.:45.00   3rd Qu.:154.0                                        
    ##  Max.   :89.00   Max.   :877.0                                        
    ##  NA's   :23      NA's   :15                                           
    ##    smoking         
    ##  Length:857        
    ##  Class :character  
    ##  Mode  :character  
    ##                    
    ##                    
    ##                    
    ## 

``` r
#is.na() # TRUE/FLASE 로 모두 나타내준다
head(is.na(acs))
```

    ##        age   sex cardiogenicShock entry    Dx    EF height weight   BMI obesity
    ## [1,] FALSE FALSE            FALSE FALSE FALSE FALSE  FALSE  FALSE FALSE   FALSE
    ## [2,] FALSE FALSE            FALSE FALSE FALSE FALSE  FALSE  FALSE FALSE   FALSE
    ## [3,] FALSE FALSE            FALSE FALSE FALSE FALSE   TRUE   TRUE  TRUE   FALSE
    ## [4,] FALSE FALSE            FALSE FALSE FALSE FALSE  FALSE  FALSE FALSE   FALSE
    ## [5,] FALSE FALSE            FALSE FALSE FALSE FALSE  FALSE  FALSE FALSE   FALSE
    ## [6,] FALSE FALSE            FALSE FALSE FALSE FALSE  FALSE  FALSE FALSE   FALSE
    ##         TC  LDLC  HDLC    TG    DM   HBP smoking
    ## [1,] FALSE FALSE FALSE FALSE FALSE FALSE   FALSE
    ## [2,]  TRUE  TRUE  TRUE FALSE FALSE FALSE   FALSE
    ## [3,]  TRUE  TRUE  TRUE  TRUE FALSE FALSE   FALSE
    ## [4,] FALSE FALSE FALSE FALSE FALSE FALSE   FALSE
    ## [5,] FALSE FALSE FALSE FALSE FALSE FALSE   FALSE
    ## [6,] FALSE FALSE FALSE FALSE FALSE FALSE   FALSE

``` r
#sum(is.na()) : 곁측값이 총 몇개인지 게산
sum(is.na(Cars93)) # 곁측값이 총 몇개인지 게산
```

    ## [1] 13

``` r
#colSums(is.na()) : colsum 으로 각 데이터의 col 의 곁측치 계산
colSums(is.na(Cars93))
```

    ##       Manufacturer              Model               Type          Min.Price 
    ##                  0                  0                  0                  0 
    ##              Price          Max.Price           MPG.city        MPG.highway 
    ##                  0                  0                  0                  0 
    ##            AirBags         DriveTrain          Cylinders         EngineSize 
    ##                  0                  0                  0                  0 
    ##         Horsepower                RPM       Rev.per.mile    Man.trans.avail 
    ##                  0                  0                  0                  0 
    ## Fuel.tank.capacity         Passengers             Length          Wheelbase 
    ##                  0                  0                  0                  0 
    ##              Width        Turn.circle     Rear.seat.room       Luggage.room 
    ##                  0                  0                  2                 11 
    ##             Weight             Origin               Make 
    ##                  0                  0                  0

## 결측치 제외 및 제거

``` r
#na.rm=TRUE : 곁측값을 통계분석시 제외 
sum(Cars93$Luggage.room) # 곁측값이 있으면 분석이 안된다.
```

    ## [1] NA

``` r
sum(Cars93$Luggage.room, na.rm=TRUE) # 곁측값 있어도 통계분석 가능
```

    ## [1] 1139

``` r
#na.omit() : 곁측값이 들어있는 행을 분석에서 제외
Cars93_new <-na.omit(Cars93)
sum(is.na(Cars93_new)) # 곁측값이 없어진것을 볼 수 있다.
```

    ## [1] 0

``` r
# 아래 작업을 통해서 곁측치 제거 후 row 들의 index 를 초기화 할 수 있다.
row.names(Cars93_new) <- NULL
tail(Cars93_new)
```

    ##    Manufacturer   Model    Type Min.Price Price Max.Price MPG.city MPG.highway
    ## 77       Toyota   Camry Midsize      15.2  18.2      21.2       22          29
    ## 78   Volkswagen     Fox   Small       8.7   9.1       9.5       25          33
    ## 79   Volkswagen  Passat Compact      17.6  20.0      22.4       21          30
    ## 80   Volkswagen Corrado  Sporty      22.9  23.3      23.7       18          25
    ## 81        Volvo     240 Compact      21.8  22.7      23.5       21          28
    ## 82        Volvo     850 Midsize      24.8  26.7      28.5       20          28
    ##               AirBags DriveTrain Cylinders EngineSize Horsepower  RPM
    ## 77        Driver only      Front         4        2.2        130 5400
    ## 78               None      Front         4        1.8         81 5500
    ## 79               None      Front         4        2.0        134 5800
    ## 80               None      Front         6        2.8        178 5800
    ## 81        Driver only       Rear         4        2.3        114 5400
    ## 82 Driver & Passenger      Front         5        2.4        168 6200
    ##    Rev.per.mile Man.trans.avail Fuel.tank.capacity Passengers Length Wheelbase
    ## 77         2340             Yes               18.5          5    188       103
    ## 78         2550             Yes               12.4          4    163        93
    ## 79         2685             Yes               18.5          5    180       103
    ## 80         2385             Yes               18.5          4    159        97
    ## 81         2215             Yes               15.8          5    190       104
    ## 82         2310             Yes               19.3          5    184       105
    ##    Width Turn.circle Rear.seat.room Luggage.room Weight  Origin
    ## 77    70          38           28.5           15   3030 non-USA
    ## 78    63          34           26.0           10   2240 non-USA
    ## 79    67          35           31.5           14   2985 non-USA
    ## 80    66          36           26.0           15   2810 non-USA
    ## 81    67          37           29.5           14   2985 non-USA
    ## 82    69          38           30.0           15   3245 non-USA
    ##                  Make
    ## 77       Toyota Camry
    ## 78     Volkswagen Fox
    ## 79  Volkswagen Passat
    ## 80 Volkswagen Corrado
    ## 81          Volvo 240
    ## 82          Volvo 850

``` r
#complete.cases() : 특정행과 열에 결측값이 들어있는 행을 데이터셋에서 제거
new<-Cars93[complete.cases
          (Cars93[ ,c('Rear.seat.room')]) , ] # Cars93 데이터 프레임의 Rear.seat.room 칼럼 내 결측값이 있는 행 전체 삭제
dim(Cars93)
```

    ## [1] 93 27

``` r
dim(new) # rear seat room 에서 NA 값이였던 2개의 관측치가 없어져서 row 가 2 줄었다. 
```

    ## [1] 91 27

## 결측치 대체

``` r
#data$col[is.na(data$col)] <- 새로운값 : 새로운값으로 col 의 곁측치 대체
mean<-mean(Cars93$Luggage.room, na.rm=TRUE) # 곁측값 미포함한 col 의 mean
Cars93$Luggage.room[is.na(Cars93$Luggage.room)] <- mean #mean 으로 대체

#sapply(data, functio(x){ifelse}(is.na(x), 대체하고픈값, x )) # 모든 col 에 대해 새로운 값으로 col 곁측치 대체 
df_imputed = sapply(Cars93, function(x){ifelse(is.na(x), mean(x, na.rm=TRUE), x)}) #sapply라 각 col 의 mean 으로 대체된다.
head(df_imputed)
```

    ##      Manufacturer Model Type Min.Price Price Max.Price MPG.city MPG.highway
    ## [1,]            1    49    4      12.9  15.9      18.8       25          31
    ## [2,]            1    56    3      29.2  33.9      38.7       18          25
    ## [3,]            2     9    1      25.9  29.1      32.3       20          26
    ## [4,]            2     1    3      30.8  37.7      44.6       19          26
    ## [5,]            3     6    3      23.7  30.0      36.2       22          30
    ## [6,]            4    24    3      14.2  15.7      17.3       22          31
    ##      AirBags DriveTrain Cylinders EngineSize Horsepower  RPM Rev.per.mile
    ## [1,]       3          2         2        1.8        140 6300         2890
    ## [2,]       1          2         4        3.2        200 5500         2335
    ## [3,]       2          2         4        2.8        172 5500         2280
    ## [4,]       1          2         4        2.8        172 5500         2535
    ## [5,]       2          3         2        3.5        208 5700         2545
    ## [6,]       2          2         2        2.2        110 5200         2565
    ##      Man.trans.avail Fuel.tank.capacity Passengers Length Wheelbase Width
    ## [1,]               2               13.2          5    177       102    68
    ## [2,]               2               18.0          5    195       115    71
    ## [3,]               2               16.9          5    180       102    67
    ## [4,]               2               21.1          6    193       106    70
    ## [5,]               2               21.1          4    186       109    69
    ## [6,]               1               16.4          6    189       105    69
    ##      Turn.circle Rear.seat.room Luggage.room Weight Origin Make
    ## [1,]          37           26.5           11   2705      2    1
    ## [2,]          38           30.0           15   3560      2    2
    ## [3,]          37           28.0           14   3375      2    4
    ## [4,]          37           31.0           17   3405      2    3
    ## [5,]          39           27.0           13   3640      2    5
    ## [6,]          41           28.0           16   2880      1    6

# NA 시각화

## NA 의 Variable 별 수

Na 를 APPLY 함수를 써서 column 만 보려고 한다. <br> 이때 is.na 로 na 가 있을때에는 True 를
출력하게 한 다음 sum 을 하는 function 을 만든다.

``` r
load(file = "./Data/acs.rda")
na.count=apply(acs,2,function(x) sum(is.na(x)))
na.count[na.count>0]
```

    ##     EF height weight    BMI     TC   LDLC   HDLC     TG 
    ##    134     93     91     93     23     24     23     15

``` r
barplot(na.count[na.count>0])
```

![](Pro_NA-imputation_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

## NA 패턴분석

``` r
require(VIM)
aggr(acs,prop=FALSE,numbers=TRUE,cex.axis=0.8)
```

![](Pro_NA-imputation_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

패턴을 보아 하니 EF 단독으로 NA 가 있는 경우가 많고, 그 다음에 EF,Height,Weight,Bmi 가 공란인 경우도
많았다. 아마 기초적인 검사를 한꺼번에(키,몸무게) 하지 않은듯 하다. <br>

## NA 산점도 분석

  - 아래의 경우는 EF와 BMI 의 경우에 Missing 이 어떻게 분포되어있는지를 보여준다. <br>
  - 회색 점들은 관측된 데이터이다. <br>
  - 빨간색 점들은 Missing 이 ‘발생하였을 떄’ EF, BMI 값들은 어떤 값이였는지를 알려주는 것이다.

<!-- end list -->

``` r
marginplot(acs[c("BMI","age")],pch=20,col=c("darkgray","red","blue"))
```

![](Pro_NA-imputation_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

  - BMI 에 대해서 Missing 이 발생하였을 떄, age 의 분포는 나이가 든 사람이 많아보였다는것이다. <br>
  - 즉 나이가 든 사람은 BMI 의 측정을 싫어한다?(정말 조약한 논리지만) 이라고도 볼 수 있다.
  - 그리고 BMI 왼편에 있는 숫자는, BMI 에 대해서 얼마나 많은 NA 가 발생하였는지를 알려준다.

<!-- end list -->

``` r
marginplot(acs[c('EF',"BMI")],pch=20,col=c("darkgray","red","blue"))
```

![](Pro_NA-imputation_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

  - 이 경우는 BMI 와 EF 의 조합이 총 59번 Missing 이 일어났다는 것이다. <br>
  - EF 가 Missing 인 경우 BMI 는 높은쪽이 많았다. 즉 비만인 사람이 EF 측정을 싫어한다고 볼 수 있다.

## 누락된 자료의 상관관계

누락된 자료일 경우 1 을 넣고, 그렇지 않은 경우 0 을 넣은 뒤 상관계수를 볼 수 있다. <br> 상관계수를 보고 난 뒤에,
Mssing 끼리 어떤 관계가 있는지 추측 가능하다.

``` r
x=as.data.frame(abs(is.na(acs)))
y=apply(x,2,function(x) sum(x)>0)
round(cor(x[y]),2)
```

    ##          EF height weight  BMI   TC LDLC HDLC   TG
    ## EF     1.00   0.46   0.45 0.46 0.13 0.12 0.13 0.11
    ## height 0.46   1.00   0.99 1.00 0.20 0.19 0.20 0.21
    ## weight 0.45   0.99   1.00 0.99 0.20 0.19 0.20 0.21
    ## BMI    0.46   1.00   0.99 1.00 0.20 0.19 0.20 0.21
    ## TC     0.13   0.20   0.20 0.20 1.00 0.98 1.00 0.75
    ## LDLC   0.12   0.19   0.19 0.19 0.98 1.00 0.98 0.73
    ## HDLC   0.13   0.20   0.20 0.20 1.00 0.98 1.00 0.75
    ## TG     0.11   0.21   0.21 0.21 0.75 0.73 0.75 1.00

``` r
library(corrplot)
corrplot(cor(x[y]), method = "color", addCoef.col="grey", order = "AOE")
```

![](Pro_NA-imputation_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

  - BMI , Height, Weight 는 상관관계가 거의 1이다.
  - LDLC , TC, HDLC, TG 끼리는 거의 상관관계가 1이다.
  - 이는 BMI = Weight / Height^2 공식과 LDLC = TC-HDLC-TG/5 공식 때문에, 이미 데이터 제공
    측에서 어느정도 계산을 해서 채워넣은듯 하다.

# NA Analysis 의 종류

  - Listwise deletion(Complete-case analysis) : 모든 변수들이 다 채워진 관측치만 이용해서
    분석을 진행
      - 한개라도 누락이 있는 자료는 제거한다.
      - 많은 통계 프로그램에서 default 로 되어있는 방법이다.
      - 그래서 NA 분석을 하지 않고 바로 Analysis 를 진행할 경우 NA 가 있다는 사실조차 까먹을 수 있음
  - pairwise deletion : NA 값이 있는 관측치를 모두 제거하는것이 아니라 방법에 따라 각 쌍의 변수들에 대해
    누락된 자료만을 제거

<!-- end list -->

``` r
acs_listwise=na.omit(acs) ; dim(acs_listwise) # 677개
```

    ## [1] 677  17

``` r
acs_pairwise=na.omit(acs[c('EF','BMI')]) ; dim(acs_pairwise) # 689개
```

    ## [1] 689   2

``` r
# lm 의 경우 pairwise 를 default 로 한다는것을 볼 수 있다.
summary(lm(EF~BMI,data=acs))
```

    ## 
    ## Call:
    ## lm(formula = EF ~ BMI, data = acs)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -38.157  -4.860   2.031   6.427  24.090 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  49.4581     2.6130  18.928   <2e-16 ***
    ## BMI           0.2626     0.1069   2.457   0.0143 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 9.453 on 687 degrees of freedom
    ##   (168 observations deleted due to missingness)
    ## Multiple R-squared:  0.008709,   Adjusted R-squared:  0.007266 
    ## F-statistic: 6.036 on 1 and 687 DF,  p-value: 0.01427

``` r
summary(lm(EF~BMI,data=acs_listwise))
```

    ## 
    ## Call:
    ## lm(formula = EF ~ BMI, data = acs_listwise)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -38.274  -4.862   1.983   6.375  23.917 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  49.8760     2.5996  19.186   <2e-16 ***
    ## BMI           0.2508     0.1064   2.358   0.0187 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 9.351 on 675 degrees of freedom
    ## Multiple R-squared:  0.00817,    Adjusted R-squared:  0.0067 
    ## F-statistic:  5.56 on 1 and 675 DF,  p-value: 0.01866

``` r
summary(lm(EF~BMI,data=acs_pairwise))
```

    ## 
    ## Call:
    ## lm(formula = EF ~ BMI, data = acs_pairwise)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -38.157  -4.860   2.031   6.427  24.090 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  49.4581     2.6130  18.928   <2e-16 ***
    ## BMI           0.2626     0.1069   2.457   0.0143 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 9.453 on 687 degrees of freedom
    ## Multiple R-squared:  0.008709,   Adjusted R-squared:  0.007266 
    ## F-statistic: 6.036 on 1 and 687 DF,  p-value: 0.01427

**Listwise**

  - Listwise deletion은 자료가 MCAR 인 것을 전제로 한다. 즉, complete observation이 전체
    데이터의 random subsample임을 전제로 한다.
  - 우리가 listwise deletion을 한다는 것은 677명의 환자 데이터가 전체 857명의 데이터의 random
    subsample임을 전제한다.
  - MCAR 가정이 흔들리는 정도에 따라 회귀분석의 계수는 편향되어 나타나게 된다(biased).
      - ex) 설문조사에서 정치성향 조사란에 보수 성향의 사람들은 공란으로 남기는 경향이 크다. 이는 데이터가 MACR 이
        아니라 MAR 또는 MNAR 이라는 의미로서 이 NA를 모두 제거한다면 보수성향의 사람을 대부분 제외하는것이므로
        편향이 나타날 수 있다는것
  - 또한 누락된 값이 있는 모든 관측치를 제거함으로써 sample size가 줄어들기 때문에 통계의 검정력(power)이
    줄어들게 된다. 이 모형에서는 listwise deletion을 통해 sample size가 21% 줄어들었다.

**Pairwise**

  - pairwise 는 통계량 계산에 필요한 variable 이 채워져 있으면 그냥 사용한다.

<!-- end list -->

``` r
round(cor(acs[c("EF","BMI","LDLC")],use="pairwise.complete.obs"),3)
```

    ##         EF   BMI  LDLC
    ## EF   1.000 0.093 0.033
    ## BMI  0.093 1.000 0.086
    ## LDLC 0.033 0.086 1.000

  - EF는 모두 134 개가 누락되어 있고 BMI는 93, LDLC는 24, 의 누락이 있다 그러므로 EF-BMI의 분석에는
    688 개, EF-LDLC의 분석에는 707 개가 사용되었고 BMI-LDLC의 분석에는 750 개가 사용되었다.
  - 이는 분석가능한 모든 데이터를 사용한다는 장점이 있지만 결정적으로 분석의 Sample space 가 각기 다르기 때문에
    분석 결과를 통합해서 해석하기가 어렵다.

# KNN imputation

  - KNN 은 매우 간단한 알고리즘이다. Acol 이 NA가 있는 데이터 에 대해, Acol 이 채워져 있는 데이터 중
    ‘비슷한’ k 개의 데이터를 찾는다. 그 데이터들에 대해 k 개의 Acol 의 값을 평균내서 NA 로 사용
  - 비모수적(통계모형이 아닌) 방법론이며 구현이 매우 쉽다.
  - 하지만 Data structure 를 고려하지 않은 Imputation 이다.
  - 변수가 많아질 경우, 그 정확도가 매우 떨어진다.

<!-- end list -->

``` r
library(VIM)
# 임의로 NA 형성
df <- acs
df[,'smoking'][sample(1:nrow(df),50)] <- NA
# 10 개의 neighborhood 를 사용
# Categorical data 도 알아서 척척 impute 해준다.
df_imputed= kNN(df,k = 10)
head(df_imputed)
```

    ##   age    sex cardiogenicShock   entry              Dx   EF height weight
    ## 1  62   Male               No Femoral           STEMI 18.0    168   72.0
    ## 2  78 Female               No Femoral           STEMI 18.4    148   48.0
    ## 3  76 Female              Yes Femoral           STEMI 20.0    160   62.5
    ## 4  89 Female               No Femoral           STEMI 21.8    165   50.0
    ## 5  56   Male               No  Radial          NSTEMI 21.8    162   64.0
    ## 6  73 Female               No  Radial Unstable Angina 22.0    153   59.0
    ##        BMI obesity  TC LDLC HDLC  TG  DM HBP smoking age_imp sex_imp
    ## 1 25.51020     Yes 215  154   35 155 Yes  No  Smoker   FALSE   FALSE
    ## 2 21.91381      No 174   98   43 166  No Yes   Never   FALSE   FALSE
    ## 3 23.80897      No 173  109   42  88  No Yes   Never   FALSE   FALSE
    ## 4 18.36547      No 121   73   20  89  No  No   Never   FALSE   FALSE
    ## 5 24.38653      No 195  151   36  63 Yes Yes  Smoker   FALSE   FALSE
    ## 6 25.20398     Yes 184  112   38 137 Yes Yes   Never   FALSE   FALSE
    ##   cardiogenicShock_imp entry_imp Dx_imp EF_imp height_imp weight_imp BMI_imp
    ## 1                FALSE     FALSE  FALSE  FALSE      FALSE      FALSE   FALSE
    ## 2                FALSE     FALSE  FALSE  FALSE      FALSE      FALSE   FALSE
    ## 3                FALSE     FALSE  FALSE  FALSE       TRUE       TRUE    TRUE
    ## 4                FALSE     FALSE  FALSE  FALSE      FALSE      FALSE   FALSE
    ## 5                FALSE     FALSE  FALSE  FALSE      FALSE      FALSE   FALSE
    ## 6                FALSE     FALSE  FALSE  FALSE      FALSE      FALSE   FALSE
    ##   obesity_imp TC_imp LDLC_imp HDLC_imp TG_imp DM_imp HBP_imp smoking_imp
    ## 1       FALSE  FALSE    FALSE    FALSE  FALSE  FALSE   FALSE       FALSE
    ## 2       FALSE   TRUE     TRUE     TRUE  FALSE  FALSE   FALSE       FALSE
    ## 3       FALSE   TRUE     TRUE     TRUE   TRUE  FALSE   FALSE       FALSE
    ## 4       FALSE  FALSE    FALSE    FALSE  FALSE  FALSE   FALSE       FALSE
    ## 5       FALSE  FALSE    FALSE    FALSE  FALSE  FALSE   FALSE       FALSE
    ## 6       FALSE  FALSE    FALSE    FALSE  FALSE  FALSE   FALSE       FALSE

# Multiple imputation(mice)

**MICE**

  - Multiple imputation 은 시뮬레이션을 통해서 누락된 데이터를 채워넣는다.
    1.  먼저 imputed dataset을 여러개 만든다. (pluasible 한)
          - 이떄 각 데이터는 우리가 정한 imputed 모델을 Gibbs sampling 을 통해 근사한 뒤 그
            모델에서 만들어진다.
    2.  각자의 dataset 에서 각종 통계분석을 시행
    3.  각 imputed data set 에서 별도로 분석한 결과를 pooling 한다.
  - Practical Steps
    1.  Missing data 의 패턴 분석
    2.  Imputation 형성
          - Mice 의 장점은 연속변수,범주형 변수를 자동으로 인식하여 적절한 imputation method 를 사용
    3.  Diagnostic check
          - convergence 여부 체크
    4.  imputed dataset 에서 impausibla 한 값 제거
          - 남자가 임신한 데이터라든지, 4살이 결혼한 경우 등…
    5.  Analysis 와 Pooling
  - 고려해야 할 사항
    1.  MAR assumption 이 충족되는지?
          - 관측하지 못했던 변수에 NA 가 Depend 하는 MNAR 의 상황이 존재할 수 있다. 이런 경우 현제
            데이터로만 NA 를 채우는 방법을 쓰게 된다면 MAR 을 가정하고 채우는 것으로, MNAR
            상황에서는 부적절한 방법일 것이다.
    2.  imputation 을 수행하기 위한 predictor 결정
          - 즉 얼마나 많은 주변 변수를 이용해 na 가 있는 변수를 채워야 하는지에 대한것.
          - 많으면 많을수록 좋다고는 하는데, computational 적인 문제 등이 있어 15\~25개 정도면
            충분하다고 한다.(van Buuren)
    3.  어떤 순서로 imputation 을 해야할까?
          - Mice 는 기본적으로 왼쪽부터 오른쪽으로 imputation 을 한다.
          - 문제가 되는 이유는 NA 를 채워야 하는 변수는 동시에 predictor 도 되기때문에 다른 변수의 NA 를
            채울때 영향을 주기 때문.
    4.  Imputed dataset 은 몇개?
          - 5개 \~ 10개를 쓰는듯..
    5.  어떤 imputation model 을 써야할까?
          - 결국 synthetic data 를 형성할 때에, gibs sampling 을 사용하기 때문에,
            conditional 의 분포가 어떤지에 대한 가정이 필요하게 된다. mice 는 그러한 모델의 선택을
            사용자에게 맡기고 있다. - 즉 분포를 사용자가 정의해 주어야 한다는 것이다.
          - 정의해준 분포의 모수,data를 gibs sampling 을 이용하려 joint distribution 을
            생성(근사)하고, 생성한 joint distribution 을 이용하여 NA 를 채우게 된다.
  - imputation model
      - Non-parametric
          - ctree,cart : tree 모델 (class,reg 모두 가능. 즉 any data type 에 가능)
      - Parametric
          - norm : normal linear regression (numeric 에 가능)
          - normrank : Normal linear regression preserving the marginal
            distribution
          - logreg : Logistic regression (0,1)
          - polyreg : polytomous(multinomial) logistic regression
            (Factor\>2 level)
          - polr : Ordered polytomous logistic regression(Ordered \> 2
            level)
          - pmm : Predictive mean matching (nemeric)
              - f(y|….) 을 이용해 hat(y) 를 imputation 했다고 하자. 이 값을 그대로 사용하는게
                아니라 oberserved 된 애들 중 hat(y) 와 가장 가까운 녀석을 사용.
          - 이 밖에 매우 방법이 많다. ?mice 를 통해서 어떤 method 가 가능한지 살펴보자.

**how to ?**

``` r
#require(mice) 
#imp <- mice(mydata,m)     # dataset을 m개 만든다. 디폴트는 5 
#fit <- with(imp,analysis) # analysis는 lm(), glm() 등의 통계모델이 들어간다.
#pooled <- pool(fit)       # pooled 는 m개의 분석결과의 평균 (분산은 약간 다르게 계산됨)
#summary(pooled)
```

## iris 데이터 example

우선 NA 를 형성하기 전에, 전체 데이터를 이용해 회귀분석을 시행해 보자.

``` r
data(iris)            
fit=lm(Sepal.Length~Petal.Length+Species,data=iris) 
summary(fit)
```

    ## 
    ## Call:
    ## lm(formula = Sepal.Length ~ Petal.Length + Species, data = iris)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.75310 -0.23142 -0.00081  0.23085  1.03100 
    ## 
    ## Coefficients:
    ##                   Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)        3.68353    0.10610  34.719  < 2e-16 ***
    ## Petal.Length       0.90456    0.06479  13.962  < 2e-16 ***
    ## Speciesversicolor -1.60097    0.19347  -8.275 7.37e-14 ***
    ## Speciesvirginica  -2.11767    0.27346  -7.744 1.48e-12 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.338 on 146 degrees of freedom
    ## Multiple R-squared:  0.8367, Adjusted R-squared:  0.8334 
    ## F-statistic: 249.4 on 3 and 146 DF,  p-value: < 2.2e-16

이제 누락시킬 데이터를 살펴보자.

``` r
iris_NA=iris                           # 누락시킬 데이터셋 만듦
set.seed(131)
random1=sample(1:150,15)             # 15개의 sample 선택
random2=sample(1:5,15,replace=TRUE)  # 몇 번째 열을 누락시킬 것인지 15개 선택 
for(i in 1:15) iris_NA[random1[i],random2[i]]<-NA
iris_NA[random1,] 
```

    ##     Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
    ## 20            NA         3.8          1.5         0.3     setosa
    ## 52            NA         3.2          4.5         1.5 versicolor
    ## 122          5.6         2.8          4.9          NA  virginica
    ## 138          6.4          NA          5.5         1.8  virginica
    ## 58           4.9         2.4           NA         1.0 versicolor
    ## 144          6.8         3.2          5.9         2.3       <NA>
    ## 59           6.6         2.9          4.6         1.3       <NA>
    ## 123          7.7         2.8          6.7          NA  virginica
    ## 149          6.2         3.4           NA         2.3  virginica
    ## 27           5.0         3.4          1.6         0.4       <NA>
    ## 28            NA         3.5          1.5         0.2     setosa
    ## 44           5.0          NA          1.6         0.6     setosa
    ## 121          6.9         3.2           NA         2.3  virginica
    ## 150          5.9         3.0           NA         1.8  virginica
    ## 111          6.5          NA          5.1         2.0  virginica

이제 mice 를 통해서 누락한 자료들의 다중대입을 통해 데이터셋을 만든다.

``` r
require(mice)
# printFlag : 프린트 하는 과정을 보지 않겠다는 뜻
# m = 몇개의 데이터 set 을 generating 할지
imp=mice(iris_NA,seed=131,printFlag = FALSE) 

summary(imp)
```

    ## Class: mids
    ## Number of multiple imputations:  5 
    ## Imputation methods:
    ## Sepal.Length  Sepal.Width Petal.Length  Petal.Width      Species 
    ##        "pmm"        "pmm"        "pmm"        "pmm"    "polyreg" 
    ## PredictorMatrix:
    ##              Sepal.Length Sepal.Width Petal.Length Petal.Width Species
    ## Sepal.Length            0           1            1           1       1
    ## Sepal.Width             1           0            1           1       1
    ## Petal.Length            1           1            0           1       1
    ## Petal.Width             1           1            1           0       1
    ## Species                 1           1            1           1       0

``` r
# 각각의 methods 를 보았을 때, 어떤것을 사용해서 각 변수들의 na 를 채웠는지 알려준다.

Complete_1= complete(imp,1) 
head(Complete_1)
```

    ##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
    ## 1          5.1         3.5          1.4         0.2  setosa
    ## 2          4.9         3.0          1.4         0.2  setosa
    ## 3          4.7         3.2          1.3         0.2  setosa
    ## 4          4.6         3.1          1.5         0.2  setosa
    ## 5          5.0         3.6          1.4         0.2  setosa
    ## 6          5.4         3.9          1.7         0.4  setosa

``` r
# miss 를 채워 넣어서 만든 synth data 첫번째
```

with 을 이용하여, 완성된 5개의 자료에 대해 regression

``` r
fit_imputed=with(imp,lm(Sepal.Length~Petal.Length+Species))
fit_imputed # imputed 된 데이터들의 m개의 각 fitting 을 보여준다. 
```

    ## call :
    ## with.mids(data = imp, expr = lm(Sepal.Length ~ Petal.Length + 
    ##     Species))
    ## 
    ## call1 :
    ## mice(data = iris_NA, printFlag = FALSE, seed = 131)
    ## 
    ## nmis :
    ## Sepal.Length  Sepal.Width Petal.Length  Petal.Width      Species 
    ##            3            3            4            2            3 
    ## 
    ## analyses :
    ## [[1]]
    ## 
    ## Call:
    ## lm(formula = Sepal.Length ~ Petal.Length + Species)
    ## 
    ## Coefficients:
    ##       (Intercept)       Petal.Length  Speciesversicolor   Speciesvirginica  
    ##            3.6979             0.9057            -1.6309            -2.1345  
    ## 
    ## 
    ## [[2]]
    ## 
    ## Call:
    ## lm(formula = Sepal.Length ~ Petal.Length + Species)
    ## 
    ## Coefficients:
    ##       (Intercept)       Petal.Length  Speciesversicolor   Speciesvirginica  
    ##            3.6830             0.9022            -1.5995            -2.0913  
    ## 
    ## 
    ## [[3]]
    ## 
    ## Call:
    ## lm(formula = Sepal.Length ~ Petal.Length + Species)
    ## 
    ## Coefficients:
    ##       (Intercept)       Petal.Length  Speciesversicolor   Speciesvirginica  
    ##            3.6863             0.9082            -1.6203            -2.1368  
    ## 
    ## 
    ## [[4]]
    ## 
    ## Call:
    ## lm(formula = Sepal.Length ~ Petal.Length + Species)
    ## 
    ## Coefficients:
    ##       (Intercept)       Petal.Length  Speciesversicolor   Speciesvirginica  
    ##            3.7219             0.8797            -1.5320            -2.0266  
    ## 
    ## 
    ## [[5]]
    ## 
    ## Call:
    ## lm(formula = Sepal.Length ~ Petal.Length + Species)
    ## 
    ## Coefficients:
    ##       (Intercept)       Petal.Length  Speciesversicolor   Speciesvirginica  
    ##            3.7267             0.8764            -1.5290            -1.9888

``` r
for (i in c(1:5)){
 print(fit_imputed$analyses[[i]]$coefficients)
}
```

    ##       (Intercept)      Petal.Length Speciesversicolor  Speciesvirginica 
    ##         3.6979247         0.9056602        -1.6309053        -2.1345277 
    ##       (Intercept)      Petal.Length Speciesversicolor  Speciesvirginica 
    ##         3.6830178         0.9021766        -1.5995076        -2.0912720 
    ##       (Intercept)      Petal.Length Speciesversicolor  Speciesvirginica 
    ##         3.6862652         0.9081633        -1.6203063        -2.1367554 
    ##       (Intercept)      Petal.Length Speciesversicolor  Speciesvirginica 
    ##         3.7219214         0.8796707        -1.5320406        -2.0266499 
    ##       (Intercept)      Petal.Length Speciesversicolor  Speciesvirginica 
    ##         3.7266542         0.8764335        -1.5290025        -1.9888374

``` r
pooled = pool(fit_imputed) # pooling 해서(평균) var, mean 값을 만든다. 
# mean 은 단순하게 1/m 을 해서 더해 더한다. 
# Var 정해진 공식을 이용하여 계산하게 된다. (Rubin's variance formula)
summary(pooled)
```

    ##                term   estimate  std.error statistic       df      p.value
    ## 1       (Intercept)  3.7031567 0.10931676 33.875472 130.6836 0.000000e+00
    ## 2      Petal.Length  0.8944209 0.06737479 13.275304 120.3780 0.000000e+00
    ## 3 Speciesversicolor -1.5823525 0.20250074 -7.814058 115.4844 2.818190e-12
    ## 4  Speciesvirginica -2.0756085 0.28466813 -7.291327 118.2709 3.778444e-11

``` r
imp
```

    ## Class: mids
    ## Number of multiple imputations:  5 
    ## Imputation methods:
    ## Sepal.Length  Sepal.Width Petal.Length  Petal.Width      Species 
    ##        "pmm"        "pmm"        "pmm"        "pmm"    "polyreg" 
    ## PredictorMatrix:
    ##              Sepal.Length Sepal.Width Petal.Length Petal.Width Species
    ## Sepal.Length            0           1            1           1       1
    ## Sepal.Width             1           0            1           1       1
    ## Petal.Length            1           1            0           1       1
    ## Petal.Width             1           1            1           0       1
    ## Species                 1           1            1           1       0

``` r
# Predictor matrix 는 각 0(NA) 를 어떤 variable 들을 이용하여 채워넣었는지를 알려준다.
# 이 떄에는 각 NA 를 나머지 모든 변수들을 사용하여서 채운것을 알 수 있다.
```

``` r
# fit 값이 잘맞나..?
fit_deleted=lm(Sepal.Length~Petal.Length+Species,data=iris_NA) 
fit_del=summary(fit_deleted)
fit_full=summary(fit)
```

``` r
# 지워진 데이터로 진행된 regression
fit_del$coefficients 
```

    ##                     Estimate Std. Error   t value     Pr(>|t|)
    ## (Intercept)        3.7090837 0.11127443 33.332758 2.624616e-67
    ## Petal.Length       0.8857382 0.06807816 13.010606 1.206380e-25
    ## Speciesversicolor -1.5554471 0.20417355 -7.618260 3.924037e-12
    ## Speciesvirginica  -2.0287817 0.28795890 -7.045386 8.393546e-11

``` r
# Mice 로 채운 데이터로 진행된 regression
summary(pooled)
```

    ##                term   estimate  std.error statistic       df      p.value
    ## 1       (Intercept)  3.7031567 0.10931676 33.875472 130.6836 0.000000e+00
    ## 2      Petal.Length  0.8944209 0.06737479 13.275304 120.3780 0.000000e+00
    ## 3 Speciesversicolor -1.5823525 0.20250074 -7.814058 115.4844 2.818190e-12
    ## 4  Speciesvirginica -2.0756085 0.28466813 -7.291327 118.2709 3.778444e-11

``` r
# Full data 로 진행되는 regression
fit_full$coefficients
```

    ##                     Estimate Std. Error   t value     Pr(>|t|)
    ## (Intercept)        3.6835266 0.10609608 34.718780 1.968671e-72
    ## Petal.Length       0.9045646 0.06478559 13.962436 1.121002e-28
    ## Speciesversicolor -1.6009717 0.19346616 -8.275203 7.371529e-14
    ## Speciesvirginica  -2.1176692 0.27346121 -7.743947 1.480296e-12

생각보다 NA 를 채우는게 좋아보이지는 않는다. <br>

  - NA를 지울때 완전 Random 으로 지웠기 때문에, 모든 NA 들은 MCAR 이다.
  - 그러므로, NA 가 발생한 데이터를 지웠다는것은, 나머지 데이터를 완전 Random 하게 지운것과 같다.
  - 즉, NA를 뺸 데이터는 Full data의 성질을 잘 나타내는 subset 이 될 수 있는것이다.
  - 그러므로 NA 를 뺴고 진행한 Regression인 fit\_del 이 오히려 더 좋은것이다.

# Amelia (Multiple Imputation)

  - Amelia 패키지를 사용해서 NA 를 처리하는법을 알아보자. <br>
  - Assumption
      - Amelia 는 모든 data 다 Multivariate Normal 을 따른다고 가정한다.
      - 그리고 NA 는 MAR 이라고 가정한다.(이는 Mice 에서도 같음)
  - Algorithm
      - MAR 과 MN 가정으로 인해 데이터를 generating 하고, 분석하기가 Mice 보다 훨씬 수월해진다.
      - bootstrap 과, EM algorithm 을 이용해 p(mu,sigma|observed data) 를 알 수
        있게 되고, 그러면 mu,sigma 의 분포를 알게 되므로 missing data 를 generating 할 수
        있게된다.
      - 그리고 bootstrap 과 EM 으로 생성된 데이터를 이용해, Mice 와 같이 모겔을 각각 세운 후 ,
        eastimates 들을 합쳐서 추정

![images](./Images/Amelia%20algorithm.PNG)

![images](./Images/Amelia%20algorithm2.png)

  - Mice 와의 비교
    (<https://www.analyticsvidhya.com/blog/2016/03/tutorial-powerful-packages-imputing-missing-values/>)
      - MICE imputes data on variable by variable basis whereas MVN uses
        a joint modeling approach based on multivariate normal
        distribution.
      - MICE is capable of handling different types of variables whereas
        the variables in MVN need to be normally distributed or
        transformed to approximate normality.
      - Also, MICE can manage imputation of variables defined on a
        subset of data whereas MVN cannot.
  - 즉 정리하자면, Amelia 는 MVN 가정때문에, 분포가 Normal 과 비슷할 때에 NA 처리를 잘한다. 그러므로 그에
    알맞은 Transformation 을 하고 난 이후에 작동이 잘 될 것이다(사실 변환은 패키지가 어느정도 해주긴 한다.
    ).

## 시계열

  - freetrade 는 1980\~1993년까지의 무역정책 자유화에 대한 분석 데이터이다. <br>
  - 변수는 연도,국가,관세율, 정치지수(-10\~10 으로 클수록 자유화),총인구,국민총생산, 총국제준비액, IMF가입년도,
    재무적공개석, US선호지수 로 구성되어 있다. <br>

<!-- end list -->

``` r
library(Amelia)
data(freetrade)
summary(freetrade)
```

    ##       year        country              tariff           polity      
    ##  Min.   :1981   Length:171         Min.   :  7.10   Min.   :-8.000  
    ##  1st Qu.:1985   Class :character   1st Qu.: 16.30   1st Qu.:-2.000  
    ##  Median :1990   Mode  :character   Median : 25.20   Median : 5.000  
    ##  Mean   :1990                      Mean   : 31.65   Mean   : 2.905  
    ##  3rd Qu.:1995                      3rd Qu.: 40.80   3rd Qu.: 8.000  
    ##  Max.   :1999                      Max.   :100.00   Max.   : 9.000  
    ##                                    NA's   :58       NA's   :2       
    ##       pop                gdp.pc           intresmi          signed      
    ##  Min.   : 14105080   Min.   :  149.5   Min.   :0.9036   Min.   :0.0000  
    ##  1st Qu.: 19676715   1st Qu.:  420.1   1st Qu.:2.2231   1st Qu.:0.0000  
    ##  Median : 52799040   Median :  814.3   Median :3.1815   Median :0.0000  
    ##  Mean   :149904501   Mean   : 1867.3   Mean   :3.3752   Mean   :0.1548  
    ##  3rd Qu.:120888400   3rd Qu.: 2462.9   3rd Qu.:4.4063   3rd Qu.:0.0000  
    ##  Max.   :997515200   Max.   :12086.2   Max.   :7.9346   Max.   :1.0000  
    ##                                        NA's   :13       NA's   :3       
    ##      fiveop          usheg       
    ##  Min.   :12.30   Min.   :0.2558  
    ##  1st Qu.:12.50   1st Qu.:0.2623  
    ##  Median :12.60   Median :0.2756  
    ##  Mean   :12.74   Mean   :0.2764  
    ##  3rd Qu.:13.20   3rd Qu.:0.2887  
    ##  Max.   :13.20   Max.   :0.3083  
    ##  NA's   :18

Regression

``` r
summary(lm(tariff ~ polity + pop + gdp.pc + year + country, data = freetrade))
```

    ## 
    ## Call:
    ## lm(formula = tariff ~ polity + pop + gdp.pc + year + country, 
    ##     data = freetrade)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -30.7640  -3.2595   0.0868   2.5983  18.3097 
    ## 
    ## Coefficients:
    ##                      Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)         1.973e+03  4.016e+02   4.912 3.61e-06 ***
    ## polity             -1.373e-01  1.821e-01  -0.754    0.453    
    ## pop                -2.021e-07  2.542e-08  -7.951 3.23e-12 ***
    ## gdp.pc              6.096e-04  7.442e-04   0.819    0.415    
    ## year               -8.705e-01  2.084e-01  -4.176 6.43e-05 ***
    ## countryIndonesia   -1.823e+02  1.857e+01  -9.819 2.98e-16 ***
    ## countryKorea       -2.204e+02  2.078e+01 -10.608  < 2e-16 ***
    ## countryMalaysia    -2.245e+02  2.171e+01 -10.343  < 2e-16 ***
    ## countryNepal       -2.163e+02  2.247e+01  -9.629 7.74e-16 ***
    ## countryPakistan    -1.554e+02  1.982e+01  -7.838 5.63e-12 ***
    ## countryPhilippines -2.040e+02  2.088e+01  -9.774 3.75e-16 ***
    ## countrySriLanka    -2.091e+02  2.210e+01  -9.460 1.80e-15 ***
    ## countryThailand    -1.961e+02  2.095e+01  -9.358 2.99e-15 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 6.221 on 98 degrees of freedom
    ##   (60 observations deleted due to missingness)
    ## Multiple R-squared:  0.9247, Adjusted R-squared:  0.9155 
    ## F-statistic: 100.3 on 12 and 98 DF,  p-value: < 2.2e-16

  - 이 떄에 60개의 데이터가 지워진것을 볼 수 있다.
  - Missing 에도 정보가 있고, 또한 MACR 이 아니라 MAR 이면, 결과가 Biased 될 지도 모르는일이기 때문에
    이를 꼭 잘 채워주어야 한다.
  - imputation 을 수행할 때에 제일 첫 step 은 imputation 에 들어갈 변수를 찾는것이다.
  - imputation 할 때에는 최대한 많은 변수를 넣는것이 좋다.
  - 그러므로 우리의 Analysis 의 주된 목적이 pop,polity,gdp.pc 에 있다 하더라도 모든 variable 을
    넣어서 imputation 을 진행하겠다.

<!-- end list -->

``` r
# m : 몇개의 데이터를 생성할 것인가
# ts : 시계열에 대한 정보가 되는 열의 이름
# cs : cross-sectional 분석에 이용되는 정보 
# Note : 횡단면 데이터(Cross-Sectional Data)란 복수의 개체(기업, 지역, 지구, 피험자 등)를 어느 한 시점에서 본 관측값으로 이루어진 데이터.예를 들면 2016년 47개 행정구역의 주민 소득 데이터 등이 이에 해당.
a.out <- amelia(freetrade, m = 5, ts = "year", cs = "country")
```

    ## -- Imputation 1 --
    ## 
    ##   1  2  3  4  5  6  7  8  9 10 11 12
    ## 
    ## -- Imputation 2 --
    ## 
    ##   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16
    ## 
    ## -- Imputation 3 --
    ## 
    ##   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19
    ## 
    ## -- Imputation 4 --
    ## 
    ##   1  2  3  4  5  6  7  8  9 10 11 12 13 14
    ## 
    ## -- Imputation 5 --
    ## 
    ##   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16

``` r
a.out
```

    ## 
    ## Amelia output with 5 imputed datasets.
    ## Return code:  1 
    ## Message:  Normal EM convergence. 
    ## 
    ## Chain Lengths:
    ## --------------
    ## Imputation 1:  12
    ## Imputation 2:  16
    ## Imputation 3:  19
    ## Imputation 4:  14
    ## Imputation 5:  16

  - 위 dataset 은 매우 작은경우임을 명심하자.
  - 일반적으로 몇백\~몇천의 EM Algorithm 의 steps 를 겪는다고 한다.
  - 긴 chain length 가 나온다면, 우리 variable 이 Multi noraml 에 잘 맞지 않는다는 의미일 수
    있고, 이는 variable 을 normal 에 맞게 변환시켜야 할 수도 있을것이다.

<!-- end list -->

``` r
df_imputed3 = a.out$imputations[[3]]# 3번째 imputed set 
head(df_imputed3)
```

    ##   year  country   tariff polity      pop   gdp.pc intresmi signed fiveop
    ## 1 1981 SriLanka 52.59540      6 14988000 461.0236 1.937347      0   12.4
    ## 2 1982 SriLanka 31.17011      5 15189000 473.7634 1.964430      0   12.5
    ## 3 1983 SriLanka 41.30000      5 15417000 489.2266 1.663936      1   12.3
    ## 4 1984 SriLanka 45.68146      5 15599000 508.1739 2.797462      0   12.3
    ## 5 1985 SriLanka 31.00000      5 15837000 525.5609 2.259116      0   12.3
    ## 6 1986 SriLanka 62.90108      5 16117000 538.9237 1.832549      0   12.5
    ##       usheg
    ## 1 0.2593112
    ## 2 0.2558008
    ## 3 0.2655022
    ## 4 0.2988009
    ## 5 0.2952431
    ## 6 0.2886563

  - 3번째 imputed data set 을 출력해 보았다.

<!-- end list -->

``` r
hist(a.out$imputations[[3]]$tariff, col="grey", border="white")
```

![](Pro_NA-imputation_files/figure-gfm/unnamed-chunk-24-1.png)<!-- --> -
3번째로 imputed 된 데이터에 대해 tariff 의 분포를 살펴보았다. - 데이터를 이용하고 싶다면, full imputed
된 데이터 a.out$imputations\[\[i\]\] 를 이용하면 될 것이다. - 자세한 Settings 는 (AMELIA
II: A Program for Missing Data) 의 pdf 21p 를 확인해보자.

## Transformation

  - As it turns out, much evidence in the literature (discussed in King
    et al. 2001) indicates that the multivariate normal model used in
    Amelia usually works well for the imputation stage even when
    discrete or nonnormal variables are included and when the analysis
    stage involves these limited dependent variable models (AMELIA II: A
    Program for Missing Data-16p)
      - 즉 어느정도 Normal 분포가 아니거나, discrete 이여도 잘 작동한다는 의미이다.
  - Although these transformations are taken internally on these
    variables to better fit the data to the multivariate normal
    assumptions of the imputation model, all the imputations that are
    created will be returned in the original untransformed form of the
    data.
      - 즉 어느정도의 Transformation 은 자체 내장 함수가 수행해 준다는 의미이다.

## Ordinal

  - Ordinal 의 경우는 따로 처리가 필요하다.

<!-- end list -->

``` r
table(a.out$imputations[[3]]$polity)
```

    ## 
    ##                  -8                  -7                  -6                  -5 
    ##                   1                  22                   4                   7 
    ##                  -4                  -2                  -1 -0.0953189811253616 
    ##                   3                   9                   1                   1 
    ##                   2                   3                   4    4.97589335686374 
    ##                   7                   7                  15                   1 
    ##                   5                   6                   7                   8 
    ##                  26                  13                   5                  36 
    ##                   9 
    ##                  13

위와 같이 polity 는 -10\~10 의 점수를 가지는 ordinal 임에도 데이터의 imputation 이
continuous 한 형태로 나타난것을 볼 수 있다. <br> 이 자체로 써도 되긴 하지만 더 정확한 impute 를 위해
다르게 할 수도 있다 <br>

``` r
# p2s 는 display 할지 말지, 크게 중요한 변수는 아님 
a.out1 <- amelia(freetrade, m = 5, ts = "year", cs = "country", ords ="polity", p2s = 0)
```

## Nominal(Categorical)

  - signed which is 1 if a country signed an IMF agreement in that year
    and 0 if it did not
      - 즉 signed 라는 variable 은 1,0 의 categorical variable 이다.

<!-- end list -->

``` r
table(a.out1$imputations[[3]]$signed)
```

    ## 
    ## -0.209595835801611                  0    0.1161643455861   0.79082105584105 
    ##                  1                142                  1                  1 
    ##                  1 
    ##                 26

그런데 conti 값으로 Categorical variable 을 채워넣은것을 볼 수 있다.

``` r
a.out2 <- amelia(freetrade, m = 5, ts = "year", cs = "country", noms ="signed", p2s = 0)
table(a.out2$imputations[[3]]$signed)
```

    ## 
    ##   0   1 
    ## 144  27

위처럼 noms 를 지정해 주어야 잘 작동하는것을 볼 수 있다.

## Diagnotic

  - amelia 에서는 diagnotic 이 가능하다. <br>

<!-- end list -->

``` r
# which.var : 어떤 variable 을 볼지 
# 우리가 채운 tariff, intresmi그려준다.
plot(a.out, which.vars = c('tariff','intresmi','fiveop'))
compare.density(a.out, var = "signed") # signed 의 Observed value 와 mean imputation 을 보여준다. 
```

![](Pro_NA-imputation_files/figure-gfm/unnamed-chunk-29-1.png)<!-- -->

``` r
summary(freetrade)
```

    ##       year        country              tariff           polity      
    ##  Min.   :1981   Length:171         Min.   :  7.10   Min.   :-8.000  
    ##  1st Qu.:1985   Class :character   1st Qu.: 16.30   1st Qu.:-2.000  
    ##  Median :1990   Mode  :character   Median : 25.20   Median : 5.000  
    ##  Mean   :1990                      Mean   : 31.65   Mean   : 2.905  
    ##  3rd Qu.:1995                      3rd Qu.: 40.80   3rd Qu.: 8.000  
    ##  Max.   :1999                      Max.   :100.00   Max.   : 9.000  
    ##                                    NA's   :58       NA's   :2       
    ##       pop                gdp.pc           intresmi          signed      
    ##  Min.   : 14105080   Min.   :  149.5   Min.   :0.9036   Min.   :0.0000  
    ##  1st Qu.: 19676715   1st Qu.:  420.1   1st Qu.:2.2231   1st Qu.:0.0000  
    ##  Median : 52799040   Median :  814.3   Median :3.1815   Median :0.0000  
    ##  Mean   :149904501   Mean   : 1867.3   Mean   :3.3752   Mean   :0.1548  
    ##  3rd Qu.:120888400   3rd Qu.: 2462.9   3rd Qu.:4.4063   3rd Qu.:0.0000  
    ##  Max.   :997515200   Max.   :12086.2   Max.   :7.9346   Max.   :1.0000  
    ##                                        NA's   :13       NA's   :3       
    ##      fiveop          usheg       
    ##  Min.   :12.30   Min.   :0.2558  
    ##  1st Qu.:12.50   1st Qu.:0.2623  
    ##  Median :12.60   Median :0.2756  
    ##  Mean   :12.74   Mean   :0.2764  
    ##  3rd Qu.:13.20   3rd Qu.:0.2887  
    ##  Max.   :13.20   Max.   :0.3083  
    ##  NA's   :18

# 참고자료

  - <https://eda-ai-lab.tistory.com/14>
  - <https://rstudio-pubs-static.s3.amazonaws.com/192402_012091b9adac42dbbd22c4d07cb00d36.html>
  - <https://robotcat.tistory.com/469>
  - <https://www.analyticsvidhya.com/blog/2016/03/tutorial-powerful-packages-imputing-missing-values/>
  - AMELIA II: A Program for Missing Data()
  - mice : Multivariate Imputation by Chained Equations in R(2011)
