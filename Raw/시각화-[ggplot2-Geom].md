ggplot2 Geom
================

# Tip

아래 그래프는 R-studio 에서 제공하는 cheat sheet 의 내용이다. <br> geom 은 그래프의 전체적 모양새를
가늠짓는 함수로 제일 중요하다 할 수 있다. <br>

``` r
library('ggplot2')
args(geom_col) #이를 통해서 (또는?) 그 함수의 default 설정을 알 수 있다.
```

    ## function (mapping = NULL, data = NULL, position = "stack", ..., 
    ##     width = NULL, na.rm = FALSE, show.legend = NA, inherit.aes = TRUE) 
    ## NULL

# 1연속형

``` r
a <- ggplot(mpg, aes(hwy))
```

## Area plot

``` r
a + geom_area(stat = "bin")
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

## density plot

``` r
a + geom_density(kernel = "gaussian")
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

## 쌓인 점 plot

``` r
a + geom_dotplot()
```

    ## `stat_bindot()` using `bins = 30`. Pick better value with `binwidth`.

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

## 빈도수 plot

``` r
a + geom_freqpoly()
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

## 히스토그램

``` r
a + geom_histogram(binwidth = 5)
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

# 1범주형

## g

``` r
b <- ggplot(mpg, aes(fl))
b + geom_bar()
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

# 2연속+연속

## jitter scatter

``` r
e <- ggplot(mpg, aes(cty, hwy))
e + geom_jitter()
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

## scatter

``` r
e + geom_point()
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

## quantile plot

95% 범위를 세개의 선으로 표시

``` r
e + geom_quantile()
```

    ## Smoothing formula not specified. Using: y ~ x

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

## 축에 rug표시

``` r
e + geom_rug(sides = "bl")
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

## smooth line

``` r
e + geom_smooth(method = lm)
```

    ## `geom_smooth()` using formula 'y ~ x'

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

## text plot

``` r
e + geom_text(aes(label = cty))
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

## 2d histogram

``` r
head(diamonds)
```

    ## # A tibble: 6 x 10
    ##   carat cut       color clarity depth table price     x     y     z
    ##   <dbl> <ord>     <ord> <ord>   <dbl> <dbl> <int> <dbl> <dbl> <dbl>
    ## 1 0.23  Ideal     E     SI2      61.5    55   326  3.95  3.98  2.43
    ## 2 0.21  Premium   E     SI1      59.8    61   326  3.89  3.84  2.31
    ## 3 0.23  Good      E     VS1      56.9    65   327  4.05  4.07  2.31
    ## 4 0.290 Premium   I     VS2      62.4    58   334  4.2   4.23  2.63
    ## 5 0.31  Good      J     SI2      63.3    58   335  4.34  4.35  2.75
    ## 6 0.24  Very Good J     VVS2     62.8    57   336  3.94  3.96  2.48

``` r
h <- ggplot(diamonds, aes(carat, price))
h + geom_bin2d(binwidth = c(0.25, 500))
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

## 2d density

``` r
h + geom_density2d()
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

## 2d hexagon

``` r
h + geom_hex()
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-17-1.png)<!-- -->

## Area plot

``` r
i <- ggplot(economics, aes(date, unemploy))
i + geom_area()
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->

## Line plot

``` r
i + geom_line()
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-19-1.png)<!-- -->

## Step plot

``` r
i + geom_step(direction = "hv")
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-20-1.png)<!-- -->

# 2범주+연속

## 막대 그래프

아래와 같이 그래프의 default 는 sum 을 출력하고 있는 모습이다. <br>

``` r
f <- ggplot(mpg, aes(class, hwy))
f + geom_col()
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-21-1.png)<!-- -->

``` r
tapply(mpg$hwy,mpg$class,sum)
```

    ##    2seater    compact    midsize    minivan     pickup subcompact        suv 
    ##        124       1330       1119        246        557        985       1124

## box plot

``` r
f + geom_boxplot()
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-22-1.png)<!-- -->

## scatter

``` r
f + geom_dotplot(binaxis = "y", stackdir ="center",dotsize=0.3)
```

    ## `stat_bindot()` using `bins = 30`. Pick better value with `binwidth`.

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-23-1.png)<!-- -->

## violin

``` r
f + geom_violin(scale = "area")
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-24-1.png)<!-- -->

# 2범주+범주

## 격자 plot

``` r
g <- ggplot(diamonds, aes(cut, color))
g + geom_count()
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-25-1.png)<!-- -->

# 3변수

## contour plot

``` r
head(seals)
```

    ## # A tibble: 6 x 4
    ##     lat  long delta_long delta_lat
    ##   <dbl> <dbl>      <dbl>     <dbl>
    ## 1  29.7 -173.     -0.915    0.143 
    ## 2  30.7 -173.     -0.867    0.128 
    ## 3  31.7 -173.     -0.819    0.113 
    ## 4  32.7 -173.     -0.771    0.0980
    ## 5  33.7 -173.     -0.723    0.0828
    ## 6  34.7 -173.     -0.674    0.0675

``` r
seals$z <- with(seals, sqrt(delta_long^2 + delta_lat^2))
l <- ggplot(seals, aes(long, lat))
l + geom_contour(aes(z = z))
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-26-1.png)<!-- -->

## raster plot

z 를 높이로 가지는 tile plot

``` r
l + geom_raster(aes(fill = z), hjust=0.5, vjust=0.5,
interpolate=FALSE)
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-27-1.png)<!-- -->

## tile plot

``` r
l + geom_tile(aes(fill = z))
```

![](시각화-%5Bggplot2-Geom%5D_files/figure-gfm/unnamed-chunk-28-1.png)<!-- -->
