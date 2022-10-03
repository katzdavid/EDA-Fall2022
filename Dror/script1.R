library(tidyverse)

rm(list=ls())

df <- read_csv("Data/Raw/EPAair_O3_NC2018_raw.csv")


# lets explore the dataframe
summary(df)
head(df)
names(df)

df_avg_county <- df %>%
  group_by(COUNTY) %>% 
  summarize(avg_aqi = mean(DAILY_AQI_VALUE))

hist(df_avg_county$avg_aqi)

df <- df %>%
  group_by(COUNTY) %>% 
  mutate(avg_aqi = cumsum(DAILY_AQI_VALUE))

df1 <- df %>% 
  ungroup %>% 
  select(c(1,3,5))

df1 <- df %>% 
  filter(avg_aqi>1000)

df1 <- df %>%
  ungroup %>% 
  slice(1:100)

write_csv(df1, "Dror/dror_data.csv")
