library(ggplot2)
library(plyr)

#Reads in the files
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

#Subsets for Baltimmore
charmCity <- subset(NEI, NEI$fips == 24510)

#Sets year into a factor and sums emissions by year and type
charmCity <-transform(NEI,year=factor(year))
charmCity <-ddply(charmCity,.(year,type),summarize,sum=sum(Emissions))

#Plots barplot and save file

p <-ggplot(charmCity, aes(year,sum, group = type)) 
p <- p +geom_point() + geom_line()+facet_grid(.~type)+ggtitle("PM2.5 Emission in Baltimore City, Maryland") 
                                              

ggsave(filename="plot3.png", plot=p)
dev.off()



