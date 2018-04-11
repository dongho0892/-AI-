install.packages("zoo")
library(zoo)

?decompose # 가법모형 / 승법모형 중 어떤 것을 쓸지 표시해줌
# 가법모형 :   Y[t] = T[t] + S[t] + e[t]
# 승법모형 :   Y[t] = T[t] * S[t] * e[t]


require(graphics)
m <- decompose(co2)  # co2 내장자료를 분해함.
m$figure  
plot(m)
# 1. 관측된 그래프
# 2. 추세 = 증가
# 3. 계절요인 = 규칙성 O
# 4. 임의로 변동하는 부분 = 오차부분 / 규칙성 X

# 애플의 조정된 주식종가 자료 - 배당, 감자 등 이벤트를 반영한 종가

getwd()
setwd("C:/dev/r_workspace/source/0933OS_Code/Chapter 1")
library(readxl)                                           # Y만 대문자 
aapl <- read.zoo("aapl.csv", sep = ",", header = TRUE, format="%Y-%m-%d")
  
plot(aapl, main = "APPLE Closing Prices on NASDAQ", ylab = "Pricie(USE)", xlab = "Date")
         #제목                                          #Y축 명               # X축 명  

head(aapl) #2000년 1월 부터 
tail(aapl) #2013년 4월 말까지의 자료
aapl[which.max(aapl)]  # 최고가의 인덱스(날짜)
aapl[which.min(aapl)]  # 최저가의 인덱스(날짜)

