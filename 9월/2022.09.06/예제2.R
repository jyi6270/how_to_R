1.
x <- c(2,3,5,6,7,10)
x

2.
x2 <- x^2
x2

3.
sum(x2)

4.
x2 -2

5.
max(x)
min(x)

6.
xx <- x>5
x_up <- x[xx]
x_up

7. 
length(x)


install.packages("UsingR")
library(UsingR)

data("primes")  # primes 데이터 셋을 불러옵니다.
head(primes)    # 처음 6개만 출력

8.
length(primes)

9. 
pp_200 <- primes <= 200
primes[pp_200]
length(primes[pp_200])

10.
mean(primes)

11.
pp_1000 <- primes >= 1000
primes[pp_1000]
length(primes[pp_1000])

12.
ppp <- primes >= 500 & primes <=1000
pp <- primes[ppp]
pp

13.
mysum <- function(x){
  result <- sum(x)
  return(result)
}

14.
x <- matrix(1:12, ncol=3, nrow=4)
x

15.
xt = t(x)
xt

16. 
xr1 <- x[1,]
xr1

17.
xc3 <- x[,3]
xc3

18.
xs <- x[2:3, 2:3]
xs

19.
x2 <- x[,2]%%2==1
x2
xs2 <- x[x2,]

20.
apply(x, 1, mean)

21
apply(x, 2, mean)


install.packages("https://cran.r-project.org/src/contrib/Archive/DMwR/DMwR_0.4.1.tar.gz", 
                 
                 repos = NULL, 
                 
                 type="source")

install.packages("DMwR2")

library(DMwR2)

data(algae)

22.
NA_NH4 <- sum(is.na(algae$NH4))

23.
mean(algae$NH4, na.rm=TRUE)











