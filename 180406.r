x <- c(1,2,3)
x

mean(x)
max(x)
min(x)

 #  c( )  여러값으로 구성변수 만들기

str5 <- c("Hello", "World","is", "good!")
str5
paste(str5,collapse =",")  #""안의 조건으로 각 단어들 하나로 합치기
paste(str5,collapse =" ")  # paste 여러 문자를 하나로 합쳐주는 함수
paste(str5,collapse ="-")  # collapse와 같이 함수의 옵션을 설정하는 명령어
paste(str5,collapse ="_")    #  => 파라미터 / 매개변수 라고 함.
paste(str5,collapse = " ")

x_mean <- mean(x)
x_mean

str5_paste <-  paste(str5,collapse = ",")
str5_paste


install.packages("ggplot2")   # 패키지 설치 /  반드시 큰 따옴표 넣기!
library(ggplot2)              # 패키지 로드

x <-  c("a","a","b","c")
x
qplot(x)                   # 빈도 막대그래프 생성
qplot(data = mpg, x=hwy)
qplot(data = mpg, x=cty)
qplot(data = mpg, x=drv,y=hwy)

qplot(data = mpg, x=drv, y=hwy, geom ="line")
qplot(data = mpg, x=drv, y=hwy, geom ="boxplot")
qplot(data = mpg, x=drv, y=hwy, geom= "boxplot", colour=drv)

?qplot
# plot = x축, y축 관련 그래프를 그릴때 사용

score <-  c(80,60,70,50,90)
score
mean(score)
m_score <- mean(score)
m_score

english <-  c(90,80,60,70)
math <-  c(50,60,100,20)
english
math
          # 데이터 프레임 만들기
df_midterm <- data.frame(english,math)
df_midterm

class <-  c(1,1,2,2)

df_midterm <- data.frame(english,math,class)

mean(df_midterm$english)    # 그 안에 변수를 특정할 때는 $를 붙임.
mean(df_midterm$math)

#한번에 다 입력해도 됨.
df_midterm <- data.frame(english= c(90,80,60,70),
                         math = c(50,60,100,20),
                         class = c(1,1,2,2))
df_midterm


table <- data.frame(product = c("사과","딸기","수박"),
                    price = c(1800,1500,3000),
                    sales = c(24,38,13))
table

product <- c("사과","딸기","수박")
price <-  c(1800,1500,3000)
sales <-c(24,38,13)

table <-data.frame(product,price,sales)
table




library(readxl)          #엑셀파일 읽어오는 패키지 로드
getwd()                  # 현재 설정된 경로 확인
setwd("C:/dev/r_workspace/source1/준비파일")    #새로운 경로 설정

read_excel("excel_exam.xlsx")         #read_excel 함수로 엑셀파일 업로드

df_exam <- read_excel(("excel_exam.xlsx"))       
df_exam

mean(df_exam$math)              #df_exam의 math변수의 평균
mean(df_exam$english)
mean(df_exam$science)

    # col_names 의 기능 -- 첫번째행에 변수명을 넣어줌. 
    #             = 열 이름을 가져올 것인가? F를 넣어주면 안가져옴 => 새로 만들어줌.
df_exam_novar <-read_excel("excel_exam_novar.xlsx",col_names = F) # F는 꼭 대문자!
df_exam_novar


df_exam_sheet <-  read_excel("excel_exam_sheet.xlsx", sheet=3)
df_exam_sheet            # 3번째 시트를 불러옴.

df_csv_exam <-  read.csv("csv_exam.csv")
df_csv_exam
              # header = col_names 와 기능 동일                                 
df_csv_exam <-  read.csv("csv_exam.csv", sheet=2,header=F)
              # 숫자를 문자타입으로 불러오려면 stringsAsFactors.로 불러옴.
df_csv_exam <- read.csv("csv_exam.csv", stringsAsFactors = F)

df_midterm <- data.frame(english= c(90,80,60,70),
                         math = c(50,60,100,20),
                         class = c(1,1,2,2))

df_midterm
        #데이터프레임을 csv파일로 저장하겠다. 
write.csv(df_midterm, file="df_midterm.csv")
        #                RData 파일로 저장하겠다.
save(df_midterm, file = "df_midterm.rda")
        #앞에서 만든 df_midterm 삭제해주는 기능
rm(df_midterm)
df_midterm      # 삭제된 것을 확인 가능

load("df_midterm.rda")
df_midterm

# 불러오기의 차이점

df_exam <- read_excel("excel_exam.xlsx")  
df_csv_exam <- read.csv("csv_exam.csv")   # 새 변수를 할당해야하지만

  # rda 파일은 자동으로 데이터프레임이 형성되서 새변수에 할당 하지 않음

load("df_midterm.rda")                    

exam <- read.csv("csv_exam.csv", header = T)
exam
head(exam) # 6행까지 출력
tail(exam) # 마지막 6행 출력   
View(exam) # 뷰창에서 전체내용을 보여줌
dim(exam)  #  몇행 , 몇열 값이 나옴.
str(exam)  # 모든 변수의 속성을 한눈에 보여줌. / 각 속성별로 값을 나열해줌.
summary(exam) # 각 속성별로 하한, 상한, Q1,Q2,Q3, 평균값 보여줌.

head(exam,10)
tail(exam,10) 
View(exam)          # V는 대문자!!
dim(exam)
str(exam)           # 첫줄 = 데이터의 속성 / 몇개의 관측치 / 몇개의 변수
summary(exam)


install.packages("ggplot2")
library(ggplot2)

        # ggplot2패키지의 mpg 데이터를 불러와 데이터프레임을 만듬.
mpg <- as.data.frame(ggplot2::mpg)  
mpg

head(mpg)
tail(mpg)
View(mpg)
dim(mpg)
str(mpg)   # $model / 문자타입 / a4 모델
summary(mpg)   # 중앙값을 중심으로 Q1, Q3 사이에 갑이 몰려있다.

?mpg



df_raw <- data.frame(var1 = c(1,2,1),
                     var2 = c(2,3,2))
df_raw


install.packages("dplyr")     #rename()을 이용하기 위한 패키지
library(dplyr)

?`dplyr-package`

df_new <- df_raw   #원본으로 수정하기 보단 복사해서 작업하는게 좋음!

 
#   (데이터프레임, 새 변수명 = 기존 변수명)  
df_new <- rename(df_new, v2 = var2)   #변수할당을 해주어야 저장 됨.

df_new
df_raw

#변수명 수정하기

mpg <- as.data.frame(ggplot2::mpg)
mpg1 <- mpg

mpg1 <- rename(mpg1, city = cty, highway = hwy)
View(mpg1)

# 파생변수 만들기

df <-  data.frame(var1 =c(4,3,8),
                  var2 = c(2,6,1))
df

df$var_sum <-  df$var1 + df$var2

df
df$var_mean <- (df$var1 + df$var2)/2  #대소문자 구별 주의

df

mpg1$total <-(mpg1$city + mpg1$highway)/2

mpg1
head(mpg1)
mean(mpg1$total)

summary(mpg1$total) # mpg1 말고, mpg1$특정변수 를 구체적으로 입력할 것

hist(mpg1$total)

# 조건문 : ifelse (조건, T , F )

mpg1$pandan <- ifelse(mpg1$total >= 20 ,"PASS", "FAIL")

head(mpg1)

table(mpg1$pandan)  # pandan 변수의 내용을 테이블형식으로 보여줌.

library(ggplot2)      #ggplot2 패키지로 막대그래프 형성
qplot(mpg1$pandan)

mpg1$pandan1 <- ifelse(mpg1$total < 20 , "C", 
                       ifelse(mpg1$total < 29, "B", "A"))
head(mpg1, 20)
qplot(mpg1$pandan1)
table(mpg1$pandan1)

mpg1$pandan2 <-  ifelse(mpg1$total < 15, "D",
                        ifelse(mpg1$total < 20, "C",
                               ifelse(mpg1$total <25, "B", "A")))

head(mpg1,20)
qplot(mpg1$pandan2)
table(mpg1$pandan2)


#정리하기

mpg1 <- as.data.freme(ggplot2::mpg)
library(dplyr)
library(ggplot2)

head(mpg1,20)
tail(mpg1,10)
View(mpg1)
dim(mpg1)
str(mpg1)
summary(mpg1)

mpg1 <- rename(mpg1, company = manufacturer)

mpg1$total <- (mpg1$city + mpg1$highway)/2
mpg1$test <- ifelse(mpg1$total >= 20,"Pass", "Fail")

table (mpg1$test)
qplot(mpg1$test)


# 분석도전 123p

library(ggplot2)
midwest <- as.data.frame(ggplot2::midwest)

head(midwest)
str(midwest)

library(dplyr)
midwest <-  rename(midwest, asian = popasian, total = poptotal)
str(midwest)

midwest$perasian <- midwest$asian/midwest$total
str(midwest)
hist(midwest$perasian)
mean(midwest$perasian)

midwest$asiantest <- ifelse(midwest$perasian >= mean(midwest$perasian), "large", "small")

str(midwest)
table(midwest$asiantest)
qplot(midwest$asiantest)
