# Question: 6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
# California fips == "06037". 
# Which city has seen greater changes over time in motor vehicle emissions?

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./data/exdata_data_NEI_data/Source_Classification_Code.rds")

nei_scc <- merge(NEI, SCC, by = "SCC")

nei_scc_vehicle_bt_la <- subset(nei_scc, (fips == "24510" | fips == "06037") & (EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles"
                                                                | EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles" | EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles"
                                                                | EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles"))

nei_scc_vehicle_bt_la <- transform(nei_scc_vehicle_bt_la, CountyName= ifelse(fips=="24510","Baltimore", "LosAngeles"))

library(dplyr)

total_emissions_by_fips_year <- nei_scc_vehicle_bt_la %>%
    group_by(CountyName, year) %>%
    summarise(total_emissions = sum(Emissions))

library(ggplot2)

g <- ggplot(total_emissions_by_fips_year, aes(year, total_emissions))

g + geom_line(aes(color = CountyName)) + labs(x = "Year") + labs(y = "Total PM2.5 Emissions") + labs(title = "Total PM2.5 Emissions in Baltimore and Los Angeles")

ggsave("plot6.png")
