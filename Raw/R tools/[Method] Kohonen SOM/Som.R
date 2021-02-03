#####################################################################
###Chapter 2 - Introduction to Neural Networks - using R ############
###Simple R program to build, train, test regression neural networks#
#########################flename: Boston.r###########################
#####################################################################
library("neuralnet")
library(MASS)
set.seed(1)
data = Boston

head(Boston) # medv 를 다른 independent variables 들로 설명하고싶다.

#dataset scaling 하기.
max_data <- apply(data, 2, max)
min_data <- apply(data, 2, min)
data_scaled <- scale(data,center = min_data, scale = max_data - min_data)
#center = 모든 값에서 그 값을 빼준다(평균 역할) #true 면 전체데이터의 평균을 뺀다.
#scale = 이 값을 나눠준다. (표준편차 역할) # true 면 전체데이터의 표준편차로 나눈다.
#scaling 하는것을 추천한다. 왜냐하면 이 데이터에서
#crim 은 매우 작고, black 은 매우 크다. 이것은 black 이 더 중요하다는것을 의미하는것이 아니기 때문
#z-normalization, min-max scale, etc 등의 scaling 가능 여기서는 min max 를 쓰자.


#training set 과 test set 으로 나누기.
index = sample(1:nrow(data),round(0.70*nrow(data)))
#nrow = row 의 수
#round = 반올림 함수.
#sample(c(....),n) -> ... 에서 n 개를 뽑겟다는 뜻. replace = false 가 default.
train_data <- as.data.frame(data_scaled[index,])
test_data <- as.data.frame(data_scaled[-index,])

dim(train_data)
# 354

n = colnames(data)
n[!n %in% "medv"]
#벡터 내 특정 값 포함 여부 확인 연산자 %in% 즉 n 안에 medv 가 있는지 false,true 로 알려준다. 
f = as.formula(paste("medv ~", paste(n[!n %in% "medv"], collapse = " + ")))
#벡터에서 paste(n[!n %in% "medv"], collapse = " + ") collapse 는,벡터 사이의 구분자이다.
#neuralnet() 에서는 formula 로 안하고 그냥 넣으면 안나오기때문에 위처럼 fomular 로 만들어주어야한다.
f
#medv = response / others = independent
net_data = neuralnet(f,data=train_data,hidden=10,linear.output=T)
#linear.output is used to specify whether we want to do regression linear.output=TRUE or classification linear.output=FALSE
plot(net_data)

predict_net_test <- compute(net_data,test_data[,1:13])
#compute 는 모델을 평가할 때 쓰는 함수
#compute( 평가에 사용되는 모델, 이 모델을 활용해 분석할 변수들)
#이 때에 변수들은 x값인 13개의 변수 사용.
predict_net_test_start <- predict_net_test$net.result*(max(data$medv)-min(data$medv))+min(data$medv)
#처음에 정규화를 하고 시작했기 떄문에 여기서는 그 정규화를 역으로 하고있다.
test_start <- as.data.frame((test_data$medv)*(max(data$medv)-min(data$medv))+min(data$medv))
#test_data 도 scaled 된 값이기 때문에, 역으로 풀면 된다.


MSE.net_data <- sum((test_start - predict_net_test_start)^2)/nrow(test_start)
#MSE fro neuron network

Regression_Model <- lm(medv~., data=data)
summary(Regression_Model)

test <- data[-index,]
predict_lm <- predict(Regression_Model,test)
MSE.lm <- sum((predict_lm - test$medv)^2)/nrow(test)

MSE.net_data
MSE.lm
# 이경우 linear model 이 더 mse 가 낮다. 
# linear model 은 각 변수에 대한 해석까지 가능하다. 
# neuron network는 그러한 해석이 불가능하다. (crim 이 어떻게 영향을 끼치는지 모름)
# NN 은 항상 좋은건 아니다.

###########################################################################
######################################################################
###Chapter 2 - Introduction to Neural Networks - using R ##########
###Usuervised ML technique using Kohonen package ####################
######################filename: kohonen.r#############################
######################################################################
library("kohonen")
data("wines")
str(wines)
head(wines)
View (wines) 

set.seed(1)
som.wines = som(scale(wines), grid = somgrid(5, 5, "hexagonal"))
# scale 된 값을 사용한다. 모두 default 이므로 평균은 0 이됨.
# 위에서 scale 은 다르게 했다. scale 의 방법은 자유
som.wines
dim(getCodes(som.wines))
# 25 = somgrid 의 수
# 13 = dim of independent variable. 즉 codebook
plot(som.wines, main = "Wine data Kohonen SOM")
# som 은 어느것끼리 similar 한지의 정보까지 말해준다. 
# cluster 가 너무 많거나 적으면 의미가 없어진다.



par(mfrow = c(1, 1))
plot(som.wines, type = "changes", main = "Wine data: SOM")


# supervised learning

training = sample(nrow(wines), 150)
Xtraining = scale(wines[training, ])
Xtest = scale(wines[-training, ],
              center = attr(Xtraining, "scaled:center"),
              scale = attr(Xtraining, "scaled:scale"))
# attr(x,"설명") 이렇게 하면 객체의 설명을 도와준다. 

trainingdata = list(measurements = Xtraining, vintages = vintages[training])
testdata = list(measurements = Xtest, vintages = vintages[-training])
# list 의 처음부분은 scale 된 값들을 나타내고, 뒤부분은 그에 y variable 을 나타낸다.
trainingdata

mygrid = somgrid(5, 5, "hexagonal")
som.wines = supersom(trainingdata, grid = mygrid)
#supersom = expanion of som function.
ls(trainingdata)
#supersom function 을 쓰려면 multiple label 이 되어있어야 한다.
#measurement 가 x variable(input)/ vintage(output) 가 y variable
#som 은 1 label 밖에 없으므로 unsupervised learning 을 한다.
#supersom 은 supervised learning 을 한다. x,y 를 가지기 때문.
som.prediction = predict(som.wines, newdata = testdata)
ls(testdata)
#2개의 dim 을 가짐을 명심하자.

vintages[-training] # 실제 y 값(test)
som.prediction$predictions[["vintages"]] # 예측값
table(vintages[-training], som.prediction$predictions[["vintages"]])
#confusion matrix 
# 세로축이 실제 y 값, 가로축이 예측값을 나타낸다. 이 때에는 모두 잘 예측했음을 알 수 있다.
######################################################################










