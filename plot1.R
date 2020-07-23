# Question: 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./data/exdata_data_NEI_data/Source_Classification_Code.rds")

total_emissions_by_year <- with(NEI, tapply(Emissions, year, sum, na.rm = T))

year <- as.numeric(names(total_emissions_by_year))

total_emissions <- unname(total_emissions_by_year[1:length(total_emissions_by_year)])

total_emissions_by_year <- data.frame(year, total_emissions)

png(file="plot1.png", width=480, height=480)

with(total_emissions_by_year, {plot(year, total_emissions, xlab = "Year", ylab=" Total PM2.5 Emissions", type='l', pch=19, xlim = c(1999, 2008), xaxt = "n")
                               axis(side = 1, at = year, labels = year)})

title(main = "Total PM2.5 Emissions for each year")

dev.off()
