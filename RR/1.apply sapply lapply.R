library(MASS)
str(Cars93)
attach(Cars93)

# apply 조작
mat <- matrix(c(1:9),byrow=TRUE,nrow=3)
mat
apply(mat,1,max) # col 관점(1)에서 최대값을 뽑아라 # 즉 row의 max
apply(mat,2,max) # row 관점(2)에서 최대값을 봅아라 # 즉 col의 max
apply(mat,1,mean)
apply(mat,2,sum) # col sum 

str(Cars93) 
# 차량 유형별(Type) 은 compeact/large/Midsize/small/sporty/van 의 수준(level)으로 고성되어있다.
head(Cars93)

# tapply(벡터,요인,함수) : '벡터' 값들을 '요인'(factor)의 '수준'(level) '함수'를 동시에 적용
# Type apply 라고 보면 쉽다. 
tapply(MPG.highway, Type, mean) #MPG 는 연비
# 차량 Type 별 고속도로 연비 평균
# tapply 를 사용하지 않으면 일일히 적용해야됨.


# sapply() : 데이터 프레임 여러 변수에 함수 명령어 동시 적용 (결과가 vector/행렬)
# sapply 는 벡터 또눈 행렬을 내보낸다.
sapply(Cars93,class) # 27개 변수 한번에 각각의 속성을 알아본다.
sapply(Cars93,length) # 모든 변수에 대해 각각의 크기를 알아본다.
s

#lapply() : 데이터 프레임 여러 변수에 함수변수 동시적용 (결과가 list)
lapply(Cars93,class)


