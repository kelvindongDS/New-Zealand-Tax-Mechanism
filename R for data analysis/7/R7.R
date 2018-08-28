
setwd("d:/OneDrive/LEARNING/S1 2018/graduate project/bi/r/tax/7")

liableparent<- read.csv('LIABLEPARENT.csv')

colnames(liableparent)<- c('FamilyID',	'CashForChildSupport',	'Time') 

#set up time hierarchy 
liableparent$Date<- substring(liableparent$Time,1,10)
liableparent$timecat[liableparent$Date<='2015-03-31']<- '2015 Q1'
liableparent$timecat[liableparent$Date>'2015-03-31'& liableparent$Date<='2015-06-30']<- '2015 Q2'
liableparent$timecat[liableparent$Date>'2015-06-30'& liableparent$Date<='2015-09-30']<- '2015 Q3'
liableparent$timecat[liableparent$Date>'2015-09-30' & liableparent$Date<='2015-12-31']<- '2015 Q4'

liableparent$timecat[liableparent$Date>'2015-12-31' & liableparent$Date<='2016-03-31']<- '2016 Q1'
liableparent$timecat[liableparent$Date>'2016-03-31'& liableparent$Date<='2016-06-30']<- '2016 Q2'
liableparent$timecat[liableparent$Date>'2016-06-30'& liableparent$Date<='2016-09-30']<- '2016 Q3'
liableparent$timecat[liableparent$Date>'2016-09-30' & liableparent$Date<='2016-12-31']<- '2016 Q4'

liableparent$timecat[liableparent$Date>'2016-12-31' & liableparent$Date<='2017-03-31']<- '2017 Q1'

#Total Amount of Cash for Child Support
#group by Year(Quarterly)
grYear <- liableparent %>% 
  group_by(timecat) %>% 
  summarise(Final = sum(CashForChildSupport))

#sum of Cash for Child Support
ggplot(data= grYear,aes(x=timecat,y=Final))+
  geom_bar(colour='purple',fill='blue',stat = "identity") +
  ylab('Sum of Cash for Child Support')

#Number of Child Support Customers by Time
ggplot(data= liableparent,aes(x=timecat))+
  geom_bar(colour='purple',fill='gold') +
  ylab('Number of Child Support Customer')

