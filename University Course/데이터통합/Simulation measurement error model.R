### Setup
B=1000
n=200
rst1=matrix(NA,B,4) #without measurement error
rst2=matrix(NA,B,4) #with    measurement error

### MC Simulation
set.seed(1105)
for(i in 1:B){
  e=rnorm(n)
  u=rnorm(n)
  x=rgamma(n,1,1) # x 를 normal 로 하지 않아도 working 한다.  
  z=x+u
  y=1+0.5*x+e
  dat=data.frame(y,x,z)
  fit1=lm(y~x,data=dat) # no   measurement error 
  fit2=lm(y~z,data=dat) # with measurement error
  rst1[i,]=c(fit1$coeff, # fitting 한 결과에 따른 계수, intercept , slope 의 순서
             summary(fit1)$sigma^2, # fit 했을때 Residual standard error 즉 sigma_ee
             sqrt(mean((y-fit1$fitted)^2)) # RMSE
             )
  rst2[i,]=c(fit2$coeff,summary(fit2)$sigma^2,sqrt(mean((y-fit2$fitted)^2)))
  if(i%%100==0){ # 100번마다 결과를 report 하게 한다.
    cat("__________Iteration____","\n")
    print(i)
    cat("__________True Model____","\n")
    print(round(apply(rst1[1:i, ],2,mean),3))
    print(round(apply(rst1[1:i,],2,sd),3))
    cat("__________Measurement Error Model____","\n")
    print(round(apply(rst2[1:i, ],2,mean),3))
    print(round(apply(rst2[1:i,],2,sd),3))
  } ## print
} ## MC simulatoin

# 대충 어느정도 추측을 하고 돌리는것
# 지금 결과적으로 에러가 들어간 모델은 b1(기울기) 는 true 모델에 비해 반타작이 나 있다.
# 그리고 에러도 약간 더 높은것을 볼 수 있다.
