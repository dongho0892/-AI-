install.packages("readxl")            # 엑셀을 불러오기 위한 패키지
library(readxl)
getwd()
student <- read_excel("빈도분석.xls")

setwd("C:/dev/r_workspace/source")        #   \ 대신 /로 처리

student

attach(student)                 # R 상에서 등록, 변수이름 바로 접근 가능
detach(student)
install.packages("descr")       # 도수분포표 사용을 위한 패키지
library(descr)                  # 사용을 위해 라이브러리 등록

attach(trees)           # 밑에 항목이 나올 때까지 쳐야함.

summary(Volume)
range(Volume)
diff(range(Volume))
IQR(Volume)

install.packages("psych")
library("psych")
  

describe(Volume)  # 
boxplot(Volume)   # 

i <- c(300, 150, 0, -100)
A <- c(0.58, 0.87, 0.55, 0.05)
B <- c(0.65, 0.51, 0.45, 0.05)

ma = sum(i*A)
mb = sum(i*B)

ma
mb

vara = sum(A*(i-ma)^2)
varb = sum(B*(i-mb)^2)



예제

E(x) = 시그마x*P(x)


hungi <- c(100, 200, 300)    #침체 / 유지 / 상승 별 수익
bonguk <- c(200, 400, 800)

hunper <- c(0.3, 0.4, 0.5)   #                  확률
bonper <- c(0.2, 0.4, 0.6)   # 

per <- c(0.7, 0.5, 0.2)

ehun = sum(hungi*hunper*per)
ebon = sum(bonguk*bonper*per)

ehun
ebon
        # var1 = sum(per*(r1*p1-m1)^2)
varhun = sum(per*(hungi*hunper-ehun)^2)   #시그마{(x-E(x))^2*P(x)}
varbon = sum(per*(bonguk*bonper-ebon)^2)

varhun  
varbon    # 수익차이가 크므로, 변동성이 더 큼...

?pnorm

    #  x, 평균, 표준편차
pnorm(4, 5.4, sqrt(1.5))
    # 확률, 평균, 표준편차
qnorm(.1, 5.4, sqrt(1.5)) # 10% 이내인 구하기
qnorm(.5, 5.4, sqrt(1.5)) # 10% 이내인 구하기

i <- 0.5*0.01+ 0.3*0.02 + 0.2*0.03
a <- 0.5*0.01


result <- a/i
result


dbinom(3,10,0.5)
pbinom(6,10,0.5)
x <- pbinom(6,10,0.5)

x <- dbinom(5, 100,0.05)
x

y <- dpois(5, 5)
y