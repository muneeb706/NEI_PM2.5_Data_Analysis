# Question: 2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./data/exdata_data_NEI_data/Source_Classification_Code.rds")

NEI_baltimore <- subset(NEI, fips == "24510")
    
total_emissions_by_year <- with(NEI_baltimore, tapply(Emissions, year, sum, na.rm = T))

year <- as.numeric(names(total_emissions_by_year))

total_emissions <- unname(total_emissions_by_year[1:length(total_emissions_by_year)])

total_emissions_by_year <- data.frame(year, total_emissions)

png(file="plot2.png", width=480, height=480)

with(total_emissions_by_year, {plot(year, total_emissions, xlab = "Year", ylab=" Total PM2.5 Emissions", type='l', pch=19, xlim = c(1999, 2008), xaxt = "n")
    axis(side = 1, at = year, labels = year)})

title(main = "Total PM2.5 Emissions in the Baltimore City, Maryland for each year")

dev.off()
