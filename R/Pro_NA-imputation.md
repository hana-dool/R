Untitled
================

``` r
library('MASS')
```

    ## Warning: package 'MASS' was built under R version 4.0.3

``` r
#is.na() # TRUE/FLASE 로 모두 나타내준다. 근데 별로임
is.na(Cars93)
```

    ##    Manufacturer Model  Type Min.Price Price Max.Price MPG.city MPG.highway
    ## 1         FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 2         FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 3         FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 4         FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 5         FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 6         FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 7         FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 8         FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 9         FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 10        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 11        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 12        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 13        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 14        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 15        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 16        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 17        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 18        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 19        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 20        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 21        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 22        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 23        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 24        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 25        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 26        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 27        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 28        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 29        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 30        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 31        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 32        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 33        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 34        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 35        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 36        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 37        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 38        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 39        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 40        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 41        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 42        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 43        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 44        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 45        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 46        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 47        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 48        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 49        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 50        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 51        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 52        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 53        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 54        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 55        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 56        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 57        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 58        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 59        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 60        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 61        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 62        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 63        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 64        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 65        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 66        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 67        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 68        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 69        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 70        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 71        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 72        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 73        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 74        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 75        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 76        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 77        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 78        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 79        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 80        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 81        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 82        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 83        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 84        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 85        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 86        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 87        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 88        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 89        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 90        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 91        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 92        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ## 93        FALSE FALSE FALSE     FALSE FALSE     FALSE    FALSE       FALSE
    ##    AirBags DriveTrain Cylinders EngineSize Horsepower   RPM Rev.per.mile
    ## 1    FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 2    FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 3    FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 4    FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 5    FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 6    FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 7    FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 8    FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 9    FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 10   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 11   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 12   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 13   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 14   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 15   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 16   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 17   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 18   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 19   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 20   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 21   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 22   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 23   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 24   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 25   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 26   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 27   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 28   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 29   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 30   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 31   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 32   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 33   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 34   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 35   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 36   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 37   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 38   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 39   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 40   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 41   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 42   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 43   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 44   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 45   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 46   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 47   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 48   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 49   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 50   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 51   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 52   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 53   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 54   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 55   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 56   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 57   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 58   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 59   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 60   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 61   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 62   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 63   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 64   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 65   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 66   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 67   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 68   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 69   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 70   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 71   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 72   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 73   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 74   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 75   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 76   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 77   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 78   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 79   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 80   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 81   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 82   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 83   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 84   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 85   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 86   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 87   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 88   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 89   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 90   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 91   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 92   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ## 93   FALSE      FALSE     FALSE      FALSE      FALSE FALSE        FALSE
    ##    Man.trans.avail Fuel.tank.capacity Passengers Length Wheelbase Width
    ## 1            FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 2            FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 3            FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 4            FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 5            FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 6            FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 7            FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 8            FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 9            FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 10           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 11           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 12           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 13           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 14           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 15           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 16           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 17           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 18           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 19           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 20           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 21           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 22           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 23           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 24           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 25           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 26           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 27           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 28           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 29           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 30           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 31           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 32           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 33           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 34           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 35           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 36           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 37           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 38           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 39           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 40           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 41           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 42           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 43           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 44           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 45           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 46           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 47           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 48           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 49           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 50           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 51           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 52           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 53           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 54           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 55           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 56           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 57           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 58           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 59           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 60           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 61           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 62           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 63           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 64           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 65           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 66           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 67           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 68           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 69           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 70           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 71           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 72           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 73           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 74           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 75           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 76           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 77           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 78           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 79           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 80           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 81           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 82           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 83           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 84           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 85           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 86           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 87           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 88           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 89           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 90           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 91           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 92           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ## 93           FALSE              FALSE      FALSE  FALSE     FALSE FALSE
    ##    Turn.circle Rear.seat.room Luggage.room Weight Origin  Make
    ## 1        FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 2        FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 3        FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 4        FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 5        FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 6        FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 7        FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 8        FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 9        FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 10       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 11       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 12       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 13       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 14       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 15       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 16       FALSE          FALSE         TRUE  FALSE  FALSE FALSE
    ## 17       FALSE          FALSE         TRUE  FALSE  FALSE FALSE
    ## 18       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 19       FALSE           TRUE         TRUE  FALSE  FALSE FALSE
    ## 20       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 21       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 22       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 23       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 24       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 25       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 26       FALSE          FALSE         TRUE  FALSE  FALSE FALSE
    ## 27       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 28       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 29       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 30       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 31       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 32       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 33       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 34       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 35       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 36       FALSE          FALSE         TRUE  FALSE  FALSE FALSE
    ## 37       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 38       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 39       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 40       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 41       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 42       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 43       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 44       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 45       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 46       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 47       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 48       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 49       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 50       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 51       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 52       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 53       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 54       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 55       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 56       FALSE          FALSE         TRUE  FALSE  FALSE FALSE
    ## 57       FALSE           TRUE         TRUE  FALSE  FALSE FALSE
    ## 58       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 59       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 60       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 61       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 62       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 63       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 64       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 65       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 66       FALSE          FALSE         TRUE  FALSE  FALSE FALSE
    ## 67       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 68       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 69       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 70       FALSE          FALSE         TRUE  FALSE  FALSE FALSE
    ## 71       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 72       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 73       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 74       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 75       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 76       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 77       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 78       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 79       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 80       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 81       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 82       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 83       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 84       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 85       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 86       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 87       FALSE          FALSE         TRUE  FALSE  FALSE FALSE
    ## 88       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 89       FALSE          FALSE         TRUE  FALSE  FALSE FALSE
    ## 90       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 91       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 92       FALSE          FALSE        FALSE  FALSE  FALSE FALSE
    ## 93       FALSE          FALSE        FALSE  FALSE  FALSE FALSE

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
# 아래 작업을 통해서 곁측치 제거 후 row 들의 index 를 초기화 할 수 있

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

``` r
#data$col[is.na(data$col)] <- 새로운값 : 새로운값으로 col 의 곁측치 대체
mean<-mean(Cars93$Luggage.room, na.rm=TRUE) # 곁측값 미포함한 col 의 mean
Cars93$Luggage.room[is.na(Cars93$Luggage.room)] <- mean #mean 으로 대체

#sapply(data, functio(x){ifelse}(is.na(x), 대체하고픈값, x )) # 모든 col 에 대해 새로운 값으로 col 곁측치 대체 
sapply(Cars93, function(x) {ifelse(is.na(x), mean(x, na.rm=TRUE), x)}) #sapply라 각 col 의 mean 으로 대체된다.
```

    ##       Manufacturer Model Type Min.Price Price Max.Price MPG.city MPG.highway
    ##  [1,]            1    49    4      12.9  15.9      18.8       25          31
    ##  [2,]            1    56    3      29.2  33.9      38.7       18          25
    ##  [3,]            2     9    1      25.9  29.1      32.3       20          26
    ##  [4,]            2     1    3      30.8  37.7      44.6       19          26
    ##  [5,]            3     6    3      23.7  30.0      36.2       22          30
    ##  [6,]            4    24    3      14.2  15.7      17.3       22          31
    ##  [7,]            4    54    2      19.9  20.8      21.7       19          28
    ##  [8,]            4    74    2      22.6  23.7      24.9       16          25
    ##  [9,]            4    73    3      26.3  26.3      26.3       19          27
    ## [10,]            5    35    2      33.0  34.7      36.3       16          25
    ## [11,]            5    79    3      37.5  40.1      42.7       16          25
    ## [12,]            6    22    1       8.5  13.4      18.3       25          36
    ## [13,]            6    30    1      11.4  11.4      11.4       25          34
    ## [14,]            6    17    5      13.4  15.1      16.8       19          28
    ## [15,]            6    58    3      13.4  15.9      18.4       21          29
    ## [16,]            6    59    6      14.7  16.3      18.0       18          23
    ## [17,]            6    15    6      14.7  16.6      18.6       15          20
    ## [18,]            6    20    2      18.0  18.8      19.6       17          26
    ## [19,]            6    31    5      34.6  38.0      41.5       17          25
    ## [20,]            7    27    2      18.4  18.4      18.4       20          28
    ## [21,]            8    52    1      14.5  15.8      17.1       23          28
    ## [22,]            8    48    2      29.5  29.5      29.5       20          26
    ## [23,]            9    26    4       7.9   9.2      10.6       29          33
    ## [24,]            9    80    4       8.4  11.3      14.2       23          29
    ## [25,]            9    83    1      11.9  13.3      14.7       22          27
    ## [26,]            9    21    6      13.6  19.0      24.4       17          21
    ## [27,]            9    37    3      14.8  15.6      16.4       21          27
    ## [28,]            9    84    5      18.5  25.8      33.1       18          24
    ## [29,]           10    86    4       7.9  12.2      16.5       29          33
    ## [30,]           10    93    2      17.5  19.3      21.2       20          28
    ## [31,]           11    44    4       6.9   7.4       7.9       31          33
    ## [32,]           11    41    4       8.4  10.1      11.9       23          30
    ## [33,]           11    90    1      10.4  11.3      12.2       22          27
    ## [34,]           11    64    5      10.8  15.9      21.0       22          29
    ## [35,]           11    68    5      12.8  14.0      15.2       24          30
    ## [36,]           11    13    6      14.5  19.9      25.3       15          20
    ## [37,]           11    89    3      15.6  20.2      24.8       21          30
    ## [38,]           11    33    2      20.1  20.9      21.7       18          26
    ## [39,]           12    62    4       6.7   8.4      10.0       46          50
    ## [40,]           12    85    5      11.5  12.5      13.5       30          36
    ## [41,]           13    66    5      17.0  19.8      22.7       24          31
    ## [42,]           13    25    4       8.4  12.1      15.8       42          46
    ## [43,]           13    11    1      13.8  17.5      21.2       24          31
    ## [44,]           14    43    4       6.8   8.0       9.2       29          33
    ## [45,]           14    40    4       9.0  10.0      11.0       22          29
    ## [46,]           14    77    5       9.1  10.0      11.0       26          34
    ## [47,]           14    82    3      12.4  13.9      15.3       20          27
    ## [48,]           15    70    3      45.4  47.9      50.4       17          22
    ## [49,]           16    38    3      27.5  28.0      28.4       18          24
    ## [50,]           16    75    3      34.7  35.2      35.6       18          23
    ## [51,]           17    28    3      33.3  34.3      35.3       17          26
    ## [52,]           17    92    2      34.4  36.1      37.8       18          26
    ## [53,]           18     5    4       7.4   8.3       9.1       29          37
    ## [54,]           18    69    4      10.9  11.6      12.3       28          36
    ## [55,]           18     7    1      14.3  16.5      18.7       26          34
    ## [56,]           18    60    6      16.6  19.1      21.7       18          24
    ## [57,]           18    72    5      32.5  32.5      32.5       17          25
    ## [58,]           19     2    1      29.0  31.9      34.9       20          29
    ## [59,]           19     4    3      43.8  61.9      80.0       19          25
    ## [60,]           20    19    5      13.3  14.1      15.0       23          26
    ## [61,]           20    32    3      14.9  14.9      14.9       19          26
    ## [62,]           21    63    4       7.7  10.3      12.9       29          33
    ## [63,]           21    36    3      22.4  26.1      29.9       18          24
    ## [64,]           22    78    4       8.7  11.8      14.9       29          33
    ## [65,]           22    14    1      13.0  15.7      18.3       24          30
    ## [66,]           22    71    6      16.7  19.1      21.5       17          23
    ## [67,]           22    61    3      21.0  21.5      22.0       21          26
    ## [68,]           23    12    1      13.0  13.5      14.0       24          31
    ## [69,]           23    34    3      14.2  16.3      18.4       23          31
    ## [70,]           23    81    6      19.5  19.5      19.5       18          23
    ## [71,]           23    39    2      19.5  20.7      21.9       19          28
    ## [72,]           24    51    5      11.4  14.4      17.4       23          30
    ## [73,]           25    53    4       8.2   9.0       9.9       31          41
    ## [74,]           25    87    1       9.4  11.1      12.8       23          31
    ## [75,]           25    45    5      14.0  17.7      21.4       19          28
    ## [76,]           25    47    3      15.4  18.5      21.6       19          27
    ## [77,]           25    16    2      19.4  24.4      29.4       19          28
    ## [78,]           26    10    1      20.3  28.7      37.1       20          26
    ## [79,]           27    76    4       9.2  11.1      12.9       28          38
    ## [80,]           28    50    4       7.3   8.4       9.5       33          37
    ## [81,]           28    57    4      10.5  10.9      11.3       25          30
    ## [82,]           28    55    1      16.3  19.5      22.7       23          30
    ## [83,]           29    88    4       7.3   8.6      10.0       39          43
    ## [84,]           30    91    4       7.8   9.8      11.8       32          37
    ## [85,]           30    23    5      14.2  18.4      22.6       25          32
    ## [86,]           30    18    3      15.2  18.2      21.2       22          29
    ## [87,]           30    67    6      18.9  22.7      26.6       18          22
    ## [88,]           31    46    4       8.7   9.1       9.5       25          33
    ## [89,]           31    42    6      16.6  19.7      22.7       17          21
    ## [90,]           31    65    1      17.6  20.0      22.4       21          30
    ## [91,]           31    29    5      22.9  23.3      23.7       18          25
    ## [92,]           32     3    1      21.8  22.7      23.5       21          28
    ## [93,]           32     8    3      24.8  26.7      28.5       20          28
    ##       AirBags DriveTrain Cylinders EngineSize Horsepower  RPM Rev.per.mile
    ##  [1,]       3          2         2        1.8        140 6300         2890
    ##  [2,]       1          2         4        3.2        200 5500         2335
    ##  [3,]       2          2         4        2.8        172 5500         2280
    ##  [4,]       1          2         4        2.8        172 5500         2535
    ##  [5,]       2          3         2        3.5        208 5700         2545
    ##  [6,]       2          2         2        2.2        110 5200         2565
    ##  [7,]       2          2         4        3.8        170 4800         1570
    ##  [8,]       2          3         4        5.7        180 4000         1320
    ##  [9,]       2          2         4        3.8        170 4800         1690
    ## [10,]       2          2         5        4.9        200 4100         1510
    ## [11,]       1          2         5        4.6        295 6000         1985
    ## [12,]       3          2         2        2.2        110 5200         2380
    ## [13,]       2          2         2        2.2        110 5200         2665
    ## [14,]       1          3         4        3.4        160 4600         1805
    ## [15,]       3          2         2        2.2        110 5200         2595
    ## [16,]       3          2         4        3.8        170 4800         1690
    ## [17,]       3          1         4        4.3        165 4000         1790
    ## [18,]       2          3         5        5.0        170 4200         1350
    ## [19,]       2          3         5        5.7        300 5000         1450
    ## [20,]       1          2         4        3.3        153 5300         1990
    ## [21,]       1          2         2        3.0        141 5000         2090
    ## [22,]       2          2         4        3.3        147 4800         1785
    ## [23,]       3          2         2        1.5         92 6000         3285
    ## [24,]       2          2         2        2.2         93 4800         2595
    ## [25,]       2          2         2        2.5        100 4800         2535
    ## [26,]       2          1         4        3.0        142 5000         1970
    ## [27,]       2          2         2        2.5        100 4800         2465
    ## [28,]       2          1         4        3.0        300 6000         2120
    ## [29,]       3          2         2        1.5         92 6000         2505
    ## [30,]       1          2         4        3.5        214 5800         1980
    ## [31,]       3          2         2        1.3         63 5000         3150
    ## [32,]       3          2         2        1.8        127 6500         2410
    ## [33,]       3          2         2        2.3         96 4200         2805
    ## [34,]       2          3         2        2.3        105 4600         2285
    ## [35,]       2          2         2        2.0        115 5500         2340
    ## [36,]       2          1         4        3.0        145 4800         2080
    ## [37,]       2          2         4        3.0        140 4800         1885
    ## [38,]       2          3         5        4.6        190 4200         1415
    ## [39,]       3          2         1        1.0         55 5700         3755
    ## [40,]       2          2         2        1.6         90 5400         3250
    ## [41,]       1          2         2        2.3        160 5800         2855
    ## [42,]       2          2         2        1.5        102 5900         2650
    ## [43,]       1          2         2        2.2        140 5600         2610
    ## [44,]       3          2         2        1.5         81 5500         2710
    ## [45,]       3          2         2        1.8        124 6000         2745
    ## [46,]       3          2         2        1.5         92 5550         2540
    ## [47,]       3          2         2        2.0        128 6000         2335
    ## [48,]       2          3         5        4.5        278 6000         1955
    ## [49,]       2          2         4        3.0        185 5200         2325
    ## [50,]       1          3         4        3.0        225 6000         2510
    ## [51,]       1          2         4        3.8        160 4400         1835
    ## [52,]       1          3         5        4.6        210 4600         1840
    ## [53,]       3          2         2        1.6         82 5000         2370
    ## [54,]       3          2         2        1.8        103 5500         2220
    ## [55,]       2          2         2        2.5        164 5600         2505
    ## [56,]       3          1         4        3.0        155 5000         2240
    ## [57,]       2          3         6        1.3        255 6500         2325
    ## [58,]       2          3         2        2.3        130 5100         2425
    ## [59,]       1          3         4        3.2        217 5500         2220
    ## [60,]       2          2         2        1.6        100 5750         2475
    ## [61,]       3          3         4        3.8        140 3800         1730
    ## [62,]       3          2         2        1.5         92 6000         2505
    ## [63,]       2          2         4        3.0        202 6000         2210
    ## [64,]       2          2         2        1.6        110 6000         2435
    ## [65,]       2          2         2        2.4        150 5600         2130
    ## [66,]       3          2         4        3.0        151 4800         2065
    ## [67,]       2          2         4        3.0        160 5200         2045
    ## [68,]       3          2         2        2.3        155 6000         2380
    ## [69,]       2          2         2        2.2        110 5200         2565
    ## [70,]       3          2         4        3.8        170 4800         1690
    ## [71,]       2          2         4        3.8        170 4800         1570
    ## [72,]       3          1         2        1.8         92 5000         2360
    ## [73,]       3          2         2        1.6         74 5600         3130
    ## [74,]       3          2         2        2.0        110 5200         2665
    ## [75,]       1          3         4        3.4        160 4600         1805
    ## [76,]       3          2         4        3.4        200 5000         1890
    ## [77,]       1          2         4        3.8        170 4800         1565
    ## [78,]       2          2         2        2.1        140 6000         2910
    ## [79,]       2          2         2        1.9         85 5000         2145
    ## [80,]       3          1         1        1.2         73 5600         2875
    ## [81,]       3          1         2        1.8         90 5200         3375
    ## [82,]       2          1         2        2.2        130 5600         2330
    ## [83,]       3          2         1        1.3         70 6000         3360
    ## [84,]       2          2         2        1.5         82 5200         3505
    ## [85,]       2          2         2        2.2        135 5400         2405
    ## [86,]       2          2         2        2.2        130 5400         2340
    ## [87,]       2          1         2        2.4        138 5000         2515
    ## [88,]       3          2         2        1.8         81 5500         2550
    ## [89,]       3          2         3        2.5        109 4500         2915
    ## [90,]       3          2         2        2.0        134 5800         2685
    ## [91,]       3          2         4        2.8        178 5800         2385
    ## [92,]       2          3         2        2.3        114 5400         2215
    ## [93,]       1          2         3        2.4        168 6200         2310
    ##       Man.trans.avail Fuel.tank.capacity Passengers Length Wheelbase Width
    ##  [1,]               2               13.2          5    177       102    68
    ##  [2,]               2               18.0          5    195       115    71
    ##  [3,]               2               16.9          5    180       102    67
    ##  [4,]               2               21.1          6    193       106    70
    ##  [5,]               2               21.1          4    186       109    69
    ##  [6,]               1               16.4          6    189       105    69
    ##  [7,]               1               18.0          6    200       111    74
    ##  [8,]               1               23.0          6    216       116    78
    ##  [9,]               1               18.8          5    198       108    73
    ## [10,]               1               18.0          6    206       114    73
    ## [11,]               1               20.0          5    204       111    74
    ## [12,]               2               15.2          5    182       101    66
    ## [13,]               2               15.6          5    184       103    68
    ## [14,]               2               15.5          4    193       101    74
    ## [15,]               1               16.5          6    198       108    71
    ## [16,]               1               20.0          7    178       110    74
    ## [17,]               1               27.0          8    194       111    78
    ## [18,]               1               23.0          6    214       116    77
    ## [19,]               2               20.0          2    179        96    74
    ## [20,]               1               18.0          6    203       113    74
    ## [21,]               1               16.0          6    183       104    68
    ## [22,]               1               16.0          6    203       110    69
    ## [23,]               2               13.2          5    174        98    66
    ## [24,]               2               14.0          5    172        97    67
    ## [25,]               2               16.0          6    181       104    68
    ## [26,]               1               20.0          7    175       112    72
    ## [27,]               1               16.0          6    192       105    69
    ## [28,]               2               19.8          4    180        97    72
    ## [29,]               2               13.2          5    174        98    66
    ## [30,]               1               18.0          6    202       113    74
    ## [31,]               2               10.0          4    141        90    63
    ## [32,]               2               13.2          5    171        98    67
    ## [33,]               2               15.9          5    177       100    68
    ## [34,]               2               15.4          4    180       101    68
    ## [35,]               2               15.5          4    179       103    70
    ## [36,]               2               21.0          7    176       119    72
    ## [37,]               1               16.0          5    192       106    71
    ## [38,]               1               20.0          6    212       114    78
    ## [39,]               2               10.6          4    151        93    63
    ## [40,]               2               12.4          4    164        97    67
    ## [41,]               2               15.9          4    175       100    70
    ## [42,]               2               11.9          4    173       103    67
    ## [43,]               2               17.0          4    185       107    67
    ## [44,]               2               11.9          5    168        94    63
    ## [45,]               2               13.7          5    172        98    66
    ## [46,]               2               11.9          4    166        94    64
    ## [47,]               2               17.2          5    184       104    69
    ## [48,]               1               22.5          5    200       113    72
    ## [49,]               2               18.5          5    188       103    70
    ## [50,]               2               20.6          4    191       106    71
    ## [51,]               1               18.4          6    205       109    73
    ## [52,]               1               20.0          6    219       117    77
    ## [53,]               2               13.2          4    164        97    66
    ## [54,]               2               14.5          5    172        98    66
    ## [55,]               2               15.5          5    184       103    69
    ## [56,]               1               19.6          7    190       110    72
    ## [57,]               2               20.0          2    169        96    69
    ## [58,]               2               14.5          5    175       105    67
    ## [59,]               1               18.5          5    187       110    69
    ## [60,]               2               11.1          4    166        95    65
    ## [61,]               1               18.0          5    199       113    73
    ## [62,]               2               13.2          5    172        98    67
    ## [63,]               1               19.0          5    190       107    70
    ## [64,]               2               13.2          5    170        96    66
    ## [65,]               2               15.9          5    181       103    67
    ## [66,]               1               20.0          7    190       112    74
    ## [67,]               1               18.5          5    188       104    69
    ## [68,]               1               15.2          5    188       103    67
    ## [69,]               1               16.5          5    190       105    70
    ## [70,]               1               20.0          7    194       110    74
    ## [71,]               1               18.0          6    201       111    74
    ## [72,]               2               15.9          4    173        97    67
    ## [73,]               2               13.2          4    177        99    66
    ## [74,]               2               15.2          5    181       101    66
    ## [75,]               2               15.5          4    196       101    75
    ## [76,]               2               16.5          5    195       108    72
    ## [77,]               1               18.0          6    177       111    74
    ## [78,]               2               18.0          5    184        99    67
    ## [79,]               2               12.8          5    176       102    68
    ## [80,]               2                9.2          4    146        90    60
    ## [81,]               2               15.9          5    175        97    65
    ## [82,]               2               15.9          5    179       102    67
    ## [83,]               2               10.6          4    161        93    63
    ## [84,]               2               11.9          5    162        94    65
    ## [85,]               2               15.9          4    174        99    69
    ## [86,]               2               18.5          5    188       103    70
    ## [87,]               2               19.8          7    187       113    71
    ## [88,]               2               12.4          4    163        93    63
    ## [89,]               2               21.1          7    187       115    72
    ## [90,]               2               18.5          5    180       103    67
    ## [91,]               2               18.5          4    159        97    66
    ## [92,]               2               15.8          5    190       104    67
    ## [93,]               2               19.3          5    184       105    69
    ##       Turn.circle Rear.seat.room Luggage.room Weight Origin Make
    ##  [1,]          37       26.50000     11.00000   2705      2    1
    ##  [2,]          38       30.00000     15.00000   3560      2    2
    ##  [3,]          37       28.00000     14.00000   3375      2    4
    ##  [4,]          37       31.00000     17.00000   3405      2    3
    ##  [5,]          39       27.00000     13.00000   3640      2    5
    ##  [6,]          41       28.00000     16.00000   2880      1    6
    ##  [7,]          42       30.50000     17.00000   3470      1    7
    ##  [8,]          45       30.50000     21.00000   4105      1    9
    ##  [9,]          41       26.50000     14.00000   3495      1    8
    ## [10,]          43       35.00000     18.00000   3620      1   10
    ## [11,]          44       31.00000     14.00000   3935      1   11
    ## [12,]          38       25.00000     13.00000   2490      1   15
    ## [13,]          39       26.00000     14.00000   2785      1   16
    ## [14,]          43       25.00000     13.00000   3240      1   13
    ## [15,]          40       28.50000     16.00000   3195      1   18
    ## [16,]          44       30.50000     13.89024   3715      1   19
    ## [17,]          42       33.50000     13.89024   4025      1   12
    ## [18,]          42       29.50000     20.00000   3910      1   14
    ## [19,]          43       27.82967     13.89024   3380      1   17
    ## [20,]          40       31.00000     15.00000   3515      1   20
    ## [21,]          41       30.50000     14.00000   3085      1   22
    ## [22,]          44       36.00000     17.00000   3570      1   21
    ## [23,]          32       26.50000     11.00000   2270      1   24
    ## [24,]          38       26.50000     13.00000   2670      1   26
    ## [25,]          39       30.50000     14.00000   2970      1   27
    ## [26,]          42       26.50000     13.89024   3705      1   23
    ## [27,]          42       30.50000     16.00000   3080      1   25
    ## [28,]          40       20.00000     11.00000   3805      1   28
    ## [29,]          36       26.50000     11.00000   2295      1   29
    ## [30,]          40       30.00000     15.00000   3490      1   30
    ## [31,]          33       26.00000     12.00000   1845      1   34
    ## [32,]          36       28.00000     12.00000   2530      1   33
    ## [33,]          39       27.50000     13.00000   2690      1   38
    ## [34,]          40       24.00000     12.00000   2850      1   35
    ## [35,]          38       23.00000     18.00000   2710      1   36
    ## [36,]          45       30.00000     13.89024   3735      1   31
    ## [37,]          40       27.50000     18.00000   3325      1   37
    ## [38,]          43       30.00000     21.00000   3950      1   32
    ## [39,]          34       27.50000     10.00000   1695      2   39
    ## [40,]          37       24.50000     11.00000   2475      2   40
    ## [41,]          39       23.50000      8.00000   2865      2   43
    ## [42,]          36       28.00000     12.00000   2350      2   42
    ## [43,]          41       28.00000     14.00000   3040      2   41
    ## [44,]          35       26.00000     11.00000   2345      2   45
    ## [45,]          36       28.00000     12.00000   2620      2   44
    ## [46,]          34       23.50000      9.00000   2285      2   46
    ## [47,]          41       31.00000     14.00000   2885      2   47
    ## [48,]          42       29.00000     15.00000   4000      2   48
    ## [49,]          40       27.50000     14.00000   3510      2   49
    ## [50,]          39       25.00000      9.00000   3515      2   50
    ## [51,]          42       30.00000     19.00000   3695      1   51
    ## [52,]          45       31.50000     22.00000   4055      1   52
    ## [53,]          34       27.00000     16.00000   2325      2   53
    ## [54,]          36       26.50000     13.00000   2440      2   56
    ## [55,]          40       29.50000     14.00000   2970      2   54
    ## [56,]          39       27.50000     13.89024   3735      2   55
    ## [57,]          37       27.82967     13.89024   2895      2   57
    ## [58,]          34       26.00000     12.00000   2920      2   58
    ## [59,]          37       27.00000     15.00000   3525      2   59
    ## [60,]          36       19.00000      6.00000   2450      1   60
    ## [61,]          38       28.00000     15.00000   3610      1   61
    ## [62,]          36       26.00000     11.00000   2295      2   63
    ## [63,]          43       27.50000     14.00000   3730      2   62
    ## [64,]          33       26.00000     12.00000   2545      2   67
    ## [65,]          40       28.50000     14.00000   3050      2   64
    ## [66,]          41       27.00000     13.89024   4100      2   66
    ## [67,]          41       28.50000     14.00000   3200      2   65
    ## [68,]          39       28.00000     14.00000   2910      1   68
    ## [69,]          42       28.00000     16.00000   2890      1   69
    ## [70,]          44       30.50000     13.89024   3715      1   71
    ## [71,]          42       31.50000     17.00000   3470      1   70
    ## [72,]          39       24.50000      8.00000   2640      1   72
    ## [73,]          35       25.50000     17.00000   2350      1   76
    ## [74,]          39       25.00000     13.00000   2575      1   77
    ## [75,]          43       25.00000     13.00000   3240      1   74
    ## [76,]          41       28.50000     16.00000   3450      1   75
    ## [77,]          43       30.50000     18.00000   3495      1   73
    ## [78,]          37       26.50000     14.00000   2775      2   78
    ## [79,]          40       26.50000     12.00000   2495      1   79
    ## [80,]          32       23.50000     10.00000   2045      2   80
    ## [81,]          35       27.50000     15.00000   2490      2   82
    ## [82,]          37       27.00000     14.00000   3085      2   81
    ## [83,]          34       27.50000     10.00000   1965      2   83
    ## [84,]          36       24.00000     11.00000   2055      2   87
    ## [85,]          39       23.00000     13.00000   2950      2   85
    ## [86,]          38       28.50000     15.00000   3030      2   84
    ## [87,]          41       35.00000     13.89024   3785      2   86
    ## [88,]          34       26.00000     10.00000   2240      2   90
    ## [89,]          38       34.00000     13.89024   3960      2   89
    ## [90,]          35       31.50000     14.00000   2985      2   91
    ## [91,]          36       26.00000     15.00000   2810      2   88
    ## [92,]          37       29.50000     14.00000   2985      2   92
    ## [93,]          38       30.00000     15.00000   3245      2   93
