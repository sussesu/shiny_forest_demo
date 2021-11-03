# install.packages('gsheet')
library(gsheet)
library(ggplot2)
library(tidyverse)

u <- "" # add url for google sheet here (check sharing settings if it doesn't work)

vastaukset <- read.csv(text=gsheet2text(u, format='csv'), stringsAsFactors=FALSE, 
         skip=1, header = FALSE, 
         col.names = c("timestamp", "metsa", "keskiarvo", "keskihajonta"))


df_list <-list ()
for(i in 1:nrow(vastaukset)) {
  df_list[[i]] <- data.frame(id = rep(i, 60),
                             metsa = rep(vastaukset$metsa[i], 60),
                             dbh = 1:60,
                             density = dnorm(1:60, 
                                             vastaukset$keskiarvo[i],
                                             vastaukset$keskihajonta[i]))
}

final_densities <- do.call(rbind, df_list)

final_densities %>%
  ggplot(aes(dbh, density, col=factor(id))) +
  geom_line() + 
  facet_wrap(metsa ~ ., ncol=3) +
  theme(legend.position = "none") +
  xlab("Rungon läpimitta (cm)") 
