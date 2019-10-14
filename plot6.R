library(tidyverse)

# road data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# join the two data set
df <- left_join(NEI, SCC, by = "SCC")

# "Mobile XXXX Vehicles" named rows in EI.Sector column
df_veh <- subset(df, grepl("Mobile.*Vehicles", df$EI.Sector))

# subset Boltimore and LA
df_veh1 <- subset(df_veh, df_veh$fips == "24510" | df_veh$fips == "06037")

# rename fips to city name
fips_name <- data.frame(fips = c("24510", "06037"), city = c("Baltimore City", "Los Angeles County"))
df_veh2 <- inner_join(df_veh1, fips_name, by = "fips")

# total emmision by year
totalEmission1 <- df_veh2 %>% 
        group_by(year, city) %>%
        summarise(Emissions = sum(Emissions, na.rm = TRUE))

# ggplot
png(filename = "plot6.png", width = 480, height = 480, units = "px")
g <- ggplot(totalEmission1, aes(x = year, y = Emissions, group = city, color = city))
g + geom_point() + geom_line() + labs(x = "year", y = "total PM2.5 emission in tons", title = "Emissions from vehicle related sources")
dev.off()