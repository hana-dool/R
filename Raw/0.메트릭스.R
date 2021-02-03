#rbind / cbind
array1 <- c(1,2,3)
array2 <- c(4,5,6)
array3 <- c(7,8,9)
rbind(array1,array2,array3) # row 기준으로 구성
cbind(array1,array2,array3) # col 기준으로 구성

#1dim vector 데이터로 매트릭스스 구성하기
x = c(1:9)
mat1<-matrix(x,nrow=3) # 그냥matrix 로 하게되면 col 기준으로 채워진다.
mat1
mat2<-matrix(x,nrow=3,byrow=TRUE) # byrow=TRUE 로 하게되면 row 으로 채운다.
mat2

#col 이름 바꾸기
colnames(mat1) <- c('A','B','C')
mat1

#row 이름 바꾸기
rownames(mat1) <- c('가','나','다')
mat1

# 행렬 연산

# apply 조작
mat1
apply(mat1,1,max) # col 관점(1)에서 최대값을 뽑아라 # 즉 row의 max
apply(mat1,2,max) # row 관점(2)에서 최대값을 봅아라 # 즉 col의 max
apply(mat1,1,mean)
apply(mat1,2,sum) # col sum 


