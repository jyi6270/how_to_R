▶ 프레임을 쉽게 접근하기 위해서 제공되는 함수

- with(data, tapply(numeric vector, factor, function))

- within(): 데이터를 수정할 때 사용

​

▶ 예를 들어 iris의 Sepal.Length, Sepal.width의 평균을 같이 구한다면

# mean()

# tapply()

# sapply(), lapply()

mean(iris$Sepal.Length)

mean(iris$Sepal.Width)

​

​

▶ 결측값을 평균으로 대체

dummy.frame <- data.frame(val=c(1,2,3,4,NA,5,NA))

dummy.frame

mean(dummy.frame$val, na.rm = TRUE)                     --  결측값제거

​

dummy.frame <- within(dummy.frame, {

  val <- ifelse(is.na(val), mean(val, na.rm = TRUE), val)

})

​

▶ case other

dummy.frame$val[ is.na(dummy.frame$val)] <-

  median(dummy.frame$val, na.rm=TRUE)

​

▶ iris 컬럼별 평균을 구하는 경우를 살펴보자

mean(iris$Sepal.Length)

mean(iris$SEpal.Width)

mean(iris$Petal.Length)

mean(iris$Petal.Width)

​

lapply(iris[ , -5], mean)

irisMean <- lapply(iris[ , -5], mean)

class(irisMean)

irisMean

​

irisMean <- sapply(iris[ , -5], mean)

class(irisMean)

irisMean[1]

​

as.data.frame(irisMean)

​

▶ iris 일부 데이터가 결측치인 경우?

tmp.frame <- iris

tmp.frame[1, 1] <- NA

tmp.frame[1, ]

​

idx <- tmp.frame$Species =='setosa'

idx

​

mean(tmp.frame$Sepal.Length[idx], na.rm = TRUE)

​

▶ 결측값 평균으로 대체 is.na()

is.na(tmp.frame$Sepal.Length)

tmp.frame$Sepal.Length[is.na(tmp.frame$Sepal.Length)] <-

  mean(tmp.frame$Sepal.Length[idx], na.rm =TRUE)

​

▶ split(데이터프레임, 분리할 기준(팩터))

split(tmp.frame, tmp.frame$Species)

​

▶ 종별 Sepal.Length 평균을 구한다면

lst <- split(tmp.frame$Sepal.Length, tmp.frame$Species)

lapply(lst, mean)

​

▶ 중위수(median)

median_per_species <- sapply(split(tmp.frame$Sepal.Length, tmp.frame$Species),

                             median,

                             na.rm = TRUE)

​

median_per_species['setosa']

​

tmp.frame <- within(tmp.frame, {

         Sepal.Length <- ifelse(is.na(Sepal.Length),

                         median_per_species[Species],

                         Sepal.Length)

})

​

▶ subset(frm, 조건식, 컬럼선택) 

frame으로부터 조건에 만족하는 행을 추출하여 새로운 프레임 반환

​

x <- letters[1:5]

y <- 1:5

z <- 6:10

tmp.frm <- data.frame(x,y,z)

tmp.frm

​

sub.frm01 <- subset(tmp.frm, y>3)

sub.frm01

​

sub.frm01 <- subset(tmp.frm, z <= 8)

sub.frm01

​

▶ & , |

sub.frm01 <- subset(tmp.frm, y >=2 & z <= 8)

​

▶ 컬럼선택

sub.frm01 <- subset(tmp.frm, z>= 8, select = c(x,y))

​

▶ 요구사항 subset 생성

- 조건 Petal.Length의 평균보다 크거나 같은 조회컬럼은 Sepal.Length, Petal.Length, Species

tmp.frame <- iris

tmp.frame

​

tmp.iris.subset <- subset(tmp.frame, 

                          Petal.Length >= mean(Petal.Length),

                          select = c(1,3,5))

tmp.iris.subset

​

subset(tmp.frame, 

       Species == 'setosa' & Sepal.Length > 5.0,

       select = c(1,5))

​

​​

▶ 1~10 숫자를 홀수별, 짝수별로 묶어서 합

tapply(1:10, rep(1:2, 5), sum)

tapply(1:10, 1:10 %% 2 == 0, sum)

tapply(1:10, rep(c('odd', 'even'), 5), sum)

tapply(1:10, ifelse(1:10%%2 ==1, 'odd', 'even'), sum)

​

▶ iris 종별 Sepal.Length 평균을 구해보자

# tapply()

tmp.frame

tapply(tmp.frame$Sepal.Length, tmp.frame$Species, mean)

​

tmp.matrix <- matrix(1:8, 

                     ncol=2, 

                     dimnames= list(c('spring', 'summer', 'fall', 'winter'),

                                    c('male', 'female')))

tmp.matrix

​

▶ 반기별 남성 셀의 값의 합과 여성셀의 합을 구한다면?

tapply(tmp.matrix,

       list(c(1,1,2,2,1,1,2,2),

            c(1,1,1,1,2,2,2,2)),

       sum)

