#-----함수정의-----#
function1 <- function() {
  x<-10
  y<-20
  result <- x+y
  return(result)
}
function1()

#Tip 매번 함수를 사용할때마다 정의하면 중간데 잘못될 경우가 있으므로 함수만 정의하는 
#cell 을 옆에 따로 만들어서 관리하면 매우매우 편하다.

#-----함수정의 2-----#
function2 <- function(x,y){
  a <- x
  b <- y
  return(a+b)
}
function2(1,2)

#-----함수 저장 및 활용-----#
ls() # 현재 어떤것들이 저장되어있는지 살펴보자.
save(function1,function2,file="myfunction.Rdata") # 이 함수들을 저장한다.

rm(list=ls()) #목록을 지운다.
function1() # 목록이 지워져서 더이상 사용할 수가 없다.
load("myfunction.Rdata")
function1() # 목록을 불러들이니, 새로 함수가 추가되었다!

#-----조건문-----#
x <- runif(1)
x

#if
if(x>0) print('양수입니다') #조건에 맞으면 양수입니다 를 print 한다.
if(x<0) print('음수입니다') #조건에 맞지않으면 음수입니다를 print 한다.

#if(조건)[명령문1] else [명령문2] : 조건을 만족하면 명령문1실행/ 그외는 명령문2실행
if(x>0) print('양수') else print('음수') 

#ifelse([조건],[명령문1],[명령문2]) : 조건을 만족하면 명령문1실행/ 그외에는 명령문2 실행
ifelse(x>0 , x+1 , x-2) 

#switch([기준],[조건1],[명령문1],[조건2],[명령문2]....)

#for
sum = 0
for (i in seq(1,10,by=2)) sum <- sum+1
sum

#중첩for
#1*1 1*2 ... 5*5 의 값을 모두 더하고싶다고 하자.
mult <- 0 
for (i in c(1:5)) {
  for (j in c(1:5)){
    mult <- i*j
  }
}
mult

# while TRUE 일때는 계속 실행한다.
sum <- 0
i <- 0 
while (i<=10) {
  sum <- sum+1
  i <- i+1 # while 을 쓸떄는 마지막에 i = i+1 을 하는것이 좋다.
}
sum 

