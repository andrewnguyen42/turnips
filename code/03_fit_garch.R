library(here)
library(rugarch)
library(tsibble)

load(here('data/turnips.Rdata'))

data <- as_tsibble(data, index = dt)

spec <- ugarchspec()

dat <- data %>%
  filter(!is.na(diff)) %>%
  .$diff


fit <- ugarchfit(data = dat, spec = spec)

infocriteria(fit)
coef(fit)
forc = ugarchforecast(fit, n.ahead = 7)
plot(forc, which = 1)
