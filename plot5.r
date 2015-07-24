library(ggplot2)
library(plyr)

#Reads in the files
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

# Creates new df with only "vehicles" values and another with Baltimore City
cars <- SCC[grepl("vehicles", SCC$SCC.Level.Two, ignore.case = TRUE), ]
charmCity <- subset(NEI, NEI$fips == 24510)

#Merge data sets
mergedData <- merge(cars, charmCity, by="SCC")

# Gets Sum
dataSum <-ddply(mergedData,.(year),summarize,sum=sum(Emissions))
colnames(dataSum)[2] <- "Emissions"


#Plots barplot and save file

p <-ggplot(dataSUm,aes(year,Emissions))
p <-p+geom_point()+geom_line() +labs(title="PM2.5 Emissions from Motor Vehicle-related sources from 1999 - 2008")


ggsave(filename="plot5.png", plot=p)
dev.off()