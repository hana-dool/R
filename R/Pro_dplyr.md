dplyr 기초 전처리
================

``` r
library(dplyr)
library(ggplot2)
```

``` r
id <- c(1,2,3,4,5,6)
class <- c(2,1,2,1,1,2)
english <- c(98,97,86,98,80,89)
science <- c(50,60,78,58,65,98)
data <- data.frame(id,class,english,science) ; data
```

    ##   id class english science
    ## 1  1     2      98      50
    ## 2  2     1      97      60
    ## 3  3     2      86      78
    ## 4  4     1      98      58
    ## 5  5     1      80      65
    ## 6  6     2      89      98

### %\>% 파이프 연산자

함수의 출력이 그 다음값으로 바로 들어가는것  
%\>% 함수1 %\>% 함수2(함수1의 값을 이용) %\>%……  
function (dataframe,arg1,arg2)  
dataframe %\>%  
function(arg1,ar2) \# 위와 이 표현은 같다.

# select

데이터 프레임에서 내가 원하는 column 만 선택하겠다.

``` r
data %>% # 데이터가 slect 의 입력으로 들어감
  select(class,english) # class, english 만 표출해라
```

    ##   class english
    ## 1     2      98
    ## 2     1      97
    ## 3     2      86
    ## 4     1      98
    ## 5     1      80
    ## 6     2      89

# filter

특정 row 만 뽑고싶을때———-\#

``` r
data %>%
  filter(class==1) # class 가 1반인 observation 만 보고싶어어
```

    ##   id class english science
    ## 1  2     1      97      60
    ## 2  4     1      98      58
    ## 3  5     1      80      65

\<= \> \!= 등 많은 operator 가 가능하다. is.na (missing value 가 있느냐 없느냐) logical
operator 를 다양하게 사용해서 filter 과 같이 사용할 수 있다.

# EX

``` r
# 다이아몬드 가격이 950 이하이고, 800이상인 것만 고를 때
diamonds %>%
  filter(price <= 950 & price >= 800)
```

    ## # A tibble: 3,707 x 10
    ##    carat cut       color clarity depth table price     x     y     z
    ##    <dbl> <ord>     <ord> <ord>   <dbl> <dbl> <int> <dbl> <dbl> <dbl>
    ##  1  0.41 Very Good G     VS2      61.4  57     800  4.76  4.81  2.94
    ##  2  0.32 Ideal     F     VVS2     62.1  55     800  4.37  4.39  2.72
    ##  3  0.32 Ideal     F     VVS2     61.2  57     800  4.42  4.44  2.71
    ##  4  0.32 Ideal     F     VVS2     60.9  56     800  4.44  4.46  2.71
    ##  5  0.32 Ideal     F     VVS2     61.2  55     800  4.43  4.46  2.72
    ##  6  0.38 Ideal     I     VVS1     62.4  54.8   800  4.64  4.66  2.9 
    ##  7  0.4  Ideal     H     VS2      61.6  57     800  4.71  4.74  2.91
    ##  8  0.36 Ideal     D     VS2      61.8  55     800  4.58  4.61  2.84
    ##  9  0.31 Ideal     E     VS1      62    55     800  4.35  4.38  2.7 
    ## 10  0.31 Ideal     E     VS1      61.7  53     800  4.36  4.39  2.7 
    ## # ... with 3,697 more rows

``` r
# c로 시작하는 변수들만 선택
diamonds %>%
  select(starts_with("c"))
```

    ## # A tibble: 53,940 x 4
    ##    carat cut       color clarity
    ##    <dbl> <ord>     <ord> <ord>  
    ##  1 0.23  Ideal     E     SI2    
    ##  2 0.21  Premium   E     SI1    
    ##  3 0.23  Good      E     VS1    
    ##  4 0.290 Premium   I     VS2    
    ##  5 0.31  Good      J     SI2    
    ##  6 0.24  Very Good J     VVS2   
    ##  7 0.24  Very Good I     VVS1   
    ##  8 0.26  Very Good H     SI1    
    ##  9 0.22  Fair      E     VS2    
    ## 10 0.23  Very Good H     VS1    
    ## # ... with 53,930 more rows

``` r
# 변수의 끝나는 스펠링
diamonds %>%
  select(ends_with("e"))
```

    ## # A tibble: 53,940 x 2
    ##    table price
    ##    <dbl> <int>
    ##  1    55   326
    ##  2    61   326
    ##  3    65   327
    ##  4    58   334
    ##  5    58   335
    ##  6    57   336
    ##  7    57   336
    ##  8    55   337
    ##  9    61   337
    ## 10    61   338
    ## # ... with 53,930 more rows

``` r
# 변수에 포함된 스펠링 
diamonds %>%
  select(contains("r"))
```

    ## # A tibble: 53,940 x 4
    ##    carat color clarity price
    ##    <dbl> <ord> <ord>   <int>
    ##  1 0.23  E     SI2       326
    ##  2 0.21  E     SI1       326
    ##  3 0.23  E     VS1       327
    ##  4 0.290 I     VS2       334
    ##  5 0.31  J     SI2       335
    ##  6 0.24  J     VVS2      336
    ##  7 0.24  I     VVS1      336
    ##  8 0.26  H     SI1       337
    ##  9 0.22  E     VS2       337
    ## 10 0.23  H     VS1       338
    ## # ... with 53,930 more rows

``` r
# 특정 위치의 선택
diamonds %>%
  select(1:4)
```

    ## # A tibble: 53,940 x 4
    ##    carat cut       color clarity
    ##    <dbl> <ord>     <ord> <ord>  
    ##  1 0.23  Ideal     E     SI2    
    ##  2 0.21  Premium   E     SI1    
    ##  3 0.23  Good      E     VS1    
    ##  4 0.290 Premium   I     VS2    
    ##  5 0.31  Good      J     SI2    
    ##  6 0.24  Very Good J     VVS2   
    ##  7 0.24  Very Good I     VVS1   
    ##  8 0.26  Very Good H     SI1    
    ##  9 0.22  Fair      E     VS2    
    ## 10 0.23  Very Good H     VS1    
    ## # ... with 53,930 more rows

``` r
data %>%
  select(english,science) %>% # 데이터에서 영어와 과학 col 만 선택하고
  filter(science >= 70) %>% # 그다음 과학 점수는 70점 이상인거만 고르고
  head(2) # 그다음 2개의 row 만 출력
```

    ##   english science
    ## 1      86      78
    ## 2      89      98

# Arrange

``` r
data %>%
  arrange(id) # 오름차순 정렬
```

    ##   id class english science
    ## 1  1     2      98      50
    ## 2  2     1      97      60
    ## 3  3     2      86      78
    ## 4  4     1      98      58
    ## 5  5     1      80      65
    ## 6  6     2      89      98

``` r
data %>%
  arrange(desc(id)) # 내림차순 정렬
```

    ##   id class english science
    ## 1  6     2      89      98
    ## 2  5     1      80      65
    ## 3  4     1      98      58
    ## 4  3     2      86      78
    ## 5  2     1      97      60
    ## 6  1     2      98      50

``` r
data %>%
  arrange(id, desc(science)) # id 는 오름차순 그리고 science 는 내림차순 정렬
```

    ##   id class english science
    ## 1  1     2      98      50
    ## 2  2     1      97      60
    ## 3  3     2      86      78
    ## 4  4     1      98      58
    ## 5  5     1      80      65
    ## 6  6     2      89      98

``` r
# id 가 먼저 순위가 된다. 

data %>%
  mutate(total = english+science) # 새로운 total 이라는 column 변수가 들어가게 된다.
```

    ##   id class english science total
    ## 1  1     2      98      50   148
    ## 2  2     1      97      60   157
    ## 3  3     2      86      78   164
    ## 4  4     1      98      58   156
    ## 5  5     1      80      65   145
    ## 6  6     2      89      98   187

``` r
data%>%
  mutate(total = english+science) %>%
  mutate(mean = total/2) %>%
  mutate(test = ifelse(mean>=60,'pass','fail')) # 이렇게 ifelse 를 쓸 수 있음
```

    ##   id class english science total mean test
    ## 1  1     2      98      50   148 74.0 pass
    ## 2  2     1      97      60   157 78.5 pass
    ## 3  3     2      86      78   164 82.0 pass
    ## 4  4     1      98      58   156 78.0 pass
    ## 5  5     1      80      65   145 72.5 pass
    ## 6  6     2      89      98   187 93.5 pass

# Summarize

``` r
storm = data.frame(storms)
# 이렇게 아래처럼 summarise 가능
storm %>%
  summarise(n_obs = n(), # 총 몇개인지 알고싶다면 n()
            max_wind = max(wind),
            min_wind = min(wind)) # 제일 약한 바람
```

    ##   n_obs max_wind min_wind
    ## 1 10010      160       10

# grouping

``` r
storm %>%
  group_by(name,year)  # name 과 year로 오름차순으로 
```

    ## # A tibble: 10,010 x 13
    ## # Groups:   name, year [426]
    ##    name   year month   day  hour   lat  long status category  wind pressure
    ##    <chr> <dbl> <dbl> <int> <dbl> <dbl> <dbl> <chr>  <ord>    <int>    <int>
    ##  1 Amy    1975     6    27     0  27.5 -79   tropi~ -1          25     1013
    ##  2 Amy    1975     6    27     6  28.5 -79   tropi~ -1          25     1013
    ##  3 Amy    1975     6    27    12  29.5 -79   tropi~ -1          25     1013
    ##  4 Amy    1975     6    27    18  30.5 -79   tropi~ -1          25     1013
    ##  5 Amy    1975     6    28     0  31.5 -78.8 tropi~ -1          25     1012
    ##  6 Amy    1975     6    28     6  32.4 -78.7 tropi~ -1          25     1012
    ##  7 Amy    1975     6    28    12  33.3 -78   tropi~ -1          25     1011
    ##  8 Amy    1975     6    28    18  34   -77   tropi~ -1          30     1006
    ##  9 Amy    1975     6    29     0  34.4 -75.8 tropi~ 0           35     1004
    ## 10 Amy    1975     6    29     6  34   -74.8 tropi~ 0           40     1002
    ## # ... with 10,000 more rows, and 2 more variables: ts_diameter <dbl>,
    ## #   hu_diameter <dbl>

``` r
# --------- grouping + summarizing
storm %>%
  group_by(name,year) %>% # 이름과, 년도에 대해 grouping
  summarise(n_obs = n(), # 각 group 에서 갯수가 몇개?
            max_wind = max(wind), # max wind 는 얼마?
            min_wind = min(wind)) 
```

    ## `summarise()` regrouping output by 'name' (override with `.groups` argument)

    ## # A tibble: 426 x 5
    ## # Groups:   name [198]
    ##    name      year n_obs max_wind min_wind
    ##    <chr>    <dbl> <int>    <int>    <int>
    ##  1 AL011993  1993     8       30       25
    ##  2 AL012000  2000     4       25       25
    ##  3 AL021992  1992     5       30       25
    ##  4 AL021994  1994     6       30       15
    ##  5 AL021999  1999     4       30       25
    ##  6 AL022000  2000    12       30       25
    ##  7 AL022001  2001     5       25       25
    ##  8 AL022003  2003     4       30       30
    ##  9 AL022006  2006     5       45       30
    ## 10 AL031987  1987    32       40       10
    ## # ... with 416 more rows

# 사용자 정의 함수 사용

``` r
knot <- function(knot){
  mph <- 1.152 * knot
}
# 위와 같이 함수를 만든다.

storm %>%
  summarise(n_obs = n(),
            max_wind = knot(max(wind))) # 다음과 같이 미리 정의한 함수 이용 가능
```

    ##   n_obs max_wind
    ## 1 10010   184.32

# 데이터 변수 이름 변환\[rename\]

``` r
diamonds <- diamonds %>%
  rename(width  = x,
         length = y,
         heigth = z)

colnames(diamonds)
```

    ##  [1] "carat"   "cut"     "color"   "clarity" "depth"   "table"   "price"  
    ##  [8] "width"   "length"  "heigth"

# 선택(select\_if)

아래 경우는 numeric 의 경우만 선택한다.

``` r
mydata <- mtcars %>%
  select_if(is.numeric)
mydata
```

    ##                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
    ## Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
    ## Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
    ## Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
    ## Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
    ## Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
    ## Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
    ## Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
    ## Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
    ## Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
    ## Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
    ## Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
    ## Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
    ## Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
    ## Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
    ## Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
    ## Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
    ## Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
    ## Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
    ## Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
    ## Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
    ## AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
    ## Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
    ## Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
    ## Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
    ## Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
    ## Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
    ## Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
    ## Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
    ## Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
    ## Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2

# sampling 함수

``` r
# 전체 관측치 중에서 100개만 비복원 추출
diamonds %>%
  sample_n(100)
```

    ## # A tibble: 100 x 10
    ##    carat cut       color clarity depth table price width length heigth
    ##    <dbl> <ord>     <ord> <ord>   <dbl> <dbl> <int> <dbl>  <dbl>  <dbl>
    ##  1  0.7  Premium   I     I1       62.3    58  1107  5.69   5.55   3.51
    ##  2  0.54 Good      E     SI1      57.2    59  1323  5.37   5.32   3.06
    ##  3  0.85 Ideal     G     SI1      61.6    55  3023  6.09   6.11   3.76
    ##  4  0.32 Ideal     G     IF       61.7    54   918  4.39   4.42   2.72
    ##  5  1.51 Very Good I     SI1      62.2    60  8637  7.23   7.3    4.52
    ##  6  0.32 Ideal     D     VS2      62.2    56   972  4.4    4.38   2.73
    ##  7  1.03 Ideal     E     VVS2     61.7    54  9932  6.49   6.52   4.02
    ##  8  0.52 Premium   F     VS2      60.7    59  1720  5.18   5.14   3.13
    ##  9  1.26 Ideal     G     VS1      61.6    56  9243  7.03   6.96   4.31
    ## 10  0.4  Good      D     SI1      63.1    61   720  4.67   4.71   2.96
    ## # ... with 90 more rows

``` r
# 100개만 복원 추출
diamonds %>%
  sample_n(100,
           replace = T)
```

    ## # A tibble: 100 x 10
    ##    carat cut     color clarity depth table price width length heigth
    ##    <dbl> <ord>   <ord> <ord>   <dbl> <dbl> <int> <dbl>  <dbl>  <dbl>
    ##  1  1.02 Premium E     VS2      60      59  7311  6.56   6.54   3.93
    ##  2  0.46 Ideal   G     IF       60.9    57  1560  4.98   5.01   3.04
    ##  3  0.81 Ideal   D     VS2      59.5    60  4315  6.08   6.15   3.64
    ##  4  0.31 Ideal   D     VS1      62.1    57   877  4.35   4.32   2.69
    ##  5  1    Ideal   E     SI1      62.7    57  5622  6.39   6.49   4.04
    ##  6  0.71 Ideal   F     VS1      61.5    56  3710  5.72   5.76   3.53
    ##  7  0.5  Ideal   E     SI1      61.6    55  1410  5.09   5.13   3.15
    ##  8  1.14 Ideal   G     VVS1     61      56  9037  6.75   6.8    4.13
    ##  9  1.02 Ideal   G     VS2      62.3    56  6796  6.46   6.51   4.04
    ## 10  0.31 Ideal   E     VS1      61.7    53   800  4.36   4.39   2.7 
    ## # ... with 90 more rows

``` r
# 전체 데이터중에 30% 비복원 추출
diamonds %>%
  sample_frac(.3)
```

    ## # A tibble: 16,182 x 10
    ##    carat cut       color clarity depth table price width length heigth
    ##    <dbl> <ord>     <ord> <ord>   <dbl> <dbl> <int> <dbl>  <dbl>  <dbl>
    ##  1  0.9  Premium   F     VS1      59      58  4770  6.29   6.33   3.72
    ##  2  0.9  Good      D     VVS1     62.9    58  8239  6.01   6.1    3.81
    ##  3  0.34 Ideal     D     SI1      62.3    57   803  4.48   4.44   2.78
    ##  4  0.31 Premium   G     VVS1     63      58  1046  4.32   4.29   2.71
    ##  5  0.91 Very Good G     VS2      62.7    63  3776  6.05   6      3.78
    ##  6  0.38 Very Good D     SI2      61.1    58   633  4.62   4.68   2.84
    ##  7  0.24 Very Good E     VS2      63      58   419  3.94   3.97   2.49
    ##  8  1.53 Ideal     I     SI1      62.3    56  9315  7.37   7.4    4.6 
    ##  9  1.13 Premium   E     SI1      62.7    57  5012  6.65   6.62   4.16
    ## 10  2.01 Very Good H     VS2      63.5    59 16677  7.92   7.86   5.01
    ## # ... with 16,172 more rows

\#————————– Advanced working——————–\#

``` r
# group by 로 두개 변수의 combination 에 대해서 각 value 들의 count
diamonds %>% 
  group_by(cut,color) %>%
  summarise(count = n())
```

    ## `summarise()` regrouping output by 'cut' (override with `.groups` argument)

    ## # A tibble: 35 x 3
    ## # Groups:   cut [5]
    ##    cut   color count
    ##    <ord> <ord> <int>
    ##  1 Fair  D       163
    ##  2 Fair  E       224
    ##  3 Fair  F       312
    ##  4 Fair  G       314
    ##  5 Fair  H       303
    ##  6 Fair  I       175
    ##  7 Fair  J       119
    ##  8 Good  D       662
    ##  9 Good  E       933
    ## 10 Good  F       909
    ## # ... with 25 more rows

``` r
# 이렇게 해도 위와 같다.
diamonds %>%
  count(cut,color) 
```

    ## # A tibble: 35 x 3
    ##    cut   color     n
    ##    <ord> <ord> <int>
    ##  1 Fair  D       163
    ##  2 Fair  E       224
    ##  3 Fair  F       312
    ##  4 Fair  G       314
    ##  5 Fair  H       303
    ##  6 Fair  I       175
    ##  7 Fair  J       119
    ##  8 Good  D       662
    ##  9 Good  E       933
    ## 10 Good  F       909
    ## # ... with 25 more rows

``` r
# group by 로 두개 변수의 combination에 대해서, unique 한 clarity 의 count
diamonds %>% 
  group_by(cut ,color) %>%
  summarise(count = n_distinct(clarity))
```

    ## `summarise()` regrouping output by 'cut' (override with `.groups` argument)

    ## # A tibble: 35 x 3
    ## # Groups:   cut [5]
    ##    cut   color count
    ##    <ord> <ord> <int>
    ##  1 Fair  D         8
    ##  2 Fair  E         7
    ##  3 Fair  F         8
    ##  4 Fair  G         8
    ##  5 Fair  H         7
    ##  6 Fair  I         7
    ##  7 Fair  J         7
    ##  8 Good  D         8
    ##  9 Good  E         8
    ## 10 Good  F         8
    ## # ... with 25 more rows

``` r
# 즉 fair cut, D color 인 경우에, clarity 의 종류는 8개
```
