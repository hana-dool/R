# pdf 그리기

# (1) 정규분포 그래프 (Normal distribution plot, X~N(0,1))
x <- seq(-3, 3, length=200)
plot(x, dnorm(x, mean=0, sd=1), type='l', main="Normal distribution, X~N(0,1)") 

# cdf 그리기

# Cumulative normal distribution plot, X~N(0,1) 
x <- seq(-3, 3, length=200)
plot(x, pnorm(x, mean=0, sd=1), type='l', main="Cumulative normal distribution, X~N(0,1)")
