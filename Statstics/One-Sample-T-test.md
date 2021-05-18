Untitled
================

# 데이터

``` r
hsb2 <- within(read.csv("https://stats.idre.ucla.edu/stat/data/hsb2.csv"), {
    race <- as.factor(race)
    schtyp <- as.factor(schtyp)
    prog <- as.factor(prog)
})
attach(hsb2)
head(hsb2,n=10)
```

    ##     id female race ses schtyp prog read write math science socst
    ## 1   70      0    4   1      1    1   57    52   41      47    57
    ## 2  121      1    4   2      1    3   68    59   53      63    61
    ## 3   86      0    4   3      1    1   44    33   54      58    31
    ## 4  141      0    4   3      1    3   63    44   47      53    56
    ## 5  172      0    4   2      1    2   47    52   57      53    61
    ## 6  113      0    4   2      1    2   44    52   51      63    61
    ## 7   50      0    3   2      1    1   50    59   42      53    61
    ## 8   11      0    1   2      1    2   34    46   45      39    36
    ## 9   84      0    4   2      1    1   63    57   54      58    51
    ## 10  48      0    3   2      1    2   57    55   52      50    51

# 2-side 테스트

``` r
t.test(write, mu = 50,alternative= 'two.sided')
```

    ## 
    ##  One Sample t-test
    ## 
    ## data:  write
    ## t = 4.1403, df = 199, p-value = 5.121e-05
    ## alternative hypothesis: true mean is not equal to 50
    ## 95 percent confidence interval:
    ##  51.45332 54.09668
    ## sample estimates:
    ## mean of x 
    ##    52.775

  - One sample T-test 에 대해서 위와 같이 결과가 나온다.
  - 맨 앞에 하나의 sample 을 쓴다.
  - mu : 검정하고자 하는 \(H_0\) 값이다.
  - alternative : 내가 검정하고자 하는 가설이다.
      - ‘two.sided’ : \(H_1\) : \(\mu \not=50\) 의 의미가 된다.
      - ‘less’ : \(\mu \le 50\)
      - ‘greater’ : \(\mu \ge 50\)
