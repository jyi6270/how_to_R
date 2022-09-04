

# 분석의 데이터는 행과 열로 이루어진 데이터의 구조를 말한다
# 행(관측치)
# 열(변수)



# 디버깅 print(), paste(), sprintf(), cat()

print("Hello world")

# %d: 인자를 정수, %f: 실수, %s: 문자열
sprintf("%d", 123)
sprintf("%.2f", 123.456)
sprintf("Number: %d, String: %s", 123, "jslim")

paste('a', 1, 2, 'b', 'c', sep="")


# 변수(데이터를 담는 그릇)
# 변수명은 알파벳, 숫자, _, . 으로 구성되면 첫 글자는 문자 또는 .

# 변수의 종류
# 단일형: 한 가지 데이터 형태로 구성된 데이터(벡터, 행렬, 배열)
# 다중형: 여러가지 형태로 구성된 데이터(리스트, 데이터프레임)

# 벡터: 데이터 구조의 기본(숫자, 정수, 문자, 논리)
# c()

digit_vec <- c(-1, 0, 1)
print(digit_vec)


x = c(0,1,4,9,16)
print(x)

# 평균
print(sum(x) / length(x))
print(mean(x))

?print

# 변수의 데이터형을 확인하려면 str(), typeof(), mode()

# 논리형 벡터 TRUE | FALSE
bool_vec <- c(TRUE, TRUE, FALSE)
print(bool_vec)
typeof(bool_vec)

#문자열 벡터
str_vec <- c('임정섭', '섭섭해', '임은결', '임재원')
print(str_vec)
typeof(str_vec)
mode(str_vec)
str(str_vec)

# NA: 데이터 값이 존재하지 않는다
ex_na <- NA
print(ex_na)
is.na(ex_na)

# NULL은 객체를 뜻함
ex_null <- NULL
print(ex_null)
is.null(ex_null)

over_vec = c(1,2,3,c(1,2,3))
print(over_vec)
typeof(over_vec)
mode(over_vec)
str(over_vec)

# 수치형 벡터 데이터를 만들 때 start:end
x <- 1:20
typeof(x)
mode(x)
str(x)

# 특정 값들이 반복된 벡터를 만들 때 rep()
rep(1:3, 5)
rep(1:3, each = 5)

# 색인(index): 1 ~ n
seq(1,10)
typeof(seq(1,10))
mode(seq(1,10))

seq(1, 10, 2)
[1, 3, 5, 7, 9]

seq(1, 10, length.out = 3)
seq(1, 10, length.out = 5)

a <- seq(1, 100, by = 3)
print(a)
length(a)

# 인덱싱 []
a[1]
a[5]
# 슬라이싱 [ : ]
a[1:5]

# 인덱스를 가지는 데이터는 인덱싱, 슬라이싱 가능
# 조건식 and(&), or(|)
ex_seq_vec <- seq(1, 100, by = 3)
ex_seq_vec[1:5]
ex_seq_vec[length(ex_seq_vec) - 4]
ex_seq_vec[ex_seq_vec >= 10 & ex_seq_vec <= 30]

# 문제) 인덱스가 홀수번째의 값만 추출
seq(1, length(ex_seq_vec), by=2)
result <- ex_seq_vec[seq(1, length(ex_seq_vec), by=2)]
result

# 벡터의 각 셀에 이름을 부여할 수 있다.
x <- c(1, 3, 5)
col <- c('kor', 'eng', 'math')
names(x) <- col
x

# 부여된 셀의 인덱싱이 가능하다
names(x)[3]
x[1]
x[c('kor')]
x[names(x)[1]]

x <- c(1, 3, 6, 8, 2)
x

#  위 x에서 마지막 요소 ~ 첫 번째 요소 값 출력
x[lengt(x) : 1]

# 특정 위치의 여러 값을 출력한다면?
x[c(1,4)]

# 음수 인덱스: 특정 요소를 제외
x[-1]

# 벡터의 길이
# length()
# nrow() 행렬의 행의 개수
# Nrow() 벡터를 행렬로 변환해서 행의  개수를 리턴

# 벡터연산자: %in%(어떤 값을 포함하는지 알려준다)
"a" %in% c("a", "b", "c")

# 합집합(union), 교집합(intersect), 차집합(setdiff)
union((c("a", "b", "c"), c("b", "c")))
intersect(c("a", "b", "c"), c("b", "c"))
setdiff(c("a", "b", "c"), c("b", "c"))

# 집합간 비교
setequal(c("a", "b", "c"), c("b", "c"))

# 요구사항
# 100에서 200으로 구성된 sampleVec 를 생성
# sample_vec = sampleVec
sampleVec <- 100:200
sampleVec <- c(100:200)
sampleVec <- seq(100,200)
sampleVec
?head
?tail

head(sampleVec, 10)

# 홀수만 출력
sampleVec <- seq(100, 200)
seq(2, length(sampleVec), by=2)
result <- sampleVec[seq(2, length(sampleVec), by=2)
]
result

sampleVec[sampleVec%%2 == 1]

# 3의 배수만 출력(%% 나머지연산자)
sampleVec
seq(3, length(sampleVec), by=3)
result <- sampleVec[seq(3, length(sampleVec), by=3)]
result

sampleVec[sampleVec%%3 == 0]

# 앞에서 20개의 값을 잘라내어 변수 d.20에 저장하고 출력 
d.20 <- head(sampleVec, 20)
d.20

# d.20의 5번째 값을 제외한 나머지 값들을 출력
d.20[-5]

# d.20의 5,7,9 번째 값을 제외한 나머지 값들을 출력
d.20[c(-5, -7, -9)]


# 요구사항 02.
# 월별 결석생 수 통계가 다음과 같을 때
# 이 자료를 absentVec 벡터에 저장하고 
# 결석생 수를 값으로 하고, 월 이름을 값의 이름으로 한다.

month. name

absentVec <- c(10, 8, 14, 15, 9, 10, 15, 12, 9, 7, 8, 7)
absentVec

names(absentVec) <- month.name
absentVec

# 5월의 결석생 수를 출력
absentVec["May"]

# 7월, 9월의 결석생 수를 출력
absentVec[c("July", "September")]

# 상반기 결석생 수의 합계 출력
sum(absentVec[c(1:6)])

# 하반기 결석생 수의 평균 출력
mean(absentVec[c(7:12)])


# 논리값을 요소로 하는 벡터(T, F, TRUE, FALSE)
# &, |, !
# xor() 같으면 FALSE 다르면 TRUE

c(TRUE, FALSE, FALSE) & c(TRUE, FALSE, FALSE)
c(TRUE, FALSE, FALSE) | c(TRUE, TRUE, FALSE)
!c(TRUE, FALSE, FALSE)
xor(c(TRUE, FALSE, FALSE), c(TRUE, TRUE, FALSE))

# 문자값을 요소로하는 벡터
str <- c('a', 'b', 'c', 'd', 'e')

paste('May I', "help you?")
month.abb           # abb 를 붙이면 약어

paste(month.abb, 1:12)

paste(month.abb, 1:12, c('st', 'nd', 'rd', rep('th', 9)))
paste('/user', 'local', 'bin', sep="/")  #sep 를 이용하면 공백을 채울 수 있음

# 정규표현식 함수
# grep()

# [정규표현식(regular expression)]

# *  0 or more.
# +  1 or more.
# ?  0 or 1.
# .  무엇이든 한 글자를 의미
# ^  시작 문자 지정 
# ex) ^[abc] abc중 한 단어 포함한 것으로 시작
# [^] 해당 문자를 제외한 모든 것 ex) [^abc] a,b,c 는 빼고
# $  끝 문자 지정
# [a-z] 알파벳 소문자 중 1개
# [A-Z] 알파벳 대문자 중 1개
# [0-9] 모든 숫자 중 1개
# [a-zA-Z] 모든 알파벳 중 1개
# [가-힣] 모든 한글 중 1개
# [^가-힣] 모든 한글을 제외한 모든 것
# [:punct:] 구두점 문자, ! " # $ % & ’ ( ) * + , - . / : ; < = > ? @ [ ] ^ _ ` { | } ~.
# [:alpha:] 알파벳 대소문자, 동등한 표현 [A-z]
# [:lower:] 영문 소문자, 동등한 표현 [a-z]
# [:upper:] 영문 대문자, 동등한 표현 [A-Z].
# [:digit:] 숫자, 0,1,2,3,4,5,6,7,8,9,
# [:xdigit:] 16진수  [0-9A-Fa-f]
# [:alnum:] 알파벳 숫자 문자, 동등한 표현[A-z0-9].
# [:cntrl:] \n, \r 같은 제어문자, 동등한 표현[\x00-\x1F\x7F].
# [:graph:] 그래픽 (사람이 읽을 수 있는) 문자, 동등한 표현
# [:print:] 출력가능한 문자, 동등한 표현
# [:space:] 공백 문자: 탭, 개행문자, 수직탭, 공백, 복귀문자, 서식이송
# [:blank:] 간격 문자, 즉 스페이스와 탭.

regVec = c("age", "gender", "exchange", "weight", "height")

# 'ex'로 시작하는 요소를 추출
regVec[grep('^ex' , regVec)]

grep('^ex', regVec, value= TRUE) #인덱스 말고 밸류값을 리턴
grep('^EX', regVec, value= TRUE) #오류) 대소문자 구분
grep('^EX', regVec, value= TRUE, ignore.case = TRUE) #대소문자 구분 무시

# ei 라는 문자열이 있는 요소를 추출
grep("ei", regVec, value= TRUE)
grep("+ei", regVec, value= TRUE)

txtVec <- c("BigData",
            "Bigdata",
            "bigdata",
            "Data",
            "dataMining",
            "class1",
            "class2")
txtVec

# 소문자 b로 시작하는 데이터 추출
grep('^b+', txtVec, value= TRUE)

# gsub(): 문자열을 찾아서 변경
txtVec

gsub("pattern", "변경데이터", "데이터")
gsub("big", "bigger", txtVec)
gsub("big", "bigger", txtVec, ignore.case = TRUE)

# 숫자를 제거하고 싶다면?
gsub("[0-9]", "", txtVec)
gsub("[[:digit:]]", "", txtVec)

# nchar(): character의 개수 반환
nchar(txtVec)

# strsplit(data, delimiter)
testTxt <- "Text data is very important"
testTxt
typeof(testTxt)




9/1
# package: 함수(function) + 데이터세트(dataset)
# install.packages('해당패키지')
# library('해당 패키지')

txtVec <- c("BigData",
            "Bigdata",
            "Data",
            "dataMining",
            "class1",
            "class2")

install.packages("stringr")
library(stringr)
str_length(txtVec)

nchar(txtVec)

str_extract()
str_extract("abc123def456", "[0-9]{3}")
lst <- str_extract_all("abc123def456", "[0-9]{3}")
typeof(lst)

str_extract("abc123def456", "[a-zA-Z]{3}")
str_extract_all("abc123def456", "[a-zA-Z]{3}")

strDummy <- "임정섭jslim50섭섭해seop34민채이김기쁨오한샘30"

# 영어단어만 추출
str_extract_all(strDummy, "[a-zA-Z]{3,5}")   -- 3자리에서 5자리

# 연속된 한글 3자 이상을 추출한다면?
str_extract_all(strDummy, "[가-힣]{3,}")
class(str_extract_all(strDummy, "[a-zA-Z]{3,}"))

# 나이 추출
str_extract_all(strDummy, "[0-9]{2,}")

# 숫자를 제외하고 추출
str_extract_all(strDummy, "[^0-9]+")
str_extract_all(strDummy, "[^0-9]{3,}")
gsub("[0-9]", "", strDummy)

# 영문자를 제외한 한글이름만 추출
str_extract_all(strDummy, "[^a-zA-z0-9]{3}")

# \\w 단어, \\d 숫자, \\s, \\특수문자, \n, \t
shopping_list <- c("apples x4", "bag of flour", "bag of sugar", "milk x2")
str_extract(shopping_list, "\\d")

ssn <- "730910-1234567"
str_extract_all(ssn, "[0-9]{6}-[1-4][0-9]{6}")
str_extract_all(ssn, "\\d{6}-[1-4]\\d{6}")

email <- "jslim9413@naver.com"
str_extract_all(email, "\\w{4,}@\\w{3,}.[a-z]{2,}")

strMsg <- "우리는 달려간다~이상한 나라로~섭섭이가 잡혀있는 마왕의 소굴로"
length(strMsg)
nchar(strMsg)
str_length(strMsg)

# 문자열의 위치
str_locate(strMsg, "섭섭이")
str_locate_all(strMsg, "섭섭이")

# 문자열의 치환
str_replace(strMsg, "섭섭", "섭순")

# 부분문자
str_sub(strMsg, start = 5 , end = 8)

# 특수문자($ , , )
num <- "$123,456"
gsub("[[:punct:]]" , "" , num)

digit <- str_replace_all(num, "\\$|\\,", "")
digit
class(digit)

# 형변환 as.
tmp <- as.numeric(digit)
class(tmp)
tmp+2

# 단일형 변수 타입인 행렬(matrix)
# 생성함수: matrix(), rbind(), cbind()
# 처리함수: apply()

x <- c(1,2,3,4,5,6,7,8,9)
x
matrix(x, nrow=3, ncol=3)
matrix(x, nrow=3)
matrix(x, ncol=3)
matrix(0, nrow=2, ncol=3)

# 정방행렬
diag(데이터값, 행과 열의 수)
diag(0,5)

# 전치행렬 t()
x <- matrix(1:6, 2, 3)
x
x.T = t(x)
x.T

# row(), col()
row(x.T) 각 열의 값이 행의 번호와 같게 만들어줌
col(x.T) 각 행의 값이 열의 번호와 같게 만들어줌
class(x.T)
typeof(x.T)
mode(x.T)

# 데이터 접근[행 인덱스, 열 인덱스]
x.T[2,2]

x <- matrix(1:9, 3, 3)
x
# 1, 2행의 2열의 요소만 출력
x[1:2,2]
x[c(1,2),2]

# 1행을 제외하고 1,3열의 정보만 출력
x[-c(1), c(1,3)]
x[-c(1), c(TRUE, FALSE, TRUE)]

# 행렬 합치기
x <- c(1,2,3)
y <- c(4,5,6)
z <- rbind(x, y)
z
z <- cbind(x, y, 7:9)

# dimnames 이용해서 행과 열에 이름을 부여할 수 있다.
x <- matrix(1:9,
            nrow = 3,
            dimnames = list(c("idx01", "idx02", "idx03"),
                            c("feature01", "feature02", "feature03")
                            )
            )
x
x["idx01", ]
x[ , "feature01"]

# 벡터 연산 가능
c(1:9) * 2

# 행렬 연산 가능
x * 2
x * x

# apply(data, 방향, 함수)
# 방향 행 -> 1, 열 -> 2  
# 함수 sum, mean

tmpMatrix <- matrix(1:9, nrow = 3)
tmpMatrix

apply(tmpMatrix, 1, sum)
apply(tmpMatrix, 2, sum)
apply(tmpMatrix, 1, min)
apply(tmpMatrix, 1, max)


# 내장 데이터 세트
iris
class(iris)

# 각 열(species 제외한)에 대한 합을 구하고 싶다면?
apply(iris[ , -5], 2, sum)
apply(iris[ , -5], 2, mean)
apply(iris[ , -5], 2, meidan)
apply(iris[ , -5], 2, min)
apply(iris[ , -5], 2, max)

# rowSums() , colSums(), rowMeans(), colMeans()
apply(iris[ , -5], 1, sum)
rowSums(iris[ , -5])

# runif(): random number generator
x <- matrix(runif(4), 2, 2)
x

# order(): 특정 행(열)에 대한 정렬
x[order(x[ , 2]), ]
x[ , order(x[1, ])]

# 1열을 기준으로 정렬
iris
order(iris[, 1]) -- 오름차순 
order(iris[, 1], decreasing = TRUE) -- 내림차순

# 행을 기준으로 오름차순 정렬
iris[order(iris[, 1], decreasing = TRUE) , ]


exDF <- data.frame(x = c(1,2,3,4,5),
                   y = c("a","b","c","d","e"))
exDF

# 데이터프레임의 컬럼에 대한 정보
exDF$x

exDF[c(T, F, T, F, T), ]

# 연산
# x값이 짝수인 행만 선택?
exDF[exDF$x%%2==0, ]
exDF[exDF[, "x"]%%2 == 0, ]
exDF[exDF[, 1]%%2 == 0, ]

# 배열
# 생성: array(), 벡터자료형을 생성 후 dim() 차원부여 가능
m <- matrix(1:12, ncol=4)
m
class(m)

ary <- array(1:12, dim=c(3,4))
ary
class(ary)
#-- 2차원까지는 array인지 matrix인지 구분할 수 없기 때문에 class 때리면 같이 나옴
ary <- array(1:12, dim=c(2,2,3))
ary
class(ary)
# -- dim으로 3차원을 부여해서 array로 나옴 matrix는 차원이 없음

# 배열은 dim() 함수를 이용하여 차원 확인
dim(ary)

ary <- array(1:8, dim=c(1,4,2))
ary

ary <- array(1:12, dim=c(2,2,3))
ary
apply(ary, 1, sum)

apply(ary, c(1,2), sum)

iris3
dim(iris3)
mode(iris3)
class(iris3)
iris3[,,1]

# list
# (key, value) 형태의 데이터를 담는 연관배열
# 생성함수: list()
# 처리함수: lapply(), sapply()
# lapply() : key=value 반환
# sapply() : value 반환

info <- list(name= "jslim", age=50)
info
info$name
info$age

info <- list(name= "jslim", age= 50, score= c(1,2,3))
info$score
class(info)

simple <- list(1:4)
simple <- list(1:4, rep(3:5), "cat")
simple
-- key 가 없으면 인덱스 [[1]]가 key를 대신함

# list str(): 리스트 구조 확인
str(simple)
lst <- list(a=list(c(1,2,3)), b=list(c(1,2,3,4)))
lst

member <- list(name = 'jslim',
               address = 'seoul',
               phone = '010-4603-2283',
               age = 30,
               marriage = TRUE)
# 리스트에서 요소의 값을 호출할 때 - key 활용, 인덱스
memeber$name
member[[1]]
# 첫 번째 서브리스트를 반환
member[1]

member <- list(name = c('홍길동', '유관순'),
               age = c(30, 35),
               marriage = c(TRUE,FALSE),
               gender = c("한양시", "천안시"))
member

# 데이터를 바로 수정할 수 있음
member$age[2] <- 28

# 데이터 추가
member$id <- c('hong', 'yoo')
member

# 데이터 제거
member$id <- NULL
member

# 서로 다른 자료구조를 조합할 수 있다.
lst <- list(one = c("1", "2", "3"),
            two = matrix(1:9, nrow=3),
            three = array(1:12, dim=c(2,3,2)))
lst

# 키가 생략된 구조
x <- list(1:5)
x[[1]][2]

# list -> vector
vec <- unlist(x)
vec

a <- list(1:5)
a

b <- list(6:10)
b

# X = 벡터 또는 리스트
lapply(X=c(a,b), FUN = max)
sapply(X=c(a,b), FUN = max)

# 벡터의 각 요소에 2배한 값을 구하고 싶다면?
c(1:3) *2

result <- lapply(X=c(1:3), function(X) {X*2})
result

class(result)
class(unlist(result))

# lapply, sapply 데이터 프레임 적용도 가능함
str(iris)

lapply(iris[, 1:4], mean)

# scalar
var.scalar <- 100
var.scalar

# vector
var.vector <- c(1,2,3)
var.vector

# matrix
var.matrix <- matrix(1:4, nrow =2)
var.matrix

# array
var.array <- array(1:8, dim=c(2,2,2))

# list
var.list <- list(name = '임정섭',
                 address = 'seoul',
                 gender = 'Male')
var.list

# $ 소유의 주체
var.list$name

# 형변환 as.XXXXX 하지만 list로 변환할 땐 unlist()






