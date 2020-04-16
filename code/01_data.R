library(googlesheets)
library(tidyverse)
library(lubridate)
library(here)

data <- gs_url('https://docs.google.com/spreadsheets/d/1CpvNhAKaN2r0gfzfBcMmnvrsSvX-y2aqBG6HUvySNSU/edit?usp=sharing') %>% 
  gs_read(ws = 'turnips') %>%
  mutate(date = mdy(date)
         , weeks = lubridate::weeks(date)
         , dt = as_datetime(date) + hours(13*!morning)
         , ds = dt
         , day = wday(date, label = T)
         , diff = price - lag(price)
         , y = price) 
  
save(data, file = here::here('data/turnips.Rdata'))


