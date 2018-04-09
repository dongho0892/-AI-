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
chisq.test(purchasing.table)