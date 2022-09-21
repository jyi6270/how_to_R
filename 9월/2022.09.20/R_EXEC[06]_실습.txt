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

# 폐업하지않고 현재 영업중인 카페찾기
raw.coffee.subset %>%
  filter(업태구분명 == '커피숍' & 상세영업상태명 == '영업')


# 지역구별로 데이터 나누기(서대문, 영등포, 동대문) 3개의 구만 
# 추출(시각화로 사용할 예정)
raw.coffee.syd <- substr(raw.coffe.subset$소재지전체주소, 7, 10)
raw.coffee.syd <- gsub(" ", "", raw.coffee.syd)
str(raw.coffee.syd)

syd.coffee <- raw.coffee.subset %>% 
              filter(raw.coffee.syd %in% c('서대문구', '영등포구', '동대문구'))


# 인허가일자와 폐업일자의 데이터 형식이 
# chr와 logic으로 되어있는 것을 확인할 수 있다.
# ymd함수를 통해 chr와 logi형식으로 되어있는 데이터형식을 Date로 바꾼다.
install.packages("anytime")
library(anytime)
install.packages("lubridate")
library(lubridate)

?ymd
raw.coffee.ymd <- ymd(c(raw.coffe.subset$인허가일자, raw.coffe.subset$폐업일자))
str(raw.coffee.ymd)

# Date로 바꾼 인허가 일자 데이터를 바탕으로 인허가 
# year, month, day을 각각 추출해 가변수를 만들어보자
substr(raw.coffee.ymd, 1, 4)
substr(raw.coffee.ymd, 6, 7)
substr(raw.coffee.ymd, 9, 10)

# 데이터 형식 전처리(규모변수 추가)
# 시설총규모 타입 확인 후 문자형 -> 수치형  
# 시설총규모에 따라 이를 구분지어 
# 초소형, 초형, 중형, 대형, 초대형으로 구분지어볼려고 한다면
# 구분은 다음코드와 같이 임의로 지정
# 3제곱미터 이하는 초소형, 
# 30제곱미터 이하는 소형, 
# 70제곱미터이하는 중형 
# 300제곱미터 이하는 대형 그 이상은 초대형

str(raw.coffee.subset)
as.numeric(raw.coffee.subset$시설총규모)
raw.coffee.subset$규모타입 <- ifelse(raw.coffee.subset$시설총규모 <= 3, '초소형', 
                              ifelse(raw.coffee.subset$시설총규모 <=30, '소형',
                              ifelse(raw.coffee.subset$시설총규모 <=70, '중형',
                              ifelse(raw.coffee.subset$시설총규모 <= 300, '대형', '초대형')))
                                     )


# 규모별 커피숍 수 확인하기
# 영업중이면서 인허가일자가 2000년 이후 인 커피숍 수를 규모별로 확인해 본다면

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



# 가장 큰 규모의 카페는 어딜까요?


raw.coffeeshop <- raw.coffee %>%
                  filter(업태구분명 == '커피숍')
raw.coffeeshop[(raw.coffeeshop$시설총규모 == max(raw.coffeeshop$시설총규모, na.rm=TRUE)),]



# 시설 총규모를 히스토그램으로 시각화한다면?
library(ggplot2)
ggplot(data = raw.coffee,
       aes(x = 시설총규모)) +
  geom_histogram( stat = "count")



# 현재영업중인 카페의 인허가연도 히스토그램
raw.coffee$인허가연도 <- substr(raw.coffee$인허가일자, 1, 4)

coffeeshop <- raw.coffee %>%
              filter(업태구분명 == '커피숍' & 상세영업상태명 == '영업')

ggplot(data = coffeeshop,
       aes(x= 인허가연도)) +
  geom_histogram(stat = "count")


# 영업과페업한 카페의 인허가 연도를 히스토 그램으로 시각화
coffeeshop2 <- raw.coffee %>%
  filter(업태구분명 == '커피숍' & 상세영업상태명 %in% c('영업','폐업'))

ggplot(data = coffeeshop2,
       aes(x= 인허가연도)) +
  geom_histogram(stat = "count")


# 서울소재 커피숍의 인허가 년도별 숫자 확인
# 정보확인 후 데이터 프레임으로 만드세요~~

# 서울소재 커피숍의 인허가 년도별 숫자와 현재 영업중인 정보확인
# 정보확인 후 데이터 프레임으로 만드세요~ 
raw.coffee.subset$인허가연도 <- substr(raw.coffee.subset$인허가일자, 1, 4)
str(raw.coffee.subset$인허가연도)
year.coffee <- as.data.frame(raw.coffee.subset$인허가연도)


state.coffee <- as.data.frame(raw.coffee.subset$상세영업상태명) 

# 생존율 시각화
# geom_line , geom_point
???
  
  
  
  # 2001년도 시설총규모에 따른 영업구분을 히스토그램으로 시각화
  
hist.subset <- raw.coffee.subset %>%
                filter(인허가연도=='2001') %>%
                group_by(규모타입) %>%
                select(상세영업상태명)

ggplot(data = hist.subset,
       aes(x=규모타입,
           fill= 상세영업상태명)) +
  geom_histogram(stat="count")




# 2000년도 ~ 
# 지역구에 따른 년도별 커피숍 인허가 정보를 요약하고
# 데이터 프레임으로 만들어보자


# 2000년도 ~
# 지역구에 따른 년도별 커피숍 인허가 정보와 
# 현재영업중인 정보를 요약하고 
# 데이터 프레임으로 만들어보자










