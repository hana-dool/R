Linear regression
================

# intro

  - 여기서 다룰 방법은 OLS 방법을 이용하는 전통적인 선형회귀 방법을 설명하겠다. <br>
  - 이 ols 방법은 모든 선형추정 방법중 가장 적은 분산을 보인다.
      - OLS estimators are said to be best linear unbiased
        estimators(BLUE), that is, to have minimum variance within the
        class of linear unbiased estimators
      - 즉 ols estimator 가 assumption(error\~iid(normal)) 하 에서 최소 분산을 가지는
        최고의 unbiased linear estimation 이라는 것이다.
  - 하지만 이 때 regression 을 제대로 적용하려면 가정사항을 만족해야한다.<br>
      - 선형성
      - 오차의 독립성
      - 오차의 정규성
      - 오차의 등분산성
      - 다중공선성 또는 이상치의 여부
  - 위 가정사항을 만족시키지 못한다면, 예측치의 값이 달라질 수 있으며 standard error 의 값이 증가한다. <br>

# 들어가기에 앞서

  - 더 예측력이 좋은 모델이 많음에도 선형회귀가 여전히 살아남은 이유는
    1.  이해하기가 쉬워서 모델에 맞게 데이터를 바꾸거나 적용하기 쉽다.
    2.  해석력이 좋다. 계수 및 std 를 비교하면서 유의성 및 의미를 알기 쉽다.
  - 하지만 무턱대고 사용하면 위의 이점을 하나도 얻을 수 없다. 가정사항을 체크하면서, 얼마나 위배하고있는지 (사실 실제
    데이터에서 가정사항을 만족하는 경우는 거의 없다.), 그에 따라 우리 계수를 얼마나 신뢰할 수 있을지를
    알아내는게 중요할 것이다.
  - EDA, Analysis 의과정을 반복해 보면서 insight 를 얻고 데이터를 선형회귀를 써도 될 정도로
    transformation 하는것이 중요하다.

# EDA

  - 변수들의 분포나 그 성질들이 선형회귀에 적절한지 체크해야한다. <br>
  - 다만 설명력을 최대로 하고싶다면, 억지로 데이터의 분포를 맞추려 하거나, 많은 transformation 은 지양해야
    한다. <br>

## 1.scaling

  - 많은 경우 데이터의 scale 이 다르다. 서로 다른 scale 을 가지고있는 경우 회귀분석의 품질이 안좋아지고 해석이
    불편해지므로 정규화를 하는 편이다.
  - 하지만 이상치가 존재할 경우 정규화는 이상치의 영향을 많이 받게된다.
  - 그런 경우 robust scaling 을 사용하거나 이상치를 제거하고 사용하곤 한다.

## 2.transformation

  - 데이터의 분포가 normal 형태가 되도록 바꾸어주는것이 회귀의 품질을 높여준다.
      - log(1+x), sqrt(x), e^x 등의 변환을 통해서 너무 치우친 경우, 그 정도를 어느정도 풀어주자.
  - ‘선형’ 이기 때문에 EDA 에서의 결과를 모델이 잘 반영하도록 변수를 변환해준다.
      - 예시로 온도가 극단적(춥거나 더울떄) 에 치킨이 잘 팔린다고 해 보자. 그 경우에 정규화를 진행한 후, 절댓값을
        취해준다면 ‘극단적’ 인 온도일때에 큰 값을 가지게 된다. 그러므로 회귀분석시 더 좋은 결과를 얻을 수
        있다.

## 3.multicorrelation

  - 다중공선성이 있는 경우, OLS 는 불안정해진다. (역행렬을 구해서 계수를 추정하게 되는데, 다중공선성이 심하면 역행렬이
    매우 불안정해진다.)
  - 그래서 corrplot 을 통해서 다중공선이 심한 변수끼리는 합치거나, 한쪽을 없애는 과정이 필요하다.

## 4.outlier

  - oulier 가 존재하는경우 선형회귀의 추정은 매우 변동이 심하다.
      - 기본적으로 Least square 을 최소화 하려고 하기 때문에, 적합된 회귀선과 먼 데이터가 있게되면 추정이 크게
        변동한다.
  - 개인적으로는 선형회귀를 진행할때에는 ‘다수의 데이터에 대한 일반적인 해석’을 하고 싶기 떄문에 ’보통이 아닌’
    outlier 를 어느정도 제거하는게 좋다고 생각한다.

## 5.NA Imputation

  - NA 및 표기 오류 등을 검사한다. 이 때에 어떤 이유로 NA 가 발생했고 어떤식으로 채울지 결정해야 한다.
  - 이 챕터에서 중요한 내용은 아니기떄문에 생략.

# Data Analysis

  - state.x77 : 미국 주들의 인구, 수입, 문맹률, 수명, 살인율 등에 대한 데이터로 Linear regression
    을 진행해 보겠다.

## 데이터 적합

  - 원래는 train 과 test를 나눈뒤에 train 에서 변환 및 모델을 test 해 보고,
  - test set 에 검정해봐서 mse(상황에 맞는 기준) 을 비교한다.
  - 하지만 아래 예제에서는 모델끼리 비교하는 상황이나 예측력을 보려는게 아니라 데이터에 대한 모델의 해석을 보려는것이기 떄문에
    그냥 진행하자.
  - train 에 대해서 적용한 모델에 대해 test 에 제일 좋은 변환이 아래의 경우라고 미리 생각하자는 것.

<!-- end list -->

``` r
# 데이터 살펴보기
head(state.x77)
```

    ##            Population Income Illiteracy Life Exp Murder HS Grad Frost   Area
    ## Alabama          3615   3624        2.1    69.05   15.1    41.3    20  50708
    ## Alaska            365   6315        1.5    69.31   11.3    66.7   152 566432
    ## Arizona          2212   4530        1.8    70.55    7.8    58.1    15 113417
    ## Arkansas         2110   3378        1.9    70.66   10.1    39.9    65  51945
    ## California      21198   5114        1.1    71.71   10.3    62.6    20 156361
    ## Colorado         2541   4884        0.7    72.06    6.8    63.9   166 103766

``` r
# data.frame 으로 고침
df <- state.x77
df<-data.frame(df)
str(df)
```

    ## 'data.frame':    50 obs. of  8 variables:
    ##  $ Population: num  3615 365 2212 2110 21198 ...
    ##  $ Income    : num  3624 6315 4530 3378 5114 ...
    ##  $ Illiteracy: num  2.1 1.5 1.8 1.9 1.1 0.7 1.1 0.9 1.3 2 ...
    ##  $ Life.Exp  : num  69 69.3 70.5 70.7 71.7 ...
    ##  $ Murder    : num  15.1 11.3 7.8 10.1 10.3 6.8 3.1 6.2 10.7 13.9 ...
    ##  $ HS.Grad   : num  41.3 66.7 58.1 39.9 62.6 63.9 56 54.6 52.6 40.6 ...
    ##  $ Frost     : num  20 152 15 65 20 166 139 103 11 60 ...
    ##  $ Area      : num  50708 566432 113417 51945 156361 ...

``` r
# 데이터 분포확인 
# 분포를 보았을 때, 인구와 면적의 분포가 왼쪽으로 치우쳐 보인다.
library("PerformanceAnalytics")
chart.Correlation(df, histogram=TRUE)
```

![](Anal_Linear-regression_OLS_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

``` r
# 데이터 transformation
# 인구,면적은 0에 가까운값이 없으므로 그냥 log(x) 로 transformation
df$Population = log(df$Population)
df$Area = log(df$Area)
chart.Correlation(df, histogram=TRUE)
```

![](Anal_Linear-regression_OLS_files/figure-gfm/unnamed-chunk-1-2.png)<!-- -->

``` r
# 데이터 scaling 
# scale 함수는 정규화를 진행
# 이 때에 output 이 df 가 아니므로 as.df 를 써야 한다.
df = as.data.frame(scale(df))

# 회귀 적합
fit=lm(Murder~.,data=df) 
summary(fit)
```

    ## 
    ## Call:
    ## lm(formula = Murder ~ ., data = df)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -0.7991 -0.3086 -0.0301  0.2728  0.8647 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -2.830e-15  6.478e-02   0.000   1.0000    
    ## Population   1.640e-01  8.781e-02   1.867   0.0688 .  
    ## Income       9.130e-02  9.260e-02   0.986   0.3298    
    ## Illiteracy   3.012e-01  1.252e-01   2.406   0.0206 *  
    ## Life.Exp    -5.961e-01  9.074e-02  -6.570 6.01e-08 ***
    ## HS.Grad      6.775e-02  1.312e-01   0.516   0.6083    
    ## Frost       -1.464e-01  1.046e-01  -1.399   0.1690    
    ## Area         1.994e-01  7.424e-02   2.686   0.0103 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.4581 on 42 degrees of freedom
    ## Multiple R-squared:  0.8201, Adjusted R-squared:  0.7902 
    ## F-statistic: 27.36 on 7 and 42 DF,  p-value: 1.045e-13

# Assumption check

## Linearlity

  - 빨간 선(residual 들의 추세) 가 0에서 직선 형태면 모델이 linear 하다고 볼 수 있다.
  - 왜냐하면 선형으로 예측하고 남은 residual 들이 예측 hyperplane 부근에서 위 아래로 비슷하게
    위치한다는것은(즉 0 값 위 아래에 띠모양으로 분포), 어쩃든 예측 못하는 에러로 인해 분산은
    컷지만, 그 추세는 어느정도 선형으로 따라간다는 이야기 이기 떄문이다.  
  - 즉 에러는 크지만 X,y 간에 linear 관계가 있다고 볼 수 있다.

<!-- end list -->

``` r
# 이정도면... 괜찮은거같은데?
plot(fit,1)
```

![](Anal_Linear-regression_OLS_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

변수별로 잔차와 함께 보기<br> - 잔차의 추이는 보라색 선이다. - 보라색 선이 fit(파란색) 위에 형성되어 있으므로 이는
어느정도 linearlity 를 보인다는 것이다.

``` r
library('car')
crPlots(fit)
```

![](Anal_Linear-regression_OLS_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

## Normality

``` r
plot(fit, 2) 
```

![](Anal_Linear-regression_OLS_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

``` r
# 양 끝 지점에서 들리는 모습이지만 원래 양 끝이 들리는 현상은 대부분의 데이터에 있는 현상
# 이정도면 거의 완벽하다고 볼 수 있다.
```

95% CI 를 같이 표시해주는 QQPLOT

``` r
library(car)
qqPlot(fit,main="Q-Q plot")
```

![](Anal_Linear-regression_OLS_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

    ##   Maine Vermont 
    ##      19      45

distribution 비교

  - kernel density curve 란, 데이터에서 분포를 근사해 주는 방법이다.
      - 각 데이터에 합이 1이 되게 weighted 동일한 kernel 함수를 누적해서 더한것으로 pdf 를 근사하는 방식
        (자세한건 <https://darkpgmr.tistory.com/147>)

<!-- end list -->

``` r
# distribution of studentized residuals
residplot <- function(fit, nbreaks=10) {
    z <- rstudent(fit)
    hist(z, breaks=nbreaks, freq=FALSE,xlab="Studentized Residual",
         main="Distribution of Errors")
    rug(jitter(z), col="brown")
    curve(dnorm(x, mean=mean(z), sd=sd(z)),add=TRUE, col="blue", lwd=2)
    lines(density(z)$x, density(z)$y,col="red", lwd=2, lty=2)
    legend("topright",legend = c( "Normal Curve", "Kernel Density Curve"),
           lty=1:2, col=c("blue","red"), cex=.7)
}
residplot(fit)
```

![](Anal_Linear-regression_OLS_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

## 오차의 독립성

  - Normal 가정에 따라 오차는 독립적이여야 한다.
  - 시계열을 회귀로 적합하려 할 때에, 시간별로 잔차를 확인하여야 한다.
  - predictor variable 과 residual 사이의 독립성도 살펴보아야 한다.

<!-- end list -->

``` r
# 띠 모양으로 없어보인다.
# 이는 당연한게, row 의 index 순으로 나열된 잔차인데 시계열이 아닌 이상 row 의 순서는 아무 의미가 없기떄문에 웬만하면 띠 모양이 나오기 떄문
plot(fit$residuals)
```

![](Anal_Linear-regression_OLS_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

  - 각 변수와 residual 을 비교해볼 수 있다.
  - 비교해 볼 때에, 크게 패턴은 없어보인다.

<!-- end list -->

``` r
# 패키지로 보기
crPlots(fit)
```

![](Anal_Linear-regression_OLS_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

``` r
# ggplot 으로 그려보기
df_plot = cbind(df,res=fit$residuals)
library(ggplot2)
library(reshape2)
mtmelt <- melt(df_plot, id = "res")
ggplot(mtmelt, aes(x = value, y = res)) +
    facet_wrap(~variable, scales = "free") +
    geom_point()
```

![](Anal_Linear-regression_OLS_files/figure-gfm/unnamed-chunk-8-2.png)<!-- -->

만약 시계열이였다면 아래와 같이

  - lag 1차이의 잔차끼리 비교
  - autocorrelation 의 값을 비교

<!-- end list -->

``` r
# lag 1 차이로 본 잔차. 
plot(fit$residuals[c(1:length(fit$residuals))-1],fit$residuals[2:length(fit$residuals)])
```

![](Anal_Linear-regression_OLS_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

``` r
acf(fit$residuals) # 자기상관여부
```

![](Anal_Linear-regression_OLS_files/figure-gfm/unnamed-chunk-9-2.png)<!-- -->

## 등분산 가정

``` r
plot(fit, 1)
```

![](Anal_Linear-regression_OLS_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

``` r
#이정도면 띠 느낌 난다.
```

## 영향점 (outlier)

cooks distnace 에서 4(n-k-1) 보다 크면 대략적으로 영향치라고 한다.(n= sample 크기,k 는 예측변수의
수)

``` r
cutoff <- 4/(nrow(df)-length(fit$coefficients)-1)
plot(fit, which=4, cook.levels=cutoff)
abline(h=cutoff, lty=2, col="red")
```

![](Anal_Linear-regression_OLS_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

## 다중공선성

  - vif 값이 5 이상이면 다중공선성이 어느정도 있다고 생각해도 된다. <br>
  - correlation 의 값이 매우 큰 경우에도 주의해야 한다.

vif 값 체크

``` r
library('car')
c<-vif(fit)
library(ggplot2)
barplot(c,horiz = T,xlim=c(0,6),las=1)
abline(v=5,col='red')
```

![](Anal_Linear-regression_OLS_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

correlation 비교

``` r
chart.Correlation(df, histogram=TRUE)
```

![](Anal_Linear-regression_OLS_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

# Interpret

  - 계수해석
      - 기본적으로 회귀 계수의 값이 크면, 그 값은 큰 영향을 끼칠것이다. 하지만 corr 도 고려해야하기 떄문에
        단독적으로 해석할 순 없다. <br>
      - 모든 predictor 가 uncorrelated 이면, 계수의 독자적인 해석이 가능하다. <br>
      - 하지만 위의 상황은 거의 불가능하다. <br>
      - 일반적으로 계수 : b\_k is the contribution to explain Y after both X\_k
        and Y have been adjusted for the remaining predictors
          - 즉 y와 x\_k 를 나머지 변수들로 적합시키고 난 뒤의 잔차들에 대한 contribution 의 의미이다.
          - 즉 계수를 고유한 설명력의 크기라고 보면 된다.
          - 즉 계수는 그 변수의 ‘총 설명력’ 의 크기를 의미하는게 아니라 다른 변수들이 설명하지 못하는 Y 값을
            얼마나 설명할 수 있는지의 척도가 된다.
  - 다중공선성
      - 기본적으로 Correlation 때문에 설명력이 겹치는 경우가 있다.
      - 이런 경우 한쪽이 모든 설명력을 가져가 버려서 나머지 한쪽의 계수가 작아지거나 무의미하게 될 수 있다.
      - 그리고 해석시 꼭 corr 이 큰 값 끼리는 묶어서 같이 해석해 주어야 한다.
  - 스케일링으로 인한 해석
      - 정규화 시에 그 데이터의 표준편차만큼 나누어 주기 때문에 이도 고려 해야 한다.

<!-- end list -->

``` r
summary(fit)
```

    ## 
    ## Call:
    ## lm(formula = Murder ~ ., data = df)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -0.7991 -0.3086 -0.0301  0.2728  0.8647 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -2.830e-15  6.478e-02   0.000   1.0000    
    ## Population   1.640e-01  8.781e-02   1.867   0.0688 .  
    ## Income       9.130e-02  9.260e-02   0.986   0.3298    
    ## Illiteracy   3.012e-01  1.252e-01   2.406   0.0206 *  
    ## Life.Exp    -5.961e-01  9.074e-02  -6.570 6.01e-08 ***
    ## HS.Grad      6.775e-02  1.312e-01   0.516   0.6083    
    ## Frost       -1.464e-01  1.046e-01  -1.399   0.1690    
    ## Area         1.994e-01  7.424e-02   2.686   0.0103 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.4581 on 42 degrees of freedom
    ## Multiple R-squared:  0.8201, Adjusted R-squared:  0.7902 
    ## F-statistic: 27.36 on 7 and 42 DF,  p-value: 1.045e-13

``` r
attributes(scale(state.x77))
```

    ## $dim
    ## [1] 50  8
    ## 
    ## $dimnames
    ## $dimnames[[1]]
    ##  [1] "Alabama"        "Alaska"         "Arizona"        "Arkansas"      
    ##  [5] "California"     "Colorado"       "Connecticut"    "Delaware"      
    ##  [9] "Florida"        "Georgia"        "Hawaii"         "Idaho"         
    ## [13] "Illinois"       "Indiana"        "Iowa"           "Kansas"        
    ## [17] "Kentucky"       "Louisiana"      "Maine"          "Maryland"      
    ## [21] "Massachusetts"  "Michigan"       "Minnesota"      "Mississippi"   
    ## [25] "Missouri"       "Montana"        "Nebraska"       "Nevada"        
    ## [29] "New Hampshire"  "New Jersey"     "New Mexico"     "New York"      
    ## [33] "North Carolina" "North Dakota"   "Ohio"           "Oklahoma"      
    ## [37] "Oregon"         "Pennsylvania"   "Rhode Island"   "South Carolina"
    ## [41] "South Dakota"   "Tennessee"      "Texas"          "Utah"          
    ## [45] "Vermont"        "Virginia"       "Washington"     "West Virginia" 
    ## [49] "Wisconsin"      "Wyoming"       
    ## 
    ## $dimnames[[2]]
    ## [1] "Population" "Income"     "Illiteracy" "Life Exp"   "Murder"    
    ## [6] "HS Grad"    "Frost"      "Area"      
    ## 
    ## 
    ## $`scaled:center`
    ## Population     Income Illiteracy   Life Exp     Murder    HS Grad      Frost 
    ##  4246.4200  4435.8000     1.1700    70.8786     7.3780    53.1080   104.4600 
    ##       Area 
    ## 70735.8800 
    ## 
    ## $`scaled:scale`
    ##   Population       Income   Illiteracy     Life Exp       Murder      HS Grad 
    ## 4.464491e+03 6.144699e+02 6.095331e-01 1.342394e+00 3.691540e+00 8.076998e+00 
    ##        Frost         Area 
    ## 5.198085e+01 8.532730e+04

다른것이 일정할 때에 \#\# Visualization

``` r
library(dotwhisker)
library(coefplot)
summary(fit) 
```

    ## 
    ## Call:
    ## lm(formula = Murder ~ ., data = df)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -0.7991 -0.3086 -0.0301  0.2728  0.8647 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -2.830e-15  6.478e-02   0.000   1.0000    
    ## Population   1.640e-01  8.781e-02   1.867   0.0688 .  
    ## Income       9.130e-02  9.260e-02   0.986   0.3298    
    ## Illiteracy   3.012e-01  1.252e-01   2.406   0.0206 *  
    ## Life.Exp    -5.961e-01  9.074e-02  -6.570 6.01e-08 ***
    ## HS.Grad      6.775e-02  1.312e-01   0.516   0.6083    
    ## Frost       -1.464e-01  1.046e-01  -1.399   0.1690    
    ## Area         1.994e-01  7.424e-02   2.686   0.0103 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.4581 on 42 degrees of freedom
    ## Multiple R-squared:  0.8201, Adjusted R-squared:  0.7902 
    ## F-statistic: 27.36 on 7 and 42 DF,  p-value: 1.045e-13

``` r
# 95% interval
coefplot(fit,intercept=FALSE)
```

![](Anal_Linear-regression_OLS_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

``` r
# 95% interval
```

## importance

다음의 함수는 Robert I. Kabacoff의 R in action(2nd edition)책에 소개되어 있는 함수로
회귀모형에서 상대적인 중요성을 보여준다. <br>

``` r
relweights <- function(fit,...){
    R <- cor(fit$model)
    nvar <- ncol(R)
    rxx <- R[2:nvar, 2:nvar]
    rxy <- R[2:nvar, 1]
    svd <- eigen(rxx)
    evec <- svd$vectors
    ev <- svd$values
    delta <- diag(sqrt(ev))
    lambda <- evec %*% delta %*% t(evec)
    lambdasq <- lambda ^ 2
    beta <- solve(lambda) %*% rxy
    rsquare <- colSums(beta ^ 2)
    rawwgt <- lambdasq %*% beta ^ 2
    import <- (rawwgt / rsquare) * 100
    import <- as.data.frame(import)
    row.names(import) <- names(fit$model[2:nvar])
    names(import) <- "Weights"
    import <- import[order(import),1, drop=FALSE]
    dotchart(import$Weights, labels=row.names(import),
                 xlab="% of R-Square", pch=19,
                 main="Relative Importance of Predictor Variables",
                 sub=paste("Total R-Square=", round(rsquare, digits=3)),
                 ...)
    return(import)
}  
relweights(fit)
```

![](Anal_Linear-regression_OLS_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

    ##              Weights
    ## Income      1.754101
    ## Population  6.268975
    ## Area        8.336433
    ## HS.Grad     8.633278
    ## Frost      12.320395
    ## Illiteracy 21.051725
    ## Life.Exp   41.635094

  - A new method called relative weights shows significant promise. The
    method closely approximates the average increase in R-square
    obtained by adding a predictor variable across all possible
    submodels (R in action 209p)
  - 즉 모든 submodel 에 대해 어떤 변수를 넣었을때 평균적으로, r^2 이 많이 상승하면 그 변수를 유의하다고 판단
  - 이를 이용해서, 변수의 relative 중요성을 판단할 수 있다.

## error

회귀를 썼을 떄에 다음과 같은 에러가 쌓일 수 있다.

  - 데이터의 측정시의 오차
      - measurement error 가 있다면 모형에 영향을 미친다.
      - ex) 강수량의 경우 0.1 단위로 측정하게 되어서 0.01 단위는 버려진다. -\> 오차
  - 가정사항에서의 오차
      - 회귀의 가정사항을 지키지 못한다면, std.error 값이 상승하고 그에 따라서 유의했던 변수가 유의하지 않게
        되거나, estimate 값이 변할 수 있다.
  - NA imputation 에서의 오차
      - NA 를 채우는 방식이 적절해야 회귀 계수의 추정도 정확할 것이다.
      - ex) 무작정 평균으로 채우는것은 data structure 를 부수는 일이다. 충분한 eda 와 방법론 탐색으로
        최대한 원 데이터의 structure 를 보전하는 방식으로 채워야한다.

위와 같은 상황이 발생했다고 회귀를 쓰지 말라는것이 아니다. (사실 대부분의 데이터는 위와 같은 상황이 발생한다.) 이런 사항들을
‘인지’ 하고 최대한 조심스런 해석이 필요한 것이다.

# 변수 selection

변수선택에는 아래와 같은 방법을 쓸 수 있다. <br>

  - lasso
  - stepwise
  - 하지만 중요한것\! 회귀는 결코 ‘예측력만을 위해서가 아니라 해석력을 위해서’ 쓰는것이다. 즉 무작정
    varselection 을 해야되는건 아니다. <br> 만약 변수가 별로 없다면 굳이 selection 을 할 필요가
    없다. 어느정도 있으면 R-Square 은 무조건 올라가기 때문

## stepwise selection

**1. forward stepwise**

가장 널리 사용되는 방법이다. <br> 선택의 기준은 F 값(SSR/SSE) 의 변동과 유의성(t) 으로 선택하게 된다.

1.  처음에 cutoff 값 a(유의수준) 을 정한다.
      - 위 유의수준에 따라 유의하지 않으므로 버리게 된다.
2.  우선 SSR(X\_k)/SSE(X\_k) 가 가장 큰 하나의 변수를 선택하고 회귀를 시작한다.
3.  그 이후 추가할 X\_l 은 SSR(X\_l | S) / SSE(X\_l,S)를 최대로 하는 X\_l 을 넣는다.
      - S 는 이전 step 에 있었던 모든 predictor 의 집합
4.  X\_l 을 추가한 이후에 S 내에서 버릴 설명변수가 있는지 검사하고, 유의하지 않으면 버리게 된다.
      - 여기서 버리는 기준이 처음에 정한 cutoff 값 a 이다.
      - 이 때에 이미 검사를 통과한(유의수준 a 를 통과한) 변수들이 S 에 있었을 텐데 왜 또 검사를 모두 하는지 궁금해
        할 수 있다. 이는 추가한 변수가 기존 변수의 설명력을 가져가면서 기존변수가 유의미했다가 무의미해 질 수 있기
        때문이다.
5.  위 3\~4 과정을 계속 반복하고, S가 변함없을때까지 진행한다.

<!-- end list -->

``` r
full.model=lm(Murder~.,data=df)
reduced.model=step(full.model,direction="forward")
```

    ## Start:  AIC=-70.79
    ## Murder ~ Population + Income + Illiteracy + Life.Exp + HS.Grad + 
    ##     Frost + Area

``` r
summary(reduced.model)
```

    ## 
    ## Call:
    ## lm(formula = Murder ~ Population + Income + Illiteracy + Life.Exp + 
    ##     HS.Grad + Frost + Area, data = df)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -0.7991 -0.3086 -0.0301  0.2728  0.8647 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -2.830e-15  6.478e-02   0.000   1.0000    
    ## Population   1.640e-01  8.781e-02   1.867   0.0688 .  
    ## Income       9.130e-02  9.260e-02   0.986   0.3298    
    ## Illiteracy   3.012e-01  1.252e-01   2.406   0.0206 *  
    ## Life.Exp    -5.961e-01  9.074e-02  -6.570 6.01e-08 ***
    ## HS.Grad      6.775e-02  1.312e-01   0.516   0.6083    
    ## Frost       -1.464e-01  1.046e-01  -1.399   0.1690    
    ## Area         1.994e-01  7.424e-02   2.686   0.0103 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.4581 on 42 degrees of freedom
    ## Multiple R-squared:  0.8201, Adjusted R-squared:  0.7902 
    ## F-statistic: 27.36 on 7 and 42 DF,  p-value: 1.045e-13

**2. Backward elemination**

기본적으로 foward 와 방법이 유사하다. <br>

1.  처음 시작시에 모든 설명변수를 넣은 상태에서 시작하며, smallest SSR(X\_l | S) / SSE(X\_l,S)
    를 가지는 변수를 선택한다.
2.  이 변수가 처음에 정한 a(유의수준) 에 따라 유의하지 않으면 제외시킨다.
3.  위 과정을 변동이 없을때까지 계속 반복

<!-- end list -->

``` r
full.model=lm(Murder~.,data=df)
reduced.model=step(full.model,direction="backward")
```

    ## Start:  AIC=-70.79
    ## Murder ~ Population + Income + Illiteracy + Life.Exp + HS.Grad + 
    ##     Frost + Area
    ## 
    ##              Df Sum of Sq     RSS     AIC
    ## - HS.Grad     1    0.0559  8.8688 -72.474
    ## - Income      1    0.2040  9.0168 -71.646
    ## <none>                     8.8129 -70.791
    ## - Frost       1    0.4109  9.2238 -70.512
    ## - Population  1    0.7316  9.5445 -68.803
    ## - Illiteracy  1    1.2151 10.0279 -66.333
    ## - Area        1    1.5140 10.3269 -64.864
    ## - Life.Exp    1    9.0572 17.8700 -37.445
    ## 
    ## Step:  AIC=-72.47
    ## Murder ~ Population + Income + Illiteracy + Life.Exp + Frost + 
    ##     Area
    ## 
    ##              Df Sum of Sq     RSS     AIC
    ## <none>                     8.8688 -72.474
    ## - Frost       1    0.5326  9.4014 -71.558
    ## - Income      1    0.5515  9.4203 -71.458
    ## - Population  1    0.7310  9.5998 -70.514
    ## - Illiteracy  1    1.2165 10.0853 -68.047
    ## - Area        1    2.2446 11.1134 -63.194
    ## - Life.Exp    1    9.8552 18.7240 -37.111

``` r
summary(reduced.model)
```

    ## 
    ## Call:
    ## lm(formula = Murder ~ Population + Income + Illiteracy + Life.Exp + 
    ##     Frost + Area, data = df)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -0.7655 -0.3246 -0.0255  0.2797  0.8903 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -2.712e-15  6.423e-02   0.000  1.00000    
    ## Population   1.407e-01  7.475e-02   1.883  0.06653 .  
    ## Income       1.200e-01  7.340e-02   1.635  0.10931    
    ## Illiteracy   2.746e-01  1.131e-01   2.429  0.01941 *  
    ## Life.Exp    -5.791e-01  8.377e-02  -6.912 1.72e-08 ***
    ## Frost       -1.607e-01  1.000e-01  -1.607  0.11538    
    ## Area         2.167e-01  6.569e-02   3.299  0.00196 ** 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.4541 on 43 degrees of freedom
    ## Multiple R-squared:  0.819,  Adjusted R-squared:  0.7937 
    ## F-statistic: 32.43 on 6 and 43 DF,  p-value: 1.982e-14

**3. Stepwise**

forward 와 backward 를 번갈아가면서 진행

``` r
full.model=lm(Murder~.,data=df)
reduced.model=step(full.model,direction="both")
```

    ## Start:  AIC=-70.79
    ## Murder ~ Population + Income + Illiteracy + Life.Exp + HS.Grad + 
    ##     Frost + Area
    ## 
    ##              Df Sum of Sq     RSS     AIC
    ## - HS.Grad     1    0.0559  8.8688 -72.474
    ## - Income      1    0.2040  9.0168 -71.646
    ## <none>                     8.8129 -70.791
    ## - Frost       1    0.4109  9.2238 -70.512
    ## - Population  1    0.7316  9.5445 -68.803
    ## - Illiteracy  1    1.2151 10.0279 -66.333
    ## - Area        1    1.5140 10.3269 -64.864
    ## - Life.Exp    1    9.0572 17.8700 -37.445
    ## 
    ## Step:  AIC=-72.47
    ## Murder ~ Population + Income + Illiteracy + Life.Exp + Frost + 
    ##     Area
    ## 
    ##              Df Sum of Sq     RSS     AIC
    ## <none>                     8.8688 -72.474
    ## - Frost       1    0.5326  9.4014 -71.558
    ## - Income      1    0.5515  9.4203 -71.458
    ## + HS.Grad     1    0.0559  8.8129 -70.791
    ## - Population  1    0.7310  9.5998 -70.514
    ## - Illiteracy  1    1.2165 10.0853 -68.047
    ## - Area        1    2.2446 11.1134 -63.194
    ## - Life.Exp    1    9.8552 18.7240 -37.111

``` r
summary(reduced.model)
```

    ## 
    ## Call:
    ## lm(formula = Murder ~ Population + Income + Illiteracy + Life.Exp + 
    ##     Frost + Area, data = df)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -0.7655 -0.3246 -0.0255  0.2797  0.8903 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -2.712e-15  6.423e-02   0.000  1.00000    
    ## Population   1.407e-01  7.475e-02   1.883  0.06653 .  
    ## Income       1.200e-01  7.340e-02   1.635  0.10931    
    ## Illiteracy   2.746e-01  1.131e-01   2.429  0.01941 *  
    ## Life.Exp    -5.791e-01  8.377e-02  -6.912 1.72e-08 ***
    ## Frost       -1.607e-01  1.000e-01  -1.607  0.11538    
    ## Area         2.167e-01  6.569e-02   3.299  0.00196 ** 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.4541 on 43 degrees of freedom
    ## Multiple R-squared:  0.819,  Adjusted R-squared:  0.7937 
    ## F-statistic: 32.43 on 6 and 43 DF,  p-value: 1.982e-14

## all subset regression

  - stepwise regression 은 every 조합을 검사하지 않기떄문에 (greedy 하게 선택할 뿐임) 그 방법이
    최적이라고 생각하기 힘들다.
  - all subset 방법에서는 가능한 모든 모형을 조사한다.
  - nbest : 조사하고픈 모델 의 수 (3으로 주면 predictor 의 수에 대해서 3개씩 모델을 보여줌)
  - plot 에서 scale=c(“bic”, “Cp”, “adjr2”, “r2”), 로 변수선택의 기준 정하기 가능

<!-- end list -->

``` r
require(leaps)
leaps <-regsubsets(Murder ~.,data=df,nbest = 3)
plot(leaps, scale="bic") # bic 으로 기준
```

![](Anal_Linear-regression_OLS_files/figure-gfm/unnamed-chunk-20-1.png)<!-- -->

# remedy

만약 위에서 보았던 error 가 발생했을 때에 어떻게 대처해야 할까? <br>

1.  transformation
      - log, exp 등의 변환으로 설명력이 안좋은 변수를 더 좋게 만들 수 있다.
2.  다른모델 선택
      - 굳이 이 모델을 고집할 필요는 없다. 다른 해석가능한 모델도 많기 떄문에 이를 활용하는것이 중요하다.
3.  데이터 추가
      - 결정적인 데이터가 없어 해석력이 안좋아 보이는 경우도 많다. 예를 들어 치킨집 매출 분석에서 휴일이라는 중요한
        변수가 없다면, 날씨, 인구, 주변영업가게 수 등의 변수도 같이 무의미해 진다. (데이터의 경향을 잘
        파악하지 못하기 때문에) 그런데 휴일이라는 critical 한 데이터를 넣는 순간, 다른 변수들이 자신이
        설명해야 하는 데이터를 비로소 오롯이 설명하게 되고, 그에 따라 모델이 좋아지고
4.  이상치 제거
      - 이상치란 기존의 데이터로 설명이 불가능한 점이다. 이 점을 제거할 경우에도 모델이 전체적으로 좋아져서 해석력이
        좋아진다. (다만 이상치를 너무 많이 제거해서 데이터를 모델에 맞추는 행동은 하지말자. 모델이 데이터에
        맞춰져야 하는 것이다.)

# Evaluation

정확한 평가를 위해서는 crossvalidation 을 진행하여 test set 에 대한 평가를 진행해야한다. <br> 아래
함수는 Robert I. Kabacoff의 R in Action(2011) 에 공개되어있는 함수이다. <br> k 만큼
cross validation 을 진행한 R square 와 원래 fitting 과의 차이를 비교해주는 함수 <br>

``` r
shrinkage <- function(fit, k=5){ 
  require(bootstrap)
                                  
  theta.fit <- function(x,y){lsfit(x,y)} 
  theta.predict <- function(fit,x){cbind(1,x)%*%fit$coef}
  
  x <- fit$model[,2:ncol(fit$model)] 
  y <- fit$model[,1]
                                  
  results <- crossval(x, y, theta.fit, theta.predict, ngroup=k) 
  r2 <- cor(y, fit$fitted.values)^2 
  r2cv <- cor(y, results$cv.fit)^2 
  cat("Original R-square =", r2, "\n")
  cat(k, "Fold Cross-Validated R-square =", r2cv, "\n") 
  cat("Change =", r2-r2cv, "\n")
}
fit1=lm(Murder~.,data=df)
shrinkage(fit1)
```

    ## Original R-square = 0.8201458 
    ## 5 Fold Cross-Validated R-square = 0.7411779 
    ## Change = 0.07896791

# 참고

Robert I. Kabacoff의 R in Action(2011)
