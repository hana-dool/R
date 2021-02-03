#Chapter 3
# setwd('경로') : 작업한 내용을 저장하는 디렉토리를 지정한다.

# getwd() 현재 설정된 작업한 파일 위치를 보여준다.
getwd()

setwd('C:/Users/goran/Desktop/Git_Hub/R/R tools/[Method] Anova')

#Chapter 3
ch3 = read.csv('ch3.csv', header=TRUE)
head(ch3)
boxplot(observations ~ Methods,
        data = ch3, 
        col = "lightgray",
        medlwd=1, 
        main="Boxplots of Method1 - Method4",
        names=c("Method1","Method2","Method3","Method4"))
# observation 이라는 관찰값을 Method 라는 요인의 수준별로 mean 을 적용
means <- tapply(ch3$observations,ch3$Methods,mean) ; means
points(means,pch=18,col='red')
mtext("means are indicated by solid circles")

# ANOVA table
# 현재 1,2,3 의 범주형으로 구성되어있는 Method 를 factor 형으로 바꾸어주어야 한다. 
ch3$Methods <- as.factor(ch3$Methods)

# next, we run the model
ch3.aov <- aov(observations~Methods, data = ch3)
summary(ch3.aov)

# residual plot
residuals <- resid(ch3.aov)
Fitted = fitted(ch3.aov)
plot(Fitted, residuals, xlab="Fitted Value", ylab="Residual",
     pch=20, main="Residuals vs the Fitted Values")
abline(0,0, lty = 2)
mtext('reponse is y')

# regression plot
tapply(ch3$observations,ch3$Methods,sd)
log_means <- log(tapply(ch3$observations,ch3$Methods,mean))
log_stds <- log(tapply(ch3$observations,ch3$Methods,sd))
plot(log_means,log_stds, pch=20, main="Regression plot",
     xlab="logmean", ylab="logstdev")
abline(lm(log_stds ~ log_means))
lm_fit = lm(log_stds ~ log_means)
summary(lm_fit)

# boxplot after sqrt
ch3$sqrt_obs = sqrt(ch3$observations)
boxplot(sqrt_obs ~ Methods, data = ch3, col = "lightgray",
        medlwd=1, main="Boxplots of Method1 - Method4",
        names=c("Method1","Method2","Method3","Method4"),
        ylab='sqrt(y)')
means <- tapply(ch3$sqrt_obs,ch3$Methods,mean)
points(means,pch=18,col='red')
mtext("means are indicated by solid circles")

# ANOVA after sqrt
# first, we convert each variable to factor
ch3$Methods <- as.factor(ch3$Methods)
# next, we run the model
ch3.aov <- aov(sqrt_obs~Methods, data = ch3)
summary(ch3.aov)
# residual plot after sqrt
residuals <- resid(ch3.aov)
Fitted = fitted(ch3.aov)
plot(Fitted, residuals, xlab="Fitted Value", ylab="Residual",
     pch=20, main="Residuals vs the Fitted Values")
abline(0,0, lty = 2)
mtext('reponse is sqrt(y)')


### Kruskal-wallis
ch3 = read.csv('ch3_add1.csv', header=TRUE)
bulb <- ch3$obs
names(bulb) <- ch3$group
mean_rank_output <- function(vector) {
  ma <- matrix(, ncol=3, nrow= 0)
  r  <- rank(vector, na.last = NA)
  to <- 0
  for(n in unique(names(r))){
    # compute the rank mean for group n
    g  <- r[names(r) == n]
    gt <- length(g)
    rm <- sum(g)/gt
    to <- to + gt
    ma <- rbind(ma, c(n, gt, rm))
  }
  colnames(ma) <- c("Type","N","Mean Rank")
  ma <- rbind(ma, c("total", to, ""))
  as.data.frame(ma)
}

#calculate mean rank
out <- mean_rank_output(bulb)
print(out, row.names= FALSE)

#kruskal wallis test
kruskal.test(obs ~ group, data = ch3)

