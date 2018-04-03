install.packages("readxl")            # 엑셀을 불러오기 위한 패키지
library(readxl)
student <- read_excel("빈도분석.xls")
path = "C:\Users\No.1\Desktop\source"
setwd("C:/Users/No.1/Desktop/source")
getwd()

setwd("C:/dev/r_workspace/source")        #   \ 대신 /로 처리

student

attach(student)
detach(student)
install.packages("descr")       # 도수분포표 사용을 위한 패키지
library(descr)                  # 사용을 위해 라이브러리 등록

freq(성별,plot=FALSE)
freq(성별,plot=TRUE)
freq(대학,plot=FALSE)
freq(대학)
pie(대학)

attach(trees)           # 밑에 항목이 나올 때까지 쳐야함.
hist(Volume)        # 40 ~ 50 빈도수가 낮음
stem(Volume)        # 트리구조
mean(Volume)
median(Volume)
hist(Volume)
x <- table(Volume)
x
names(which.max(x))       # 최빈값을 가져오는 것.

평균 : 30.17097
중앙값 : 24.2

summary(Volume)           #   요약자료
                          # 최소값 / 4분위값 / 중간값 / 평균값 / 최대값

var(x)

# 3.4 산포도 관련 예제문제        
score <- c(10,40,70,85,85,100)
score

mean(score)
median(score)
which.max(score)
summary(score)
                  

setwd("C:/dev/r_workspace/source1/준비파일")
student1 <- read_excel("3장_신장.xlsx")

student1

summary(student1)
