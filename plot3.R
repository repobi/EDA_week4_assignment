library(tidyverse)

# road data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# join the two data set
df <- left_join(NEI, SCC, by = "SCC")

# subset with Boltimore
Emission_Boltimore <- subset(df, df$fips == "24510")

# total emissions by year in Boltimore
totalEmission_byYear_Bol1 <- Emission_Boltimore %>% 
        group_by(year, type) %>% 
        summarise(Emission = sum(Emissions, na.rm = TRUE))

# ggplot; facet in type groups
png(filename = "plot3.png", width = 480, height = 480, units = "px")
g <- ggplot(totalEmission_byYear_Bol1, aes(x = year, y = Emission))
g + geom_point() + geom_line() + facet_wrap(~type) + labs(x = "year", y = "total PM2.5 emission in tons", title = "PM2.5 total emissions in Boltimore City")
dev.off()