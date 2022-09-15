# 9/15

airquality
raw.air <- airquality

# x -> day, y -> tmp
library(ggplot2)
g<- ggplot(data = raw.air,
           aes(x = Day,
               y = Temp))

# 산점도 geom_point
g +
  geom_point()

# dot 크기를 3, 색상을 빨강으로 적용
g +
  geom_point(size = 3,
             colour = 'red')

# 꺾은선 그래프 geom_line()
g +
  geom_line(colour = 'red',
            size = 1) +
  geom_point(size = 3)

# 상자그림: geom_boxplot()
# day열 그룹지어, 날짜별 온도 상자그림을 시각화
g +
  geom_boxplot(aes(group = Day))

# Temp 히스토그램
hist(raw.air$Temp)

ggplot(data = raw.air,
       aes(x = Temp)) +
  geom_histogram()


# cyl 종류별 빈도수 확인
raw.cars <- mtcars
ggplot(data = raw.cars,
       aes(x= cyl)) +
  geom_bar()

ggplot(data = raw.cars,
       aes(x= factor(cyl))) +
  geom_bar()

# cyl 종류별 gear 빈도 누적막대
ggplot(data = raw.cars,
       aes(x = factor(cyl),
           y = gear)) +
  geom_bar(stat = 'identity')

ggplot(data = raw.cars,
       aes(x = factor(cyl),
           y = gear)) +
  geom_col()

ggplot(data = raw.cars,
       aes(x = factor(cyl))) +
  geom_bar(aes(fill = gear))


# 원 그래프, 선 버스트
ggplot(data = raw.cars,
       aes(x=factor(cyl))) +
  geom_bar(aes(fill=gear)) +
  coord_polar()

ggplot(data = raw.cars,
       aes(x=factor(cyl))) +
  geom_bar(aes(fill=gear)) +
  coord_polar(theta= 'y')

# 산점도에 레이블 추가
g +
  geom_point() +
  geom_text(aes(label = Temp,
                vjust = 0,
                hjust = 0)) +
  labs(x= '날짜', y= '기온',
       title= '시각화')

# 일 평균 승차인원의 노선별 운행횟수 노선에 대한 혼잡도를 산점도로 시각화
raw.subway <- read.csv(file.choose())
ggplot(data = raw.subway,
       aes(x= AVG_ONEDAY,
           y= RUNNINGTIMES_WEEKDAYS)) +
  geom_point(aes(colour = LINE,
                 size = AVG_CROWDEDNESS))
  
# 노선별 평균 승차인원을 시각화한다면?
# 원의 크기를 인원수의 크기로 설정한다면
ggplot(data = raw.subway,
       aes(x= LINE,
           y= AVG_ONEDAY)) +
  geom_point(aes(colour=LINE,
                 size = AVG_ONEDAY))

#1. poptotal -> total, popasian -> asian 컬럼 수정
library(dplyr)
raw.midwest <- midwest
raw.tibble <-rename(raw.midwest, total = poptotal, asian= popasian)
raw.midwest <- as.data.frame(raw.tibble)

#2. total, asian 변수를 이용해서 전체인구대비 아시아 인구 비율 추가
# perasian 파생 변수를 만들고 히스토그램으로 시각화?
raw.midwest <- mutate(raw.midwest,
                      perasian = (asian / total)*100)

ggplot(data = raw.midwest,
       aes(x = perasian)) +
  geom_histogram()

#3. 아시아인구 백분율 전체 평균 구하고 평균을 초과하면 'over', 아니면 'under'
# perasian_mean 파생변수 추가
perasian_mean <- mean(raw.midwest$perasian)
raw.midwest <- mutate(raw.midwest,
                      perasian_mean = ifelse(raw.midwest$perasian > 
                                               mean(raw.midwest$perasian), 'over', 'under'))
raw.midwest <- raw.midwest %>%
               mutate(perasian_mean = ifelse(perasian > mean(perasian), 'over', 'under'))

#4. perasian_mean 빈도확인?
table(raw.midwest$perasian_mean)
ggplot(raw.midwest,
       aes(x= perasian_mean)) +
  geom_bar()

?barplot
barplot(table(raw.midwest$perasian_mean))

#5. 전체인구대비 미성년 인구 백분율 파생변수 추가
# peryouth
View(raw.midwest)
raw.midwest <- raw.midwest %>%
               mutate(peryouth = (total - popadults)*100 / total)

#6. 미성년 인구 백분율이 가장 높은 상위 5개의 지역(county)
head(raw.midwest[order(raw.midwest$peryouth, decreasing=TRUE), ], 5)


raw.midwest%>%
  group_by(county) %>%
  arrange(desc(peryouth)) %>%
  select(county, peryouth) %>%
  head(5)

#7. 전체 인구대비 아시아인 인구 백분율
# ratio_asian 파생변수 추가
# 하위 10개지역의 state, county, ration_asian 출력
raw.midwest <- mutate(raw.midwest,
                      ratio_asian = (asian / total)*100)
head(raw.midwest[order(raw.midwest$ratio_asian), ], 10)


raw.midwest %>%
  mutate(ratio_asian = (asian / total) *100) %>%
  arrange(ratio_asian) %>%
  head(10) %>%
  select(state, couty, ratio_asian)

#8. 미성년자 등급 파생변수 추가 gradeyouth
# 분류기준 40% 이상 large, 30~40 middle, 30 미만 small
# 빈도시각화

raw.midwest <- raw.midwest %>%
               mutate(gradeyouth = ifelse(peryouth >= 40, 'large',
                                          ifelse(peryouth >=30, 'middle', 'small')))
ggplot(raw.midwest,
       aes(x= gradeyouth)) +
  geom_bar()


# 예제5-2

url <- "https://www.dropbox.com/s/0djexymb42zd1e2/example_salary.csv?dl=1"
tmp.salary.frm <- read.csv(url, 
                           fileEncoding = 'euc-kr',
                           stringsAsFactors = FALSE,   # TRUE 문자열을 범주형데이터로 바꿀 수 있음
                           na = '-')     # 특정값을 결측값으로
#1
names(tmp.salary.frm)
tmp.salary.frm <- rename(tmp.salary.frm,
                        'Age' = '연령',
                        'Salary' = '월급여액..원.',
                        'SpecialSalary' = '연간특별급여액..원.',
                        'WorkingTime' = '근로시간..시간.',
                        'Numberofworker'='근로자수..명.',
                        'Career' = '경력구분',
                        'Gender' = '성별')

#2
View(tmp.salary.frm)
is.na(tmp.salary.frm)

#3
mean(tmp.salary.frm$Salary, na.rm = TRUE)

#4
median(tmp.salary.frm$Salary, na.rm = TRUE)

#5
min(tmp.salary.frm$Salary, na.rm = TRUE)
max(tmp.salary.frm$Salary, na.rm = TRUE)

#6
quantile(tmp.salary.frm$Salary, na.rm = TRUE)

#7
tmp.salary.frm %>%
  group_by(Gender) %>%
  summarise(mean.m = mean(Salary, na.rm = TRUE))

#8
ggplot(tmp.salary.frm,
       aes(x=Gender,
           y=Salary)) +
  geom_col()

#9
tmp.salary.frm %>%
  group_by(Gender) %>%
  summarise(sd.m = sd(Salary, na.rm = TRUE))

#10
tmp.salary.frm %>%
  group_by(Career) %>%
  summarise(mean.c = mean(Salary, na.rm = TRUE)) %>%
  arrange(mean.c)

#11
ggplot(tmp.salary.frm,
       aes(x=Career,
           y=Salary)) +
  geom_col()