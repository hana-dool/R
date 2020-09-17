
# vecror 로부터 dataframe 형성하기
xNum <- c(1,3,5,7)
xLog <- c(T,T,F,F)
xChar <- c('a','b','c','d')
df <- data.frame(xNum,xLog,xChar)
df

str(df)

# 데이터프레임 변수추가
#1
df$Name <- c('kim','park','tom','jae') # 그냥 새로운 col 을 추가
df
#2
df <- transform(df,Age = c(10,13,14,17)) # 이걸 더 선호((여러번수도 한꺼번에 가능))
df

# 데이터프레임 결합
df1 <-data.frame(xNum,xLog)
df1
df2 <-data.frame(xChar)
df2
cbind(df1,df2) # column 방향으로 묶는다.

df1 <- data.frame(name = c('kim','park'),
                  age = c(13,15))
df2 <- data.frame(name = c('han','choi'),
                  age = c(26,23))
rbind(df1,df2) # row 방향으로 묶는다.

# 데이터프레임 인덱싱
df
df[,2] # index 직접 써서 찾기
df[2,]
df[3,3] 
df$xLog[2] # col 의 이름 쳐서 찾기

# 데이터프레임 변수명 변경
names(df) <- c('V1','V2','V3','V4','V5')
df

# 데이터프레임 조건에 맞는 관측치 선택
mtcars
# 변속기가 자동(am==0) 이고 실린더가 4개 또는 6개(cyl==4 or cyl==6) 인 자동차의 연비 (mpg) 평균은?
attach(mtcars) # attach 하고 하는게 편하다!!!!
mtcars[(am==0)& (cyl %in% c(4,6)) , c('mpg','cyl','am')]

# 데이터프레임 정렬
mtcars[ order(mpg),]
