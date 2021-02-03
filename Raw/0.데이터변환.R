student_id <- c("s01", "s02", "s03", "s04", "s05", "s06", "s07", "s08", "s09", "s10")
stat_score <- c(56, 94, 82, 70, 64, 82, 78, 80, 76, 78)
mean(stat_score)
hist(stat_score)


#-------------연속형 -> 범주형--------------#
#ifelse 를 반복적으로 쓰게되면, 각 값마다 알맞게 범주형으로 고칠 수 있다.
score_d.f <- data.frame(student_id, stat_score)
score_d.f
#
attach(score_d.f)
score_d.f <- transform(score_d.f, 
                       stat_score_5 = ifelse(stat_score < 60, "가", 
                                             ifelse(stat_score >= 60 & stat_score < 70, "양", 
                                                    ifelse(stat_score >= 70 & stat_score < 80, "미", 
                                                           ifelse(stat_score >= 80 & stat_score < 90, "우", "수")))))
detach(score_d.f)
score_d.f

#-------------데이터 표준화 ---------------#
#평균0 분산1 의 데이터를 가지도록 정규화
scale_score1= scale(score_d.f$stat_score)
scale_score1
attributes(scale_score1)
# 어떻게 표준화 시켰는지 알려준다.
# 이 값을 통해 표준화  하기 전 값으로 돌려갈 수있다.

# [0-1] 의 값을 가지도록 정규화
k = score_d.f$stat_score 
scale_score2 = (k- min(k))/(max(k)-min(k))
scale_score2
#------------ 데이터 log/sqrt 변환----------#
sqrt(x) 
log(x)
#------------ 데이터 범주화 -------------#

#------------ 데이터 중복없이 unique 한 관측치만 선별하기 -------#
a1 <- rep(1:10, each=2)
a2 <- rep(c(1,3,5,7,9),each=4)
a3 <- c(1,1,1,1,3,3,3,3,5,5,6,6,7,7,8,8,9,10,11,12)
a1a2a3 <- data.frame(cbind(a1,a2,a3))

# a1,a2의 두개 변수를 기준으로 중복 체크 후 중복이있을때는 1개만선텍
unique(a1a2a3[,c('a1','a2')]) # a1a2a3[,c('a1','a2')] : 변수a1,a2만 선택
a1a2a3 [duplicated(a1a2a3[,c('a1','a2')]),]
