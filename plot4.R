# Question: 4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./data/exdata_data_NEI_data/Source_Classification_Code.rds")

nei_scc <- merge(NEI, SCC, by = "SCC")

nei_scc_coal <- subset(nei_scc, EI.Sector == "Fuel Comb - Comm/Institutional - Coal"
                       | EI.Sector == "Fuel Comb - Electric Generation - Coal" | EI.Sector == "Fuel Comb - Industrial Boilers, ICEs - Coal")


total_emissions_coal_by_year <- with(nei_scc_coal, tapply(Emissions, year, sum, na.rm = T))

year <- as.numeric(names(total_emissions_coal_by_year))

total_emissions <- unname(total_emissions_coal_by_year[1:length(total_emissions_coal_by_year)])

total_emissions_coal_by_year <- data.frame(year, total_emissions)

png(file="plot4.png")

with(total_emissions_coal_by_year, {plot(year, total_emissions, xlab = "Year", ylab=" Total PM2.5 Emissions", type='l', pch=19, xlim = c(1999, 2008), xaxt = "n")
    axis(side = 1, at = year, labels = year)})

title(main = "Total PM2.5 Emissions from coal combustion-related sources")

dev.off()
