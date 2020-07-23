# Question: 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./data/exdata_data_NEI_data/Source_Classification_Code.rds")

NEI_baltimore <- subset(NEI, fips == "24510")

library(dplyr)

total_emissions_by_type_year <- NEI_baltimore %>%
                                    group_by(type, year) %>%
                                    summarise(total_emissions = sum(Emissions))


library(ggplot2)

g <- ggplot(total_emissions_by_type_year, aes(year, total_emissions))

g + geom_line() + facet_wrap(.~type, nrow = 2, ncol = 2) + labs(x = "Year") + labs(y = "Total PM2.5 Emissions") + labs(title = "Total PM2.5 Emissions by type over the years")

ggsave("plot3.png")