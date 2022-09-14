# 9/14
# 시각화
# R (graphics, lattice, ggplot)
# 변수구분( 이산 vs 연속 )
# 이산(범주형 변수): 변수가 가질 수 있는 값이 끊어진 변수(명목, 순위)- 막대, 점, 파이
# 연속 변수: 변수가 연속된 구간을 갖는다는 의미(간격, 비율) - 상자, 히스토그램, 산점도

# 이산변수 - 막대차트
chart.data <- c(305, 450, 320, 460, 330, 480, 380, 520)

# 컬럼라벨
names(chart.data) <- c('Y2021_1Q', 'Y2021_2Q', 'Y2021_3Q', 'Y2021_4Q'
                       , 'Y2022_1Q', 'Y2022_2Q', 'Y2022_3Q', 'Y2022_4Q')
# 막대그래프
barplot(chart.data)

barplot(chart.data,
        ylim = c(0, 600),
        col = rainbow(8),
        main = '매출현황',
        ylab = '매출액',
        xlab = '년도별 분기')


barplot(chart.data,
        xlim = c(0, 600),
        col = rainbow(8),
        main = '매출현황',
        ylab = '매출액',
        xlab = '년도별 분기',
        horiz = TRUE)

# 연속변수
# 히스토그램 - hist()
# Sepal.length - 꽃받침 길이 시각화
iris
hist(iris$Sepal.Length,
     xlab = '꽃받침 길이',
     col = 'green',
     main = 'IRIS',
     xlim = c(4.0, 8.5))

# plot()
install.packages('mlbench')
library(mlbench)
data(Ozone)
raw.ozone <- Ozone

plot(raw.ozone$V8, raw.ozone$V9)
plot(raw.ozone$V8, raw.ozone$V9,
     xlab = 'Sandburg',
     ylab = 'El Monte',
     main = 'Ozone',
     pch = 2,           # 점의 모양
     cex = 0.5,          # 점의 크기
     col = 'red',         # 점의 색깔
     xlim = c(20, 100),    # 최소값 최대값
     ylim = c(20, 90))          

# V6풍속, V7 습도
# 겹쳐보이는 현상을 막기 위해서 jitter()
plot(jitter(raw.ozone$V6),
     jitter(raw.ozone$V7),
     xlab = '풍속',
     ylab = '습도',
     main = 'Ozone',
     pch = '*',           
     cex = 0.5,           
     col = 'red') 

# type: 그래프의 종류
raw.cars <- cars
plot(raw.cars, type = 'l')
plot(raw.cars, type = 'o')

# y = a + bx

plot(cars, xlim = c(0, 25))
abline(a = -5, b = 3.5,
       col = 'blue',
       lty = 2 )

# 수평선
abline( h = mean(raw.cars$dist),
        col = 'green')
# 수직선
abline(v=mean(raw.cars$speed),
       col = 'blue')

# points(): 기존 시각화에 점을 추가로 그려준다
plot(iris$Sepal.Width,
     iris$Sepal.Length,
     cex = .5,
     pch = '+',
     xlab = 'width',
     ylab = 'length',
     main = 'iris')

points(iris$Petal.Width,
       iris$Petal.Length,
       cex = 1.0,
       pch = '-',
       col = 'red')

# 범례
legend('topright',
       legend = c('Sepal', 'Petal'),
       pch = c('+', '-'),
       cex = .8,
       col = c('black', 'red'),
       bg = 'gray'
       )


# ggplot
# ggplot(), geom_xxxx(그래프, 도형), coord_xxxx(옵션)
# geom_point(그래프, 도형), geom_line(), geom_bar(), geom_histogram(), geom_box()


# ggplot() + geom_xxxx() + coord_xxxx()
# aes(x축, y축)
library(ggplot2)
g<- ggplot(data = iris,
           mapping = aes(x= Sepal.Length,
                         y= Sepal.Width)) +
      geom_point(col = c('red', 'blue', 'green')[iris$Species],
                 pch = c('+', '-', '*')[iris$Species],
                 size = c(1,1,1)[iris$Species])

# annotate()

# labs()
g + labs(title = '제목',
         subtitle = '부제목',
         caption = '주석',
         x= 'x축의 이름',
         y= 'y축의 이름')

tmp.frm <- data.frame(
  years = c(2016, 2017, 2018, 2019, 2020, 2021, 2022),
  gdp = c(300, 350, 400, 450, 500, 550, 600)
)

tmp.frm
ggplot(data = tmp.frm,
       aes(x= years,
           y= gdp)) +
  geom_point() +
  geom_line(linetype = 'dashed')

# 막대그래프 
# geom_bar: y축이 없음
library(MASS)
Cars93
ggplot(data = cars93,
       aes(x = Type)) +
  geom_bar(fill='red', col = 'black') +
  labs(title = '제목',
       subtitle = '부제목',
       caption = '주석',
       x = 'x축의 이름',
       y = 'y축의 이름')

# geom_col: x축 y축 가능
tmp.frm <- data.frame(
  movies = c('공조2', '오겜', '발신제한'),
  cnt = c(5, 11, 8)
)
ggplot(data = tmp.frm,
       aes(x=movies,
           y=cnt)) +
  geom_col(col='blue', fill ='red', width = .4)

# df sql 구현가능한 라이브러리
install.packages('sqldf')
library(sqldf)

cars.type.grp <- sqldf('select Type, count(*) as cnt
                        from Cars93
                        group by Type
                        order by Type')
ggplot(data = cars.type.grp,
       aes(x = Type,
           y = cnt)) +
  geom_col(col='blue', fill = 'red', width = .4)

# stat: geom_bar를 geom_col처럼 사용하는 법
ggplot(data = cars.type.grp,
       aes(x = Type,
           y = cnt)) +
  geom_bar(stat = 'identity',
           col='blue', fill = 'red', width = .4)

# Stacked Bar
class.num <- c(1,2,3,4,5,6)
class.m <- c(30,20,24,37,43,23)
class.f <- c(20,18,38,32,34,45)

class.frm <- data.frame(grade = class.num,
                        gender.m = class.m,
                        gender.f = class.f)


# 누적바 만들기
library(reshape2)
class.frm.melt <- melt(class.frm,
                       id = c('grade'))

ggplot(data = class.frm.melt,
       aes(x = grade,
           y = value,
           fill = variable)) +
  geom_bar(stat = 'identity',
           col='blue', 
           width = .4)

# multi bar
# position = dodge
ggplot(data = class.frm.melt,
       aes(x = grade,
           y = value,
           fill = variable)) +
  geom_bar(stat = 'identity',
           col='blue', 
           width = .4,
           position = 'dodge')

# Cars93 차종(Type)별 제조국(Origin) 자동차 수를 시각화?
View(Cars93)

ggplot(data = Cars93,
       aes(x = Type,
           fill = Origin)) +
  geom_bar(position = 'dodge') +
  ggtitle('multi bar')

# histogram(양적자료) vs bar(범주)
# 분포를 표현 / 가로 -> 자료의 넓이, 세로 -> 분포
hist(iris$Sepal.Width)
hist(iris$Sepal.Width, probability = T)

# geom_histogram()
# rnorm(): 정규분포 난수 발생
rnorm(200, mean =55, sd = 5)
rnorm(200, mean =65, sd = 5)

hist.frm <- data.frame(
  gender = factor(rep(c('F', 'M'), each = 200)),
  weight = c(rnorm(200, mean =55, sd = 5),
             rnorm(200, mean =65, sd = 5))
  )
hist.frm
#1)
ggplot(data = hist.frm,
       aes(x = weight, fill = gender)) +
  geom_histogram()
#2)
ggplot(data = hist.frm) +
  geom_histogram(aes(x = weight, fill = gender))

#수정
ggplot(data = hist.frm) +
  geom_histogram(aes(x = weight, fill = gender),
                 bins = 20,
                 binwidth = 5)


weather.frm <- read.csv(file.choose(), 
                        fileEncoding = 'euc-kr')

# 지역별 평균기온에 대한 히스토그램을 시각화?
ggplot(data = weather.frm) +
  geom_histogram(aes(x = 평균기온, fill = 지점),
                 bins = 30)

# 박스 그래프
# IQR(Inter Quartile Range)
# Q1 - 1.5*IQR: 아래쪽 펜서
# Q3 + 1.5*IQR: 위쪽 펜서

# 프레임 생성
weight01 <- c(56, 67, 42, 48, 55, 61, 52, 39, 47, 58,
              50, 40, 59, 62, 44, 57, 128)
weight02 <- c(78, 34, 37, 72, 58, 68, 27, 55, 65, 40,
              75, 33, 66, 116)
data01 <- data.frame(weight = weight01, num = as.factor(rep(1,17)))
data01

data02 <- data.frame(weight = weight02, num = as.factor(rep(2,14)))
data02

bind.frm <- rbind(data01, data02)
bind.frm

ggplot(data = bind.frm) +
  geom_boxplot(aes(x=num,
                   y=weight),
               outlier.color = 'red')
summary(weight01)

# coord_flip: 가로 세로 바꿈
ggplot(data = bind.frm) +
  geom_boxplot(aes(x=num,
                   y=weight),
               outlier.color = 'red') +
  coord_flip()


ggplot(data = bind.frm,
       aes(x=num,
           y=weight) ) +
  geom_boxplot(ouglier.color = 'red',
               outlier.shape = 24) +
  geom_dotplot(binaxis = 'y',
               stackdir = 'center',
               dotsize = .5,
               )

# word cloud
# 핵심단어를 시각화
install.packages('wordcloud2')
library(wordcloud2)

raw.wc <- demoFreq
str(raw.wc)

wordcloud2(raw.wc,
           color = 'random-light',
           backgroundColor = 'black')

# html, pdf, png
install.packages('webshot')
install.packages('htmlwidgets')
library(webshot)
library(htmlwidgets)

my.cloud <- wordcloud2(raw.wc,
                       color = 'random-light',
                       backgroundColor = 'black')
# html 저장
saveWidget(my.cloud, 'tmp.html',
           selfcontained = FALSE)
# png
webshot::install_phantomjs()
webshot('tmp.html',
        'tmp.png',
        vwidth = 480,
        vheight = 480)



