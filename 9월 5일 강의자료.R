9/5

height <- c(180, 172, 165, 181, 178, 163, 158, 175, 190)
gender <- c('m', 'm', 'f', 'm', 'm', 'f', 'f', 'm', 'm')

height.gender.frm <- data.frame(height, gender)
height.gender.frm
str(height.gender.frm)

# as.factor()
height.gender.frm$gender <- as.factor(height.gender.frm$gender)
str(height.gender.frm)
levels(height.gender.frm)

# 성별에 따른 키의 평균을 분석한다면
# tapply(데이터, 그룹조건, 함수)

tapply(height.gender.frm$height,
       gender,
       mean)

with(height.gender.frm,
     tapply(height, gender, mean))

# 그룹 집계를 위한 자주 사용되는 함수
# aggregate()

aggregate(height.gender.frm$height,
          list(height.gender.frm$gender),
          mean)
# 기준컬럼은 반드시 list여야 함
list(height.gender.frm$gender)

genderGrp <- aggregate(x = height.gender.frm$height,
                       by = list(height.gender.frm$gender),
                       FUN = mean)
genderGrp

# 내장 데이터 세트 로드
mtcars
str(mtcars)

# cyl 기준으로 중량의 총 합을 분석하고 싶다면?
aggregate( mtcars$wt,
           list(mtcars$cyl),
           sum)

# 기존 조건에 disp 값이 120 이상인 조건을 추가해서 중량의 평균을 분석한다면?
aggregate(x = mtcars$wt,
          by= list(cyl = mtcars$cyl,
                   disp = mtcars$disp >= 120),
          FUN = sum)

# cyl 기준으로 wt 평균을 분석한다면? (formula 방식)
aggregate(wt ~ cyl, data = mtcars, mean)
aggregate(wt ~ cyl + disp, data = mtcars, mean)

# gear 기준으로 disp, wt 평균을 분석한다면
aggregate(cbind(wt, disp) ~ gear, data = mtcars, mean)

# cyl 제외한 다른 모든 컬럼을 기준으로 cyl 평균을 분석
aggregate(cyl ~ . , data = mtcars, mean)

# disp 120 이상인 조건으로 subset
aggregate(x = mtcars$wt,
          by = list(mtcars$cyl),
          subset = mtcars$disp >= 120,
          FUN = sum)

with(mtcars, aggregate(x = wt,
                       by = list(cyl),
                       subset = disp >= 120,
                       FUN = sum))

#install.packages()
# library()
install.packages("MASS")
library(MASS)

cars.frm <- Cars93
cars.frm

# 타입별 고속도로 연비 평균을 분석
with(cars.frm, aggregate(MPG.highway,
                         list(Type),
                         mean))

aggregate(x = cars.frm$MPG.highway,
          by = list(cars.frm$Type),
          FUN = mean)

with(cars.frm, aggregate(MPG.highway ~ Type, cars.frm, mean))

with(cars.frm, tapply(MPG.highway, Type, mean))

# 시각화 패키지
install.packages("ggplot2")
library(ggplot2)

# 그래프를 그릴 때도 요인별로 구분해서 시각화
# 인사이트를 뽑아내는데 유용하게 사용할 수 있다.
qplot(MPG.highway,
      data = cars.frm,
      facets = Type ~ . ,
      bindwidth = 2)

# 자료구조 확인시 사용하는 함수
class

# 타입변환
# as.XXXXX()

as.data.frame( matrix(c(1,2,3,4), ncol = 2))
data.frame( matrix(c(1,2,3,4), ncol = 2))

# 제어구문, 연산자, 함수
# 산술연산자
num01 <- 100
num02 <- 200

result <- num01 + num02
result <- num01 - num02
result <- num01 * num02
result <- num01 / num02
result <- num01 %% num02
result <- num01**2
result <- num01^2

# 관계 연산자
# (1) 동등비교
boolean.val <- num01 == num02
boolean.val
# (2) 크기비교
boolean.val <- num01 >= num02

# 논리연산자(&(and), |(or))
#   A      B     and    or
# true   true   true   true
# true   false  false  true
# false  true   false  true
# false  false  false  true

logcal.var <- num01 > 50 & num02 <= 10
logcal.var

# if, for, while
if(조건) {
} else if(조건) {
} else if(조건) {
}


# scan()
score <- scan()
print(score)

# 키보드 점수 입력받고 점수에 따른 학점 등급을 출력
# 등급(grade): A(90>=0), B(80>=0), C(70>=0), D(60>=0), F학점
# 당신의 점수는: score이고, 당신의 학점은 grade
score <- scan()

grade <- ' '

if(score >= 90) {
  grade <- 'A'
} else if(score >= 80){
  grade <- 'B'
} else if(score >= 70){
  grade <- 'C'
} else if(score >= 60){
  grade <- 'D'
} else {
  grade <- 'F'
}
sprintf('당신의 점수는 : %d 이고, 당신의 학점은 %s', score, grade)

library(stringr)

# stringr::str_sub()
# 주민번호를 가지고 남자, 여자를 구분하고 싶다면?
user.ssn <- '730910-1xxxxxx'
gender <- str_sub(user.ssn, 8, 8)

if(gender == '1' | gender == '3'){
  print(' 성별은 남자입니다 ')
}else {
  print(' 성별은 여자입니다 ')
}

# ifelse(조건, 참, 거짓)
ifelse(gender == '1' | gender == '3', '남자', '여자')

scores <- c(96, 91, 100, 88, 80)
ifelse( scores >= 90, 'pass', 'fail')

# is.na()
na.vec <- c(96, 91, 100, 88, 90, NA, 95, 100, NA, NA)
na.vec

# 평균을 구한다면? ifelse()

ifelse( sum(is.na(na.vec))>=1 ,
        mean(na.vec, na.rm=TRUE),
        mean(na.vec))

# 홀, 짝을 판별하고 싶다?
tmp.vec <- c(1,2,3,4,5,6,7,8,9)
ifelse(tmp.vec %% 2 == 1, 'Odd', 'Even')

# 결측값을 평균대체
tmp.vec <- c(100, 89, NA, 68, 79, 50, 40, NA, 70, 69, 98, 83, NA)
tmp.vec

ifelse(is.na(tmp.vec), mean(tmp.vec, na.rm = TRUE), tmp.vec)


tmp.csv <- read.csv(file.choose())
tmp.csv

tmp.csv$q5

# q6 컬럼을 추가하는데 q5값을 가지고 3보다 크거나 같다면 'bigger', 그렇지 않으면 'smaller'

tmp.csv$q6 <- ifelse(tmp.csv$q5 >=3, 'bigger', 'smaller')
tmp.csv

# q6 타입을 factor로
tmp.csv$q6 <- as.factor(tmp.csv$q6)
str(tmp.csv)

# q6 를 그룹으로 q5에 대한 합계 분석한다면?
tapply(tmp.csv$q5, tmp.csv$q6, sum)
with(tmp.csv, aggregate(q5, list(category = q6), sum))
aggregate( x = tmp.csv$q5,
           by = list(tmp.csv$q6),
           FUN = sum)

table(tmp.csv$q6)

# 조건식이 많아질 경우 특정 case를 가지고 비교하는 구문
# switch
# switch(stirng, 값 = 구문, 값 = 구문, 값 = 구문, 값 = 구문)

x <- 'r'
switch(x,
       'r' = print('분석도구'),
       'python' = print('분석프로그램'))

# service_data_html_cont.csv
tmp.csv <- read.csv(file.choose())
str(tmp.csv)

# which() : 조건에 만족하는 index 반환
tmp.csv$State[13]
tmp.csv[13,]

which(tmp.csv$State == 'Hawaii')
tmp.csv[which(tmp.csv$State == 'Hawaii'),]
tmp.csv[which(c(TRUE, FALSE, TRUE)), ]

# 반복구문
# 1+2+3....+10

# for ~ in
# for(변수 in 시퀀스 값) {}

tmp.seq <- 2:8
tmp.seq
length(tmp.seq)

for(value in tmp.seq) {
  print(value)
}


for(value in tmp.seq) {
  cat(value, "/n")
}


for(value in 1:50) {
  if(value%%3 == 0) {
    cat(value, '\t')
  }
}

even <- 0
odd <- 0
for(value in 1:1000) {
  if(value %% 2 == 0) {
    even <- even + value
  } else {
    odd <- odd + value
  }
}

print(even)
print(odd)


stu.kor <- c(81, 95, 70, 69)
stu.eng <- c(75, 88, 78, 70)
stu.math <- c(78, 100, 100, 89)
stu.name <- c("조용일", "오한샘", "김가영", "김기쁨")

#1. 데이터 프레임을 생성하라
data.frame(c(stu.kor, stu.eng, stu.math), stu.name)

stu.frm <- data.frame(name = stu.name,
                      kor = stu.kor,
                      eng = stu.eng,
                      math = stu.math)
stu.frm

# 파생변수: 데이터프레임에 있는 열을 이용해서 새로운 열을 추가하는 것
# 총점(total), 평균(avg) 파생변수 추가

# apply()
# case01
stu.sum <- apply(stu.frm[2:4], 1, sum)

stu.avg <- apply(stu.frm[2:4], 1, mean)

stu.frm$total <- stu.sum
stu.frm$avg <- stu.avg

stu.frm

# case02
# cbind()

stu.frm.sum <- cbind(stu.frm, sum = apply(stu.frm[2:4], 1, sum))
stu.frm.sum

stu.frm.avg <- cbind(stu.frm, avg = apply(stu.frm[2:4], 1, mean))
stu.frm.avg

stu.frm

# for
# grade 파생변수 추가
# 등급(grade): A(90>= 0), B(80>=0), C(70>=0), D(60>=0), F학점

size <- nrow(stu.frm)
for(idx in 1:size) {
  #cat('idx = ', idx, '\n')
  #print(stu.frm$avg[idx])
  if(stu.frm$avg[idx] >= 90) {
    grade[idx] <- 'A'
  } else if(stu.frm$avg[idx] >= 80){
    grade[idx] <- 'B'
  } else if(stu.frm$avg[idx] >= 70){
    grade[idx] <- 'C'
  } else if(stu.frm$avg[idx] >= 60){
    grade[idx] <- 'D'
  } else {
    grade[idx] <- 'F'
  }
}
grade
stu.frm$grade <- grade
stu.frm




















