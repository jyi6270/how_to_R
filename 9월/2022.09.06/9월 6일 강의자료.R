9/6

# 제어구문, 반복구문, 함수

# nrow(), NROW()
# read.csv(file.choose())

tmp.csv <- read.csv(file.choose())
str(tmp.csv)

# 파생변수
tmp.csv$Diff <- tmp.csv$High - tmp.csv$Low
tmp.csv

tmp <- c(1,2,3,4,5,6)
sum(tmp)

# for(변수 in 순차형값) {}
size <- length(tmp)
for(idx in 1:size) {
  print(idx)
}

sum(tmp)를 반복문으로 구하기
size <- length(tmp)
user.sum <- 0

for(idx in  1:size) {
  user.sum <- tmp[idx] + user.sum
}
print(user.sum)

# for(변수 in 순차형값) {}
# Diff 변수를 이용해서 Result 파생변수 생성
# 조건) Diff의 평균보다 크면 'mean over' 작으면 'mean under'
mean(tmp.csv$Diff)
row <- nrow(tmp.csv)
diff_result = ''
for(idx in 1:row){
  if (tmp.csv$Diff[idx] > mean(tmp.csv$Diff) ) {
    diff_result[idx] <- 'mean over'
  } else{
    diff_result[idx] <- 'mean under' 
  }
}

tmp.csv$Result <- diff_result
tmp.csv


# 이중 루프 구문 for() { for() {}}
for(i in 2:9) {
  cat(i, "단>>>", "\n")
  for(j in 1:9) {
    cat(i, '*', j, '=', (i*j), '\t')
  }
  cat('\n')
}

# tmp.csv(for(for()))
row <- nrow(tmp.csv)
col <- length(tmp.csv)

for(i in 1:row) {
  for(j in 1:col) {
    cat(tmp.csv[i, j], '\t')
  }
  cat('\n')
}

# while()
i <- 1
while( i <= 10 ) {
  print(i)
  i <- i +1
}

i <- 1
while( i <= 100 ) {
  if(i %% 5 == 0){
    cat(i, '\t')
  }
  i <- i+1
}

# break, next, repeat
idx <- 1
while(idx <= 10) {
  if(idx %% 2 ==0 ) {
    cat(idx, '\t')
  }
  idx <- idx + 1
}

# next는 특정 조건일 때 스킵
idx <- 1
while(idx <= 10) {
  idx <- idx + 1
  if(idx %% 2 != 0 ) {
    next
  }
  print(idx)
}

# repeat, break
idx <- 1
repeat{
  print(idx)
  if(idx >= 10) {
    break
  }
  idx <- idx +1
}

# 결측값 확인
# is.na()

is.na(c(1,2,3,4,5,NA))

tmp.frm <- data.frame(
  a = c(1,2,3),
  b = c("a", NA, "c"),
  c = c("a", "b", NA)
)
tmp.frm

is.na(tmp.frm)

# 결측값의 문제점을 해결하기 위해서 연산에서 결측값을 제거
# na.rm = TRUE

# 결측치 대체법(Imputation)
# 평균값, 중앙값, 최소값, 최대값, 전후값, 평균
tmp.vec <- c(2,3,NA,5,NA,7)
tmp.vec[is.na(tmp.vec)] <- median(tmp.vec, na.rm=TRUE)
tmp.vec

# 결측치 시각화(히트맵)

# 임의적으로 결측값 할당
iris.frm <- iris
iris.frm
iris.frm[4:10, 3] <- NA
iris.frm[1:5, 4] <- NA
iris.frm[60:70, 5] <- NA
iris.frm[97:103, 5] <- NA
iris.frm[133:138, 5] <- NA
iris.frm[140, 5] <- NA

heatmap(1 * is.na(iris.frm))

heatmap(1 * is.na(iris.frm),
        Rowv = NA,
        Colv = NA,
        scale = 'none',
        cexCol = .8)

# 함수 정의

user.func <- function(){
  print('인자가 없고 리턴도 없는 함수')
}

class(user.func)
user.func()


user.func <- function(x, y) {
  result <- x + y
  return (result)             #-- return시키는 값은 괄호로
}

user.result <- user.func(10,20)

# x=10, y=20
user.result <- user.func(y=10, x=20)
user.result

user.func <- function(x,y) {
  cat("x = ", x, '\n')
  cat("y = ", y, '\n')
  result <- x + y
  return (result)         #-- R은 마지막에 리턴이 없으면 마지막 문장이 리턴됨
}

user.func <- function(...) {
  args <- list(...)
  for(value in args) {
    cat(value, '\t')
  }
}
user.func()

# 결측치 비율을 계산하는 함수를 정의
# 행 및 열 별로 비율을 계산
sum(is.na(iris.frm)) / length(iris.frm) * 100

user.naMissFunc <- function(frm) {
  sum(is.na(frm)) / length(frm)
}

user.naMissFunc(iris.frm)

apply(iris.frm, 1, user.naMissFunc)
apply(iris.frm, 2, user.naMissFunc)

col_missing_per <- apply(iris.frm, 2, user.naMissFunc)
barplot(col_missing_per)

# 데이터셋 정보 확인하기
library(help=datasets)

# 데이터조작
# cbind(), rbind()
# merge(): SQL - join (동일 열의 이름으로 공통된 값을 기준으로 병합)

x.frm <- data.frame(name = c('a', 'b', 'c'),
                    math = c(1,2,3))
x.frm
y.frm <- data.frame(name = c('c','b','a'),
                    eng = c(4,5,6))
y.frm

merge(x.frm, y.frm)

cbind(x.frm, y.frm)      -- 단순히 열 합치기

# mapply(FUN, 인자)
# sapply()와 유사하지만 다수의 인자를 함수에 넘길 수 있다.

# iris 각 컬럼의 평균을 분석하고 싶다면?
iris[1:4]
mapply(mean, iris[1:4])

mapply(function(i, s) {
        sprintf('%d%s', i, s)
      },
      1:3,
      c('a','b','c')
      )

# doBy package
# summaryBy(), orderBy(), splitBy(), sampleBy()
# package::함수이름
# doBy::summaryBy()
# base::summaryBy()

install.packages("doBy")
library(doBy)

?summaryBy
?summary

base::summary(iris)
doBy::summerBy(. ~ Species, iris)

# 수치형 자료의 분포를 확인하는 함수(quantile())
quantile(iris$Sepal.Length)

doBy::summaryBy(Sepal.Width + Sepal.Length ~ Species, iris)

# orderBy ; 정렬
doBY::orderBy( ~ Species + Sepal.Width, iris)
base::ordr(iris$Sepal.Length)

iris[order(iris$Sepal.Length)]

# sampleBy()
# sample(): 임의로 샘플을 추출하는 목적으로 사용
base::sample(1:10, 5)
base::sample(1:10, 5, replace = TRUE)

base::sample(1:10, 10)

# iris 데이터 역시 무작위로 섞을 수 있을까?
nrow(iris)
NROW(iris)
iris[sample(nrow(iris), nrow(iris)), ]

# Species 기준으로 각 종별 10%씩 추출하고 싶다면?
sampleBy(~ Species, frac = 0.1, data = iris)

# split(데이터, 분리조건)
iris.lst <- split(iris, iris$Species)
class(iris.lst)
iris.lst

iris.lst <- split(iris$Sepal.Length, iris$Species)
iris.lst

lapply(iris.lst, mean)

# list -> vector -> matrix -> data.frame
iris.vec <- unlist(iris.lst)
iris.vec

iris.matrix <- matrix(iris.vec, ncol =3 )
iris.matrix

iris.frm <- data.frame(iris.matrix)
iris.frm

# subset(): 특정 부분만 취하는 용도
# setosa 추출하고 싶다면?
subset(iris, iris$Species == 'setosa')
subset(iris,
       iris$Species == 'setosa' &
       iris$Sepal.Length > 5.0 )

subset(iris,
       iris$Species == 'setosa' &
       iris$Sepal.Length > 5.0,
       select = c(Sepal.Length, Species))






install.packages("https://cran.r-project.org/src/contrib/Archive/DMwR/DMwR_0.4.1.tar.gz", 
                 repos = NULL, 
                 type="source")
install.packages("DMwR2")
library(DMwR2)


