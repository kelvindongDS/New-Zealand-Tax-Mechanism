
setwd("d:/OneDrive/LEARNING/S1 2018/graduate project/bi/r/tax/4")
doRebate<- read.csv('donationrebate.csv')

colnames(doRebate)<- c('DonationRebateID',	'DoRebateAmount',	'RebateTime',	'CustomerID')

head(doRebate,3)
# set up time hierarchy
doRebate$Date<- substring(doRebate$RebateTime,1,10)
doRebate$timecat[doRebate$Date<='2015-03-31']<- '2015 Q1'
doRebate$timecat[doRebate$Date>'2015-03-31'& doRebate$Date<='2015-06-30']<- '2015 Q2'
doRebate$timecat[doRebate$Date>'2015-06-30'& doRebate$Date<='2015-09-30']<- '2015 Q3'
doRebate$timecat[doRebate$Date>'2015-09-30' & doRebate$Date<='2015-12-31']<- '2015 Q4'

doRebate$timecat[doRebate$Date>'2015-12-31' & doRebate$Date<='2016-03-31']<- '2016 Q1'
doRebate$timecat[doRebate$Date>'2016-03-31'& doRebate$Date<='2016-06-30']<- '2016 Q2'
doRebate$timecat[doRebate$Date>'2016-06-30'& doRebate$Date<='2016-09-30']<- '2016 Q3'
doRebate$timecat[doRebate$Date>'2016-09-30' & doRebate$Date<='2016-12-31']<- '2016 Q4'

doRebate$timecat[doRebate$Date>'2016-12-31' & doRebate$Date<='2017-03-31']<- '2017 Q1'

# Total number of rebate by Time
ggplot(data = doRebate,aes(x=timecat )) + ylab('Number of Rebates')+
  geom_bar(color='red',fill='grey')

# Average of Donation Rebate by Time
grTime <- doRebate %>% 
  group_by(timecat) %>% 
  summarise(Final = mean(DoRebateAmount))

ggplot(data = grTime,aes(x=timecat,y=Final,size=Final )) + ylab('Average of Rebates')+
  geom_jitter(color='red')

