ggplot 기초
================

``` r
library('ggplot2')
```

# ggplot2 의 문법 및 기초

ggplot2 는 시각화 그래프 패키지이다. <br> ggplot 은 신규 요소를 하나씩 쌓아가는 방식으로 그래프를 만든다.
<br> qplot 도 있으나, 그것은 ggplot 과 거의 유사하여 여기서는 ggplot 만 소개하겠다. <br> ggplot
의 구성요소는 다음과 같이 5가지 이다. <br>

  - data frame (데이터) <br>
  - 미학요소(aesthetics)(aes)(Mapping) (그래프 크기,색상 등을 데이터와 Mapping) <br>
  - 기하학적 요소(geometries)(geoms) (점,선,모양) 즉 그래프형태 <br>
  - 통계적 처리(stats) <br>
  - 그래프의 배치(Position) <br>

<!-- end list -->

``` r
ggplot(data=mtcars, # 데이터 설정
       aes(x=disp,y=mpg))+  # x 는 disp , y 는 mpg 로 설정
  geom_point(aes(size=hp,color=wt),stat='identity') # size 는 hp 기준 , color 는 wt값 기준
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->
위 코드를 보자. <br>

  - 데이터는 mtcars <br>
  - mapping이 aes의 (x=..y=..) 로 이루어지고 있다. <br>
  - 기하학적 요소는 geom 으로 생성(geom\_point : 산점도) <br>
  - Position과 stat 기본값 (identity) 사용 <br>

<!-- end list -->

``` r
ggplot(data = iris,
       aes(x = Sepal.Length, y = Sepal.Width, color = Species))+
  # note color 와  colour 는 같다. 혼용해서 사용한다고 한다. 
  geom_point(size=3)+
  # size 를 크게 한다. 
  geom_smooth(formula = y~x) # smooth 를 통해서 추세선을 긋는다.
```

    ## `geom_smooth()` using method = 'loess'

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

``` r
library(ggplot2)
ggplot(data = BOD, aes(x=Time, y=demand)) +
    geom_bar(stat='identity') # geom 에서 point 말고 barplot 을 이용할 수 있다.
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

``` r
ggplot(sleep, aes(ID, extra, fill=group))+
    geom_bar(stat='identity', position = 'dodge') # barplot 에서 position 의 변화를 주었다.
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

# ggplot 구성요소

이제 어느정도 예시를 통해서 ggplot 의 기초 동작을 알아보았다. <br> 이제 ggplot cheet sheet(r
studio) 의 내용을 기초로 각각의 구성요소들에 대해서 알아보자.<br> ggplot2 그래프는 Layer + Scale +
Coordinate System + (Facet) + (Guide) 순으로 쌓인다. <br>

## aes

plot 안에서 aes 를 사용하여(mapping) 데이터와 그래프 연결

``` r
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
    geom_point() +
    geom_smooth()
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

만약 smotthing 곡선과 point 자체의 color,size 등을 수정하고싶다면 aes 가 아니라 geom 위에서
수정해야한다.

``` r
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
    geom_point(color="green") +
    geom_smooth(color="green")
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

만약 아래와 같이 aes 로 색을 지정하려 하면 설정이 안된다.

``` r
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
    geom_point(mapping = aes(color="green")) +
    geom_smooth(mapping = aes(color="green"))
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

geom 안에서 color 설정으로, cyl 마다 다른 추이를 볼 수 있음

``` r
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
    geom_point(mapping = aes(color=as.factor(cyl))) +
    geom_smooth()
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

## Stat

stat(statistical transformation) 은 주어진 데이터셋을 geom 이 활용하기 편하도록 데이터를 변환하는
역할을 한다. <br> 예시로 히스토그램을 그리려면 해당 bin 에 속할 수 있도록 통계적으로 집계가 필요하다. 이런 통계적
연산을 담당하는 알고리즘이 Stat 이다.(이때 stat은 count이다.) <br> 각각의 geom 에는 알맞은 stat 이
default 로 되어있다. <br>

## Layer

처음에 살펴보았던 5가지 요소들을 이용해 레이어를 구성한다. <br> 레이어가 구성되면 비로소 하나의 ggplot 이
그려지는것이다. <br>

``` r
i = ggplot(data = iris, aes(x=Sepal.Length, y=Sepal.Width))
i +
  geom_point(size = 3, colour = 'red') + 
  geom_smooth(method='lm', linetype=2, se = FALSE)  
```

    ## `geom_smooth()` using formula 'y ~ x'

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->
linetype 을 점선으로, se 를 false 로 주어서 신뢰구간을 없앴다. <br> 5개의 요소들이 적절히 들어가 하나의
산점도를 생성하는 모습<br> 기타 다른 요소 geom 등은 다른 포스트에서 만나보자. \#\#

<br>

``` r
HR = read.csv('./HR.csv')
HR$left = as.factor(HR$left)
HR$salary = factor(HR$salary,levels = c("low","medium","high"))
```

# 테마

``` r
library(ggthemes)
```

    ## Warning: package 'ggthemes' was built under R version 4.0.3

``` r
Graph = ggplot(HR,aes(x=salary)) +  
  geom_bar(aes(fill=salary)) 

Graph + theme_bw() + ggtitle("Theme_bw") 
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

``` r
Graph + theme_classic() + ggtitle("Theme_classic") 
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-13-2.png)<!-- -->

``` r
Graph + theme_dark() + ggtitle("Theme_dark") 
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-13-3.png)<!-- -->

``` r
Graph + theme_light() + ggtitle("Theme_light")  
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-13-4.png)<!-- -->

``` r
Graph + theme_linedraw() + ggtitle("Theme_linedraw") 
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-13-5.png)<!-- -->

``` r
Graph + theme_minimal() + ggtitle("Theme_minimal") 
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-13-6.png)<!-- -->

``` r
Graph + theme_test() + ggtitle("Theme_test") 
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-13-7.png)<!-- -->

``` r
Graph + theme_void() + ggtitle("Theme_vold") 
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-13-8.png)<!-- -->

# 범례

## 범례제목 및 색

  - **fill** : 색을 채우는 개념
  - **col** : 겉 형태의 색을 바꿈(테두리,선,점..)

<!-- end list -->

``` r
ggplot(HR,aes(x=salary)) +  
  geom_bar(aes(fill=salary)) +
  theme_bw() +
  labs(fill = "범례 제목 수정(fill)")
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

``` r
ggplot(HR,aes(x = salary)) +  
  geom_bar(aes(col = salary)) +
  theme_bw() +
  labs(col = "범례 제목 수정(col)")
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-14-2.png)<!-- -->

## 범례위치

``` r
Graph + theme(legend.position = "top")
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

``` r
Graph + theme(legend.position = "bottom")
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-15-2.png)<!-- -->

``` r
Graph + theme(legend.position = c(0.9,0.7)) # 비율에 맞는 위치
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-15-3.png)<!-- -->

``` r
Graph + theme(legend.position = 'none') # 위치 없음
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-15-4.png)<!-- -->

## 범례 테두리

margin 을 1,1,1,1 로 줌으로써 테두리를 만들 수 있다.

``` r
Graph + theme(legend.position = "bottom")
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

``` r
Graph + theme(legend.position = "bottom",
              legend.box.background = element_rect(),
              legend.box.margin = margin(1, 1, 1, 1)) 
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-16-2.png)<!-- -->

# 축

축의 경우 제일 먼저 체크해야 하는것은 축에 설정된 변수가 conti 인지 discrete 인지이다. <br>

  - **이산형** : scale\_x\_discrete()<br>
  - **연속형** : scale\_x\_discrete()<br>

## 축 이름,단위

``` r
ggplot(HR,aes(x = salary)) +  
  geom_bar(aes(fill = salary)) + #barplot 생성 
  theme_bw() + # 테마 붙이기 
  scale_x_discrete(expand =  c(0,0), labels = c("하","중","상")) + # discrete 한 x축 
  scale_y_continuous(expand = c(0,0),breaks = seq(0,8000,by = 1000)) # 1000 단위로 구분되는 y 축
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-17-1.png)<!-- -->

``` r
ggplot(HR,aes(x = salary)) +  
  geom_bar(aes(fill = salary)) + # salary 로 구분되는 barchart
  theme_bw() +
  scale_x_discrete(expand =  c(0,0), labels = c("하","중","상")) +
  scale_y_continuous(expand = c(0,0),breaks = seq(0,8000,by = 1000)) +
  scale_fill_discrete(labels = c("하","중","상")) # 라벨의 변경
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-17-2.png)<!-- -->

## 축 범위

``` r
ggplot(HR,aes(x = salary)) +  
  geom_bar(aes(fill = salary)) +
  theme_bw() +
  ylim(0,5000) # ylim 을 통해서 축의 범위 조절 가능
```

    ## Warning: Removed 2 rows containing missing values (geom_bar).

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->

``` r
# 이떄 범위를 넘어서게 된다면, 넘는 범위의 값은 짤린다.

ggplot(HR,aes(x = salary)) +  
  geom_bar(aes(fill = salary)) +
  theme_bw() +
  ylim(0,13000)
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-18-2.png)<!-- -->

## 축 색깔

  - scale\_fill-manual : 사용자가 임의로 색을 입힌다. <br>
  - alpha : 투명도 <br>

<!-- end list -->

``` r
ggplot(HR,aes(x = salary)) +  
  geom_bar(aes(fill = salary)) +
  theme_bw() +
  scale_fill_manual(values = c('red','royalblue','tan')) 
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-19-1.png)<!-- -->

# 그래프 배치

  - coord\_flip() : x,y 축의 위치를 대칭이동
  - facet\_wrap() : 분할하고픈 변수 지정 뒤, ncol 로 열 몇개로 나열할지 결정

<!-- end list -->

``` r
ggplot(HR,aes(x = salary)) +  
  geom_bar(aes(fill = salary), alpha = 0.4) +
  theme_bw() +
  scale_fill_manual(values = c('red','royalblue','tan')) +
  coord_flip()
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-20-1.png)<!-- -->

``` r
ggplot(HR,aes(x = salary)) +  
  geom_bar(aes(fill = salary)) +
  theme_bw() +
  scale_fill_manual(values = c('red','royalblue','tan'))  +
  guides(fill = FALSE) + 
  facet_wrap(~time_spend_company,ncol = 2) 
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-20-2.png)<!-- -->

# 글자크기, 각도

``` r
ggplot(HR,aes(x = salary)) +  
  geom_bar(aes(fill = salary)) +
  theme_bw() +
  scale_fill_manual(values = c('red','royalblue','tan'))  +
  coord_flip() +
  theme(legend.position = 'none',
        axis.text.x = element_text(size = 15,angle = 90),
        axis.text.y = element_text(size = 15),
        legend.text = element_text(size = 15))
```

![](시각화-%5Bggplot2-기초%5D_files/figure-gfm/unnamed-chunk-21-1.png)<!-- -->
