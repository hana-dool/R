Logistic regression
================

# logistic regresssion

  - 로지스틱 회귀분석은 ‘회귀’ 를 y 가 범주형의 경우에도 사용하려고 할 때에 쓰는 방법입니다.
  - glm 의 일종으로 g(E\[YlX\]) = Xb 형태로 link function g 를 통해 선형으로 예측하기 힘든 y
    를 변형을 통해서 선형으로 예측하게 된다.
      - E\[YlX\] 는 X 가 주어졌을 때의 Y 값으로 우리가 예측하고자 하는 값이다.
      - y=0,1 이므로 E\[YlX\] = p(x) 가 된다.
  - logistic regression 에서 link function은 g(x) = log(x/(1-x)) 가 된다.
      - 이 때에 E\[YlX\] = p(x) 이므로 결국 lof(p(x)/(1-p(x))) 를 선형으로 예측하려 한다.
  - 왜 굳이 위의 형태로 link function 을 정의하였을까?
      - log(p(x)/1-p(x)) 로 g 가 정의된다면, 이 값의 범위는 -inf \~ inf 의 값을 가지게된다.
        (확률은 0\~1 의 값을 가지므로)
      - 만약 범위가 -5\~5 로 제한된다면 우리는 Xb 모델에도 제한식을 달게 되고 그러면 통상적인 OLS 방법 등을 쓸
        수 없게 된다. 이런 제한을 피하기 위해 link function g 를 위와 같이 정하게 된 것이다.
  - 이 때에 logistic 은 0,1 class 를 예측한다는것을 알아두자. 즉 예측되는 class 는 꼭 0,1 값을
    가지게 setting 해 주거나, factor 이 되어있어야 한다.
      - factor 가 앞에있는게 0, 뒤에있는게 1 로 인식하고 logistic 이 실행된다.

<!-- end list -->

``` r
require(tidyverse)
require(broom)
require(mlbench)
require(dplyr)
```

# Data Analysis

  - 아래 분석하게 되는 데이터는 당뇨병의 유무 데이터이다. <br>
  - 임신, 혈압, 체중 등의 값을 통해서 당뇨 (neg=1,pos=2) 를 예측하는것이 목적 <br>

<!-- end list -->

``` r
# 데이터 로드하기
data("PimaIndiansDiabetes2", package = "mlbench")

# NA 값 제거하기
PimaIndiansDiabetes2 <- na.omit(PimaIndiansDiabetes2) 

# 살펴보기
head(PimaIndiansDiabetes2)
```

    ##    pregnant glucose pressure triceps insulin mass pedigree age diabetes
    ## 4         1      89       66      23      94 28.1    0.167  21      neg
    ## 5         0     137       40      35     168 43.1    2.288  33      pos
    ## 7         3      78       50      32      88 31.0    0.248  26      pos
    ## 9         2     197       70      45     543 30.5    0.158  53      pos
    ## 14        1     189       60      23     846 30.1    0.398  59      pos
    ## 15        5     166       72      19     175 25.8    0.587  51      pos

``` r
# Fit the logistic regression model
model <- glm(diabetes ~., data = PimaIndiansDiabetes2, 
               family = binomial) # 이때 family = binomial 로 해야 logistic 이 된다. 

summary(model)
```

    ## 
    ## Call:
    ## glm(formula = diabetes ~ ., family = binomial, data = PimaIndiansDiabetes2)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -2.7823  -0.6603  -0.3642   0.6409   2.5612  
    ## 
    ## Coefficients:
    ##               Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept) -1.004e+01  1.218e+00  -8.246  < 2e-16 ***
    ## pregnant     8.216e-02  5.543e-02   1.482  0.13825    
    ## glucose      3.827e-02  5.768e-03   6.635 3.24e-11 ***
    ## pressure    -1.420e-03  1.183e-02  -0.120  0.90446    
    ## triceps      1.122e-02  1.708e-02   0.657  0.51128    
    ## insulin     -8.253e-04  1.306e-03  -0.632  0.52757    
    ## mass         7.054e-02  2.734e-02   2.580  0.00989 ** 
    ## pedigree     1.141e+00  4.274e-01   2.669  0.00760 ** 
    ## age          3.395e-02  1.838e-02   1.847  0.06474 .  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 498.10  on 391  degrees of freedom
    ## Residual deviance: 344.02  on 383  degrees of freedom
    ## AIC: 362.02
    ## 
    ## Number of Fisher Scoring iterations: 5

``` r
# Predict the probability (p) of diabete positivity
# predict 할 때에 response 라고 하게 되면 확률값을 예측한다.
probabilities <- predict(model, type = "response")

# 0.5를 초과하면 positive 라고 예측된것이므로, 예측하는 class 를 생성하자.
predicted.classes <- ifelse(probabilities > 0.5, "pos", "neg")

# 예측된 class 의 앞 값들
head(predicted.classes)
```

    ##     4     5     7     9    14    15 
    ## "neg" "pos" "neg" "pos" "pos" "pos"

# Assumption check

  - 결국 logistic 도 link function 을 통해서 regression 이 된것은 똑같다.
  - 즉 g(E\[YlX\]) = Xb 에서, log(p(x)/(1-p(x))) = Xb 의 형식이 되는것이다.
  - fitted 된 g(E\[YlX\]) 값을 이용하여 regression 과 같은 Assumption check 를 할 수
    있다.
  - Assumption 에 잘 맞게 variable 을 조정해 주어야 품질이 올라감을 명심하자\!
  - 하지만 logit 모형의 경우 strict 하게 가정사항을 맞추지 않아도 된다고 한다. \#\# Linearlity

<!-- end list -->

``` r
# Select only numeric predictors
# 범주형 변수는 Check 할 필요가 없기 때문
mydata <- PimaIndiansDiabetes2 %>%
  select_if(is.numeric) 
predictors <- colnames(mydata)

# Bind the logit and tidying the data for plot
mydata <- mydata %>%
  # log probability 를 원래 선형회귀때에 적합했던 scale 로 변환
  mutate(logit = log(probabilities/(1-probabilities))) %>% 
  # gather 을 통해서 predictor 을 모두 해채한다음, 일렬로 이어붙인다.
  gather(key = "predictors", value = "predictor.value", -logit)
```

``` r
# 일렬로 해체한 데이터를 그래프로 그려본다. 
ggplot(mydata, aes(predictor.value,logit))+
  geom_point(size = 0.5, alpha = 0.5) +
  geom_smooth(method = "loess") + 
  theme_bw() + 
  facet_wrap(~predictors, scales = "free_x") 
```

![](Anal_Logistic-regression_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

  - 나름 선형이 맞는거 같다. 인슐린, 혈압의 경우 약간의 변환이 필요해보인다.

## 이상치 탐지

``` r
plot(model, which = 4, id.n = 3)
```

![](Anal_Logistic-regression_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

``` r
model.data <- augment(model) %>% 
  mutate(index = 1:n()) 
```

``` r
model.data %>% top_n(3, .cooksd)
```

    ## # A tibble: 3 x 17
    ##   .rownames diabetes pregnant glucose pressure triceps insulin  mass pedigree
    ##   <chr>     <fct>       <dbl>   <dbl>    <dbl>   <dbl>   <dbl> <dbl>    <dbl>
    ## 1 229       neg             4     197       70      39     744  36.7     2.33
    ## 2 460       neg             9     134       74      33      60  25.9     0.46
    ## 3 488       neg             0     173       78      32     265  46.5     1.16
    ## # ... with 8 more variables: age <dbl>, .fitted <dbl>, .resid <dbl>,
    ## #   .std.resid <dbl>, .hat <dbl>, .sigma <dbl>, .cooksd <dbl>, index <int>

  - 이 3개의 값들이 이상치이다. 어떤점에서 이상치가 왜 생기는지 잘 생각해보자.

## 등분산

``` r
ggplot(model.data, aes(index, .std.resid)) + 
  geom_point(aes(color = diabetes), alpha = .5) +
  theme_bw()
```

![](Anal_Logistic-regression_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

``` r
model.data %>% 
  filter(abs(.std.resid) > 3)
```

    ## # A tibble: 0 x 17
    ## # ... with 17 variables: .rownames <chr>, diabetes <fct>, pregnant <dbl>,
    ## #   glucose <dbl>, pressure <dbl>, triceps <dbl>, insulin <dbl>, mass <dbl>,
    ## #   pedigree <dbl>, age <dbl>, .fitted <dbl>, .resid <dbl>, .std.resid <dbl>,
    ## #   .hat <dbl>, .sigma <dbl>, .cooksd <dbl>, index <int>

## 다중공선성

``` r
car::vif(model)
```

    ## pregnant  glucose pressure  triceps  insulin     mass pedigree      age 
    ## 1.892387 1.378937 1.191287 1.638865 1.384038 1.832416 1.031715 1.974053

  - 넘는게 없어보인다.

# Interpret

``` r
model <- glm(diabetes ~., data = PimaIndiansDiabetes2,family = binomial)
summary(model)
```

    ## 
    ## Call:
    ## glm(formula = diabetes ~ ., family = binomial, data = PimaIndiansDiabetes2)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -2.7823  -0.6603  -0.3642   0.6409   2.5612  
    ## 
    ## Coefficients:
    ##               Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept) -1.004e+01  1.218e+00  -8.246  < 2e-16 ***
    ## pregnant     8.216e-02  5.543e-02   1.482  0.13825    
    ## glucose      3.827e-02  5.768e-03   6.635 3.24e-11 ***
    ## pressure    -1.420e-03  1.183e-02  -0.120  0.90446    
    ## triceps      1.122e-02  1.708e-02   0.657  0.51128    
    ## insulin     -8.253e-04  1.306e-03  -0.632  0.52757    
    ## mass         7.054e-02  2.734e-02   2.580  0.00989 ** 
    ## pedigree     1.141e+00  4.274e-01   2.669  0.00760 ** 
    ## age          3.395e-02  1.838e-02   1.847  0.06474 .  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 498.10  on 391  degrees of freedom
    ## Residual deviance: 344.02  on 383  degrees of freedom
    ## AIC: 362.02
    ## 
    ## Number of Fisher Scoring iterations: 5

  - pregnant 의 값을 보자. 이 경우 임신의 계수는 -10 이다. 이는 임신 하였을 때에 당뇨병에 걸릴
    logit(=log(p(x)/1-p(x))) (p 는 1이 positive 이므로 당뇨병에 걸릴 확률) +0.08 만큼
    변한다는 것이다.
  - 하지만 logit 으로 할 경우 해석이 직관적이지 않다.

<!-- end list -->

``` r
exp(model$coefficients)
```

    ##  (Intercept)     pregnant      glucose     pressure      triceps      insulin 
    ## 4.358754e-05 1.085629e+00 1.039011e+00 9.985807e-01 1.011285e+00 9.991750e-01 
    ##         mass     pedigree          age 
    ## 1.073085e+00 3.129611e+00 1.034535e+00

  - 또는 계수에 대해서 exp 를 취하면 p(x)/1-p(x) 가 얼만큼 오르는지에 대한 추정이 된다.
      - p(x)/1-p(x) = exp(b\_0 + b\_1X\_1…..)
  - pregnant 의 계수는 1.08 이다. 이는 임신하게 되면 odds 가 약 \*1.08 만큼 상승한다는 것이고 이는
    당뇨에 걸릴 확률(odds)이 증가한다는 의미이다.

# 성능 체크

이번에는 train 과 test set 을 나누어서 성능을 체크해보자.

``` r
# seed 를 고정해야 모델의 재현성이 보장됩니다. (물론 선택사항)
set.seed(12345)
df <- PimaIndiansDiabetes2
# getting training data set sizes of .20 (in this case 20 out of 100)
train_size <- floor(0.80*nrow(df))
in_rows <- sample(c(1:nrow(df)), size = train_size, replace = FALSE)
train <- df[in_rows, ]
test <- df[-in_rows, ]
model <- glm(diabetes ~., data = train, family = binomial)
pred <- predict(model,newdata = test, type = "response")
pred_class <- ifelse(pred > 0.5, "pos", "neg")
confusion <- table(predicted = pred_class, actual = test$diabetes)
confusion
```

    ##          actual
    ## predicted neg pos
    ##       neg  52   6
    ##       pos   5  16

## Confusion matrix

``` r
library("caret")
confusionMatrix(confusion)
```

    ## Confusion Matrix and Statistics
    ## 
    ##          actual
    ## predicted neg pos
    ##       neg  52   6
    ##       pos   5  16
    ##                                           
    ##                Accuracy : 0.8608          
    ##                  95% CI : (0.7645, 0.9284)
    ##     No Information Rate : 0.7215          
    ##     P-Value [Acc > NIR] : 0.002649        
    ##                                           
    ##                   Kappa : 0.6486          
    ##                                           
    ##  Mcnemar's Test P-Value : 1.000000        
    ##                                           
    ##             Sensitivity : 0.9123          
    ##             Specificity : 0.7273          
    ##          Pos Pred Value : 0.8966          
    ##          Neg Pred Value : 0.7619          
    ##              Prevalence : 0.7215          
    ##          Detection Rate : 0.6582          
    ##    Detection Prevalence : 0.7342          
    ##       Balanced Accuracy : 0.8198          
    ##                                           
    ##        'Positive' Class : neg             
    ## 

## ROC Curve

``` r
library('pROC')
test_prob <- predict(model, newdata = test, type = "response")
test_roc <- roc(test$diabetes ~ test_prob, plot = TRUE, print.auc = TRUE)
```

![](Anal_Logistic-regression_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->
