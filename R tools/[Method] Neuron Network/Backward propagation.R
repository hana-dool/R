##########################################
##### Backpropagation Implementation #####
##########################################

rm(list=ls())
numIter = 1000

### Initial settings 

# Initialize parameters
w1 = 0.15
w2 = 0.20
w3 = 0.25
w4 = 0.30
w5 = 0.40
w6 = 0.45
w7 = 0.50
w8 = 0.55
w = c(w1, w2, w3, w4, w5, w6, w7, w8)

b1 = 0.35
b2 = 0.60
b = c(b1, b2)

# input and target values
input1 = 0.05
input2 = 0.10 
input = c(input1, input2)

out1 = 0.01
out2 = 0.99
out = c(out1, out2)

# set learning rate
gamma = 0.5

### define functions
sigmoid = function(z){ 
  return( 1/(1+exp(-z)) )
}

forwardProp = function(input, w, b){
  # input to hidden layer
  neth1 = w[1]*input[1] + w[2]*input[2] + b[1]
  neth2 = w[3]*input[1] + w[4]*input[2] + b[1]
  outh1 = sigmoid(neth1)
  outh2 = sigmoid(neth2)
  
  # hidden layer to output layer
  neto1 = w[5]*outh1 + w[6]*outh2 + b[2]
  neto2 = w[7]*outh1 + w[8]*outh2 + b[2]
  outo1 = sigmoid(neto1)
  outo2 = sigmoid(neto2)
  
  res = c(outh1, outh2, outo1, outo2)
  return(res)
}

error = function(res, out){ 
  err = 0.5*(out[1] - res[3])^2 + 0.5*(out[2] - res[4])^2 
  return(err)
}



### Implement Forward-backward propagation
err = c()
for(i in 1:numIter){
  
  ### forward
  res = forwardProp(input, w, b)
  outh1 = res[1]; outh2 = res[2]; outo1 = res[3]; outo2 = res[4]
  
  ### compute error
  err[i] = error(res, out)
  
  ### backward propagation
  ## update w_5, w_6, w_7, w_8, b2 
  # compute dE_dw5
  dE_douto1 = -( out[1] - outo1 )
  douto1_dneto1 = outo1*(1-outo1)
  dneto1_dw5 = outh1
  dE_dw5 = dE_douto1*douto1_dneto1*dneto1_dw5
  
  # compute dE_dw6
  dneto1_dw6 = outh2
  dE_dw6 = dE_douto1*douto1_dneto1*dneto1_dw6
  
  # compute dE_dw7
  dE_douto2 = -( out[2] - outo2 )
  douto2_dneto2 = outo2*(1-outo2)
  dneto2_dw7 = outh1
  dE_dw7 = dE_douto2*douto2_dneto2*dneto2_dw7
  
  # compute dE_dw8
  dneto2_dw8 = outh2
  dE_dw8 = dE_douto2*douto2_dneto2*dneto2_dw8
  
  # compute dE_db2
  dE_db2 = dE_douto1*douto1_dneto1*1 + dE_douto2*douto2_dneto2*1
  
  ## update w_1, w_2, w_3, w_4, b1 
  # compute dE_douth1 first
  dneto1_douth1 = w5
  dneto2_douth1 = w7
  dE_douth1 = dE_douto1*douto1_dneto1*dneto1_douth1 + dE_douto2*douto2_dneto2*dneto2_douth1
  
  # compute dE_douth2 first
  dneto1_douth2 = w6
  dneto2_douth2 = w8
  dE_douth2 = dE_douto1*douto1_dneto1*dneto1_douth2 + dE_douto2*douto2_dneto2*dneto2_douth2 
  
  # compute dE_dw1    
  douth1_dneth1 = outh1*(1-outh1)
  dneth1_dw1 = input[1]
  dE_dw1 = dE_douth1*douth1_dneth1*dneth1_dw1
  
  # compute dE_dw2
  dneth1_dw2 = input[2]
  dE_dw2 = dE_douth1*douth1_dneth1*dneth1_dw2
  
  # compute dE_dw3
  douth2_dneth2 = outh2*(1-outh2)
  dneth2_dw3 = input[1] 
  dE_dw3 = dE_douth2*douth2_dneth2*dneth2_dw3
  
  # compute dE_dw4
  dneth2_dw4 = input[2]
  dE_dw4 = dE_douth2*douth2_dneth2*dneth2_dw4  
  
  # compute dE_db1
  dE_db1 = dE_douto1*douto1_dneto1*dneto1_douth1*douth1_dneth1*1 + dE_douto2*douto2_dneto2*dneto2_douth2*douth2_dneth2*1
  
  ### update all parameters via a gradient descent 
  w1 = w1 - gamma*dE_dw1
  w2 = w2 - gamma*dE_dw2
  w3 = w3 - gamma*dE_dw3
  w4 = w4 - gamma*dE_dw4
  w5 = w5 - gamma*dE_dw5
  w6 = w6 - gamma*dE_dw6
  w7 = w7 - gamma*dE_dw7
  w8 = w8 - gamma*dE_dw8
  b1 = b1 - gamma*dE_db1
  b2 = b2 - gamma*dE_db2    
  
  w = c(w1, w2, w3, w4, w5, w6, w7, w8)
  b = c(b1, b2)
  
  print(i)
  
}

ts.plot( err )
pred = forwardProp(input, w, b)
pred[3:4]
out



















