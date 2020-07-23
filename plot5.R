# Question: 5
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./data/exdata_data_NEI_data/Source_Classification_Code.rds")

nei_scc <- merge(NEI, SCC, by = "SCC")

nei_scc_vehicle_baltimore <- subset(nei_scc, fips == "24510" & (EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles"
                       | EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles" | EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles"
                       | EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles"))


total_emissions_vehicle_by_year <- with(nei_scc_vehicle_baltimore, tapply(Emissions, year, sum, na.rm = T))

year <- as.numeric(names(total_emissions_vehicle_by_year))

total_emissions <- unname(total_emissions_vehicle_by_year[1:length(total_emissions_vehicle_by_year)])

total_emissions_vehicle_by_year <- data.frame(year, total_emissions)

png(file="plot5.png")

with(total_emissions_vehicle_by_year, {plot(year, total_emissions, xlab = "Year", ylab=" Total PM2.5 Emissions", type='l', pch=19, xlim = c(1999, 2008), xaxt = "n")
    axis(side = 1, at = year, labels = year)})

title(main = "Total PM2.5 Emissions from motor vehicle sources in Baltimore")

dev.off()