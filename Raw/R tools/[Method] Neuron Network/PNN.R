######################################################################
###Chapter 4 - Introduction to Neural Networks - using R ##########
###Simple Perceptron implementation function in R - iris dataset ####
######################################################################

#데이터 살펴보기
data(iris)
head(iris, n=20)
iris_sub=iris[1:100, c(1, 3, 5)]
# 우선 100 개의 DATA 를 사용하자.
names(iris_sub)=c("sepal", "petal", "species")
# 우리는 2 variable (sepal,petal) 을 이용해 species 를 구분할 것이다.
head(iris_sub)


#데이터 시각화해보기
library(ggplot2)
# ggplot 은 graph 를 fancy 하게 만들 수 있게 해준다.
ggplot(iris_sub, aes(x = sepal, y = petal)) +
  geom_point(aes(colour=species, shape=species), size = 3) +
  xlab("Sepal length") +
  ylab("Petal length") +
  ggtitle("Species vs Sepal and Petal lengths")
#linear line 을 그려서 두개의 species 에 대한 구분을 하고싶다!


#PNN 을 위한 함수 정의하기
#norm 을 계산하기 위한 function 을 정의
euclidean.norm = function(x) {sqrt(sum(x * x))}
distance.from.plane = function(z,w,b) {sum(z*w) + b}
# weight parameter = w , bias = b

classify.linear = function(x,w,b) {
  distances = apply(x, 1, distance.from.plane, w, b) # 행별로 distnce function 을 적용하겠다는 의미
  return(ifelse(distances < 0, -1, +1))}
# distance 가 0보다 작으면 -1/ 0보다 크면 +1 을 도출

perceptron = function(x, y, learning.rate=1) {
  w = vector(length = ncol(x)) # initialize weights
  b = 0 # Initialize bias
  k = 0 # count updates
  R = max(apply(x, 1, euclidean.norm))
  mark.complete = TRUE
  
  while (mark.complete) {
    mark.complete=FALSE
    yc = classify.linear(x,w,b)
    for (i in 1:nrow(x)) {
      if (y[i] != yc[i]) {
        w = w + learning.rate * y[i]*x[i,] # update!
        b = b + learning.rate * y[i]*R^2
        k = k+1 # number of update . 한번 update 될때마다 1 씩 증가하고 있음을 볼 수 있다.
        mark.complete=TRUE # if 안으로 들어오지 않아야 ( 즉y[i]=yc[i]여야 mark.complete=FALSE 로 유지가 되어 while 이 끝난다.)
      }
    }
  }
  s = euclidean.norm(w)
  return(list(w=w/s,b=b/s,updates=k))
}

x = cbind(iris_sub$sepal, iris_sub$petal)
y = ifelse(iris_sub$species == "setosa", +1, -1)
p = perceptron(x,y)
plot(x,cex=0.2)
points(subset(x,y==1),col="black",pch="+",cex=2)
points(subset(x,y==-1),col="red",pch="-",cex=2)
intercept = - p$b / p$w[[2]]
slope = - p$w[[1]] /p$ w[[2]]
abline(intercept,slope,col="green")
# b + w1x1 + w2x2 > 0 -> 1
# b + w1x1 + w2x2 < 0 -> -1
# green line 은 b + w1x1 + w2x2=0 의 line 이다.