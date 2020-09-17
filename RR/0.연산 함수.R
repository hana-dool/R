#------------처리함수------------#
abs(-10) # 절대값
sqrt(9) # 제곱근
ceiling(9.4) 
floor(9.4)
round(9.45,1) # x를 소수점 n까지 반올림
log(100,base=10) # 밑이 10 인 log
log(2.718) # 자연로그
exp(2) # exponential
factorial(3)

#------------기술통계 함수------------#
x<-c(1:5) 
mean(x)   #평균
median(x) #중앙값값
var(x)    #분산
sd(x)     #표준편차
min(x)    #최소
max(x)    #최대
range(x)  #범위
length(x) #갯수 
cumsum(x) #벡터누적합
cumprod(x)#벡터누적곱

#------------통계 분포 함수 -----------# 
#beta        : beta  (shape1 shape2) 
#binomial    : binom (size prob)
#chi-square  : chisq (df)
#unif        : unif  (min max)
#exp         : exp   (rate)
#F           : f     (df1 df2)
#gamma       : gamma (shape rate(scale))
#geometric   : geom  (prob)
#normal      : norm  (mean sd)
#poisson     : pois  (lambda)
#T           : t     (df)

#d--- : pdf/pmf 
#p--- : cdf
#q--- : quantile
#r--- : random sample

rnorm(100) # 100개의 N(0,1) sample
rexp(100,rate=1)

dbinom(3,size=10,prob=0.25) # X ~ B(10,0.25) 에서 P(X=3)
dpois(0:2,lamda = 4) # X ~ pois(4) 에서 P(X=0,1,2)

pnorm(12,mean=10,sd=2) # X~N(10,4) 에서 P(X <= 12)

qt(0.95,df=20) # 95th percentile of t(20) 즉 왼쪽꼬리의 값이 0.95 
qt(0.05,df=20,lower.tail = F) # 즉 오른쪽 꼬리의 값이 0.05


#------------비교,논리연산함수------------#
x<-c(1:5) 
y<-c(5:1)

# elementwise 하게 수행이 된다.
x*y
x+y

#비교
x>=y
x<=y
x>y 
x!=y #서로 같지 않다.

#논리
(3 <= x) & (x <= 4) # and
(3 <= x) | (x <= 4) # or
any(3<=x) # 하나여도 맞으면 true
all(3<=x) # 모두 맞아야 true

#--------------연산자--------------#
x
y
x%%3 #나머지
x%/%3 #몫
x%*%y #행렬곱
x%in%2 #벡터내 특정값 포함여부


#-------------행렬함수----------#
A <- matrix(c(1,6,3,
              4,2,5,
              8,7,9), byrow=TRUE,nrow=3)
B <- matrix(c(1,1,1,
              -1,-1,-1,
              0,0,0),byrow=TRUE,nrow=3)
t(A) #transpose
diag(c(1,2,3,4)) #대각행렬
diag(4) #항등행렬렬
solve(A) #역행렬
det(A) #det
A*B # elementwise 연산
A%*%B # 행렬연산
# 1~10 의 vector 만들기

# ----------정렬 ----------#
x <- c(1,4,3,2,6,5,4,8)
sort(x) # 오름차순 정렬
sort(x,decreasing = TRUE) # 내림차순 정렬
order(x,decreasing=FALSE) # 값이 큰 것부터 있는 인덱스값
?order

x<- c(1:10)
which(x==3) # 3이 위치하고 있는 2를 반환


1:10 
c(1:10)

# sequence 만들기 (등차수열)
seq(from=1, to=10, by=0.5)

# 반복되는 vector 만들기
rep(1:3, each=3) # 111222333 처럼 each 숫자가 3번 반복
rep(1:3, times=2) # 123 123 으로 전체가 2번 반복


sort(x,decreasing = TRUE) #정렬

#x[i] : 벡터의 i번째 값을 보여준다.
x[2]

#x[i] <- 3 : 벡터의 i번째 값을 3 으로 치환한다.
x[2] = 99

#x[-i] : 벡터의 i번쨰 값을 없애고 보여준다.
x[-2]

#x[n:m] : 벡터의 n~m 값을 보여준다.
x[2:4]

#apppend(x,y) : x와y 를 연결한다.
append(x,y)

#x + 1, x * 3 , x / 3 ... : 연산이 모두 elemetwise 하게 된다
x+10
x*10
x/10

# 벡터의 집합연산
x
y
union(x,y) #x,y 의 합집합
intersect(x,y) #x,y 의 교집합
setdiff(x,y) #x,y 의 차집합


#--------------문자형 벡터 연산------------#
x<- c('japan','taiwan','japan','korea','china','china','india')

#nchar(x) : 문자형 벡터의 갯수 구하기
nchar(x)

# unique(x) : 벡터가 어떤 종류로 구성되었는지 확인
unique(x)

#strsplit(x,split='') 문자형 벡터 x 를 split 기준으로 해서 나누기
name <- c("Chulsu, Kim", "Younghei, Lee", "Dongho, Choi") 
name_split <- strsplit(name, split=",")# strsplit() 으로 분리하기
name_split
last_name <- c(name_split[[1]][2], name_split[[2]][2], name_split[[3]][2]) #indexing
first_name <- c(name_split[[1]][1], name_split[[2]][1], name_split[[3]][1])# last_name과 first_name, name을 데이터 프레임으로 묶기
name_d.f <- data.frame(last_name, first_name, name) # last_name과 first_name, name을 묶기
name_d.f


# match(x, 기준vector) # 기준 vector 와 x 가 같은지 검사
match(x,c('korea','india')) 

# grep('A',x) A로 시작하는 문자열을 찾아서 INDEX 를 도출 
grep('ja' , x)  # ja 로 시작하는 japan 은 1,3 번쨰
grep('(pa)', x) # 문자열에 pa 를 보함하는 문자는 1,3 번째



#-------------논리형 벡터 연산-------------#
x <- c(1,5,2,6,7,3)

5 <= x # 각 element 들에 대해서 조건을 확인한다.

all(5 <= x) # 모든 element 에 대해서 조건을 만족하는지 확인

any(5 <= x) # 적어도 하나 element 에 대해서 조건을 만족하는지 확인

(5 <= x) & (x <= 6) # 두개 이상의 논리형을 엮을때 &
