install.packages("EnvStats")
library(EnvStats)
library(readxl)
install.packages("psych")
library(psych)
getwd()
setwd("C:/dev/r_workspace/source1/준비파일") 
diet <- read_excel("8장_대응표본의 가설검정.xlsx")
diet
attach(diet)

diet$`복용 전`
diet$'복용 후'

t.test('복용 전','복용 후')
setwd("C:/dev/r_workspace/source")
worktime <- read_excel("독립표본 t 검정.xls")

worktime

attach(worktime)

