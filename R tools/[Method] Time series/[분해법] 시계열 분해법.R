#install.packages("fpp")
library(fpp)
##EX 1 ##
head(ausbeer)
zt <- head(ausbeer, 17*4)
ts.plot(zt)
#추세성분 계절성분이 들어가있다.
#다만 분산이 점점 증가하는거같지 않으므로 가법모형이 더 적합해보인다.
plot(stl(zt,s.window="periodic"))
#시각적인 표현
#periodic = 각각 분리해서 보여주라는 말.
#seaonal = 추세 빼버렸을떄 
#remiander = 계절, 추세 다 빼도 불규칙이 이정도있어!

##EX 3 ##
plot(AirPassengers) # 시도표 그리기
#계절성이 있고, 계절성의 진폭이 점점 증가하므로 승법모형이 적절해 보인다.
#분해법을 쓰려고 하면
plot(stl(AirPassengers,s.window="periodic"))

# 추세 체크하는 정도로만으로 그치자. 