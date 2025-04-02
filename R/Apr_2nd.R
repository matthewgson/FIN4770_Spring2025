library(tidyverse)
price_str <- c("123.45", "67.89", "1e3")
typeof(price_str) # character

price_str
parsed_price <- parse_double(price_str)
print(parsed_price)
typeof(parsed_price)

as.numeric(price_str)


bond_yields1 <- c(3.5, 3.6, 3.7)
bond_yields2 <- c(3.8, 3.4, 3.9)
yields <- tibble(bond_yields1, bond_yields2)


yields |>
  mutate(
    min_yield = pmin(bond_yields1, bond_yields2),
    max_yield = pmax(bond_yields1, bond_yields2),
    .keep = "unused"
  )


prices <- c(100, 102, 101, 105, 107)

results <- tibble(
  Day = 1:length(prices),
  Price = prices
)
results <- results |>
  mutate(
    arith_ret = Price / lag(Price) - 1,
    log_ret = log(Price / lag(Price)),
    convert_log_ret = exp(log_ret) - 1
  ) |>
  drop_na()

# cumulative returns
results |>
  mutate(
    cum_arith_ret = cumprod(1 + arith_ret) - 1,
    cum_log_ret = cumsum(log_ret),
    convert_cum_log_ret = exp(cum_log_ret) - 1
  )


div_yields <- c(0.02, 0.03, 0.05, 0.07, 0.1)
div_yields

yield_bins <- cut(div_yields, breaks = c(0, 0.03, 0.06, 0.1))

yield_bins

yield_bins <- cut(
  div_yields,
  breaks = c(0, 0.03, 0.06, 0.1),
  labels = c("Low", "Medium", "High")
)

yield_bins
class(yield_bins)
typeof(yield_bins)


# lead / lag

prices <- c(150, 155, 160, 158)
lag(prices) # previous
lag(prices, 2) # 2 times previous
lead(prices) # after
