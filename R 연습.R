
9/1

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


str_extract("abc123def456", "[0-9]{3}")
lst <- str_extract_all("abc123def456", "[0-9]{3}")
typeof(lst)

str_extract("abc123def456", "[a-zA-Z]{3}")
str_extract_all("abc123def456", "[a-zA-Z]{3}")

strDummy <- "임정섭jslim50섭섭해seop34민채이김기쁨오한샘30"

# 영어단어만 추출
str_extract_all(strDummy, "[a-zA-Z]{3,5}")   #3자리에서 5자리

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
member$name
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

# $ 소유의 주체
var.list$name

# 형변환 as.XXXXX 하지만 list로 변환할 땐 unlist()






