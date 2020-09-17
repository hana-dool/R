#------------데이터 처리함수------------#

# head(데이터) : 데이터의 앞부분을 보여준다.
head(iris)

# tail(데이터) : 데이터의 뒷부분을 보여준다.
tail(iris)

# View(데이터) : 데이터 내용을 새 윈도우를 열어서 보여준다.
View(iris) # 오름차순으로 각 COL 을 정렬시켜볼수도 있고 아주 다양하다.

# dim(데이터) : 데이터의 차원
dim(iris)

# length(데이터) : 테이터의 element 갯수
length(iris)

# names(데이터) : 데이터의 구성요소 이름 (col 의 이름)
names(iris)

# summary(데이터) : 데이터의 기초 통계량을 보여준다.
summary(iris)

# class(데이터) 데이터의 속성 
class(iris)

# str(데이터) : 데이터의 구성의 속성 보여준다.
str(iris) # 범주형의 경우 어떤 level 로 구성되어있고, 각 data type 이 뭔지

# attach(데이터) : 데이터를 고정해서 사용한다.
attach(iris)
Sepal.Length # 원래 iris@Sepal.Length 로 해야하지만, attcach 로 해서 바로나온다.

# detach(데이터) : 데이터 고정을 해재한다.
detach(iris)
Sepal.Length # 이렇게 실행하면 오류가 난다.
iris$Sepal.Length 

# with(데이터) : 데이터를 활성화한다. attach 와 비슷
with(iris,max(Sepal.Length))

#------------R 의 데이터구조------------#
# scala : 구성인자가 하나인 벡터
c(1)

# vector : 구성인자가 1개 이상/ 1차원 ( 벡터중에서 구성인자가 1개면 scala)
c(1,2,3)

# factor(요인) : 범주형(명목/순서)의 데이터구조
# 요인이 가질 수 있는값들을 수준(level) 이라고 한다.
# 펙터는 레벨을 알파벳 순으로 정렬한다. 
# 그 다음 알파벳 순의 레벨의 정수 인덱스로 벡터 내용을 다시 만든다.
# 펙터의 실제 내용은 레벨의 정수 인덱스이고, 각 정수를 레벨명으로 해독 가능한 범례가 있다고 생각하면 쉽다.
data = c('c','a','b')
example = factor(data)
as.numeric(example) # 이를 보면 3,1,2 로 되어있음을 볼 수 있다.
# 이렇게 하면 c,b,a 순으로 1,2,3 의 값을 매기고 ordered 가 c<b<a 로 된다.
factor(data,levels=c('c','b','a'),ordered = T) 


# Matrix(행렬) : 동일한 유형의 2차원 데이터
matrix(1:12,nrow=3)

# array(배열) : 동일한 유형의 데이터가 2차원 이상으로 구성
array(1:24,c(2,3,4)) # 2*3*4 array

# dataframe(데이터프레임) : 데이터 유형에 상관없는 2차원데이터
data.frame('X1'=c('a','b'),'X2'=c(1,2))

# List(리스트) : 벡터/행렬 등등 다른 구조의 데이터를 모두 묶은 객체
L1 <- c(1,2,3,4)
L2 <- matrix(1:6,3)
L <- list(L1,L2)
L

#-------------데이터 구조 함수----------#
#--왜 해야하나요?--#
library(MASS)
str(Cars93) # 데이터의 속성을 잘 확인하여야, 
# 1.각 데이터 속성에 맞는 함수를 적용가능
# 2.데이터별 속성이 잘못 들어가있을수도 있다. (숫자형이 factor 라든지...)

# factor(데이터) : 데이터를 factor 로 변환해준다.
x <- c('A','B','C')
factor_x <- factor(x)
str(factor_x) # level이 생긴 factor 형태가 된 것을 볼 수 있다.

# as.numeric(데이터) : 데이터를 숫자로 변환한다.
x <- c('4','5','10')
str(x) # chr 의 데이터 tpye
numeric_x <- as.numeric(x)
str(numeric_x) # chr -> num 으로 데이터 type 이 바뀐것을 볼 수 있다.

# as.character(데이터) : 데이터를 chr 로 변환


