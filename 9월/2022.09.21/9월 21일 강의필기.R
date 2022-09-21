# 9/21
# 데이터 수집(크롤링)

# https://movie.naver.com/movie/point/af/list.naver?&page=1
# 영화제목(.movie), 영화 평점(.point_type_1 fl), 영화 리뷰

# rvest: html_nodes(), html_node(), html_text(), html_attrs()

install.packages('rvest')
library(rvest)
url <- 'https://movie.naver.com/movie/point/af/list.naver?&page=1'
url

movie.title <- NULL
html <- read_html(url)
html

movie.nodes <- html_nodes(html, '.movie')
movie.nodes

movie.title <- html_text(movie.nodes)
movie.title

# 평점 movie.point
movie.point.nodes <- html_nodes(html, '.list_netizen_score > em')
movie.point.nodes

movie.point <- html_text(movie.point.nodes)
movie.point

# 영화 리뷰
movie.review.nodes <- html_nodes(html, '.title')
movie.review.nodes

movie.review <- html_text(movie.review.nodes, trim = TRUE)

movie.review <- gsub('\t', '', movie.review)
movie.review
movie.review <- gsub('\n', '', movie.review)
movie.review
movie.review <- gsub('신고', '', movie.review)
movie.review

# data.frame
title.point <- cbind(movie.title, movie.point)
title.point.review <- cbind(title.point, movie.review)
title.point.review

movie.frm <- as.data.frame(title.point.review)

# 파일 저장
write.csv(movie.frm, 'movie_reviews.csv', fileEncoding = 'euc-kr')

movies <- read.csv(file.choose())

View(movies)
movies <- movies[c('movie.title', 'movie.point', 'movie.review')]

# page 1~10
# paste(), paste0()

page_url <- 'https://movie.naver.com/movie/point/af/list.naver?&page='
for(page in 1:10) {
  print(paste(page_url, page, sep=''))  #-- 공백을 같이 가져와서 sep 옵션 사용
}

page_url <- 'https://movie.naver.com/movie/point/af/list.naver?&page='
for(page in 1:10) {
  print(paste0(page_url, page))         #-- page= 다음에 공백을 빼고 가져옴
}

movie.frm02 <- NULL
for(page in 1:10) {
  print(paste(page_url, page, sep=''))
  url <- paste0(page_url, page)
  print(url)
  
  html <- read_html(url)
  movie.title <- html_text(html_nodes(html, '.movie'))
  print(movie.title)
  
  movie.point.nodes <- html_nodes(html, '.list_netizen_score > em')
  movie.point <- html_text(movie.point.nodes)
  print(movie.point)
  
  tmp <- cbind(movie.title, movie.point)
  movie.frm02 <- rbind(movie.frm02, tmp)
}

write.csv(movie.frm02, 'movie_reviews02.csv')

View(movie.frm02)


# html: <a href='link'>txt</a>
# 태그 속성의 value 를 가져와야 한다면?
# html_attr()
# ul (unorder list) - li(list)
# ol (order list) - li(list)

install.packages('httr')
library(httr)

url <- GET('https://news.naver.com/main/main.naver?mode=LSD&mid=shm&sid1=100')
html <- read_html(url)

a.links <- html_nodes(html, 'div.cluster_text > a')
a.links

headline.article.links <- html_attr(a.links, 'href')
headline.article.links

# 이미지(jpg)
html <- read_html('http://unico2013.dothome.co.kr/productlog.html')
html

imgs = html_nodes(html, 'img')
imgs

img.src <- html_nodes(html, 'img') %>%
            html_attr('src')
img.src

for(idx in 1:length(img.src)) {
  response <- GET(paste0('http://unico2013.dothome.co.kr/', img.src[idx]))
  writeBin(content(response, 'raw'), paste0('c:/imgs/', img.src[idx]))
}


# ggmap
install.packages('devtools')
library(devtools)
install_github('dkahle/ggmap')
library(ggmap)

aip.key = "AIzaSyD0c5StKevyov8tB60LCxIZLi1HH3CvcUE"
register_google(aip.key)
gg_seoul <- get_googlemap('seoul' , maptype = 'terrain')

ggmap(gg_seoul)


# 

geo_code <- enc2utf8('서울 강서구 곰달래로53길 41 1층 102호(화곡동, 재룡빌딩)') %>% geocode()
geo_data <- as.numeric(geo_code)
geo_data 

get_googlemap(center = geo_data , 
              maptype = 'roadmap' , 
              zoom = 13) %>% ggmap() +
  geom_point(data = geo_code,
             aes(x = geo_data[1] , y = geo_data[2]))




# 로또 1등 배출점 크롤링 및 지도 시각화
url <- 'https://dhlottery.co.kr/store.do?method=topStore&pageGubun=L645'

html <- read_html(url, encoding = 'cp949')

# node working

html %>%
  html_nodes('body') %>%                    #-- 태그선택자  
  html_nodes('.containerWrap') %>%          #-- 클래스선택자
  html_nodes('.contentSection') %>%
  html_nodes('#article')                    #-- 아이디선택자

html %>%
  html_nodes('#article')                    # 혹은 바로 아티클로



html %>%
  html_nodes('body') %>%
  html_nodes('.containerWrap')  %>%
  html_nodes('.contentSection') %>%
  html_nodes('#article') %>%
  html_nodes('.content_wrap') %>% 
  html_nodes('.group_content') %>% 
  html_nodes('.tbl_data') %>%
  html_nodes('tbody') %>% 
  html_nodes('tr')




















