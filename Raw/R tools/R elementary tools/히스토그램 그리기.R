# 데이터 불러오기
library(readxl) ## excel 읽는 명령어 출력하기
setwd("C:/Users/Han/Desktop/R") ## 기본경로 설정하기
data <- read_excel("examdata.xlsx") ## data 에 excel data 집어넣기.
data ## data 끝

# 히스토그램 그려보기
summary(data) ## 데이터의 값들이 어떤지 한번 훑어본다.
hist(data$score) ## data 의 score 열의 분포를 그려본다.
hist(data$score,prob=TRUE,breaks=40) ## prob 가 T 이면 상대도수분포도를 만들고, breaks 는 계급을 몇개로 나눌지를 결정한다.
lines(density(data$score), col="red") ## 그래프 위에 직선을 그려본다.
table(data) # 각 값의 도수 구하기