#----------bar plot 그리기--------------#

x <- c(50,40,32,68,120,92)
barplot(x,names = 'bar')

barplot(x)
# legend = 범례 그리기
# names = 각 막대의 label 정의
# width = 각 막대의 상대적인 폭을 정의
# space = 각 막대 사이의 간격 지정
# beside = T 이면 각각의 값마다 막대를 그린다.
# horiz = T 이면 막대를 옆으로 눞힌다.
# col = 그래프의 색깔 지정. rainbow(), heat.color(),cm.colors() 가능 
barplot(x,
        main='Main',
        xlab = 'xnames',
        ylab = 'Sale',
        names = c('a','b','c','d','e','f'),
        horiz= T
        )

# 막대그래프 응용하기
a <- c(110,300,150,280,310) # 1~5 월 야구공 판매현황
b <- c(180,200,210,190,170) # 1~5 월 농구공 판매현환
c <- c(210,150,260,210,70)  # 1~5 월 축구공 판매현환
table <- matrix(c(a,b,c),nrow=5,byrow=FALSE)

#------ 월별 판매량(y) 야구공/농구공/축고공(x) 별로 확인하기 -------#
barplot(table,
        main = '월별 판매량',
        beside = TRUE,
        col = rainbow(5),
        ylim = c(0,400),
        names = c('야구공','농구공','축구공')
        )

legend(16,400,c('1월','2월','3월','4월','5월'),
       cex=0.8,
       fill=rainbow(5)) 

#------ 월별 판매량(x) 야구공/농구공/축구공(y) 별로 확인하기 -------#
barplot(t(table),
        beside =TRUE) # 이와같이 transpose 를 시키면 된다. 

#------ 데이터 누적형태로 보기 -------#
barplot(t(table),
        names = c('1월','2월','3월','4월','5월'),
        ylim = c(0,1000),
        col = cm.colors(3)) # beside 를 없애면 된다.

legend(5,1000,
       c('야구공','농구공','축구공'), 
       cex=0.8,
       fill = cm.colors(3))
