9/7
# 데이터 조작 관련 함수
# group_by()

# dplyr, plyr, hflights

install.packages(c('plyr', 'dplyr', 'hflights'))
library(plyr)
library(dplyr)
library(hflights)

flight.frm <- hflights
str(flight.frm)

# 데이터 한 눈에 보기
flight.tbl <- as_tibble(flight.frm)

View(flight.frm)

# filter(): 조건에 따라서 추출

# 1월 1일 데이터 추출
filter(flight.frm, Month==1, DayofMonth==1)
View(filter(flight.frm, Month==1, DayofMonth==1))

# 1월 또는 2월
View(filter(flight.frm, Month==1 | Month==2))

# 열의 기준으로 오름차순, 내림차순 desc()
# arrange()
View(arrange(flight.frm, desc(Month)))
View(arrange(flight.frm, desc(Month), desc(DayofMonth)))
View(plyr::arrange(flight.frm, desc(Month), desc(DayofMonth)))

# select(), mutate() 열의 조작
# select() : 열 추출(복수개를 추출, )
View(select(flight.frm, Year, Month))
View(select(flight.frm, Year:Month))
View(select(flight.frm, -(Year:DayOfWeek)))

# mutate() 새로운 열 추가
mutate(flight.frm,
       gain = ArrDelay - DepDelay)
View(mutate(flight.frm,
            gain = ArrDelay - DepDelay))

# transform() 열을 추가하는 건 같지만 파생변수를 다른 파생변수의 데이터로 활용할 수는 없음
View(transform ( flight.frm,
                 gain = ArrDelay - DepDelay,
                 gain_per_hour = gain/(AirTime/60))) # 오류

# 출발지연시간 평균 및 합계
sum(flight.frm$DepDelay, na.rm=TRUE)
mean(flight.frm$DepDelay, na.rm=TRUE)

# summarise(): 통계함수를 지정하여 값을 구할 수 있다.
# mean(), sd(), var(), median()

flight.avg.sum <- summarise(
                            flight.frm,
                            delay_avg = mean(DepDelay, na.rm = TRUE),
                            delay_sum = sum(DepDelay, na.rm = TRUE)
                            )
flight.avg.sum

# group_by() 그룹화
# 비행편수가 20편 이상, 평균 비행거리가 2,000 마일 이상인 항공사별 평균 연착시간을 분석
planes <- group_by(flight.frm, TailNum)

View(dplyr::summarise(planes,
          count = n(),
          dist = mean(Distance, na.rm=TRUE),
          delay = mean(ArrDelay, na.rm=TRUE))
          )

tmp.frm <- dplyr::summarise(planes,
                            count = n(),
                            dist = mean(Distance, na.rm=TRUE),
                            delay = mean(ArrDelay, na.rm=TRUE))
tmp.frm

# 비행편수가 20편 이상, 평균 비행거리가 2,000 마일 이상인
delay.frm <- filter(tmp.frm, count > 20, dist > 2000)
View(delay.frm)

# chain() 함수
# dplyr::chain()
# %>% 각 조작을 연결해서 한 번에 수행할 수 있다.

# step01) 그룹화
step01 <- group_by(hflights, Year, Month, DayofMonth)

# step02) DayofMonth, ArrDelay, DepDelay 추출
step02 <- select(step01, Year:DayofMonth, ArrDelay, DepDelay)

# step03) 평균 연착시간과 평균 지연시간
step03 <- dplyr::summarise(step02,
                    arr = mean(ArrDelay, na.rm=TRUE),
                    dep = mean(DepDelay, na.rm=TRUE))

# step04) 평균 연착시간과 평균 출발지연시간이 30분 이상인 데이터 추출
step04 <- filter(step03, arr >= 30 | dep >= 30 )


hflights %>%
  group_by(Year, Month, DayofMonth) %>%
  select(Year:DayofMonth, ArrDelay, DepDelay) %>%
  dplyr::summarise(arr = mean(ArrDelay, na.rm= TRUE),
                   dep = mean(DepDelay, na.rm= TRUE)) %>%
  filter(arr >= 30 | dep >= 30)

# adply()
# 데이터 분할 - split
# 특정함수를 적용 - apply
# 열추가 - 이런 절차를 처리해주는 함수

# 입력데이터 타입 - 배열, 프레임, 리스트

iris.frm <- iris

apply(iris.frm[, 1:4], 1, function(row) {
  print(row)
})

# Sepal.Length > 5.0 & Species == 'setosa' 만 가져와서 새로운 변수(sepal.5.setosa)를 추가

tmp <- split(iris.frm, iris.frm$Species)$setosa
tmp$sepal.5.setosa <- c(tmp$Sepal.Length > 5.0 &
                        tmp$Species == 'setosa')

# case01. chain
iris.frm %>%
  mutate(sepal.5.setosa = c(Sepal.Length > 5.0 &
                            Species == 'setosa'))

# case02. adply()
adply(iris.frm,
      1,
      function(row){
        data.frame(
          sepal.5.setosa = c(row$Sepal.Length > 5.0 &
                             row$Species == 'setosa')
        )
      })

# ddply()
# iris 데이터에서 Sepal.Length 평균을 종별로 계산한다면?

ddply(iris.frm,
      .(Species),
      function(row) {
        data.frame(sepal.length.mean = mean(row$Sepal.Length))
      })

# baseball데이터에서 id가 ansonca01 선수의 기록만 확인
baseball.frm <- baseball
# case01
filter(baseball.frm, id=='ansonca01')

# case02
subset(baseball.frm, baseball.frm$id == 'ansonca01')

# case03
baseball.frm[baseball.frm$id=='ansonca01', ]

# ddply()
# 각 선수가 출전한 게임수(g)의 평균을 분석한다면
ddply(baseball.frm,
      .(id),
      function(row) {
        data.frame(game.mean = mean(row$g))
      })

ddply(baseball.frm,
      .(id, g > 100),          #-- 헤딩
      function(row) {
        data.frame(game.mean = mean(row$g))
      })

ddply(baseball.frm,
      .(id),
      summarise,
      minyear = min(year),
      maxyear = max(year)
      )

#각 선수별 최대 출장기록 정보를 분석한다면
ddply(baseball.frm,
      .(id),
      subset,
      g== max(g)
      )

# 프레임 병합
# join()
# inner join, left join, right join, full join
# join(frm, frm, by, type =)

tmp.first.frm <- data.frame(
  id = c(1,2,3,4,6),
  height = c(160, 175, 180, 178, 192)
)
tmp.second.frm <- data.frame(
  id = c(5,4,3,2,1),
  weight = c(55, 75, 80, 78, 92)
)

inner.frm <- join(tmp.first.frm,
                  tmp.second.frm,
                  by = 'id',
                  type = 'inner')
inner.frm

# distinct() 중복없이 유일한 값을 리턴
# names(): 컬럼이름 확인

library(MASS)
cars.frm <- Cars93
str(cars.frm)
View(cars.frm)

names(cars.frm)
distinct(cars.frm, Origin)

#예제
# Cars93 데이터 프레임에서 '차종(Type)'과 
#'생산국-미국여부(Origin)' 변수를 기준으로  중복없는 유일한 값을 추출하시오.
distinct(cars.frm, Origin, Type)

# 문) Cars93 데이터 프레임(1~5번째 변수만 사용)에서 10개의 관측치를 무작위로 추출하시오.

c5 <- cars.frm[, 1:5]
sample_c5 <- c5[sample(nrow(c5), 10),]
sample_c5

sample_n(cars.frm[ , 1:5], 10)

# 문) Cars93 데이터 프레임(1~5번째 변수만 사용)에서 10%의 관측치를 무작위로 추출하시오.
install.packages("doBy")
library(doBy)

sampleBy(~c5, frac = 0.1, data = c5)
sample_frac(cars.frm[ , 1:5], 0.1)

# 문) Cars93 데이터 프레임(1~5번까지 변수만 사용)에서 20개의 관측치를 무작위 복원추출 하시오.
sample_c5_20 <- c5[sample(nrow(c5), 20, replace=TRUE),]
sample_c5_20 

sample_n(cars.frm[ , 1:5], 20, replace = TRUE)

# 문) Cars93 데이터 프레임에서 ?????
# '제조국가_미국여부(Origin)'의 'USA', 'non-USA' 요인 속성별로 
# 각 10개씩의 표본을 무작위 비복원 추출하시오.
cars.frm[ , c('Model', 'Origin')] %>%
  group_by(Origin) %>%
  sample_n(10)


cars_origin <- group_by(cars.frm, Origin)
View(cars_origin)

ca <- dplyr::summarise(cars_origin,
                 sample1 = sample(cars_origin, 10),
                 sample2 = sample(cars_origin, 10),
)

View(ca)







# 문) Cars93 데이터프레임에서 
# 최소가격(Min.Price)과 최대가격(Max.Price)의 범위(range), 
# 최소가격 대비 최대가격의 비율(=Max.Price/Min.Price) 의 
# 새로운 변수를 생성하시오.
range(cars.frm$Min.Price, cars.frm$Max.Price)


mutate()






# 문) Cars93_1 데이터 프레임에서 
# (a) 총 관측치의 개수, 
# (b) 제조사(Manufacturer)의 개수(유일한 값), 
# (c) 첫번째 관측치의 제조사 이름, 
# (d) 마지막 관측치의 제조사 이름, 
# (e) 5번째 관측치의 제조사 이름은?



nth(Manufacturer, 5)










# 문) Cars93 데이터 프레임에서 
# '차종(Type)' 별로 구분해서 
# (a) 전체 관측치 개수, 
# (b) (중복 없이 센) 제조사 개수, 
# (c) 가격(Price)의 평균과 (d) 가격의 표준편차를 구하시오. 
# (단, 결측값은 포함하지 않고 계산함)

grp <- group_by(cars.frm, Type)

dplyr::summarise(grp,
                 total = n(),
                 cnt = n_distinct(Manufacturer),
                 avg = mean(Price, na.rm= TRUE),
                 sdv = sd(Price, na.rm = TRUE))









