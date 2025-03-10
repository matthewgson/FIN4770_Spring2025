# install.packages("tidyquant")
library(tidyquant)
library(tidyverse)


crypto_coins <- c(
  "BTC-USD",
  "ETH-USD",
  "BNB-USD",
  "SOL-USD",
  "XRP-USD",
  "DOT-USD",
  "DOGE-USD",
  "MATIC-USD",
  "ADA-USD"
)

crypto_data <- tq_get(
  crypto_coins,
  from = "2020-01-01",
  to = "2023-01-01"
)

# generate return based on adjusted
crypto_data <- crypto_data |>
  arrange(symbol, date) |>
  group_by(symbol) |>
  mutate(daily_ret = adjusted / lag(adjusted) - 1)

crypto_data

# performance metrics
performance_metrics <- crypto_data |>
  group_by(symbol) |>
  summarize(
    avg_daily_return = mean(daily_ret, na.rm = TRUE),
    sd_daily_return = sd(daily_ret, na.rm = TRUE)
  )

# grapics: ggplot

?fct_reorder()

performance_metrics |>
  ggplot(aes(
    x = fct_reorder(symbol, -avg_daily_return),
    y = avg_daily_return,
    fill = symbol
  )) +
  geom_col(color = "green4") +
  theme_bw() +
  scale_y_continuous(
    labels = scales::percent_format()
  ) +
  labs(
    title = "Crypto Average Daily Returns",
    subtitle = "From 2020-2022",
    caption = "Source: Yahoo Finance",
    y = "Percentage Return (%)",
    x = "Coins",
    fill = "Crypto Symbol"
  )


performance_long <- performance_metrics |>
  pivot_longer(
    cols = ends_with("return")
  )

performance_long |>
  ggplot(aes(x = fct_reorder(symbol, -value), y = value, fill = name)) +
  geom_col(position = "dodge")

# Use of AI to get help

ordering <- performance_long |>
  filter(name == "avg_daily_return") |>
  arrange(desc(value)) |>
  pull(symbol)

# Use the ordering vector for the x-axis
performance_long |>
  ggplot(aes(x = factor(symbol, levels = ordering), y = value, fill = name)) +
  geom_col(position = "dodge") +
  labs(
    title = "Cryptocurrency Performance Metrics",
    x = "Cryptocurrency",
    y = "Value"
  ) +
  theme_minimal()
