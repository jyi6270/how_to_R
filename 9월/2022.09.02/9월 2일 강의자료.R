9/2

# data.frame
# 생성: data.frame()
# $: 각 열에 대한 접근 가능
# 1.vector

id <- c(100, 200, 300)
name <- c("섭섭해", "임섭순", "홍길동")
salary <- c(1000000, 2000000, 3000000)

var.frame <- data.frame(ID = id, name, salary)
var.frame

var.frame$ID
var.frame[1, ]
var.frame[, 1]

# 2. matrix
var.matrix <- matrix(data = c(1, 'jslim', 150,
                              2, 'jslim', 150,
                              3, 'jslim', 150),
                     nrow = 3,
                     byrow = T )
var.matrix

var.frame <- data.frame(Var.matrix)
var.frame

var.frame$X1

sample.frame <- data.frame(col01 = c(1,2,3,4,5),
                           col02 = c(2,4,6,8,10),
                           col03 = c(1,3,5,7,9))
sample.frame

# sample.frame[행 인덱스, 열 인덱스]
sample.frame[ , c("col01", "col03")]
sample.frame[ , "col01"]
sample.frame[ , "col01"][1]
sample.frame[ , "col01"][1:3]

# 결과를 벡터가 아닌 데이터프레임 형태로 추출
sample.frame[ , "col01", drop = FALSE]

# str(), head(), tail()

# 행 이름(rownames()), 열 이름(colnames())
tmp.frame <- data.frame(1:3)
tmp.frame

colnames(tmp.frame) <- c('col01')
rownames(tmp.frame) <- c('row01', 'row02', 'row03')

# 컬럼의 이름을 리스트로 반환
names(tmp.frame)

# 문자열벡터, 숫자벡터, 문자열벡터
name.vector <- c("임정섭", "문승환", "최진형", "오한샘")
score.vector <- c(100, 90, 80, 70)
grade.vector <- c('A', 'B', 'C', 'D')

class.frame <- data.frame(name.vector,
                          score.vector,
                          grade.vector)
class.frame
str(class.frame)
names(class.frame)
colnames(class.frame) <- c('name', 'score', 'grade')
class.frame

# 행 개수 및 열 개수 구하기
ncol(class.frame)
nrow(class.frame)

# 프레임의 변형으로 열 추가 cbind()
student.id <- c('s001', 's002', 's003', 's004')
class.frame <- cbind(class.frame, student.id)
colnames(class.frame) <- c('name', 'score', 'grade', 'id')

# 프레임의 변형으로 행 추가 rbind()
row.insert <- c('민채이', 100, 'A', 's005')
class.frame <- rbind(class.frame, row.insert)

# 인덱싱
class.frame$name
class.frame[2, 3]
class.frame[2, ]
str(class.frame)

# 주어진 값이 벡터에 존재하는지를 판별하는 연산자
# %in%

test.frame <- data.frame(a = 1:3,
                         b = 4:6,
                         c = 7:9)
test.frame
test.frame[ , names(test.frame) %in% c('b','c')]


# ID, GENDER, AGE, AREA 변수를 포함하는
# 데이터 프레임을 만들어 info.frame 변수에 저장

ID <- c(1,2,3,4,5,6,7,8,9,10)
GENDER <- c("F","F","M","M","M","F","M","F","M","F")
AGE <- c(19,22,31,42,52,63,37,28,19,50)
AREA <- c("서울", "경기","경기","제주","제주","서울","서울","광주", "경기", "서울")
info.frame <- data.frame(ID, GENDER, AGE, AREA)
str(info.frame)

# 범주형 타입으로 변경 as.factor()
info.frame$AREA <- as.factor(info.frame$AREA)
str(info.frame)
levels(info.frame$AREA)
levels(info.frame$AREA)[1]
levels(info.frame$AREA)[2]

# factor 요인
tmp.factor <- c('A', 'O', 'AB', 'B', 'A', 'O', 'A')
tmp.factor

blood.factor <- as.factor(tmp.factor)
str(blood.factor)
table(blood.factor)
plot(blood.factor)

levels(blood.factor)
is.factor(blood.factor)
ordered(blood.factor)
nlevels(blood.factor)

# %in%
info.frame[ , names(info.frame) %in% c('GENDER', 'AGE')]

# GENDER, FACTOR로 변경
str(info.frame)
info.frame$GENDER <- as.factor(info.frame$GENDER)

# 프레임을 쉽게 접근하기 위해서 제공되는 함수
# with(data, tapply(numeric vector, factor, function))
# within(): 데이터를 수정할 때 사용


# 예를 들어 iris의 Sepal.Length, Sepal.width의 평균을 같이 구한다면
# mean()
# tapply()
# sapply(), lapply()
mean(iris$Sepal.Length)
mean(iris$Sepal.Width)

with(iris, {
  print(mean(Sepal.Length))
  print(mean(Sepal.Width))
})

# 결측값을 평균으로 대체
dummy.frame <- data.frame(val=c(1,2,3,4,NA,5,NA))
dummy.frame
mean(dummy.frame$val, na.rm = TRUE)  <- 결측값제거


dummy.frame <- within(dummy.frame, {
  val <- ifelse(is.na(val), mean(val, na.rm = TRUE), val)
})

# case other
dummy.frame$val[ is.na(dummy.frame$val)] <-
  median(dummy.frame$val, na.rm=TRUE)

# iris 컬럼별 평균을 구하는 경우를 살펴보자
mean(iris$Sepal.Length)
mean(iris$SEpal.Width)
mean(iris$Petal.Length)
mean(iris$Petal.Width)

lapply(iris[ , -5], mean)
irisMean <- lapply(iris[ , -5], mean)
class(irisMean)
irisMean

irisMean <- sapply(iris[ , -5], mean)
class(irisMean)
irisMean[1]

as.data.frame(irisMean)

# iris 일부 데이터가 결측치인 경우?
iris
str(iris)

data(iris)
tmp.frame <- iris
tmp.frame[1, 1] <- NA
tmp.frame[1, ]

idx <- tmp.frame$Species =='setosa'
idx

mean(tmp.frame$Sepal.Length[idx], na.rm = TRUE)

# 결측값 평균으로 대체 is.na()
is.na(tmp.frame$Sepal.Length)
tmp.frame$Sepal.Length[is.na(tmp.frame$Sepal.Length)] <-
  mean(tmp.frame$Sepal.Length[idx], na.rm =TRUE)

#split(데이터프레임, 분리할 기준(팩터))
split(tmp.frame, tmp.frame$Species)

# 종별 Sepal.Length 평균을 구한다면
lst <- split(tmp.frame$Sepal.Length, tmp.frame$Species)
lapply(lst, mean)

# 중위수(median)
median_per_species <- sapply(split(tmp.frame$Sepal.Length, tmp.frame$Species),
                             median,
                             na.rm = TRUE)

median_per_species['setosa']

tmp.frame <- within(tmp.frame, {
         Sepal.Length <- ifelse(is.na(Sepal.Length),
                         median_per_species[Species],
                         Sepal.Length)
})

head(tmp.frame)
tail(tmp.frame)

# subset(frm, 조건식, 컬럼선택) 
# frame으로부터 조건에 만족하는 행을 추출하여 새로운 프레임 반환

x <- letters[1:5]
y <- 1:5
z <- 6:10
tmp.frm <- data.frame(x,y,z)
tmp.frm

sub.frm01 <- subset(tmp.frm, y>3)
sub.frm01

sub.frm01 <- subset(tmp.frm, z <= 8)
sub.frm01

# & , |
sub.frm01 <- subset(tmp.frm, y >=2 & z <= 8)

# 컬럼선택
sub.frm01 <- subset(tmp.frm, z>= 8, select = c(x,y))

# 요구사항 subset 생성
# 조건 Petal.Length의 평균보다 크거나 같은 
# 조회컬럼은 Sepal.Length, Petal.Length, Species

tmp.frame <- iris
tmp.frame


tmp.iris.subset <- subset(tmp.frame, 
                          Petal.Length >= mean(Petal.Length),
                          select = c(1,3,5))
tmp.iris.subset

subset(tmp.frame, 
       Species == 'setosa' & Sepal.Length > 5.0,
       select = c(1,5))

# tapply()
# 그룹별 처리를 위한 함수
1:10
rep(1, 10)

tapply(1:10, rep(1,10), sum)

# 1~10 숫자를 홀수별, 짝수별로 묶어서 합
tapply(1:10, rep(1:2, 5), sum)
tapply(1:10, 1:10 %% 2 == 0, sum)
tapply(1:10, rep(c('odd', 'even'), 5), sum)
tapply(1:10, ifelse(1:10%%2 ==1, 'odd', 'even'), sum)

# iris 종별 Sepal.Length 평균을 구해보자
# tapply()
tmp.frame
tapply(tmp.frame$Sepal.Length, tmp.frame$Species, mean)

tmp.matrix <- matrix(1:8, 
                     ncol=2, 
                     dimnames= list(c('spring', 'summer', 'fall', 'winter'),
                                    c('male', 'female')))
tmp.matrix

# 반기별 남성 셀의 값의 합과 여성셀의 합을 구한다면?
tapply(tmp.matrix,
       list(c(1,1,2,2,1,1,2,2),
            c(1,1,1,1,2,2,2,2)),
       sum)


연습문제)
1.
x <- c(4, 6, 5, 7, 10, 9, 4, 15)
x
str(x)

2.
x1 = c(3,5,6,8)
x2 = c(3,3,3)
x1
x2

3.
Age <- c(22,25,18,20)
Name <- c("James", "Mathew", "Olivia", "Stella")
Gender <- c("M", "M", "F", "F")

a <- data.frame(Age, Name, Gender)
a
subset(a[1:2,])

4.
x <- c(2,4,6,8)
y <- c(TRUE, TRUE, FALSE, TRUE)
sum(x[y])

5. ??
x <- c(34, 56, 55, 87, NA, 4, 77, NA, 21, NA, 39)
naVec <- is.na(x)
isnaVec <- data.frame(naVec)
nasubset <- subset(isnaVec, naVec == 'TRUE')
nrow(nasubset)


6.
a <- c(1,2,4,5,6)
b <- c(3,2,4,1,9)
cbind(a,b)

7.
a <- c(10,2,4,15)
b <- c(3,12,4,11)
rbind(a,b)

9. 
x <- c(1:12)
length(x)

10.
x <- c('blue', '10', 'green', 20)
is.character(x)

11.
year=c(2005:2016)
month=c(1:12)
day=c(1:31)

Date <- list(year =year, month= month, day = day)
Date

12.
M=matrix(c(1:9),3,3,byrow=T)
N=matrix(c(1:9),3,3)

M%*%N

14.
Department <- data.frame(DepartmentID= c(31, 33, 34, 35), 
                         DepartmentName= c('영업부', '기술부', '사무부', '마케팅'))
Department


