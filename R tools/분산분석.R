# 분산분석 
# 일원분산분석
# 많은 모집단중 모집단끼리 평균 차이가 있을까?

damage <- c(681, 643, 469, 384,
            728, 655, 727, 656,
            917, 742, 525, 602,
            898, 514, 454, 687,
            620, 525, 459, 360)
size <- gl(n=4, k=1, length=20, labels=c("1소형","2준중형","3중형","4대형"))
data1 <- data.frame(damage, size)
data1
stripchart(damage ~ size, vertical=T, main="head damage by the size of car") #strip chart

library(gplots)
plotmeans(damage ~ size)           # 95% confidence intervals
plotmeans(damage ~ size, bars=F)   # without confidence intervals

damage.aov <- aov(damage ~ size)   # 1-way ANOVA 
#aov(Y~X) 앞의것은 반응변수, 뒤의것은 설명변수 이때는 사이즈에 대해서(소,중,대) damage 를 설명하고있으므로 damage~size
summary(damage.aov)
#PF(>F) 값이 매우 작다. 즉 평균이 모두 같다는 귀무가설을 기각한다. 

TukeyHSD(damage.aov)               # Tukey multiple comparison
plot(TukeyHSD(damage.aov))
# 평균차이가 존재한다는 결론이 났으므로 그 차이를 보이는 모집단이 무었인지에 대한 검정이 추가로 필요하다. 
# 옆에 신회구간이 0을 포함하지 않아야 두 모집단 평균은 유의적으로 차이가 있다고 결론이 난다. 지금은 3중형과 1소형이 유의적인 차이가
# 있다고 해석할 수 있다.



###2 이원분산분석
#하나의 반응변수에 영향을 미치는 요인이 2가지 일때 어떤 요인이 영향을 미칠까?
damage2 <- c(700, 540, 450, 460,
             820, 680, 590, 600,
             710, 530, 470, 470,
             830, 710, 590, 610)

size2 <- gl(n=4, k=1, length=16, labels=c("1소형","2준중형","3중형","4대형")) 
make2 <- gl(n=2, k=8, length=16, labels=c("제조사A","제조사B")) 

data2 <- data.frame (damage2, size2, make2)
data2

damage2.aov <- aov(damage2 ~ size2 * make2 ) #이렇게 *를 해주어야 한다. 순서는 상관없다.
summary(damage2.aov)
#            Df Sum Sq Mean Sq F value Pr(>F)  
#size2        3 147600   49200   5.112 0.0289 *  # 평균차가 없다 라는 귀무가설 기각 즉 사이즈에 대한 damage 차이는 존재한다.
#make2        1    400     400   0.042 0.8436    # 평균차가 없다 라는 귀무가설 채택
#size2:make2  3      0       0   0.000 1.0000    # 상호작용에 대한 검정. 1이므로 상호작용이 없다는 귀무가설 채택.
#Residuals    8  77000    9625  


### 확률화 블록설계
#피험자 1,2,3,4,5 에 대해 운영체제 a,b,c, 에대해 과제를 수행하는 실험이라 하자. 피험자의 역량 차이에 대한 오차를 제거해주기 위해
#피험자간을 블록처리하자.
time <- c(16, 16, 19,
          19, 17, 18,
          14, 13, 15,
          13, 12, 14,
          18, 17, 19)

OS <- gl(n=3, k=1, length=15, labels=c("A","B","C"))
subject <- gl(n=5, k=3, length=15, labels=1:5)

data3 <- data.frame (time, OS, subject)
data3
        

time.aov <- aov(time ~ OS + subject) #블록설계는 + 를 쓴다. 요인 + 블록 으로 블록이 뒤로 오게 쓴다.
summary(time.aov)
#               Df Sum Sq Mean Sq F value   Pr(>F)    
#  OS           2     10     5.0      10  0.00666 **   # 블록설계를 고려한 p-value 이다. 즉 귀무가설(평균차가없다) 를 기각. 
#  subject      4     66    16.5      33 5.09e-05 ***  # subject 는 블록화된것에 대한 값이다.
#  Residuals    8      4     0.5             

## If there were no block....
time.aov2 <- aov(time ~ OS)
summary(time.aov2) # 즉 블록이 없으면 귀무가설 기각 불가. 즉 평균차이가 없다. 


