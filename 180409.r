# 분산분석의 내용

library(readxl)
library(descr)
library(ggplot2)

getwd()
setwd("C:/dev/r_workspace/source1/준비파일")
read_excel("낚시터.xlsx")

anova <- read_excel("낚시터.xlsx")
group <- as.character(anova$낚시터)

boxplot(anova$물고기~ group)
?bartlett.test
(anova$물고기~ group)
bartlett.test(anova$물고기~ group) # 귀무가설 기각 불가능

with(anova, tapply(물고기, group, mean))   # 평균
with(anova, tapply(물고기, group, sd))     # 표준편차 

?lm         #물고기 = 종속변수 / group 독립변수의 위치
outl=lm(anova$물고기~ group)
outl                                   # A낚시터와의 차이를 보여줌.

summary(outl)

?aov

out2=aov(anova$물고기~ group)
summary(out2)


?anova
out3

TukeyHSD(out2)           # p adj : 조정된 p 값, 



# 이원분산분석
setwd("C:/dev/r_workspace/source")
anova2 <- read_excel("이원분산분석.xls")
anova2

group1 <- as.character(anova2$흡연석여부)
group2 <- as.character(anova2$위치
                       )
boxplot(anova2$매출액 ~ group1)
boxplot(anova2$매출액 ~ group2)
with(anova, tapply(anova2$매출액, group1, mean))
with(anova, tapply(anova2$매출액, group2, mean))

out1=aov(anova2$매출액~ group1 + group2 + group1*group2)
anova(out1)

out2=aov(anova2$매출액~ group1 + group2)
anova(out2)

anova(out2)
TukeyHSD(out1)


# 연관성 분석 -- 각 변수가 지금 연관되어 있는지 확인해보는 것

# 피어슨, 교차분석, 

# 상관분석 - 특정 변수가 증가했을때, 다른 변수가 어떻게 변화하는가?
#      산포도
#      공분산 + 상관계수

# 상관분석
# 산점도                           #모양          #점의 모양
plot(dist ~ speed, data = cars, type = "p", pch = 20, col="blue", cex=2)
         # 속도와 제동거리
#공분산
cov(cars$dist, cars$speed)
#상관계수
cor (cars$dist, cars$speed)
#상관계수 검정                                                    (기본)  (캔,스 = 서열,순위에 대해서)                     
?cor.test   # 두 변수가 들어감 / 양측검정,  단측검정 2가지 나옴 / 피어슨, 캔달,스피어만 3가지 가 있음.


cor.test(~dist+speed, data=cars, method = c("pearson"))
# t값 /  p값. 굉장히 작게 나옴 = 두값이 관계가 있다. / 귀무가설 = 0이다 = 둘이 아무 관계가 없다. 는 것을 기각함.
# 신뢰구간 0.68 ~ 0.88  /  


#ex)

ad <- read_excel("단순 회귀분석.xls")
ad
plot(매출액 ~ 광고비, data = ad, type ="p", pch = 20, col = "blue", cex=2)
cov(ad$매출액, ad$광고비)  
cor(ad$매출액, ad$광고비)   # 1에 가까우니, 양의 관계가 있다고 볼 수 있고
cor.test(~매출액+광고비, data=ad, method = c("pearson"))
#p값이 매우 작게 나와서 귀무가설인 상관계수가 0이다 라는 주장을 기각한다.

#교차분석 (연관성 분석의 일부)
vacation <- c(68,32)     # 산과 바다 중 관측된 빈도
prob <- c(0.5, 0.5)      # 선호도를 반반으로 봄.
?chisq.test
chisq.test(vacation, p=prob) # 빈도와 확률을 넣어서 검증함.

# 카이제곱 값 12.96 ,  p 값 0.05보다 작음. => 선호도가 다르게 나온 것으로 볼 수 있다.
# 귀무가설 : 휴가계획 선호도가 바다와 산으로 가는 비율이 같을 것이다. => p값이 낮아서 기각.
# 카이제곱 값 : 채택역과 기각역,  통계량 기준값이 3.84인데, 12,84가 나와서 기각역안에 들어옴.
# 카이제곱값을 바탕으로 기각역을 판단하는데는 어려움이 있으므로, p값으로 판단함.

#(적합성 분석)
# 예제 - 멘델의 유전법칙 관련 내용

# 귀무가설 : 멘델의 유전법칙이 성립한다.
bean <- c(315, 101, 108, 32)
#prob <- c(9/16, 3/16, 3/16, 1/16)
prob <- c(9, 3, 3, 1)/16
chisq.test(bean, p=prob)      # p값이 기각역에 있지 않다 = 귀무가설 채택

#(독립성 분석)  - 여러가지 범주로 검정을 하게 됨. 구매지역, 구매의사 
자유도 : (행-1)*(열-1)

purchasing <- read_excel("교차_카이제곱.xls")
?xtabs
purchasing  # 외관, 편의성, 유용성의 종류에 따른 만족감 분석  / 학력 구매의사 등등..
  # 구매의사와 지역간의 독립성이 있는가 판단
xtabs  # 교차표를 만들어주기 위해서 씀 

purchasing.table <- xtabs(~구매의사+지역, data=purchasing)
purchasing.table
chisq.test(purchasing.table) # 자유도 (2-1)(2-1) = 1


# 귀무가설 : 구매의사와 지역간에 서로 독립적이다  => 기각 : 서로 연관이 있다. 대립가설 채택

# 회귀분석 : 인과관계를 나타내어주는 것 -> 종속변수를 예측하기 위해서 / 
#   독립변수 : 설명하거나, 원인이 되어 다른 변수에 영향을 주는 변수 
#   종속변수 : 다른 변수로부터 영향을 받는 변수

#   잔차 : residual = 오차, 편차, 잔차 / 특정한 패턴(규칙)이 없음. / 
#   표본에서 모수(베타0,1) 찾기 / 최소자승(제곱)법 - 오차의 제곱합이 최소가 되는 것
                                # 최대우도법 - 어떤 하나의 함수가 최대한 모수를 갖는 함수로 접근하도록 하는 법
#   가우스.마트코프 정리 : 잔차의 평균이 0이 되는 것                  | 
#                        / 잔차의 공분산 = 0 (잔차끼리 관계가 없는 것)| 
#                        / 잔차의 분산이 모분산(고정) / 정규분포를 따른다   |  => 최소자승법으로 쓰는게 좋다.
#                         => BLUE 이다.


# 추정한 회귀식이 적합한가? 판단하기                         

#    총편차 : 설명되지 않는 편차 + 설명되는 편차
#  총제곱합(SST) : 오차 제곱합 (SSE) + 회귀 제곱합 (SSR)

#  결정계수(R^2) = SSR/SST = 1-(SSE/SST) / 설명비율이 높을 수록 1이 됨.
#                  SSE가 0에 가까울 수록 설명력이 높아짐.

# 분산분석 : 총편차를 분해하는 과정이 분산분석과 동일
#    SST의 자유도 : 
#    SSR 
#    SSE 
#    평균오차제곱(MSE) / 평균회귀제곱(MSR)
#    분산비율 F = MSR/MSE   => 표준오차보다 회귀식으로 설명되는 부분이 어느정도 더 많은지 나타내는 수치

# 회귀식이 유의한가?
# 가설수립 : 귀무가설 = 회귀식이 유의하지 않다.
#          : 대립가설 = 회귀식이 유의하다.      (증명하고 싶은 걸 이 곳에)

# 회귀분석식 추정  
ad <- read_excel("단순 회귀분석.xls")
ad
?plot
plot(ad$매출액~ad$광고비, data = ad, type = "p", pch=20, col="blue", cex=2)
reg <- lm(ad$매출액~ad$광고비)   # 최적선 구하기.
  #Intercept가 y절편, 뒤의 ad$광고비가 추정된 B1
?lm
summary(reg)
confint(reg)  # 베타0,1의 신뢰구간의 범위  

# 예제

getwd()
kind <- read_excel("친절도_재구매.xlsx")
?plot
       # 종속변수 ~ 독립변수
plot(kind$재구매 ~ kind$친절도, data=kind, type="p", pch=20, col="red", cex=2)
reg1 <-lm(kind$재구매~kind$친절도)
abline(reg1, lwd=2, col="red")

reg1 #  => 각 계수의 값 확인
summary(reg1)
# 잔차관련 : 잔차의 하한 ~ 상

# b0, b1 이 유의한가? 표준오차 / t값 / p값(유의값) - b0 은 신뢰구간 밖에 위치
# R스퀘어 : 설명해줄 수 있는 정도 30% 정도 설명해준다.
# Estimate Std           # t값. p값
confint(reg1)



#잔차의 독립성 2 근처면 독립, 1.4보다 작으면 양의 상관
?durbinWatsonTest
library(car)

res = residuals(reg)   # 잔차를 구해주는 함수

par(mfrow=c(2,2))# 위 아래 각각 2개씩 나오도록
plot(reg)
par(mfrow=c(1,1))

#정규성 - 
?shapiro.test
shapiro.test(res)

#산점도와 회귀직선                진하게
plot(ad$매출액~ad$광고비, cex=1, lwd=1 )
abline(reg, lwd=2, col="red")
?abline    # 선 긋기 / 



kind <- read_excel("친절도_재구매.xlsx")
?plot
# 종속변수 ~ 독립변수
plot(kind$재구매 ~ kind$친절도, data=kind, type="p", pch=20, col="red", cex=2)
reg1 <-lm(kind$재구매~kind$친절도)
res1 = residuals(reg1)   # 잔차를 구해주는 함수
summary(reg1)
summary(res1)

shapiro.test(res1)
plot(kind$재구매~kind$친절도, cex=1, lwd=1 )


#  [ 최소제곱법을 사용해서 값이 유의한지 아닌지 확인해봤음 ]


# 다중회귀분석
# 독립변수의 갯수가 여러개 중 종속변수에 어떠한 영향을 미치는지 분석.
# 적합도 검정 - 수정된 R^2
# 분산분석

# 추정된 회귀식에서 회귀계수 베타1추정치 검정

# 귀무가설 : 베타0,1 = 0   - 의미가 없는 값이다.
# 대립가설 : 베타0,1 = 0이 아니다.

#추정된 회귀식의 유의성 검정   - t_통계량

# 귀무가설 : 회귀식이 유의하지 않다.
# 대립가설 : 회귀식이 유의하다.    

phone <-read_excel("다중 회귀분석_요인저장_변수 계산.xls")
#           종속변수 ~ 독립변 
reg1=lm(phone$만족감 ~ phone$외관 + phone$유용성 + phone$편의성)
reg1   
summary(reg1)
# p-값 - 다 유의함
# 회귀식 판단 - 수정된 R값 - 22.9% 정도 설명해줌.
#             - 분산분석을 통해 이 값이 유의한가? -> f값 => p값 기각역에 위치 => 유의하다.
confint(reg1) # 신뢰구간 분석


# 다중공선성 : 서로 상관관계가 높아서 분산값이 높아짐! -> 신뢰도가 떨어짐.

par(mfrow=c(2,2))
plot(reg1)
shapiro.test(res1)
res1 = residuals(reg1)

####################################################

library(readxl)
library(ggplot2)
library(descr)
setwd("C:/dev/r_workspace/source")
b <- read_excel("친절도_재구매2.xlsx")

#엑셀파일을 불러온다.
reg1=lm(b$재구매 ~ b$친절도 + b$사은품) 
# 종속변수 : 재구매 / 독립변수 : 친절도, 사은
?lm
# lm 함수를 이용해서 선형모델로 만들어준 뒤, 각 독립변수의 계수를 표시해줌.
reg1    # 회귀분석의 결과 : y절편, 친절도, 사은품
summary(reg1)  # 잔차의 내용 / 각각의 값이 유의하            


plot(reg1)     # normal Q-Q  
par(mfrow=c(2,2)) 

res1 = residuals(reg1)
shapiro.test(res1)
summary(res1)
confint(reg1)

shapiro.test(res1)


#  
install.packages("lmtest")
library(lmtest)
install.packages("car")
library(car)
res1 = residuals(reg1)   # 잔차들의 값을 계산해줌.

# 최소제곱법을 사용함.
# 잔차의 평균이 0, 공분산 0, 잔차의 분산이 변하지 않음, 정규분포를 따름


durbinWatsonTest(res1)   # 잔차가 독립되어 있는가?
# 주식 자료 / 시계열분석 어제와 오늘의 나는 연결이 되어있다. -> 독립성여부 판단.
# 귀무가설 : 잔차가 독립성을 가진다 / 대립가설 : 양의 상관관계를 가진다.
# = > 2 근처면 독립, 1.4보다 작으면 양의 상관 / 보기 좋은 값은 아님 1.333 애매하다.  

# 다중공선성 - 다중회귀분석에서 쓰임
#           - 그 둘의 관계가 상관관계가 크므로, 두개 다 넣으면, 분산값이 커져서, 그 전에 그 둘의 다중공성성을 확인해야됨.

?vif
vif=vif(reg1)
vif

 # b$친절도 b$사은품 
 # 1.115853 1.115853    => 10보다 작으면 다중공선성이 없다고 볼 수 있음. => 다중회귀에서 그대로 써도 된다. 
 # / 10을 넘어가면 다른 값으로 바꿔 줘야함.


 