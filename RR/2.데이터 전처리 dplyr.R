library(dplyr)
library(ggplot2)
# %>% 파이프 연산자
# 함수의 출력이 그 다음값으로 바로 들어가는것
# %>% 함수1 %>% 함수2(함수1의 값을 이용) %>%...... 
# function (dataframe,arg1,arg2) 
# dataframe %>% 
#   function(arg1,ar2) # 위와 이 표현은 같다.
id <- c(1,2,3,4,5,6)
class <- c(2,1,2,1,1,2)
english <- c(98,97,86,98,80,89)
science <- c(50,60,78,58,65,98)
data <- data.frame(id,class,english,science) ; data

# select : 데이터 프레임에서 내가 원하는 column 만 선택하겠다. 
data %>% # 데이터가 slect 의 입력으로 들어감
  select(class,english) # class, english 만 표출해라

#------filter : 특정 row 만 뽑고싶을때----------#
data %>%
  filter(class==1) # class 가 1반인 observation 만 보고싶어어
# 이때 %in% (included in) 으로 storm_name %in% c('Katrina',Maemi) 은 카트리나 혹은 매미를 포함하는 것
# <= > != 등 많은 operator 가 가능하다.
# is.na (missing value 가 있느냐 없느냐)
# logical operator 를 다양하게 사용해서 filter 과 같이 사용할 수 있다.

#다이아몬드 가격이 950 이하이고, 800이상인 것만 고를 때
diamonds %>%
  filter(price <= 950 & price >= 800)

#-------select 변수 성택 -----------------#

# c로 시작하는 변수들만 선택
diamonds %>%
  select(starts_with("c"))

# 변수의 끝나는 스펠링
diamonds %>%
  select(ends_with("e"))

# 변수에 포함된 스펠링 
diamonds %>%
  select(contains("r"))

# 특정 위치의 선택
diamonds %>%
  select(1:4)

data %>%
  select(english,science) %>% # 데이터에서 영어와 과학 col 만 선택하고
  filter(science >= 70) %>% # 그다음 과학 점수는 70점 이상인거만 고르고
  head(2) # 그다음 2개의 row 만 출력

#----------arrange : 정렬
data %>%
  arrange(id) # 오름차순 정렬

data %>%
  arrange(desc(id)) # 내림차순 정렬

data %>%
  arrange(id, desc(science)) # id 는 오름차순 그리고 science 는 내림차순 정렬
# id 가 먼저 순위가 된다. 

data %>%
  mutate(total = english+science) # 새로운 total 이라는 column 변수가 들어가게 된다.

data%>%
  mutate(total = english+science) %>%
  mutate(mean = total/2) %>%
  mutate(test = ifelse(mean>=60,'pass','fail')) # 이렇게 ifelse 를 쓸 수 있음

#--------------- Summarize data
storm = data.frame(storms)
# 이렇게 아래처럼 summarise 가능
storm %>%
  summarise(n_obs = n(), # 총 몇개인지 알고싶다면 n()
            max_wind = max(wind),
            min_wind = min(wind)) # 제일 약한 바람

# ------------------ grouping 가능
storm %>%
  group_by(name,year)  # name 과 year로 오름차순으로 

# --------- grouping + summarizing
storm %>%
  group_by(name,year) %>% # 이름과, 년도에 대해 grouping
  summarise(n_obs = n(), # 각 group 에서 갯수가 몇개?
            max_wind = max(wind), # max wind 는 얼마?
            min_wind = min(wind)) 

# ------------ Use 사용자 정의 함수
knot <- function(knot){
  mph <- 1.152 * knot
}
# 위와 같이 함수를 만든다.

storm %>%
  summarise(n_obs = n(),
            max_wind = knot(max(wind))) # 다음과 같이 미리 정의한 함수 이용 가능

#--------------- count 함수

# 데이터 변수 이름 변환환
diamonds <- diamonds %>%
  rename(width  = x,
         length = y,
         heigth = z)

colnames(diamonds)

#---------------- sampling 함수
# 전체 관측치 중에서 100개만 비복원 추출
diamonds %>%
  sample_n(100)

# 100개만 복원 추출
diamonds %>%
  sample_n(100,
           replace = T)

# 전체 데이터중에 30% 비복원 추출
diamonds %>%
  sample_frac(.3)


# https://www.youtube.com/watch?v=HrtfvxQ8f_M&list=PLCsebpDZm0n6yYlJ64KFJHu2T8VCC5YCj&index=4 


#-------------------------- Advanced working--------------------#
# group by 로 두개 변수의 combination 에 대해서 각 value 들의 count
diamonds %>% 
  group_by(cut,color) %>%
  summarise(count = n())
# 이렇게 해도 위와 같다.
diamonds %>%
  count(cut,color) 

# group by 로 두개 변수의 combination에 대해서, unique 한 clarity 의 count
diamonds %>% 
  group_by(cut ,color) %>%
  summarise(count = n_distinct(clarity))
# 즉 fair cut, D color 인 경우에, clarity 의 종류는 8개



