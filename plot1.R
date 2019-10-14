library(tidyverse)

# road data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# join the two data set
df <- left_join(NEI, SCC, by = "SCC")

# total emmision by year
totalEmission_byYear <- df %>% 
        group_by(year) %>% 
        summarise(Emissions = sum(Emissions, na.rm = TRUE))
#base plot
png(filename = "plot1.png", width = 480, height = 480, units = "px")
with(totalEmission_byYear, plot(x = year, y = Emissions, 
                                main = "PM2.5 total emissions in the Unite States", 
                                type = "l", 
                                xlab = "yaer", ylab = "total PM2.5 emission in tons"))
dev.off()