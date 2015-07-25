library(ggplot2)
library(plyr)

#Reads in the files
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

# Creates new df with only "vehicles" values and another with Baltimore City and LA County
cars <- SCC[grepl("vehicles", SCC$SCC.Level.Two, ignore.case = TRUE), ]
bmla <- subset(NEI, NEI$fips == '24510' | NEI$fips == '06037')

#Merge data sets
mergedData <- merge(cars, bmla, by="SCC")

# Gets Sum
dataSum <-ddply(mergedData,.(year,fips),summarize,sum=sum(Emissions))
colnames(dataSum)[3] <- "Emissions"
dataSum$year <-as.character(dataSum$year)


#Plots bargraph and save file

p <- ggplot(dataSum, aes( x = year, y = Emissions, fill = fips)) + geom_bar( position ="dodge", stat ="identity") 
p <- p + ggtitle("Comparing LA County with Balitmore City") + guides( fill = guide_legend( title = NULL))
p <- p + scale_fill_discrete( labels = c("LA County", "Baltimore City"))

 


ggsave(filename="plot6.png", plot=p)
dev.off()