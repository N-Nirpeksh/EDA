NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
head(NEI)
head(SCC)
library(ggplot2)
library(plyr)
CoalCombustionSCC <- subset(SCC, EI.Sector %in% c("Fuel Comb - 
                            Comm/Institutional - Coal",
                                                  "Fuel Comb - Electric Generation - Coal",
                                                  "Fuel Comb - Industrial Boilers, ICEs - Coal"))

CoalCombustionSCC1 <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", 
                                                                    Short.Name))

d3 <- setdiff(CoalCombustionSCC$SCC, CoalCombustionSCC1$SCC)
d4 <- setdiff(CoalCombustionSCC1$SCC, CoalCombustionSCC$SCC)
length(d3)
CoalCombustionSCCCodes <- union(CoalCombustionSCC$SCC, CoalCombustionSCC1$SCC)
length(CoalCombustionSCCCodes)

CoalCombustion <- subset(NEI, SCC %in% CoalCombustionSCCCodes)

coalCombustionPM25ByYear <- ddply(CoalCombustion, .(year, type), function(x) 
  sum(x$Emissions))
colnames(coalCombustionPM25ByYear)[3] <- "Emissions"

qplot(year, Emissions, data = coalCombustionPM25ByYear, color = type, 
      geom = "line") + ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ 
                                            "Emissions by Source Type and Year")) + xlab("Year") + 
  ylab(expression  ("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.copy(png,filename="plot4.png");
dev.off ()