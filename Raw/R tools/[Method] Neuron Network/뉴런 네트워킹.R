#########################################################################
###Chapter 1 - Introduction to Neural Networks - using R ################
###Simple R program to build, train and test neural Networks#############
#########################################################################
#Choose the libraries to use
#install.packages("neuralnet")
library("neuralnet")
#Set working directory for the training data
setwd("C:/Users/Han/Desktop/R/R tools/R dataset")
getwd()
#Read the input file
mydata=read.csv('Squares.csv',sep=",",header=TRUE)
mydata
# 제곱 관계에 있음을 알 수 있다.
plot(mydata[,1],mydata[,2])
# 확인 가능.
attach(mydata)
names(mydata)

#Train the model based on output from input
model=neuralnet(formula = OUTPUT~INPUT,data = mydata, hidden=5, threshold=0.01 )
#regression 의 코드와 비슷하다. 
#model=neuralnet(formula = response~dependent,data = 쓸 데이터, hidden=hidden layer 갯수, threshold=0.01 )
#hidden =c(5,10) -> hidden1 = 5개, hidden2 = 10개
print(model)

#Lets plot and see the layers
plot(model)
#data points = 10개
#data dim = 1이다. y변수 한개와 x변수 하나가 연결되기 때문
#100*100 pixels 이라면 dim이 10000 일것이다.
#blue 는 bias part 이다.
#f(bias + weight*input)
#activate funciotn 을 아직 지정해주지 않았다. default 값으로 되었을 것. 확인하려면 ?neuralnet
#f(h1*25 + h2*24 + h3*27 + h4*-19 + h5*20 +18) => predicted output
#j(w) = (prediced output - output)^2

#w_1 = w_0 = gradient(J(W_0))*gamma
#repeat forwrad back propagation for n times
#w_0 -> w_1 -> ...... -> w_n (converge 될때까지)
#|w_n-w_n-1| < 0.01 이면 converge 된다고 생각한다. 
#threhold 가 작을수록 정확한 값을 얻을 수 있을것이다. 

#Check the data - actual and predicted
final_output=cbind (INPUT, OUTPUT, as.data.frame(model$net.result) )
colnames(final_output) = c("Input", "Expected Output", "Neural Net Output" )
print(final_output)
# 1,2 col 는 input/output value / 
# 3col output값(input을 이용한)  


########################################################################
##Chapter 1 - Introduction to Neural Networks - using R ################
###Simple R program to build, train and test neural networks ###########
### Classification based on 3 inputs and 1 categorical output ##########
########################################################################
###Choose the libraries to use
# NN 을 위해서 nnet 을 사용할수도 있고 위의 libarary 를 사용할 수도 있다. 선택사항.
rm(list=ls())
library(NeuralNetTools)
library(nnet)

###Set working directory for the training data
setwd("C:/Users/Han/Desktop/R/R tools/R dataset")
getwd()
# no cusomer tip 에서 1 이면 tip 을 낸것,0 이면 안낸것.
# logistic regression 이 가능. (y 변수가 binary)

###Read the input file
mydata=read.csv('RestaurantTips.csv',sep=",",header=TRUE)
mydata
attach(mydata)
names(mydata)

##Train the model based on output from input
model=nnet(CustomerWillTip~Service+Ambience+Food, data=mydata, size =5, rang=0.1, decay=5e-2, maxit=5000)
# model=nnet(independent~ depen+depen  , data=mydata, size =hidden layer size, rang=0.1, decay=5e-2, maxit=#of iteration 의 수)
# 3 dim 이라 input 에 3개의 동그라미가 있다.

print(model)
plotnet(model)
garson(model)
# importance plot 을 통해서 어느게 좋은지 알 수 있다.
# 물론 positive 인지 negative 인지는 알 수 없다. 
# if fitting image recognition 일 경우는 10000nodes 이다. 이경우는 individual importane 가 크게 도움이 되지 않는다.
# relative importancce of each variable
# service 가 제일 중요해보인다.
# calcuated by service 를 제거해본다. 나머지 2개로 해보고 prediction 이 좋은지 해봄. 그런식으로 체크.
########################################################################
