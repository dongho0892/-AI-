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

# 벡터    ?vector-----------------------------------------------------
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

# 배열 ?array  -----------------------------------------------------
 arr <- array(1:3, c(2,4))           # 좌측 위부터 아래 순으로 열 먼저 채우고, 
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

# 매트릭스 -----------------------------------------------------
?matrix

tmp <- 1:12
tmp
matrix(tmp,nrow=3)   #위에서 아래로 열부터 채움
matrix(tmp,ncow=3, byrow=TRUE)  # 좌우 행부터 채윰

# 합치기 ?rbind() / ?cbind()

v1 <- c(1,2,3,4)
v2 <- c(5,6,7,8)
v3 <- c(9,10,11,12)
cbind(v1,v2,v3)  #행을 기준으로 합쳐짐 : 4행 3열
rbind(v1,v2,v3)  #열을 기준으로 합쳐짐 : 3행 4열

# 행별, 열별 평균 계산
?apply #(array, margin, ...)

v1 <- c(1,2,3,4)
v2 <- c(5,6,7,8)
v3 <- c(9,10,11,12)

m1 <- cbind(v1,v2,v3) # 열 기준으로 
m1
apply(m1, 1, mean) # 행별 평균
apply(m1, 2, mean) # 열별 평균

# 요인 ?factor -----------------------------------------

?factor
x <- c(1,2,3,4,5)
factor(x, levels=c(1,2,3,4))  # 1,2,3,4만 뽑겠다. 
factor(x, levels=c(1,2,3,4), exclude=c(1,2))   # 1,2는 제외하겠다.
factor(x, levels=c(1,2,3,4), exclude=c(1,2), ordered=TRUE)  # ordered : 순서를 지정해준다.

# ?is.factor / ?as.factor
v <- c(1,2,3,4)
x <- factor(x) #요인으로 생성
is.factor(x)
is.factor(v)
v
as.factor(v) # 요인으로 변환
s <- as.factor(v)
is.factor(as.factor(v))
is.factor(s)

# ?tapply   - Ragged Array
score <-  c(92,90,82,88,78,64,82,90)
subject <- c("k","k","m","m","m","m","k","k")
tapply(score, subject, mean) # 각 요소를 묶어서 평균내줌.


# 데이터 프레임 . data.frame
 name <-c("철수","영희","남혁")
 age <- c(21,20,31)
 gender <- factor(c("M","F","M"))
 character <-  data.frame(name, age, gender)
 character
 character$name  # $이름 속성 나열
 character[1,]   # 첫번째 행 지정 / 열 전체
 character[,2]   # 두번째 열 / 행 전체
 character[3,1]  # 세번째 행, 첫번째 열이 겹치는 곳
 character[2,2]  
 character[1,1]  

 # ?attach - 데이터 프레임의 열이름을 변수명으로 쓸 수 있게끔 설정해줌
 # ?detach -  
 
 head(airquality) # 오존, 바람 온도 등등..
 Ozone   # 현재는 자료를 불러올 수 없음
 attach(airquality) 
 Ozone  
 Ozone[1:5]
 Ozone <- c(1,2,3)
 attach (airquality)  # 기존에 attach 되어있어서 할 수 없음
 Ozone 
 Month[1:5]   # 표 안의 값이 5 이기 때문에.
 detach(airquality) 
 
 
 
 #with
 head(cars)
 mean(cars$speed) 
 mean(cars$dist) 
 with(cars,mean(speed))  #
 with(cars, mean(dist))  # 데이터프레임 안에 있는 자료의 평균을 구할 수 있음.

 #subset # 조건에 맞는 부분집합을 추출하기
 ?subset
 airquality
 subset(airquality, Temp > 80) 
 subset(airquality, Temp > 80, select=c(Ozone,Temp))  # 
 subset(airquality, Temp > 80, select=-c(Ozone,Temp)) # - 관련된 것만 빼주고 
 
 #NA는 값이 기록되지 않았거나 관측되지 않은 경우 데이터에 저장되는 값으로 ‘결측치’라고 부른다
 # ?na.omit : object에 NA가 포함되어 있으면 이를 제외한다.
 str(airquality)
 str(na.omit(airquality))
 
 #
title <- "My List"
ages <- c(31,41,21) 
numbers <- matrix(1:9, nrow=3) 
names <- c("Baby", "Gentle", "none")

listEx <- list(title, ages, numbers, names)  # 순서대로 뿌려
listEx
listEx[1]  # 첫번째 요소만 가지고 옴

#
listEx2 <- list(title=title, age=ages, number=numbers, name=names)
listEx2
listEx2[1]
listEx2$title
listEx2$age
listEx2$name
listEx2$number

# is.list : 리스트 인지 판단 / as.list : 리스트로 변환해줌

x <- list(c(1,2,3,4), c(3,2,1))
v <- c(1,2,3,4)  # vector
x
v
is.list(x)
is.list(v)
a.l <- as.list(v)
a.l
is.list(a.l)

# 리스트에 함수 적용하기

# lapply 리스트의 각 요소에 평균을 구하고 결과를 리스트로 반환
# sapply 리스트의 각 요소에 평균을 구하고 결과를 벡터로 반환

x <- list(a=1:10, beta = exp(-3:3), logic = c(TRUE, FALSE,FALSE,TRUE))
x # a, beta, logic 3개 리스트로 결과값 나옴
lapply(x,mean) # 리스트 별로 결과값 보여줌
sapply(x,mean) # 하나의 벡터로 결과값 보여줌

# 자료 내 특정 원소 가져오기 / 조건 : []를 씀!
ex <- c(1,3,7,NA,12)
ex[ex < 10]
ex[ex %% 2 == 0]
ex[!is.na(ex)]
ex[is.na(ex)]   # NA  인 것만 추출
ex[ex %% 2 == 0 & !is.na(ex)] # 짝수이며, NA가 아닌 원소 추

name <- c("철수", "영미","남혁")
age <- c(21,20,27)
gender <- factor(c("M","F","M"))
characters <- data.frame(name, age,gender) # 조건에 맞는 행을 찾을 때 주로 씀
characters[characters$gender == "F",]
characters[characters$gender == "F" & characters$age < 30, ]
characters[characters$gender == "M" & characters$age < 30, ]
