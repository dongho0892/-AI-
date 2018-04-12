  
myfactorial <- function(x) {  
  fact <- 1
  i <- x
  while (i>1) {
    fact <- fact*i
    i <- i-1
  }
  return(fact)
}
myfactorial(3)  

#분산효과 각자산 표준편차가 0.2, 0.3 인 경우

div <- seq(-0.2, 1.2, length=100)
rhos <- c(-1, -0.5, 0, 0.5, 1)  # 5가지의 경우로 상관관계를 표시함
out <- matrix(0, nrow=100, ncol=5)  # 행이 100개, 열이 5개 메트릭스 형성
for(i in 1:5) {  # i 1~5
out[,i]  <- sapply(div, function(a) {#함수를 만들어줌, 
  rho <- rhos[i]
  ans <- a^2*0.2^2 + (1-a)^2*0.3^2+2*a*(1-a)*rho*0.2*0.3 # 공식을 넣어줌. 
        # 보고 싶어 하는게 포토폴리오 분산
  return(ans)
})
}       
matplot(div, out, type='l')
nms <- c('rho=-1', 'rho=-0.5', 'rho=0', 'rho=0.5', 'rho=-1')  # 그래프 표시 
legend("topright", legend=nms, lty=1:5, col=1:5, bty="n")   # 범주 보여줌 
?legend                      # 1~5까지 표시되게끔 해주는 것   


head(letters, -1)    # -1 = 마지막에 있는 하나를 빼줌
tail(letters, -1)    # -1 = 맨 처음에 있는 하나를 빼줌


-------------------------------------------------------
  
  
# 포트폴리오 최적화 - 라그랑지 구현

minvariance <- function(assets, my = 0.005) {
  return <- log(tail(assets, -1) / head(assets, -1)) # 로그수익률 자료
               # 현재가격 / 어제 가격 .   마지막 날거는 필요 없음.
    Q <- rbind(cov(return,use="complete.obs"), rep(1, ncol(assets)), colMeans(return,na.rm=TRUE))
       # Q 1 r 을 만들어줌.
       # 
    Q <- cbind(Q, rbind(t(tail(Q,2)), matrix(0,2,2)))  # rbind로 묶어주고, cbind로 열로 묶어줌
              # t(바꿔줌)  # Q에서 아래 2가지(1,r)을 가져옴. 
              # 0000 4개를 만들어줘야되서 matrix에 채워줌 
    B <- c(rep(0,ncol(assets)), 1, mu)
         # 자산의 수 만큼 만들어줌. 벡터로 만들어줌
 solve(Q,b)
}
?solve

-------------------------------------------------------
  
install.packages("Quandl")
library(Quandl)
IT <- Quandl('DAROCZI/IT', start_Date = '2014-04-01', end_date='2016-02-19')
?Quandl
str(IT)   #시계열 자료
head(IT)
head(return)

# 내가 산 가격과 지금 현재 가격

#자산의 수익률
assets <- IT[,-1]
return <- log(tail(assets,-1) / head(assets, -1))

head(return)
?rep
cov(return)

Q <- rbind(cov(return), rep(1, ncol(assets)), colMeans(return))
round(Q,5)

# 맨 아래쪽 평균수익률 / 1이 자산의 갯수만큼 들어가있음 / 
# 대각선 각 자료별 공분산 자료 
# NA 오류...!!  => 자료 중에서 NA가 있는 듯
                        # complete.obs넣으면 NA값 제외
Q <- rbind(cov(return, use="complete.obs"), rep(1, ncol(assets)),
           colMeans(return,na.rm=TRUE))
                        # colMeans에 na.rm은 NA 빼고 계산.   
round(Q,5)    

Q <- cbind(Q, rbind(t(tail(Q,2)), matrix(0,2,2)))
round(Q,5)

#우측에 1과 다른 값이 들어가 있는 것을 확인 할 수 있음.

mu <- 0.005            # 초기값 ,기대값이 0.005로 우선 넣어줌.
b <- c(rep(0,ncol(assets)), 1, mu)
b           #자산의 수 만큼 들어가고, 1, 수익률을 넣어줌 
    # 0,1 뮤

solve(Q,b) # 이상적인 기대수익률과 최소 분산을 갖는 결과값 도출 가능 

-------------------------------------------------------
minvariance(IT[,-1])


# 포토폴리오 투자선

frontier <- function(assets) {
  return <- log(tail(assets, -1) / head(assets,-1))
  Q <- cov(return)
  n <- ncol(assets)
  r <- colMeans(return)
  Q1 <- rbind(Q, rep(1,n),r)
  Q1 <- cbind(Q1, rbind(t(tail(Q1,2)), matrix(0,2,2)))
  rbase <- seq(min(r), max(r), length=100)
  s <- sapply(rbase, function(x) {
    y <- head(solve(Q1, c(rep(0,n),1,x)),n)
    y%*%Q%*%y
  })
  plot(s,rbase, ylab='Return', xlab='Variance')
}

frontier(asset)


install.packages("fPortfolio")
library(timeSeries)

library(Quandl)
IT <- Quandl('DAROCZI/IT', start_Date = '2014-04-01', end_date='2016-02-19')


IT <- timeSeries(IT[,2:6],IT[,1])
IT
# 수익률 구하기
log(lag(IT)/IT) # 다양한 방법으로 보여줌
IT_return <- returns(IT)
IT_return

install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
chart.CumReturns(IT_return, legend.loc = 'topleft',main ='')

?chart.CumReturns
library(fPortfolio)
plot(portfolioFrontier(IT_return))


Spec = portfolioSpec()
setSolver(Spec) = "solveRshortExact"
Frontier <- portfolioFrontier(as.timeSeries(IT_return),
                              Spec, constraints = "Short")
frontierPlot(Frontier, col = rep('orange',2),pch=19)
monteCarloPoints(Frontier, mcSteps = 1000, cex = 0.25, pch=19)
grid()




library(timeSeries)
library(Quandl)
IT <- Quandl('DAROCZI/IT', start_Date = '2014-04-01', end_date='2016-02-19')
IT <- timeSeries(IT[,2:6],IT[,1])
assets <- IT[,-1]
return <- log(tail(assets,-1) / head(assets, -1))
IT_return <- returns(IT)

n <- 6   ; mu <- 0.005
Q <- cbind(cov(return, use="complete.obs"),rep(0,n-1))
Q <- rbind(Q,rep(0,n))

r <- c(colMeans(return,na.rm=TRUE),0.0001)

Q <- rbind(Q, rep(1,n),r)
Q <- cbind(Q, rbind(t(tail(Q,2)),matrix(0,2,2)))
b <- c(rep(0, n), 1, mu)

round(Q,6)
b
w <- solve(Q,b)
w <- head(w,-3)
w/sum(w)




library(timeSeries)
library(Quandl)
IT <- Quandl('DAROCZI/IT', start_Date = '2014-04-01', end_date='2016-02-19')
IT <- timeSeries(IT[,2:6],IT[,1])
assets <- IT[,-1]
return <- log(tail(assets,-1) / head(assets, -1))
IT_return <- returns(IT)

library(fPortfolio)
Spec <- portfolioSpec()
setSolver(Spec) <- "solveRshortExact"
setTargetReturn(Spec) <- mean(colMeans(IT_return))
efficientPortfolio(IT_return, Spec, 'Short')                               
minvariancePortfolio(IT_return, Spec, 'short')
minriskPortfolio(IT_return, Spec)
maxreturnPortfolio(IT_return, Spec)
