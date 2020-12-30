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

# sampling 함수

``` r
# 전체 관측치 중에서 100개만 비복원 추출
diamonds %>%
  sample_n(100)
```

    ## # A tibble: 100 x 10
    ##    carat cut       color clarity depth table price width length heigth
    ##    <dbl> <ord>     <ord> <ord>   <dbl> <dbl> <int> <dbl>  <dbl>  <dbl>
    ##  1  1.28 Ideal     F     SI2      62.3    55  6458  6.96   6.91   4.32
    ##  2  1.5  Ideal     D     VS2      62.6    56 15848  7.21   7.27   4.53
    ##  3  1    Good      D     SI2      64.3    53  3965  6.34   6.29   4.06
    ##  4  1.01 Very Good G     SI1      63.5    60  4271  6.41   6.38   3.92
    ##  5  1.06 Very Good E     IF       62.7    58 11518  6.48   6.54   4.08
    ##  6  0.38 Ideal     E     SI2      61.8    56   628  4.62   4.66   2.87
    ##  7  0.7  Good      D     VS2      63.9    58  3087  5.58   5.62   3.58
    ##  8  0.3  Very Good D     SI1      63.4    55   662  4.26   4.22   2.69
    ##  9  0.23 Ideal     F     VVS2     62.5    55   511  3.94   3.96   2.47
    ## 10  0.6  Premium   D     SI1      61.6    58  1896  5.42   5.45   3.35
    ## # ... with 90 more rows

``` r
# 100개만 복원 추출
diamonds %>%
  sample_n(100,
           replace = T)
```

    ## # A tibble: 100 x 10
    ##    carat cut       color clarity depth table price width length heigth
    ##    <dbl> <ord>     <ord> <ord>   <dbl> <dbl> <int> <dbl>  <dbl>  <dbl>
    ##  1  0.32 Ideal     F     SI1      61      55   648  4.45   4.47   2.72
    ##  2  1.5  Fair      I     SI2      64.8    58  6717  7.05   7.15   4.6 
    ##  3  0.63 Premium   E     SI2      58.9    59  1169  5.64   5.6    3.31
    ##  4  1.2  Premium   H     SI1      62.9    56  6129  6.8    6.74   4.26
    ##  5  1.08 Very Good E     SI2      60.2    58  4656  6.61   6.68   4   
    ##  6  0.51 Good      G     VS2      63.5    57  1343  5.05   5.06   3.21
    ##  7  0.7  Very Good J     SI2      63.6    56  1609  5.57   5.63   3.56
    ##  8  1    Ideal     H     SI1      61.4    55  4469  6.49   6.44   3.97
    ##  9  1.3  Premium   F     VS2      60.4    59 10090  7.12   7.06   4.28
    ## 10  0.33 Ideal     G     VVS1     62.4    56   820  4.41   4.45   2.76
    ## # ... with 90 more rows

``` r
# 전체 데이터중에 30% 비복원 추출
diamonds %>%
  sample_frac(.3)
```

    ## # A tibble: 16,182 x 10
    ##    carat cut       color clarity depth table price width length heigth
    ##    <dbl> <ord>     <ord> <ord>   <dbl> <dbl> <int> <dbl>  <dbl>  <dbl>
    ##  1  0.65 Premium   D     VS1      59.4    62  2387  5.72   5.66   3.38
    ##  2  0.61 Ideal     F     VS1      62.3    55  2366  5.46   5.49   3.41
    ##  3  0.8  Ideal     I     VS1      62.2    58  2906  5.92   5.95   3.69
    ##  4  0.32 Ideal     D     VVS2     62.2    56   790  4.37   4.41   2.73
    ##  5  1.2  Very Good H     SI1      61.2    57  6019  6.78   6.91   4.19
    ##  6  1.12 Premium   H     SI2      62.1    56  4014  6.7    6.65   4.14
    ##  7  0.34 Very Good E     SI1      63.3    57   714  4.47   4.44   2.82
    ##  8  0.56 Ideal     I     VVS1     61.1    55  1622  5.33   5.35   3.26
    ##  9  0.61 Ideal     G     VS1      62.6    55  2309  5.46   5.43   3.41
    ## 10  0.3  Ideal     G     IF       62.1    55   895  4.31   4.35   2.69
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
