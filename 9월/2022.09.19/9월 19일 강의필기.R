#9/19
# 탐색적 데이터 분석 - EDA(Exploratory Data Analysis)
# 기술통계분석 - Descriptive statistics

# 서대문구에 있는 치킨집 분포 분석
library(readxl)
raw.datasets <- read_excel(file.choose())
str(raw.datasets)

raw.datasets.frm <- as.data.frame(raw.datasets)


# 1. xxx동만 남기고 이후 상세 주소는 삭제
# substr() 함수를 이용하여 소재지전체주소에 있는 11~15번째 문자 가져오기
# 실행결과를 보면 동이름이 3글자, 4글자인 경우가 있어 지정한 자리만큼 글자를 추출하면 숫자가 포함된다
# gsub()함수를 이용하여 공백과 숫자를 제거

address.datasets.frm <- substr(raw.datasets.frm$소재지전체주소, 11, 15)
add.datasets.frm <- gsub("[0-9]", "", address.datasets.frm)
address <- gsub(" ", "", add.datasets.frm)
address

# 동별 업소의 개수를 확인하고 싶다면?
# 빈도확인 - 도수분포
table(address)

# 교차표
library(dplyr)
address.frm <- address %>%
                table() %>%
                data.frame

# treemap -- 데이터 프레임을 인자로 받는다
install.packages('treemap')
library(treemap)
treemap(address.frm,
        index = '.',
        vSize = 'Freq',
        title = '서대문구 치킨집 분포')

# 미세먼지 비교 및 지역별 차이 분석
raw.datasets <- read_excel(file.choose())
raw.datasets.frm <- as.data.frame(raw.datasets)

# 동작구, 서초구 데이터만 추출하여 새로운 프레임 생성
subset.frm <- raw.datasets.frm %>%
  filter(area == '동작구' | area == '서초구')

subset.frm <- raw.datasets.frm %>%
  filter(area %in% c('동작구', '서초구'))

subset.frm

# yyyymmdd 데이터의 수 파악
count(subset.frm, yyyymmdd)

# 동작구, 서초구 각각의 subset 생성
dataset.dj.frm <- subset(subset.frm, area == '동작구')
dataset.sc.frm <- subset(subset.frm, area == '서초구')
dataset.dj.frm
dataset.sc.frm

# 라인그래프 시각화
library(ggplot2)
ggplot(data = subset.frm, 
       aes(x= yyyymmdd,
           y= finedust,
           group = area,
           col = area)) +
  geom_line()

# 박스그래프
ggplot(data = subset.frm, 
       aes(x= yyyymmdd,
           y= finedust,
           group = area,
           col = area)) +
  geom_boxplot(fill = 'grey',
               color = 'darkgrey',
               width = 0.3,
               outlier.color = 'red',
               outlier.shape = 2)

# 데이터 전처리
# 1. 데이터탐색(조회)
# 2. 결측치 처리
# 3. 이상치 발견과 처리
# 4. 코딩변경
# 5. 시각화
# 6. 파생변수

tmp.frm <- read.csv(file.choose(), header = TRUE)
names(tmp.frm)
attributes(tmp.frm)

# 행의 수, 열의 수
nrow(tmp.frm)
ncol(tmp.frm)
length(tmp.frm)
dim(tmp.frm)

# 결측값 처리 (제거, 0, 통계적 방법)
table(is.na(tmp.frm))

summary(tmp.frm$price)
table(is.na(tmp.frm$price))

# 전체 변수를 대상으로 결측치 제거
tmp.na.frm <- na.omit(tmp.frm)
dim(tmp.na.frm)

# price 변수의 결측값 0 대체(price02)
summary(tmp.frm$price)
tmp.frm$price02 <- ifelse(is.na(tmp.frm$price), 0, tmp.frm$price)

table(is.na(tmp.frm$price02))

tmp.frm$price03 <- ifelse(is.na(tmp.frm$price),
                          mean(tmp.frm$price, na.rm=TRUE),
                          tmp.frm$price)

table(is.na(tmp.frm$price03))
tmp.frm[c('price', 'price02', 'price03')]

# 통계적 방법
# type: 1. 우수, 2. 보통, 3. 저조
# 평균보다 높으면 type 우수 * 1.5 , 낮으면 저조 * 0.5
price.avg <- mean(tmp.frm$price, na.rm=TRUE)
tmp.frm$type <- ifelse(tmp.frm$price > price.avg, '우수',
                       ifelse(tmp.frm$price == price.avg, '보통', '저조'))
tmp.frm$type02 <- ifelse(tmp.frm$type == '우수', tmp.frm$price * 1.5,
                         ifelse(tmp.frm$type == '저조', tmp.frm$price *0.5, tmp.frm$price))

# outlier 발견 & 처리
str(tmp.frm)
tmp.frm
tmp.frm <- subset(tmp.frm, gender %in% c(1,2))
tmp.frm$gender <- as.factor(tmp.frm$gender)
levels(tmp.frm$gender)
table(tmp.frm$gender)

pie(table(tmp.frm$gender))

ggplot(data = tmp.frm,
       aes(x= '',
           y= gender,
           fill = gender)) +
  geom_bar(stat = 'identity') +
  coord_polar('y')

# price 이상치 처리
price <- tmp.frm$price
price
plot(price)

IQR(price, na.rm=TRUE)
# Q1 - (1.5*IQR)
4.4 - (1.5 * 1.9)
# Q3 + (1.5*IQR)
6.3 + (1.5 * 1.9)
boxplot(price)$stats

ggplot(data = tmp.frm,
       aes(y= price)) +
  geom_boxplot()

tmp.price.frm <- subset(tmp.frm,
                        price >= 2.1 & price <= 7.9)
summary(tmp.price.frm$price)
nrow(tmp.price.frm)

# 코딩변경 - 리코딩
# 데이터의 가독성을 위해서 역코딩
# 연속형 -> 범주형
tmp.frm$resident

# resident = 1. 서울, 2. 인천, 3. 대전, 4. 대구, 5. 광주
# resident2 파생변수에 추가
range(tmp.frm$resident, na.rm=TRUE)

tmp.frm$resident2 <- ifelse(tmp.frm$resident == 1, '서울',
                      ifelse(tmp.frm$resident == 2, '인천',
                      ifelse(tmp.frm$resident == 3, '대전',
                      ifelse(tmp.frm$resident == 4, '대구', '광주'))))


# job = 1. 공무원, 2. 회사원, 3. 개인사업
# job2 파생변수에 추가

tmp.frm$job2 <- ifelse(tmp.frm$job == 1, '공무원',
                ifelse(tmp.frm$job == 2, '회사원', '개인사업'))

# age 척도변경(연속형 -> 범주형)
range(tmp.frm$age, na.rm=TRUE)

# ~34 청년, ~49 중년, ~64 장년, 노인
# age2 파생변수 추가
tmp.frm$age2 <- ifelse(tmp.frm$age <= 34, '청년',
                ifelse(tmp.frm$age <= 49, '중년',
                ifelse(tmp.frm$age <= 64, '장년', '노인')))
tmp.frm$age2

# 거주지역별 성별 확인
# 교차분할표(table)
resident_gender <- table(tmp.frm$resident2, tmp.frm$gender)

# 모자이크플롯
mosaicplot(resident_gender, col = rainbow(2))

# 바플롯
barplot(resident_gender,
        col= rainbow(5),
        beside = T,
        legend = row.names(resident_gender))

# 지지플롯
resident_gender <- as.data.frame(resident_gender)
ggplot(data = resident_gender,
       aes(x= Var1,
           y= Freq,
           fill = Var2)) +
  geom_bar(stat='identity',
           position='dodge')

# 직업 유형에 따른 나이를 시각화
job_age_tbl <- table(tmp.frm$job2,
                     tmp.frm$age2)
# 바플롯
barplot(job_age_tbl,
        col= rainbow(5),
        beside = T,
        legend = row.names(job_age_tbl))
# 지지플롯
job_age_tbl <- as.data.frame(job_age_tbl)
ggplot(data = job_age_tbl,
       aes(x= Var1,
           y= Freq,
           fill = Var2)) +
  geom_bar(stat='identity',
           position='dodge')



















