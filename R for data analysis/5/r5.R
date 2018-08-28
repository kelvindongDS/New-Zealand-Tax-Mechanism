
setwd("d:/OneDrive/LEARNING/S1 2018/graduate project/bi/r/tax/5")

TaxAgentData<- read.csv('AGENT.csv')

colnames(TaxAgentData)<- c('CustomerID',	'FName',	'LName',	'Register',	'Active',	'Geography',
                       'TimeRegister',	'CustomerID',	'BusinessSegment')

TaxAgent<- TaxAgentData[,2:9]
head(TaxAgent,4)

#set up time hierarchy
TaxAgent$Date<- substring(TaxAgent$TimeRegister,1,10)
TaxAgent$timecat[TaxAgent$Date<='2015-03-31']<- '2015 Q1'
TaxAgent$timecat[TaxAgent$Date>'2015-03-31'& TaxAgent$Date<='2015-06-30']<- '2015 Q2'
TaxAgent$timecat[TaxAgent$Date>'2015-06-30'& TaxAgent$Date<='2015-09-30']<- '2015 Q3'
TaxAgent$timecat[TaxAgent$Date>'2015-09-30' & TaxAgent$Date<='2015-12-31']<- '2015 Q4'

TaxAgent$timecat[TaxAgent$Date>'2015-12-31' & TaxAgent$Date<='2016-03-31']<- '2016 Q1'
TaxAgent$timecat[TaxAgent$Date>'2016-03-31'& TaxAgent$Date<='2016-06-30']<- '2016 Q2'
TaxAgent$timecat[TaxAgent$Date>'2016-06-30'& TaxAgent$Date<='2016-09-30']<- '2016 Q3'
TaxAgent$timecat[TaxAgent$Date>'2016-09-30' & TaxAgent$Date<='2016-12-31']<- '2016 Q4'

TaxAgent$timecat[TaxAgent$Date>'2016-12-31' & TaxAgent$Date<='2017-03-31']<- '2017 Q1'

levels(TaxAgent$BusinessSegment)

#The number of Tax Agents by Time and location
ggplot(data= TaxAgent[TaxAgent$BusinessSegment=="Tax Agent" &  TaxAgent$Register=="Yes",],aes(x=timecat))+
  geom_bar(colour='purple')+ coord_cartesian(ylim=c(0,100)) + facet_grid(Geography~.)+
 ylab('The number of Tax Agents')



