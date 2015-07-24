library(ggplot2)
library(plyr)

#Reads in the files
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

# Creates new df with only "coal" values
coal <- SCC[grepl("coal", SCC$EI.Sector, ignore.case = TRUE), ]

#Merge data sets
mergedData <- merge(NEI, coal, by="SCC")

# Gets Sum
dataSUm <-ddply(mergedData,.(year),summarize,sum=sum(Emissions))


#Plots barplot and save file

p <-ggplot(dataSUm,aes(year,sum))
p <-p+geom_point()+geom_line() +labs(title="PM2.5 Emissions from coal combustion-related sources from 1999 - 2008")


ggsave(filename="plot4.png", plot=p)
dev.off()



