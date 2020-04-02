library(googlesheets)
library(tidyverse)
library(lubridate)

data <- gs_url('https://docs.google.com/spreadsheets/d/1CpvNhAKaN2r0gfzfBcMmnvrsSvX-y2aqBG6HUvySNSU/edit?usp=sharing') %>% 
  gs_read(ws = 'turnips') %>%
  mutate(date = mdy(date)
         , dt = as_datetime(date) + hours(13*!morning)
         , day = wday(date, label = T)
         , diff = price - lag(price))

data %>%
  ggplot(aes(x = dt, y = price)) +
  geom_line() +
  geom_point(aes(shape = morning))

data %>%
  ggplot(aes(x = dt, y = price)) +
  geom_line() +
  facet_wrap(vars(morning))

data %>%
  mutate(diff = price - lag(price)) %>%
  ggplot(aes(x = dt, y = diff)) +
  geom_line() 
