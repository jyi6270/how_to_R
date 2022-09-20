# 9/20
# EDA 실습

library(readxl)
raw.coffee <- read_xlsx(file.choose())
str(raw.coffee)

library(stringr)
tmp.vec <- c('tomato', 'pear', 'apple', 'banana', 'mato')
str_detect(tmp.vec, 't')
str_detect(tmp.vec, '^t')
letters
str_detect(letters, '[acd]')

library(dplyr)


# 1. 데이터 전처리

# select와 filter를 통해 아래 컬럼만 뽑고 
# 주소지가 서울특별시인 데이터만 추출하여 확인해보자
# 번호, 사업장명, 소재지전체주소, 업태구분명, 시설총규모, 인허가일자, 폐업일자, 
# 소재지면적, 상세영업상태명, 영업상태구분코드

raw.coffee.subset <- raw.coffee %>%
                    select('번호', '사업장명', '소재지전체주소', '업태구분명',
                   '시설총규모', '인허가일자', '폐업일자', '소재지면적', 
                   '상세영업상태명', '영업상태구분코드') %>%
                    filter(substr(raw.coffee$도로명전체주소, 1, 2) == '서울')


raw.coffee.subset %>%
  filter(업태구분명 == '커피숍' & 상세영업상태명 == '영업')



raw.coffee.syd <- substr(raw.coffe.subset$소재지전체주소, 7, 10)
raw.coffee.syd <- gsub(" ", "", raw.coffee.syd)
str(raw.coffee.syd)

syd.coffee <- raw.coffee.subset %>% 
              filter(raw.coffee.syd %in% c('서대문구', '영등포구', '동대문구'))



install.packages("anytime")
library(anytime)
install.packages("lubridate")
library(lubridate)

?ymd
raw.coffee.ymd <- ymd(c(raw.coffe.subset$인허가일자, raw.coffe.subset$폐업일자))
str(raw.coffee.ymd)

substr(raw.coffee.ymd, 1, 4)
substr(raw.coffee.ymd, 6, 7)
substr(raw.coffee.ymd, 9, 10)


str(raw.coffee.subset)
as.numeric(raw.coffee.subset$시설총규모)
raw.coffee.subset$규모타입 <- ifelse(raw.coffee.subset$시설총규모 <= 3, '초소형', 
                              ifelse(raw.coffee.subset$시설총규모 <=30, '소형',
                              ifelse(raw.coffee.subset$시설총규모 <=70, '중형',
                              ifelse(raw.coffee.subset$시설총규모 <= 300, '대형', '초대형')))
                                     )



table(raw.coffee.subset$규모타입)

library(ggplot2)
ggplot(raw.coffee.subset,
       aes(x=규모타입)) +
  geom_bar()



raw.2000 <- raw.coffee.subset %>%
              filter(상세영업상태명 == '영업'& 
                     substr(raw.coffee.subset$인허가일자, 1, 4) >= 2000 ) %>%
              group_by(규모타입)

table(raw.2000$규모타입)




raw.coffeeshop <- raw.coffee %>%
                  filter(업태구분명 == '커피숍')
raw.coffeeshop[(raw.coffeeshop$시설총규모 == max(raw.coffeeshop$시설총규모, na.rm=TRUE)),]




ggplot(data = raw.coffee,
       aes(x = 시설총규모)) +
  geom_histogram( stat = "count")




raw.coffee$인허가연도 <- substr(raw.coffee$인허가일자, 1, 4)

coffeeshop <- raw.coffee %>%
              filter(업태구분명 == '커피숍' & 상세영업상태명 == '영업')

ggplot(data = coffeeshop,
       aes(x= 인허가연도)) +
  geom_histogram(stat = "count")



coffeeshop2 <- raw.coffee %>%
  filter(업태구분명 == '커피숍' & 상세영업상태명 %in% c('영업','폐업'))

ggplot(data = coffeeshop2,
       aes(x= 인허가연도)) +
  geom_histogram(stat = "count")



raw.coffee.subset$인허가연도 <- substr(raw.coffee.subset$인허가일자, 1, 4)
str(raw.coffee.subset$인허가연도)
year.coffee <- as.data.frame(raw.coffee.subset$인허가연도)


state.coffee <- as.data.frame(raw.coffee.subset$상세영업상태명) 



hist.subset <- raw.coffee.subset %>%
                filter(인허가연도=='2001') %>%
                group_by(규모타입) %>%
                select(상세영업상태명)

ggplot(data = hist.subset,
       aes(x=규모타입,
           fill= 상세영업상태명)) +
  geom_histogram(stat="count")














