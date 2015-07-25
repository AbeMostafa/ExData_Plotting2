#Reads in the files
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

#Gets a list of years
yearsList <- list(NEI$year)

#Aggregates the data read above to Sum Emissions by Year
totalEmissions <- aggregate(NEI$Emissions, by = yearsList, FUN = sum)

#Plots barplot and saves file
png(filename = "plot1.png")
barplot(totalEmissions$x, names.arg = totalEmissions$Group.1,
        xlab="Years", ylab= "PM 2.5 Emmissions (Ton)", main="Total PM 2.5 Emmisions")
dev.off()

