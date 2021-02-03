library(readxl) ## excel 읽는 명령어 출력하기
setwd("C:/Users/Han/Desktop/R") ## 기본경로 설정하기
data <- read_excel("examdata.xlsx") ## data 에 excel data 집어넣기. read_excel("파일 이름")
data ## data 가 지정되었다.