###
### 표 12.7 시장점유율 적합도 검정
###

x <- c(110, 195,  47, 148)
p <- c(0.2, 0.4, 0.1, 0.3)

(table12.7 <- chisq.test(x, p=p))     # Prints test summary

table12.7$observed   # observed counts (same as M)
table12.7$expected   # expected counts under the null
table12.7$residuals  # Pearson residuals == (Obs-Exp)/sqrt(Exp)
table12.7$stdres     # standardized residuals


###
### 예제 12.1 주사위 - 균등분포 검정
###

p <- rep(1/6, 6)
x <- c(210, 180, 185, 220, 195, 210)

(example12.1 <- chisq.test(x, p=p))     # Prints test summary


###
### 표 12.10 AS접수건수 - 포아송분포 검정
###

x <- 0:4
Obs <- c(94, 67, 33, 3, 3)               # Observed frequency
(n <- sum(Obs))                          # sample size

(sample.mean <- drop(x%*%Obs/sum(Obs)))  # %*% := inner product
# drop := as scalar 
prob <- dpois(x, lambda=sample.mean)
prob <- c(prob, 1-sum(prob))             # the rest of probability

Exp <- n * prob

x <- c(x, 5)
Obs <- c(Obs, 0)
cbind(x, Obs, prob, Exp)
(Exp >= 5)                     # check if expected frequency >= 5

Obs[4] <- sum(Obs[4:6])        # collapse the categories
prob[4] <- sum(prob[4:6])
Exp[4] <- sum(Exp[4:6])      

x <- x[1:4]                    # erase the unnecessary categories
Obs <- Obs[1:4]      
prob <- prob[1:4]
Exp <- Exp[1:4]

chisq <- (Obs-Exp)^2/Exp
cbind(x, Obs, prob, Exp, chisq)

sum.chisq <- sum(chisq)
(p.value <- 1 - pchisq(sum.chisq, df=4-1-1))


## vcd package --> does not collapse !!! 
Obs <- c(94, 67, 33, 3, 3)
x.poi <- c(rep(0, 94), rep(1,67), rep(2,33), rep(3,3), rep(4,3))
library(vcd)    						## loading vcd package
gf<-goodfit(x.poi,type= "poisson",method= "MinChisq")
summary(gf)
plot(gf,main="Count data vs Poisson distribution")


###
### 표 12.14 머리둘레 - 정규분포 검정
###

x <- c(51.92, 52.10, 52.25, 52.41, 52.48, 52.64, 53.02, 53.39,
       53.40, 53.77, 54.00, 54.04, 54.30, 54.42, 54.77, 54.78,
       54.85, 55.31, 55.33, 55.38, 55.49,	55.51, 55.68, 55.69,
       55.80, 55.85, 56.03, 56.05, 56.10,	56.18, 56.22, 56.26,
       56.29, 56.32, 56.35, 56.45, 56.57,	56.64, 56.71, 56.84,
       56.91, 57.03, 57.14, 57.18, 58.00,	58.07, 58.32, 58.66,
       59.26, 59.37)

(x.mean <- mean(x))
(x.sd <- sd(x))
p <- seq(0.1, 1, 0.1)
(z <- qnorm(p, x.mean, x.sd))

count <- as.vector(10)
for (i in 1:10) {
  count[i] <- length(x[x <z[i]])
}
for (i in 10:2) {
  count[i] <- count[i] - count[i-1]
}
count

exp <- rep(5, 10)
(chisq <- sum( (count - exp)^2 / exp))
1 - pchisq(chisq, 7)                   # p-value


###
### 표 12.17 전공과 학점 분할표
###

y <- matrix(c(30, 13, 16,
              8, 16,  7,
              12, 11, 17), nrow=3, ncol=3, byrow=T)
dimnames(y) <- list(c("3.5-4.5","2.5-3.5","1.5-2.5"), c("사회과학","자연과학","공학"))
y

margin.col <- c(50, 40, 40)
margin.row <- c(59, 31, 40)

(margin.col.prob <- margin.col / 130)                  # 표 12.18
(margin.row.prob <- margin.row / 130)                 # 표 12.18

(joint.prob <- margin.row.prob %o% margin.col.prob)   # 표 12.18

(y.exp <- 130 * joint.prob)                           # 표 12.18 expected
(y.chisq <- (y - y.exp)^2 / y.exp)                    # 표 12.18 chi-squares
sum(y.chisq)                                         # 표 12.18 chi-square statistics


## ------------------------------------------------   chisq.test::stats
(x <- chisq.test(y, correct=F))
x$expected
x$residuals^2


###
### 예제 12.2  Homogeneity Test
###

homo <- matrix(c(124, 50, 26,
                 90, 38, 22), nrow=2, ncol=3, byrow=T)
dimnames(yy) <- list(c("남자","여자"), c("경영학","경제학","응용통계학"))
n.marginal <- rowSums(homo)

p.obs <- homo / n.marginal      # compute the est. prob. for men and women
p.obs                     

p.exp <- colSums(homo)/350      # compute the estimated homogeneous prob 
p.exp

homo.exp <- n.marginal%o%p.exp  # Exp values under the homogeneity hypothesis
homo.exp

homo.chisq <- (homo - homo.exp)^2 / homo.exp
homo.chisq
rowSums(homo.chisq)

(xx <- chisq.test(homo))
xx$expected                     # Exp values under the independence hypothesis
xx$residuals^2                  # Chi-square values for each cell
sum(xx$residuals^2)
