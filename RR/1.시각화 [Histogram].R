#----- hisogram-----#
x <- c(1,9,2,4,3,4,5,2,1,3,2,5,6,7,2,4,3,2,5,1,4,2,3,6,1,6,2,3,1,4,5,2)
# 그냥 히스토그램
hist(x)

# density 가 기준인 히스토그램
hist(x,probability = T)

# 그래프를 겹쳐그리기 
hist(x,probability = T)
lines(density(x)) 

# 구간의 갯수 설정
hist(x, breaks=24) # 갯수 설정
hist(x, breaks=seq(1,20,by=1)) # 직접 구간설정
