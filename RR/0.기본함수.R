x=3

# ls() : 현재 사용중인 변수의 목록을 보여준다.
ls()

# rm(x) : 사용중인 변수 x 를 지운다.
rm(x)

# cat('텍스트') : 괄호 안의 내용을 화면에 출력한다.
cat('PYTHON 이 최고야')

# setwd('경로') : 작업한 내용을 저장하는 디렉토리를 지정한다.
setwd('C:/Users/Han/Desktop')

# getwd() 현재 설정된 작업한 파일 위치를 보여준다ㅏ.
getwd()

# read.csv('.../데이터.csv') : 경로에서 csv 파일을 읽어옵니다.
data<-read.csv('C:/Users/Han/Desktop/data_finance.csv')
# header = TRUE (제목의 존재여부. 있으면 O)
# stringAsFactor = FALSE R 은 기본적으로 데이터 파일 안에있는 string 을 요인(factor) 취급한다. 그게 싫으면 readCSV 함수 내에 stringasfactor 을 false 로 하면 된다.

# colsole 의 메시지 전부삭제
cat("\014")

# 우층 상단의 envirenment 창의 모든 dataseats를 삭제
rm(list=ls())

# 우측 하단의 plots 창에 있는 plot 들을 전부 삭제
dev.off()

# 내장 data import 하기
data(trees)

# 데이터 프레임 선택
trees[trees$Height>3,]

# 지수형태 출력 바꾸기
options("scipen" = -100) # 작은 값을 지정하면 지수가 붙어서 나온다.
999 * 1000000
options("scipen" = 100) # 큰 값을 지정하면 값이 그대로 나온다.
999 * 1000000
options("scipen" = 0) # default
999 * 1000000

# 새로운 열 추가
data('mtcars')
mtcars
mtcars$carname = 2
mtcars # 위와같이 지정하면 그냥 추가된다.

# [attach] 데이터 프레임의 값 붙여주기(계속 사용하기위해)
attach(trees)
mean(Height)

# [detach] 데이터 프레임을 떼놓을 때에 사용한다
detach(trees)
mean(Height)

# [with] (attach 의 간소화 버젼)
library(MASS)
data(Cars93)
# 데이터 프레임 이름을 지정하지 않으면 R은 어디에서 변수를 가져와야 할지 알지 못함. 에러 발생
mean(mpg)
# '데이터 프레임 이름$변수명' 형식으로 '$'를 이용해 객체 지정해주어야 R이 이해를 함
mean(mtcars$mpg)
tf_0_1 <- (max(mtcars$mpg) - mtcars$mpg) / (max(mtcars$mpg) - min(mtcars$mpg))
tf_0_1
# 위의 '$'는 R 명령어를 입력할 때마다 매번 '데이터 프레임 이름$변수명' 처럼 데이터 프레임 이름을 입력해주어야 하므로,
# 입력해야할 R 명령문이 많아지만 꽤 번거로운 방법
# 이런 번거로움을 해결해주는 방법이 바로 WITH 이다.
tf_0_1_2 <- with(mtcars, (max(mpg) - mpg) / (max(mpg) - min(mpg)) )
tf_0_1_2
# 그러나 이 방법은 계속 with 을 붙여줘야해서 넘모 번거롭다.