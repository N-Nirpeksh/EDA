NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
head(NEI)
head(SCC)
library(ggplot2)
library(plyr)
typePM25ByYear <- ddply(BaltimoreCity, .(year, type), function(x) sum(x$Emissions))
colnames(typePM25ByYear)[3] <- "Emissions"
qplot(year, Emissions, data = typePM25ByYear, color = type, geom = "line") +
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ 
                       "Emissions by Source Type and Year")) + xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.copy(png,filename="plot3.png");
dev.off ()