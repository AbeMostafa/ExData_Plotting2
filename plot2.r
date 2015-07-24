#Reads in the files
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

#Subsets for Baltimmore
charmCity <- subset(NEI, NEI$fips == 24510)

#Gets a list of years
yearsList <- list(charmCity$year)

#Aggregates the data read above to Sum Emissions by Year
totalEmissions <- aggregate(charmCity$Emissions, by = yearsList, FUN = sum)

#Plots barplot and save file
png(filename = "plot2.png")
barplot(totalEmissions$x, names.arg = totalEmissions$Group.1,
        xlab="Years", ylab= "PM 2.5 Emmissions (Ton)", main="Total Emmisions for Baltimore City, Marland (fips # 24510")
dev.off()