library(tidyverse)

# road data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# join the two data set
df <- left_join(NEI, SCC, by = "SCC")

# "Mobile XXXX Vehicles" named rows in EI.Sector column
df_veh <- subset(df, grepl("Mobile.*Vehicles", df$EI.Sector))

# subset data in Boltimore
df_veh_Bol <- subset(df_veh, df_veh$fips == "24510")

# total emmision by year
totalEmission_veh_Bol_byYear <- df_veh_Bol %>% 
        group_by(year) %>%
        summarise(Emissions = sum(Emissions, na.rm = TRUE))

# ggplot
png(filename = "plot5.png", width = 480, height = 480, units = "px")
g <- ggplot(totalEmission_veh_Bol_byYear, aes(x = year, y = Emissions))
g + geom_point() + geom_line() + labs(x = "year", y = "total PM2.5 emission in tons", title = "Emission from vehicle related sources in Boltimore City")
dev.off()