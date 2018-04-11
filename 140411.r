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


head(aapl)
head(lag(aapl,k=-1))
head(log(aapl))
?diff # 차이를 계산 해주는 것 lagged (특정 기의 차이)
ret_simple <- diff(aapl)/ lag(aapl,k=-1) * 100
ret_cont <- diff(log(aapl))*100   # diff 디폴트 값으로 1기의 차이를 나타남.
   # log 안의 값은 나누면 성질상 빼기로 나누어서 표현이 가능함.
head(ret_simple)
head(ret_cont)
plot(ret_simple)
plot(ret_cont)

?coredata # 보고 싶은 것을 추려낼 수 있음.
summary(coredata(ret_simple))
summary(ret_simple)

summary(coredata(ret_simple))

ret_simple[which.min(ret_simple)]

?hist # breaks = 데이터를 100으로 나눈다. 
      # https://thebook.io/006723/ch06/08/02/
hist(ret_simple, breaks = 100, main = "Histogram of Simple returns", xlab="%")
 # 일별 수익률이라 0% 수익률이 날 때가 많았다. 

?window  # 2013년도의 주가가 얼마가 되는가?
aapl_2013 <- window(aapl, start ='2013-01-01', end='2013-12-31')
aapl_2013
head(aapl_2013)
tail(aapl_2013)

aapl_2013[which.max(aapl_2013)]

# Value-at_Risk - 일정기간 동안 발생할 수 있는 최대 손실금액
quantile(ret_simple, probs=0.01)

?quantile  # random variable X의 분포를 확률적으로 균등하게 (q개로) 자른 개념


install.packages("forecast")
library(forecast)

hp <- read.zoo("UKHP.csv", sep=",", header=TRUE, format="%Y-%m", FUN=as.yearmon)
getwd()
hp
frequency((hp))

hp_ret <- diff(hp) / lag(hp,k=-1)*100
mod <- auto.arima(hp_ret, stationary= TRUE, seasonal = FALSE, ic="aic")
      # 수익률 자료         정상성 = 참 /     계절성은 없다.  / 정보기준 AIC를 사용하겠다.
mod
# AR 모형 앞에만 숫자가 있음.
# ARIMA(2,0,0) with non-zero mean => 함수가 AR2 모형이 적합하다고 판단함.
# ar1 시차가 1개의 차이 계수 = 0.229  / 표준오차 0.0573
# ar2 시차가 2개의 차이 계수 = 0.3491 / 표준오차 = 0.0573
# 시그마제곱 = 오차의 제곱 / AIC 값이 두개를 넣었을 때 낮은 값이므로 적합하다.

confint(mod)

# 신뢰구간 확인 => 95%신뢰수준 기준... 계수 비교.
# Coefficients: 계수

tsdiag(mod)

# 모델의 샘플데이터 설명
plot(mod$x, lty=1, main ="UK house prices : raw data vs. fitted values",
     ylab="Return in percent", xlab="Date")
lines(fitted(mod), lty=2, lwd=2, col="red")


?fitted
# 모델의 정확도 확인
accuracy(mod)

# 궁극적으로 할 것  =  예측 !!

predict(mod, n.ahead=3)
plot(forecast(mod))


# 공적분
# 최적헤지비율

install.packages("urca")
library(urca)

prices <- read.zoo("JetFuelHedging.csv", sep=",", FUN=as.yearmon, format="%Y-%m", header=TRUE)

simple_mod <- lm(diff(prices$JetFuel) ~ diff(prices$HeatingOil)+0)
summary(simple_mod)


# 난방유가 변할 때 연료유가 변함. 0.89059

plot(prices$JetFuel, main ="Jet Fuel and Heating Oil Prices", xlab="Date", ylab="USD")
lines(prices$HeatingOil, col = "red")
#

#비정상성 검정 : 단위근 검정 - dickey-fuller

jf_adf <- ur.df(prices$JetFuel, type="drift")
summary(jf_adf)
# 결과  -1.1335 / 
# tau2 -3.46과 비교, 더 작게 나옴 => 단위근검정에서 봤을 때 => 귀무가설 기각 못함 -> 단위근을 가진다.
#귀무가설 = 단위근이 1인 경우
#대립가설 = 단위근이 1보다 작은 경우

?ur.df      #       아무것도 없는 것 /상수항 /  추세가 있는 것
ur.df(y, type = c("none", "drift", "trend"), lags = 1,  # 시차가 1 있는것
      selectlags = c("Fixed", "AIC", "BIC")) 

ho_adf  <- ur.df(prices$HeatingOil, type="drift")
summary(ho_adf)

# 정태적 균형 모델 추정 및 잔차 정상성 검정
mod_static <- summary(lm(prices$JetFuel ~ prices$HeatingOil))
mod_static
error <- residuals(mod_static) # 잔차의 모임
error_cadf <- ur.df(error, type="none")
summary(error_cadf)   # 타우값 < 검정통계량
#residuals 잔차


djf <- diff(prices$JetFuel)    
dho <- diff(prices$HeatingOil)   
error_lag <- lag(error, k=-1) # 에러에 
mod_ecm <- lm(djf ~ dho + error_lag + 0 ) # 절편이 0, 
summary(mod_ecm)



library("zoo")
intc <- read.zoo("intc.csv", header=TRUE, sep=",", format="%Y-%m", FUN=as.yearmon)
intc

plot(intc, main = "Monthly returns of Intel Corporation", xlab="Date", ylab="Return in percent")

box.test(coredata(intc^2), type="Ljung-Box", lag=12)

install.packages("rugarch")
library(rugarch)
?ugarchspec  #
?ugarchfit   #
intc_garch11_spec <- ugarchspec(variance.model =
                                  list(garchOrder =c(1,1)), #garch 1,1 모형을 사용하겠다. 
                                       mean.model=list(armaOrder = c(0,0)))
intc_garch11_spec
intc_garch11_fit <- ugarchfit(spec = intc_garch11_spec, data=intc)
                                
intc_garch11_fit


intc_garch11_roll <- ugarchroll(intc_garch11_spec, intc, n.start = 120, refit.window = "moving", refit.every = 1, solver = "hybrid", calculate.VaR =TRUE, VaR.alpha=0.01, keep.coef=TRUE)



