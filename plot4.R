library(tidyverse)

# road data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# join the two data set
df <- left_join(NEI, SCC, by = "SCC")

# subset "Fuel Comb XXXX Coal" named rows in EI.Sector column
df_coal <- subset(df, grepl("Fuel Comb.*Coal", df$EI.Sector))

# total emmision by year
totalEmissionCoal_byYear <- df_coal %>% 
        group_by(year) %>%
        summarise(Emissions = sum(Emissions, na.rm = TRUE))

# ggplot
png(filename = "plot4.png", width = 480, height = 480, units = "px")
g <- ggplot(totalEmissionCoal_byYear, aes(x = year, y = Emissions))
g + geom_point() + geom_line() + labs(x = "year", y = "total PM2.5 emission in tons", title = "Emissions from coal combustion-related sources")
dev.off()