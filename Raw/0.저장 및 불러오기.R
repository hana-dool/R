# 현재 위치를, 기본 directory 로 지정
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# txt 파일 불러오기[read.table]
txt= read.table('./dataset_1.txt',
                 header = T, # 첫줄에 col 의 이름이 적혀있는 경우가 많다.
                 sep=',' # 기본적으로 txt 파일은 띄어쓰기가 구분자이나 이 예시처럼 , 일수도 있음
                )

# csv 파일 불러오기[read.csv]
txt = read.csv('./example.csv')
txt

# 데이터 파일 저장하기
write.csv(txt,
          file = './example.csv',
          row.names = FALSE # default 로 첫 col 에 row 의 index 가 추가로 들어간다. 이를 방지
          )
write.table(txt,
            file= './example.txt') # 다행히 txt 에는 그런거 없다.


# 분석결과 저장하기 (cat 활용)
x <- c(1:20)
cat('mean :' , mean(x),'\n',
    'var :' , var(x),
    file = './analysis.txt')

# 분석결과 저장하기 (capture.output 활용)
# cat 의 경우는 사실 list 의 형태로 나타나는 분석결과를 나타낼 수 없다.
# 그래서 아래와 같이 capture.output 을 활용하면 나타낼 수 있다.
data(trees)
lm <- lm(Volume~Height,data=trees)
capture.output(summary(lm),
               file = './analysis2.txt')
