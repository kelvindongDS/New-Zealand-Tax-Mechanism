
setwd("d:/OneDrive/LEARNING/S1 2018/graduate project/bi/r/tax/3")
install.packages("magrittr")
library(magrittr)
library(dplyr)
debt<- read.csv('debt.csv')

colnames(debt)<- c('DebtID',	'StartTime',	'DueDate',	'EndTime',	'Value',	'Age',	'Overdue',	'Type',	'CustomerID')

# set up time hierarchy
debt$Year<- substring(debt$DueDate,1,4)
debt$Date<- substring(debt$DueDate,1,10)
debt$timecat[debt$Date<='2016-03-31']<- '2016 Q1'
debt$timecat[debt$Date>'2016-03-31'& debt$Date<='2016-06-30']<- '2016 Q2'
debt$timecat[debt$Date>'2016-06-30'& debt$Date<='2016-09-30']<- '2016 Q3'
debt$timecat[debt$Date>'2016-09-30' & debt$Date<='2016-12-31']<- '2016 Q4'

debt$timecat[debt$Date>'2016-12-31' & debt$Date<='2017-03-31']<- '2017 Q1'
debt$timecat[debt$Date>'2017-03-31'& debt$Date<='2017-06-30']<- '2017 Q2'
debt$timecat[debt$Date>'2017-06-30'& debt$Date<='2017-09-30']<- '2017 Q3'
debt$timecat[debt$Date>'2017-09-30' & debt$Date<='2017-12-31']<- '2017 Q4'

debt$timecat[debt$Date>'2017-12-31' & debt$Date<='2018-03-31']<- '2018 Q1'

head(debt,4)
factor(debt$timecat)

#Total Amount of Value group by Type, Time
grType <- debt[debt$Overdue=='Yes',] %>% 
  group_by(Type,timecat) %>% 
  summarise(Final = sum(Value))
grType

ggplot(data= grType,aes(x=timecat,y=Final,colour=Type,size=Final))+
  geom_jitter()+ coord_cartesian(ylim=c(5000000,6200000))

#Average Number of Age( days) group by Type, Time
grTypeAge <- debt[debt$Overdue=='Yes',] %>% 
  group_by(Type,Year) %>% 
  summarise(Final = mean(Age))

ggplot(data= grTypeAge,aes(x=Type,y=Final,colour=Type))+ geom_bar(stat = "identity")+
 facet_grid(.~grTypeAge$Year)
