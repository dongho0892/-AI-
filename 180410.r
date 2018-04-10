help(sum)
?sum
example(mean)
??("normal distribution")

1:5
5:1

x <-  c(1,2,3)
y <- c(4,5,c(6,7,8))

?seq
seq (from=1, to=5, by=2)
seq(1,5,by=2)
seq(0,1,by=0.001)
seq(0,1,length.out=1000)
    
?rep
rep(c(1,2,3,4,5,6),times=2)
rep(c(1,2,3,4,5),each=2)

?vector
x <- c(5,4,3,2,1)
length(x)
x[1]           # 첫번째 원소만 갖고 옴.
x[c(1,2,3)]    # 해당하는 위치 값을 갖고 옴. # x[(1,2,3)] => 안됨
x[-c(1,2,3)]   # 해당하는 위치 값을 제외하고 가져옴.
x

x <- c(1,2,3,4)
y <- c(5,6,7,8)
z <- c(1,2)
w <- c(1,2,3)

2+x
y+z
x+z         # 작은 쪽이 원소 갯수의 차이가 정수배가 날 경우 작은 쪽이 반복해서 나타남.
x+w

?is.vector #
?as.vector #
x <- c(1,2,3,4)
   is.vector(x)
   f <- factor(x)  # 벡터
  is.vector(f)
  v <-as.vector(f) # 문자열로
f
v

?all 
?any
    x <- 1:5
    x > 3
    all(x>3) # 모두 만족?
    any(x>3) # 구성원 어느 하나만 만족?

?name # 아래 객체에서 불러오거나 이름을 지정해줌    
    
names(x)
names(x) <-  value

height <- c(80,90,70,170)
names(height) <-　c("A","B","C","D")
height　


?head # 이 자료가 어떤 형태인가 / 처음에 언제 시작하고
?tail #                           마지막에 언제 끝나는
x <- 1:100
head(x)      # 기본 6개
head(x,n=7)
tail(x)
tail(x,n=7)


?sample #(x, size, replace = FALSE, prob = NULL)
sample(10)   # 10개를 임의로 섞어서 보여줌
sample(45,6)  # 45개 중 6개 
sample(10, 3, replace=TRUE)   # 10개를 임의로 뽑고 + 복원추출
sample(10, 3, prob=(1:10)/55)   # 10개를 임의로 뽑고 + 확률을 다르게 해줌
x <- seq(0,1,by=0.1)
x
x[sample(length(x),3)]  # x 안에 쓰여져서 x의 구조 중에 3개 
sample(x,3)             # x 벡터를 넣어서 3개 뽑기    => 결과는 같지만, 방식이 다름


?which    # 조건판단을 하는 수식
          # 인덱스 기준으로 판단함.

x <- c(2,4,-1,3)
which( x > 2)   # x가 2보다 큰 인덱스를 보여줌 ! 2번째, 4번째      
names(x) <- c("a","b","c","d")
which( x > 2)   

?array
 arr <- array(1:3, c(2,4))           #행 먼저 채우고, 열 채우고
arr[1,]   #1번째 행을 가져오고 싶다.
arr[,3]   #3번째 열을 가져오고 싶다.
arr 
               # 차원의 이름 지정 가능
dimnamearr=list(c("A","B"), c("A","B","c","D"))
            # (첫번째, 두번째 차원) , 
            # 특정 행,열의 이름으로 불러올 수 있음
arr2 <- array(1:3, c(2,4), dimnames=dimnamearr)
arr2
arr2["A",]
arr2[,"D"]
