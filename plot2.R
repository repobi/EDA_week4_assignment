library(tidyverse)

# road data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# join the two data set
df <- left_join(NEI, SCC, by = "SCC")

# subset with Boltimore
Emission_Boltimore <- subset(df, df$fips == "24510")

# total emissions by year in Boltimore
totalEmission_byYear_Bol0 <- Emission_Boltimore %>% 
        group_by(year) %>% 
        summarise(Emissions = sum(Emissions, na.rm = TRUE))

#base plot
png(filename = "plot2.png", width = 480, height = 480, units = "px")
with(totalEmission_byYear_Bol0, plot(x = year, y = Emissions, 
                                     main = "PM2.5 total emissions in Boltimore City", 
                                     type = "l", 
                                     xlab = "yaer", ylab = "total PM2.5 emission in tons"))
dev.off()