
setwd("d:/OneDrive/LEARNING/S1 2018/graduate project/bi/r/tax/6")

library(magrittr)
library(dplyr)
#activate plot libary 
library('ggplot2')

fam<- read.csv('FAMILY.csv')

colnames(fam)<- c('FamilyID',	'WorkingForFamilyTaxEntitlement',	'WorkingForFamilyTaxType',
                  'ChildSupport',	'FamilyID',	'NumberOfChild',	'Time',	'CustomerID1',	'CustomerID2')

famdata<- fam[,2:9]

#set up timecat to quarterly 
famdata$Year<- substring(famdata$Time,1,4)
famdata$Date<- substring(famdata$Time,1,10)
famdata$timecat[famdata$Date<='2010-03-31']<- '2010 Q1'
famdata$timecat[famdata$Date>'2010-03-31'& famdata$Date<='2010-06-30']<- '2010 Q2'
famdata$timecat[famdata$Date>'2010-06-30'& famdata$Date<='2010-09-30']<- '2010 Q3'
famdata$timecat[famdata$Date>'2010-09-30' & famdata$Date<='2010-12-31']<- '2010 Q4'

famdata$timecat[famdata$Date>'2010-12-31' & famdata$Date<='2011-03-31']<- '2011 Q1'
famdata$timecat[famdata$Date>'2011-03-31'& famdata$Date<='2011-06-30']<- '2011 Q2'
famdata$timecat[famdata$Date>'2011-06-30'& famdata$Date<='2011-09-30']<- '2011 Q3'
famdata$timecat[famdata$Date>'2011-09-30' & famdata$Date<='2011-12-31']<- '2011 Q4'

famdata$timecat[famdata$Date>'2011-12-31' & famdata$Date<='2012-03-31']<- '2012 Q1'
famdata$timecat[famdata$Date>'2012-03-31'& famdata$Date<='2012-06-30']<- '2012 Q2'
famdata$timecat[famdata$Date>'2012-06-30'& famdata$Date<='2012-09-30']<- '2012 Q3'
famdata$timecat[famdata$Date>'2012-09-30' & famdata$Date<='2012-12-31']<- '2012 Q4'

famdata$timecat[famdata$Date>'2012-12-31' & famdata$Date<='2013-03-31']<- '2013 Q1'
famdata$timecat[famdata$Date>'2013-03-31'& famdata$Date<='2013-06-30']<- '2013 Q2'
famdata$timecat[famdata$Date>'2013-06-30'& famdata$Date<='2013-09-30']<- '2013 Q3'
famdata$timecat[famdata$Date>'2013-09-30' & famdata$Date<='2013-12-31']<- '2013 Q4'

famdata$timecat[famdata$Date>'2013-12-31' & famdata$Date<='2014-03-31']<- '2014 Q1'
famdata$timecat[famdata$Date>'2014-03-31'& famdata$Date<='2014-06-30']<- '2014 Q2'
famdata$timecat[famdata$Date>'2014-06-30'& famdata$Date<='2014-09-30']<- '2014 Q3'
famdata$timecat[famdata$Date>'2014-09-30' & famdata$Date<='2014-12-31']<- '2014 Q4'

famdata$timecat[famdata$Date>'2014-12-31' & famdata$Date<='2015-03-31']<- '2015 Q1'

head(famdata,3)

#Number of Child Support Customers by Time and Type
ggplot(data= famdata[famdata$ChildSupport=='Yes',],aes(x=timecat))+
  geom_bar(colour='purple') +facet_grid(WorkingForFamilyTaxType~.)+
  ylab('Number of Child Support Customers')

#Average of TaxEntitlement by Time
#group by Year, WorkingForFamilyTaxType
grEntitlement <- famdata[famdata$ChildSupport=='Yes',] %>% 
  group_by(Year,WorkingForFamilyTaxType) %>% 
  summarise(Final = mean(WorkingForFamilyTaxEntitlement))

#plot of Average of TaxEntitlement by Time
ggplot(data= grEntitlement,aes(x=Year,y=Final))+
  geom_bar(colour='purple',fill='blue',stat = "identity") +
  ylab('Average of TaxEntitlement')

 
