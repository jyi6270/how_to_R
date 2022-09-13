# 9/13
# 외부파일(.csv , .xsl, .txt) 데이터 가공 및 시각화
# reshape 패키지: 데이터의 모양을 변형
# melt(), cast()

# melt(): 인자로 데이터를 구분하는 식별자, 대상변수, 측정치를 받아서 데이터를 표현

install.packages("reshape2")
library(reshape2)

fries.frm <- french_fries
str(fries.frm)

head(fries.frm)

melt(id= 1:4, data = fries.frm)

# 행의 값이 하나라도 NA이면 FALSE 반환
complete.cases(fries.frm)

# 결측값이 있는 행만 확인
fries.frm[ !complete.cases(fries.frm), ]

# cast(): 원상복구
# -> dcase(frame), acast(vector, matrix, array)

fries.frm.melt <- metl(id = 1:4, fries.frm, na.rm=TRUE)
fries.frm.melt
fries.frm.cast <- dcast(fries.frm.melt,
                        time + treatment + subject + rep ~ ...)
fries.frm.cast

# 엑셀파일 및 txt 파일을 불러오기 위해서는 패키지 설치가 필요
install.packages('readxl')
library(readxl)

# read_excel() - xl, read.table() - txt

tmp.xl <- read_excel(file.choose())
class(tmp.xl)   - 티블

tmp.xl.frm <- as.data.frame(tmp.xl)
class(tmp.xl.frm) - 데이터프레임

# 다른 시트가 보고싶다면 sheet = 2 
tmp.xl <- read_excel(file.choose(), sheet = 2)

# 엑셀파일을 읽을 때
# sheet =
# header = 변수명인지 아닌지를 판단(변수명이면 TRUE)
# skip = 특정 행까지 제외하고 가져오기
# nrows = 특정 행까지 가져오기
# sep = 데이터 구분자 지정

# txt
tmp.txt <- read.table(file.choose(), 
                      header = TRUE,
                      nrows = 7)
class(tmp.txt)
str(tmp.txt)
tmp.txt

# header가 없는 txt 파일을 로드하여 변수명을 지정하고 싶다면
# col.names
col.vec <- c('ID', 'GENDER', 'AGE', 'AREA')
tmp.txt <- read.table(file.choose(), 
                      header = FALSE,
                      sep = ' , ',
                      col.names = col.vec)

# 데이터 저장하여 추후에 로우데이터로 활용하고 싶다면
# write.csv(), write.table()
write.csv(tmp.txt, file = "c:\\r_data_csv\\save_data.csv")
raw.data <- read.csv(file.choose())
raw.data

# txt save
write.table(tmp.txt, file = "c:\\r_data_csv\\save_data.txt")
raw.data <- read.table(file.choose())
raw.data

# gender, area 요인(factor)변수로 변경한다면?
raw.data$GENDER <- as.factor(raw.data$GENDER)
raw.data$AREA <- as.factor(raw.data$AREA)
levels(raw.data$GENDER)
levels(raw.data$AREA)

# 데이터 파악하기 위한 함수 사용법

tmp.xl <- read_excel(file.choose(), sheet=1)
tmp.xl.frm <- as.data.frame(tmp.xl)

# sex, area 요인변수로 변경
tmp.xl.frm$SEX <- as.factor(tmp.xl.frm$SEX)
tmp.xl.frm$AREA <- as.factor(tmp.xl.frm$AREA)


# 성별에 따른 17년도 ATM 평균 이용 금액
aggregate(tmp.xl.frm$AMT17,
          list(tmp.xl.frm$SEX),
          mean)

tapply(tmp.xl.frm$AMT17,
       tmp.xl.frm$SEX,
       FUN = mean)

with(tmp.xl.frm,
     tapply(AMT17,
            SEX,
            FUN = mean)
)


install.packages('plyr')
library(plyr)
ddply(tmp.xl.frm,
      .(SEX),
      function(row){
        data.frame(atm.mean = mean(row$AMT17 , na.rm=TRUE))
      })

sapply(split(tmp.xl.frm$AMT17, tmp.xl.frm$SEX),
       mean,
       na.rm=TRUE)

install.packages('dplyr')
library(dplyr)
tmp.xl.frm %>%
  group_by(SEX) %>%
   dplyr::summarise(cnt=n(),
                    mean=mean(AMT17))


# 지역별 Y17_CNT 이용건수에 대한 합계를 분석한다면?
sapply(split(tmp.xl.frm$Y17_CNT, tmp.xl.frm$AREA),
       sum,
       na.rm=TRUE)

tmp.xl.frm %>%
  group_by(AREA) %>%
  dplyr::summarise(cnt = n(),
                   sum = sum(Y17_CNT))

ddply(tmp.xl.frm,
      .(AREA),
      function(row) {
        data.frame(Y17_CNT.sum = sum(row$Y17_CNT, na.rm = TRUE))
      })

aggregate(tmp.xl.frm$Y17_CNT,
          list(tmp.xl.frm$AREA),
          sum)

# ls() 이름만 가져오기
ls(tmp.xl.frm)

# AMT16 -> Y16_AMT, AMT17 -> Y17_AMT 변수명 변경한다면?
# rename()
tmp.xl.frm <- rename(tmp.xl.frm,
                     Y16_AMT = AMT16,
                     Y17_AMT = AMT17)
ls(tmp.xl.frm)

# 파생변수 추가(Y17_AMT + Y16_AMT = AMT)
# 파생변수 추가(Y17_CNT + Y16_CNT = CNT)

tmp.xl.frm <- mutate(tmp.xl.frm,
                     AMT = Y17_AMT + Y16_AMT,
                     CNT = Y17_CNT + Y16_CNT)
tmp.xl.frm

# AMT를 CNT로 나눈 값을 AVG_AMT 변수로 추가
tmp.xl.frm <- mutate(tmp.xl.frm,
                     AVG_ANT = AMT / CNT)

# 나이를 기준으로 50이상이면 'Y' 미만이면 'N' 파생변수(AGE_YN)

tmp.xl.frm$AGE_YN <- ifelse( tmp.xl.frm$AGE >= 50, 'Y', 'N')
tmp.xl.frm

row_size = nrow(tmp.xl.frm)
row_size

for(idx in 1:row_size) {
  print(tmp.xl.frm[idx, ])
}

# 나이대별 분석을 위해서 나이등급파생변수 추가
tmp.xl.frm$AGE_GRADE <- ifelse(tmp.xl.frm$AGE >= 50, '50++',
                               ifelse(tmp.xl.frm$AGE >= 40, '40++',
                                      ifelse(tmp.xl.frm$AGE >= 30, '30++',
                                             ifelse(tmp.xl.frm$AGE >= 20, '20++', 
                                                    '20--'))))


# dplyr :: %>% 데이터 추출, 정렬, 요약, 결합
tmp.xl.frm$AGE_GRADE

tmp.xl.frm %>%
  select(AGE_GRADE)

ls(tmp.xl.frm)
tmp.xl.frm[ , c('AGE', 'AGE_GRADE', 'AGE_YN')]

tmp.xl.frm %>%
  select(AGE, AGE_GRADE, AGE_YN)

tmp.xl.frm %>%
  select(-AGE)

# 지역이 서울인 사람만 추출한다면?
subset(tmp.xl.frm, tmp.xl.frm$AREA == '서울')

filter(tmp.xl.frm, AREA == '서울')

tmp.xl.frm %>%
  subset(AREA == '서울')

# 지역이 서울이면서 17년도 AMT 출금횟수가 10회 이상인 데이터만 추출한다면?
filter(tmp.xl.frm, AREA == '서울' & Y17_CNT >= 10)

# 나이순으로 정렬(내림차순)
arrange(tmp.xl.frm, desc(AGE))
arrange(tmp.xl.frm, AGE)

# 지역별 17년도 AMT 총합의 Y17_AMT_SUM 추출
tmp.xl.frm %>%
  group_by(AREA) %>%
  dplyr::summarise(Y17_AMT_SUM = sum(Y17_AMT_SUM))


# 데이터 결합
tmp.male.frm <- read_excel(file.choose(), sheet=1)
tmp.female.frm <- read_excel(file.choose(), sheet=1)

# 세로결합
rbind(tmp.male.frm, tmp.female.frm)
bind_rows(tmp.male.frm, tmp.female.frm)

# 가로결합 - join(left, inner, full)
# 기준컬럼을 필요로 한다
# cbind(tmp.male.frm, tmp.female.frm)


tmp.16.frm <- read_excel(file.choose(), sheet=1)
tmp.17.frm <- read_excel(file.choose(), sheet=1)

inner_join(tmp.16.frm, tmp.17.frm, by = 'ID')
left_join(tmp.16.frm, tmp.17.frm, by = 'ID')
full_join(tmp.16.frm, tmp.17.frm, by = 'ID')

# 빈도분석(특정값이 얼마나 반복되는지)을 위해서 descr 패키지
install.packages('descr')
library(descr)


tmp.xl.frm
freq(tmp.xl.frm$AREA, plot = TRUE)

hist(tmp.xl.frm$AGE,
     xlim = c(0, 60),
     ylim = c(0, 5),
     main = '나이분포')

library(ggplot2)
ggplot2::mpg

ls(ggplot2::mpg)

raw.mpg <- ggplot2::mpg
str(raw.mpg)

# 1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려 한다. 
# displ(배기량)이 4 이하인 자동차와 4 초과인 자동차 중 
# 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 확인하세요.

raw.mpg %>%
  mutate(displ.4.higher = ifelse(displ > 4 , 'higher', 'lower')) %>%
  group_by(displ.4.higher) %>%
  summarise(mean.hwy = mean(hwy))


# 2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 한다. 
# "audi"와 "toyota" 중 어느 manufacturer(제조회사)의 cty(도시 연비)가 
# 평균적으로 더 높은지 확인하세요.
raw.mpg.at <- subset(raw.mpg,
                     raw.mpg$manufacturer == 'audi' | raw.mpg$manufacturer == 'toyota')

raw.mpg.at %>%
  mutate(raw.cty = ifelse(manufacturer == 'audi', 'audi', 'toyota'))%>%
           group_by(raw.cty)%>%
           summarise(mean.cty=mean(cty))

# 3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 한다. 
# 이 회사들의 데이터를 추출한 후 hwy(고속도로 연비) 전체 평균을 구하세요.

raw.mpg.hwy <- subset(raw.mpg,
                      raw.mpg$manufacturer == 'chevrolet' | 
                      raw.mpg$manufacturer == 'ford' |
                      raw.mpg$manufacturer == 'honda')
mean(raw.mpg.hwy$hwy)

# 4. "audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가 
# 높은지 알아보려고 한다. "audi"에서 생산한 자동차 중 hwy가 1~5위에 해당하는 
# 자동차의 데이터를 출력하세요.


raw.mpg.audi <- subset(raw.mpg,
                       raw.mpg$manufacturer == 'audi')
 
rrr <- raw.mpg.audi %>%
         group_by(raw.mpg.audi$model)

raw.mpg.audi.hwy <- rrr[order(rrr[,9], decreasing = TRUE),]

head(raw.mpg.audi.hwy, 5)


# 5. mpg 데이터는 연비를 나타내는 변수가 2개입니다.??? 
# 두 변수를 각각 활용하는 대신 하나의 통합 연비 변수를 만들어 사용하려 합니다. 
# 평균 연비 변수는 두 연비(고속도로와 도시)의 평균을 이용합니다. 
# 회사별로 "suv" 자동차의 평균 연비를 구한후 내림차순으로 정렬한 후 1~5위까지 데이터를 출력하세요.

View(raw.mpg)


raw.suv <- subset(raw.mpg,
       raw.mpg$class == 'suv')
raw.suv.mean <- raw.suv %>%
                 group_by(raw.suv$manufacturer)%>%
                 summarise(mean.suv = mean(raw.suv$cty + raw.suv$hwy))
ddply(raw.suv,
      .(raw.suv$manufacturer),
      function(row){
        data.frame(mean.suv=mean(raw.suv$cty + raw.suv$hwy))
      })



as.data.frame(raw.suv.mean)
order(raw.suv.mean[,2], decreasing = TRUE)
View(raw.suv.mean)


raw.mpg.at %>%
  mutate(raw.cty = ifelse(manufacturer == 'audi', 'audi', 'toyota'))%>%
  group_by(raw.cty)%>%
  summarise(mean.cty=mean(cty))


subset(raw.mpg,
       raw.mpg$class == 'suv') %>%
  group_by(raw.mpg$manufacturer, mean) %>%
  summarise(mean = mean(raw.mpg$cty, raw.mpg$hwy))


# 6. mpg 데이터의 class는 "suv", "compact" 등 자동차의 특징에 따라 
# 일곱 종류로 분류한 변수입니다. 어떤 차종의 도시 연비가 높은지 비교하려 합니다. 
# class별 cty 평균을 구하고 cty 평균이 높은 순으로 정렬해 출력하세요.

raw.mpg.cty <- aggregate(raw.mpg$cty, 
                         list(raw.mpg$class),
                         mean)
raw.mpg.cty.order <- raw.mpg.cty[order(raw.mpg.cty[,2], decreasing=TRUE),]
raw.mpg.cty.order

# 7. 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려 합니다. 
# hwy(고속도로 연비) 평균이 가장 높은 회사 세 곳을 출력하세요.
rara <- aggregate(raw.mpg$hwy,
                  list(raw.mpg$manufacturer),
                  mean)
rara.order <- rara[order(rara[,2], decreasing=TRUE), ]
head(rara.order, 3)

# 8. 어떤 회사에서 "compact" 차종을 가장 많이 생산하는지 알아보려고 합니다. ???
# 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.
raw.mpg.compact <- aggregate(raw.mpg$comp,
                            list(raw.mpg$manufacturer),
                            mean)
rara.order <- rara[order(rara[,2], decreasing=TRUE), ]
head(rara.order, 3)



compact <- subset(raw.mpg, raw.mpg$class == 'compact')
aggregate(compact,
          list(compact$manufacturer),
          count)
raw.mpg %>%
  count(raw.mpg$class == 'compact')

raw.mpg %>%
  group_by(raw.mpg$manufacturer) %>%
  summarise(sum = sum(raw.mpg$class))

aggregate(raw.mpg,
          list(raw.mpg$manufacturer),
          count(raw.mpg$class == 'compact'))
