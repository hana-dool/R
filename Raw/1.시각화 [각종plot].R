#----- hisogram-----#

x <- c(1,9,2,4,3,4,5,2,1,3,2,5,6,7,2,4,3,2,5,1,4,2,3,6,1,6,2,3,1,4,5,2)
# 그냥 히스토그램
hist(x)

# density 가 기준인 히스토그램
hist(x,probability = T)

# 그래프를 겹쳐그리기 
hist(x,probability = T)
lines(density(x)) 

#-----원 그래프-----#
x <- c(100,130,200,250)
pie(x)

pie(x, 
    init.angle = 90,
    labels = c('1월','2월','3월','4월'),
    col = rainbow(length(x)))

legend(1,1,c('1월','2월','3월','4월'),fill = rainbow(length(x)))
    
#------- box plot -----#

boxplot(x) 

#----- 
