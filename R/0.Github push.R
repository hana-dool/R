# jekyll 블로그 디렉토리 설정
base <- "C:/Users/goran/Desktop/Git_Hub/Blog_Git/hana-dool.github.io"

# Rmd 파일이 저장된 디렉토리 지정
rmds <- "C:/Users/goran/Desktop/Git_Hub/R/R"
setwd(base)

# 파일 이름 지정
filename <- "Anal_Logistic-regression.Rmd"

# 폴더 경로들 지정 
figs.path <- "assets/images/" # 이미지가 들갈 폴더을 지정
posts.path <- "_posts/R/" # 포스트가 들어갈 폴더 지정

# Rmd -> md 변환
require(knitr)
render_jekyll(highlight = "pygments")
opts_knit$set(base.url="/")
file <- paste0(rmds, "/", filename)

### 파일 경로 설정
fig.path <- paste0(figs.path, sub(".Rmd$", "", basename(file)), "/")
opts_chunk$set(fig.path = fig.path)

### suppress messages
opts_chunk$set(cache = F, warning = F, message = F, cache.path = "_cache/", tidy = F)

### 파일 변환 및 경로 지정
out.file <- basename(knit(file))
file.rename(out.file, paste0(posts.path, out.file))

