m <- prophet(data, weekly.seasonality = TRUE) 

future <- make_future_dataframe(m
                                , periods = 24*7
                                , freq = 3600) %>%
  filter(hour(ds) %in% c(13, 0))

forecast <- predict(m, future) %>%
  mutate(day = wday(ds, label = T))

plot(m, forecast) + 
  geom_vline(data = forecast %>% filter(day == 'Mon', hour(ds) == 0)
             , aes(xintercept = ds), linetype = 'dashed')

prophet::prophet_plot_components(m, forecast)
