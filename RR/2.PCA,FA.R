
# setwd('경로') : 작업한 내용을 저장하는 디렉토리를 지정한다.
setwd('C:/Users/Han/Desktop')

# getwd() 현재 설정된 작업한 파일 위치를 보여준다ㅏ.
getwd()

# read.csv('데이터.csv') : setwd 경로에서 csv 파일을 읽어옵니다.
data<-read.csv('C:/Users/Han/Desktop/data_finance.csv')
attach(data)

#---------------------PCA---------------------#
# WHY?
# 1. 여러 변수들간에 내재하는 상관관계/ 연관성을 이용해 소주의 주성분,요인으로
#    축소함으로서 데이터를 이해하기 쉽고 관리하기 쉽게 한다.
# 2. 다중공선성이 존재할경우 상관도가 높은 변수들을 하나의 주성분/요인으로 축소
#    하여 모형개발에 활용한다.
# 3. 기계에서 나오는 다수의 센서데이터를 주성분/요인분석을 하여 차원을 축소한후
#    시계열로 분포나 추세의 변화를 분석하면 기계의 고장징후를 사전에 파악할 수도 있다.

#---1.데이터 표준화하기---#
#주성분분석에서는 평균고 표준편차를 가지고 표쥰화 한 데이터를 사용한다.
data
V1_s = scale(V1)
V2_s = scale(V2)
V3_s = scale(V3) 
V4_s = scale(V4) 
V4_s2 = max(V4_s) - V4_s
V5_s = scale(V5)
data2 = data.frame(company,V1_s,V2_s,V3_s,V4_s2,V5_s)

#---2.PCA---#
cor(data[,-1]) # 이 값을 보면 v4_s2  v_3 이 큰 관련이 있어보인다.
data_pca <- prcomp(data[,c(2:6)])
summary(data_pca) # 주성분 3개까지만 써도, var 의 98% 를 차지한다.
print(data_pca) 
# 변환후의 계수를보면
# PC1 = V3,V4 와 큰 관련
# PC2 = V1,V2 와 큰 관련
# PC3 = V5 와 큰 관련

#---NOTE---#
# PCA 로 차원축소시 몇개의 PCA 를 선택할것인가?
# 1. 누적비율이 최소 0.8 이상
# 2. 평균분산보다 큰 PC만 선별할것. (standard deviation 부분)
# 3. scree plot 을 그렸을떄 꺾이는 부분(elbow) 이 잇다면 elbow 지점 앞의 PC 개수선택

#---3.요인 뽑아내기---#
plot(prcomp(data2[,c(2:6)]),type='l')

#Biplot
biplot(prcomp(data2[,c(2:6)]),cex=c(0.7,0.8))

#관측치변 주성분1/주성분2 점수계산
pc1 <- predict(data_pca)[,1]
pc2 <- predict(data_pca)[,2]

#관측치별 이름 맵핑
text(pc1,pc2,labels= data2$company,cex=0.7,pos=3,col='blue')


#--------------------FA-------------------#
#요인분석
data_fa <- factanal(data[,2:6],
                    factors=2, #요인의 갯수 지정
                    rotation = 'varimax', #회전방법 지정
                    scores = 'regression') # 요인점수 계산방법 지정
print(data_fa)

# factor 2 의 값이 비어있다. 이 때에는 cutoff 를 지정해주면 모두 볼 수 있다.
print(data_fa,cutoff=0)

# factor 1 은 v3_2,v4_s 를 같이 묶었으며 
# factro 2 는 v1_1,v2_s 를 같이 묶었다.
# v5_s가 두 요인중 어디에 속한다고 보기 애매하다. factor 1 과는 부호가 다르므로 2에 묶인다고 해 보자.
