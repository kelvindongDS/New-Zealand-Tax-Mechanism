#set working directory 
setwd("d:/OneDrive/LEARNING/S1 2018/graduate project/bi/r/tax/2")

library(ggplot2)
#get data
data_return<- read.csv('taxreturn.csv')
tail(taxreturn,5)
#set up columns name
colnames(data_return)<- c('CustomerID',	'FName',	'LName',	'Register',	'Active',	'Geography',
                          'TimeRegister_Customer',	'TaxReturnID',	'FilingChannel',	'ReturnType',	'TimeRegister',
                          'ReturnAmount',	'CustomerID')
#remove unexpected col
taxreturn<- data_return[,c(1:6,8:12)]
head(taxreturn,5)

#set up time hierarchy 
taxreturn$Date<- substring(taxreturn$TimeRegister,1,10)
taxreturn$timecat[taxreturn$Date<='2015-03-31']<- '2015 Q1'
taxreturn$timecat[taxreturn$Date>'2015-03-31'& taxreturn$Date<='2015-06-30']<- '2015 Q2'
taxreturn$timecat[taxreturn$Date>'2015-06-30'& taxreturn$Date<='2015-09-30']<- '2015 Q3'
taxreturn$timecat[taxreturn$Date>'2015-09-30' & taxreturn$Date<='2015-12-31']<- '2015 Q4'

taxreturn$timecat[taxreturn$Date>'2015-12-31' & taxreturn$Date<='2016-03-31']<- '2016 Q1'
taxreturn$timecat[taxreturn$Date>'2016-03-31'& taxreturn$Date<='2016-06-30']<- '2016 Q2'
taxreturn$timecat[taxreturn$Date>'2016-06-30'& taxreturn$Date<='2016-09-30']<- '2016 Q3'
taxreturn$timecat[taxreturn$Date>'2016-09-30' & taxreturn$Date<='2016-12-31']<- '2016 Q4'

taxreturn$timecat[taxreturn$Date>'2016-12-31' & taxreturn$Date<='2017-03-31']<- '2017 Q1'

# Total Number of Return by Filling Channel
ggplot(data= taxreturn[taxreturn$Register=="Yes",],aes(x=ReturnType,colour=FilingChannel))+
  ylab("The Number of Return")+
  geom_bar()

#Total Number of Return  by Time
ggplot(data= taxreturn[taxreturn$Register=="Yes",],aes(x=timecat,colour=ReturnType))+
  ylab("The Number of Return") +
  geom_bar() 

# set type list of return type by company and individual
#company return list
CompanyList <- c("Fringe benefit tax","IR4: Income tax return-Companies","IR4J: Annual imputation return" ,
                 "IR6: Income tax return-Estates or Trusts","IR101: Goods and services tax")

#Individual return list
IndividualList<-c("FS1 : Family Assistance Registration" ,"IR3: Individual Tax return",
                  "IR345: PAYE monthly summary" ,"IR348: PAYE monthly schedule" ,
                  "IR526 : Claim for personal tax rebate" ,"Personal Tax Summary"  )

# Total number of Return Type of Organisation by Time
ggplot(data= taxreturn[taxreturn$Register=="Yes" & taxreturn$ReturnType %in% CompanyList,],aes(x=timecat,colour=ReturnType))+
  ylab("The Number of Return") + geom_bar()

# Total number of Return Type of Individual by Time
ggplot(data= taxreturn[taxreturn$Register=="Yes" & taxreturn$ReturnType %in% IndividualList,],aes(x=timecat,colour=ReturnType))+
  ylab("The Number of Return") + geom_bar()

levels(taxreturn$ReturnType)
