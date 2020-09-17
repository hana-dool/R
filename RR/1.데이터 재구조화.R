library(reshape)
library(MASS)
attach(Cars93)
#subset(Data 이름, select = c(변수명), subset = (선별 조건)) 변수, 관측치 선택
Cars93
data <- subset(Cars93,
               select = c(Type,Origin,MPG.city,MPG.highway),
               subset = (Type %in% c('Compact','Van')))
data

#melt : 식별자(id)/ 측정변수(variable) / 측정치(value) 형태로 데이터를 재구성한다.
data_melt <- melt(data = data,
                  id.vars = c('Type','Origin'), # 식별자가 될 col
                  measure.vars = c('MPG.city','MPG.highway')) # 측정치가될 col들
data_melt
data
# 이제 melt 시켰으므로 , cast 로 함수를 재 정렬시키자.

# 한개의 id.var 기준(세로) & variable(가로) 조합의 value 값에 mean 함수 적용
cast(data = data_melt, Type ~ variable, fun = mean)

# 두개의 id.var 기준(세로) & variable(가로) 조합의 value 값에 mean 함수 적용
cast(data = data_melt, Type + Origin ~ variable, fun = mean)







