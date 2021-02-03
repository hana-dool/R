# ggplot 
library(ggplot2)

# 사용될 데이터 준비
diamonds

# 이렇게 하면 table 대로 오름차순의 순서대로 데이터를 배열한다.
g = diamonds[order(diamonds$table),] 
head(g) # 오름차순 배열 후 맨 앞의것 5개이므로, table 이 작은 값을 출력
tail(g) # 오름차순 배열 후 맨 뒤의것 5개이므로, table 이 큰 상위값을 출력

# 기본 그래픽 데이터
# 맨 처음에 ggplot를 써서 그래프를 그릴 거라고 컴퓨터에게 알려줍니다.
# 이어서 괄호 안에 어떤 데이터를 쓸 건지, x축과 y축은 어떤 열을 활용할 것인지도 담아줍니다.

gg <- ggplot(diamonds, aes(x=carat,y=price)) # 그래프를 그리기 위해 x,y 를 지정한다.
gg 
# 여기서 그냥 실행을 하면 그냥 x축에 carat, y축에 price만 표시할 뿐 메인 영역(?)은 그냥 빈 공간으로 남아 있게 됩니다.

# 이 메인 영역 모양을 결정하는 게 바로 geom_point(aes(size=hp, color=wt)입니다. 
# ggplot2에서는 이렇게 더하기(+) 표시로 이어가면서 그래프에 필요한 요소를 추가합니다.
gg + geom_point()

gg+geom_point(size=2,shape=2,color='blue',stroke=1)
# size : 점 크기
# shape : 점의 모양 
# color : 점의 색깔
# stroke : 각 점 의 외곽선 굵기


#-- 색, 크기 등에 categorical/continuous 데이터 대입하기 --#
gg+geom_point(aes(size=carat, shape = cut, color=color,stroke=carat))
# cut / color 는 categorical data 이기 때문에 shae / color 에 쓸 수 있다! 
# gg 에 data를 diamonds 라고 명시하였기 때문에, col명들을 그냥 diamonds$shape 라고 하지 않아도 된다.


#-- 재목과 축 명칭을 변경해보기 --#
gg1 = gg+geom_point(aes(color=color))
gg2 = gg1 + labs(title='Diamonds', x = 'Carat Layer', y = 'Price Layer')
gg2

#-- example --#
options(scipen=999) # 1e+48 같은 표현식을 쓰지 않겠다는 의미
