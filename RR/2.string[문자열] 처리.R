# paste 
# 입력받은 문자열을 하나로 붙여준다. 
num = 1:10
alphabet = c('a','b','c')
paste(num,alphabet) # paste 를 통해서 두 문자열을 하나로 붙여 주었다. 
paste(num,alphabet, sep='과') # 두 vector 사이에 구분자를 '과' 로 설정하였다.

# substr
# 주어진 문자열에서 특정 문자열을 추출한다.
substr('starcraft',1,4) # 1~4 번째의 문자열을 출력한다.
country = c('korea','japan','china')
substr(country,1,3)


