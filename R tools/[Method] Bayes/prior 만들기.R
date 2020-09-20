# 복잡한 pdf 의식 답 구하기
f = function(b){
  answer = pbeta(0.8,((19*b)-18),b)-0.0001
  return(answer)
}

# uniroot() 함수는 대략적인 근의 위치, 그 지점의 함수 값, 소요되는 반복 횟수 및 추정된 근의 정확도를 포함하는 리스트를 반환한다.
uniroot(f,lower=1,upper=100)
