
setwd("d:/OneDrive/LEARNING/S1 2018/graduate project/bi/r/tax/1")
register<-read.csv('register.csv')
colnames(register)<- c('CustomerID',	'FName','LName','Register','Active',	'Geography',
                        'TimeRegister',	'CustomerID_Individual',	'TaxCode','Occupation','Gender')

tail(register,5)
# create time hierarchy
register$Date<- substring(register$TimeRegister,1,10)
register$timecat[register$Date<='2015-03-31']<- '2015 Q1'
register$timecat[register$Date>'2015-03-31'& register$Date<='2015-06-30']<- '2015 Q2'
register$timecat[register$Date>'2015-06-30'& register$Date<='2015-09-30']<- '2015 Q3'
register$timecat[register$Date>'2015-09-30' & register$Date<='2015-12-31']<- '2015 Q4'

register$timecat[register$Date>'2015-12-31' & register$Date<='2016-03-31']<- '2016 Q1'
register$timecat[register$Date>'2016-03-31'& register$Date<='2016-06-30']<- '2016 Q2'
register$timecat[register$Date>'2016-06-30'& register$Date<='2016-09-30']<- '2016 Q3'
register$timecat[register$Date>'2016-09-30' & register$Date<='2016-12-31']<- '2016 Q4'

register$timecat[register$Date>'2016-12-31' & register$Date<='2017-03-31']<- '2017 Q1'

factor(register$timecat)

library(ggplot2)

#register customers
ggplot(data= register[register$Register=='Yes',],aes(x=timecat))+
           geom_bar()

#individual register customers
t<- register[ register$CustomerID_Individual !='NULL',]

ggplot(data= t[t$Register=='Yes',],  aes(x=timecat))+ ylim(0,4000)+
  geom_bar()

#active customers
ggplot(data= register[register$Register=='Yes' & register$Active=='Yes',],aes(x=timecat))+
  geom_bar() +ylab('The number of Active Customers')

#active individual customers
ggplot(data= t[t$Register=='Yes' & t$Active=='Yes',],  aes(x=timecat))+ ylim(0,2000)+
  geom_bar()

#Total number of register customers group by region 
ggplot(data= register[register$Register=='Yes' & register$Active=='Yes',],aes(x=timecat,colour=Geography))+
  geom_bar()

