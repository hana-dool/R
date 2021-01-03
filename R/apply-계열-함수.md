apply 계열 함수
================

``` r
library(MASS)
str(Cars93)
```

    ## 'data.frame':    93 obs. of  27 variables:
    ##  $ Manufacturer      : Factor w/ 32 levels "Acura","Audi",..: 1 1 2 2 3 4 4 4 4 5 ...
    ##  $ Model             : Factor w/ 93 levels "100","190E","240",..: 49 56 9 1 6 24 54 74 73 35 ...
    ##  $ Type              : Factor w/ 6 levels "Compact","Large",..: 4 3 1 3 3 3 2 2 3 2 ...
    ##  $ Min.Price         : num  12.9 29.2 25.9 30.8 23.7 14.2 19.9 22.6 26.3 33 ...
    ##  $ Price             : num  15.9 33.9 29.1 37.7 30 15.7 20.8 23.7 26.3 34.7 ...
    ##  $ Max.Price         : num  18.8 38.7 32.3 44.6 36.2 17.3 21.7 24.9 26.3 36.3 ...
    ##  $ MPG.city          : int  25 18 20 19 22 22 19 16 19 16 ...
    ##  $ MPG.highway       : int  31 25 26 26 30 31 28 25 27 25 ...
    ##  $ AirBags           : Factor w/ 3 levels "Driver & Passenger",..: 3 1 2 1 2 2 2 2 2 2 ...
    ##  $ DriveTrain        : Factor w/ 3 levels "4WD","Front",..: 2 2 2 2 3 2 2 3 2 2 ...
    ##  $ Cylinders         : Factor w/ 6 levels "3","4","5","6",..: 2 4 4 4 2 2 4 4 4 5 ...
    ##  $ EngineSize        : num  1.8 3.2 2.8 2.8 3.5 2.2 3.8 5.7 3.8 4.9 ...
    ##  $ Horsepower        : int  140 200 172 172 208 110 170 180 170 200 ...
    ##  $ RPM               : int  6300 5500 5500 5500 5700 5200 4800 4000 4800 4100 ...
    ##  $ Rev.per.mile      : int  2890 2335 2280 2535 2545 2565 1570 1320 1690 1510 ...
    ##  $ Man.trans.avail   : Factor w/ 2 levels "No","Yes": 2 2 2 2 2 1 1 1 1 1 ...
    ##  $ Fuel.tank.capacity: num  13.2 18 16.9 21.1 21.1 16.4 18 23 18.8 18 ...
    ##  $ Passengers        : int  5 5 5 6 4 6 6 6 5 6 ...
    ##  $ Length            : int  177 195 180 193 186 189 200 216 198 206 ...
    ##  $ Wheelbase         : int  102 115 102 106 109 105 111 116 108 114 ...
    ##  $ Width             : int  68 71 67 70 69 69 74 78 73 73 ...
    ##  $ Turn.circle       : int  37 38 37 37 39 41 42 45 41 43 ...
    ##  $ Rear.seat.room    : num  26.5 30 28 31 27 28 30.5 30.5 26.5 35 ...
    ##  $ Luggage.room      : int  11 15 14 17 13 16 17 21 14 18 ...
    ##  $ Weight            : int  2705 3560 3375 3405 3640 2880 3470 4105 3495 3620 ...
    ##  $ Origin            : Factor w/ 2 levels "USA","non-USA": 2 2 2 2 2 1 1 1 1 1 ...
    ##  $ Make              : Factor w/ 93 levels "Acura Integra",..: 1 2 4 3 5 6 7 9 8 10 ...

``` r
attach(Cars93)
```

# apply

apply 는 row 와 col 기준에서 기술통계(max, mean, sum) 등을 집계할 수 있다.

``` r
mat <- matrix(c(1:9),byrow=TRUE,nrow=3)
mat
```

    ##      [,1] [,2] [,3]
    ## [1,]    1    2    3
    ## [2,]    4    5    6
    ## [3,]    7    8    9

``` r
apply(mat,1,max) # col 관점(1)에서 최대값을 뽑아라 # 즉 row의 max
```

    ## [1] 3 6 9

``` r
apply(mat,2,max) # row 관점(2)에서 최대값을 봅아라 # 즉 col의 max
```

    ## [1] 7 8 9

``` r
apply(mat,1,mean)
```

    ## [1] 2 5 8

``` r
apply(mat,2,sum) # col sum 
```

    ## [1] 12 15 18

# tapply

tapply(벡터,요인,함수) : ‘벡터’ 값들을 ‘요인’(factor)의 ‘수준’(level) 별로 ’함수’를 동시에 적용
<br> 즉 factor 로 나누어 져 있는 df 에 대해 효과적으로 각 범주별로 연산이 가능하다. <br> Type apply
라고 생각하면 이해가 쉬울것이다. <br>

``` r
head(Cars93)
```

    ##   Manufacturer   Model    Type Min.Price Price Max.Price MPG.city MPG.highway
    ## 1        Acura Integra   Small      12.9  15.9      18.8       25          31
    ## 2        Acura  Legend Midsize      29.2  33.9      38.7       18          25
    ## 3         Audi      90 Compact      25.9  29.1      32.3       20          26
    ## 4         Audi     100 Midsize      30.8  37.7      44.6       19          26
    ## 5          BMW    535i Midsize      23.7  30.0      36.2       22          30
    ## 6        Buick Century Midsize      14.2  15.7      17.3       22          31
    ##              AirBags DriveTrain Cylinders EngineSize Horsepower  RPM
    ## 1               None      Front         4        1.8        140 6300
    ## 2 Driver & Passenger      Front         6        3.2        200 5500
    ## 3        Driver only      Front         6        2.8        172 5500
    ## 4 Driver & Passenger      Front         6        2.8        172 5500
    ## 5        Driver only       Rear         4        3.5        208 5700
    ## 6        Driver only      Front         4        2.2        110 5200
    ##   Rev.per.mile Man.trans.avail Fuel.tank.capacity Passengers Length Wheelbase
    ## 1         2890             Yes               13.2          5    177       102
    ## 2         2335             Yes               18.0          5    195       115
    ## 3         2280             Yes               16.9          5    180       102
    ## 4         2535             Yes               21.1          6    193       106
    ## 5         2545             Yes               21.1          4    186       109
    ## 6         2565              No               16.4          6    189       105
    ##   Width Turn.circle Rear.seat.room Luggage.room Weight  Origin          Make
    ## 1    68          37           26.5           11   2705 non-USA Acura Integra
    ## 2    71          38           30.0           15   3560 non-USA  Acura Legend
    ## 3    67          37           28.0           14   3375 non-USA       Audi 90
    ## 4    70          37           31.0           17   3405 non-USA      Audi 100
    ## 5    69          39           27.0           13   3640 non-USA      BMW 535i
    ## 6    69          41           28.0           16   2880     USA Buick Century

``` r
str(Cars93) 
```

    ## 'data.frame':    93 obs. of  27 variables:
    ##  $ Manufacturer      : Factor w/ 32 levels "Acura","Audi",..: 1 1 2 2 3 4 4 4 4 5 ...
    ##  $ Model             : Factor w/ 93 levels "100","190E","240",..: 49 56 9 1 6 24 54 74 73 35 ...
    ##  $ Type              : Factor w/ 6 levels "Compact","Large",..: 4 3 1 3 3 3 2 2 3 2 ...
    ##  $ Min.Price         : num  12.9 29.2 25.9 30.8 23.7 14.2 19.9 22.6 26.3 33 ...
    ##  $ Price             : num  15.9 33.9 29.1 37.7 30 15.7 20.8 23.7 26.3 34.7 ...
    ##  $ Max.Price         : num  18.8 38.7 32.3 44.6 36.2 17.3 21.7 24.9 26.3 36.3 ...
    ##  $ MPG.city          : int  25 18 20 19 22 22 19 16 19 16 ...
    ##  $ MPG.highway       : int  31 25 26 26 30 31 28 25 27 25 ...
    ##  $ AirBags           : Factor w/ 3 levels "Driver & Passenger",..: 3 1 2 1 2 2 2 2 2 2 ...
    ##  $ DriveTrain        : Factor w/ 3 levels "4WD","Front",..: 2 2 2 2 3 2 2 3 2 2 ...
    ##  $ Cylinders         : Factor w/ 6 levels "3","4","5","6",..: 2 4 4 4 2 2 4 4 4 5 ...
    ##  $ EngineSize        : num  1.8 3.2 2.8 2.8 3.5 2.2 3.8 5.7 3.8 4.9 ...
    ##  $ Horsepower        : int  140 200 172 172 208 110 170 180 170 200 ...
    ##  $ RPM               : int  6300 5500 5500 5500 5700 5200 4800 4000 4800 4100 ...
    ##  $ Rev.per.mile      : int  2890 2335 2280 2535 2545 2565 1570 1320 1690 1510 ...
    ##  $ Man.trans.avail   : Factor w/ 2 levels "No","Yes": 2 2 2 2 2 1 1 1 1 1 ...
    ##  $ Fuel.tank.capacity: num  13.2 18 16.9 21.1 21.1 16.4 18 23 18.8 18 ...
    ##  $ Passengers        : int  5 5 5 6 4 6 6 6 5 6 ...
    ##  $ Length            : int  177 195 180 193 186 189 200 216 198 206 ...
    ##  $ Wheelbase         : int  102 115 102 106 109 105 111 116 108 114 ...
    ##  $ Width             : int  68 71 67 70 69 69 74 78 73 73 ...
    ##  $ Turn.circle       : int  37 38 37 37 39 41 42 45 41 43 ...
    ##  $ Rear.seat.room    : num  26.5 30 28 31 27 28 30.5 30.5 26.5 35 ...
    ##  $ Luggage.room      : int  11 15 14 17 13 16 17 21 14 18 ...
    ##  $ Weight            : int  2705 3560 3375 3405 3640 2880 3470 4105 3495 3620 ...
    ##  $ Origin            : Factor w/ 2 levels "USA","non-USA": 2 2 2 2 2 1 1 1 1 1 ...
    ##  $ Make              : Factor w/ 93 levels "Acura Integra",..: 1 2 4 3 5 6 7 9 8 10 ...

``` r
# 차량 유형별(Type) 은 compeact/large/Midsize/small/sporty/van 의 수준(level)으로 고성되어있다.
# 각각의 type 에 대해서 연비가 얼마나 될지 궁금할 것이다.
tapply(MPG.highway, Type, mean) #MPG 는 연비
```

    ##  Compact    Large  Midsize    Small   Sporty      Van 
    ## 29.87500 26.72727 26.72727 35.47619 28.78571 21.88889

``` r
# 차량 Type 별 고속도로 연비 평균
# tapply 사용하여 각 type 별 통계적 특징을 알아낼 수 있다.
```

# sapply

데이터 프레임 여러 변수에 함수 명령어 동시 적용 (결과가 vector/행렬) <br> sapply 는 벡터 또는 행렬을
출력한다.

``` r
sapply(Cars93,class) # 27개 변수 한번에 각각의 속성을 알아본다.
```

    ##       Manufacturer              Model               Type          Min.Price 
    ##           "factor"           "factor"           "factor"          "numeric" 
    ##              Price          Max.Price           MPG.city        MPG.highway 
    ##          "numeric"          "numeric"          "integer"          "integer" 
    ##            AirBags         DriveTrain          Cylinders         EngineSize 
    ##           "factor"           "factor"           "factor"          "numeric" 
    ##         Horsepower                RPM       Rev.per.mile    Man.trans.avail 
    ##          "integer"          "integer"          "integer"           "factor" 
    ## Fuel.tank.capacity         Passengers             Length          Wheelbase 
    ##          "numeric"          "integer"          "integer"          "integer" 
    ##              Width        Turn.circle     Rear.seat.room       Luggage.room 
    ##          "integer"          "integer"          "numeric"          "integer" 
    ##             Weight             Origin               Make 
    ##          "integer"           "factor"           "factor"

``` r
sapply(Cars93,length) # 모든 변수에 대해 각각의 크기를 알아본다.
```

    ##       Manufacturer              Model               Type          Min.Price 
    ##                 93                 93                 93                 93 
    ##              Price          Max.Price           MPG.city        MPG.highway 
    ##                 93                 93                 93                 93 
    ##            AirBags         DriveTrain          Cylinders         EngineSize 
    ##                 93                 93                 93                 93 
    ##         Horsepower                RPM       Rev.per.mile    Man.trans.avail 
    ##                 93                 93                 93                 93 
    ## Fuel.tank.capacity         Passengers             Length          Wheelbase 
    ##                 93                 93                 93                 93 
    ##              Width        Turn.circle     Rear.seat.room       Luggage.room 
    ##                 93                 93                 93                 93 
    ##             Weight             Origin               Make 
    ##                 93                 93                 93

# laaply

lapply() : 데이터 프레임 여러 변수에 함수변수 동시적용 (결과가 list)

``` r
lapply(Cars93,class)
```

    ## $Manufacturer
    ## [1] "factor"
    ## 
    ## $Model
    ## [1] "factor"
    ## 
    ## $Type
    ## [1] "factor"
    ## 
    ## $Min.Price
    ## [1] "numeric"
    ## 
    ## $Price
    ## [1] "numeric"
    ## 
    ## $Max.Price
    ## [1] "numeric"
    ## 
    ## $MPG.city
    ## [1] "integer"
    ## 
    ## $MPG.highway
    ## [1] "integer"
    ## 
    ## $AirBags
    ## [1] "factor"
    ## 
    ## $DriveTrain
    ## [1] "factor"
    ## 
    ## $Cylinders
    ## [1] "factor"
    ## 
    ## $EngineSize
    ## [1] "numeric"
    ## 
    ## $Horsepower
    ## [1] "integer"
    ## 
    ## $RPM
    ## [1] "integer"
    ## 
    ## $Rev.per.mile
    ## [1] "integer"
    ## 
    ## $Man.trans.avail
    ## [1] "factor"
    ## 
    ## $Fuel.tank.capacity
    ## [1] "numeric"
    ## 
    ## $Passengers
    ## [1] "integer"
    ## 
    ## $Length
    ## [1] "integer"
    ## 
    ## $Wheelbase
    ## [1] "integer"
    ## 
    ## $Width
    ## [1] "integer"
    ## 
    ## $Turn.circle
    ## [1] "integer"
    ## 
    ## $Rear.seat.room
    ## [1] "numeric"
    ## 
    ## $Luggage.room
    ## [1] "integer"
    ## 
    ## $Weight
    ## [1] "integer"
    ## 
    ## $Origin
    ## [1] "factor"
    ## 
    ## $Make
    ## [1] "factor"
