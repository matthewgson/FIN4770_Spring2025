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

crypto_data <- crypto_data |>
  arrange(symbol, date) |>
  group_by(symbol) |>
  mutate(daily_ret = adjusted / lag(adjusted) - 1) |> # arithmetic return
  ungroup()


performance_metrics <- crypto_data |>
  group_by(symbol) |>
  summarize(
    avg_daily_ret = mean(daily_ret, na.rm = TRUE),
    vol_daily = sd(daily_ret, na.rm = TRUE)
  )
performance_metrics


# bar plot

performance_metrics |>
  ggplot(
    aes(x = symbol, y = avg_daily_ret)
  ) +
  geom_col()


performance_metrics |>
  mutate(symbol = fct_reorder(symbol, desc(avg_daily_ret))) |>
  pivot_longer(cols = c(avg_daily_ret, vol_daily)) |>
  ggplot(
    aes(x = symbol, y = value, fill = name)
  ) +
  geom_col(position = "dodge") +
  labs(
    fill = "Metric"
  )


performance_metrics |>
  mutate(symbol = fct_reorder(symbol, desc(avg_daily_ret))) |>
  pivot_longer(cols = !symbol) |> # make long form
  ggplot(
    aes(x = symbol, y = value, fill = name)
  ) +
  geom_col(position = "dodge") +
  scale_y_continuous(labels = scales::percent_format()) +
  labs(
    title = "Average Daily Return / Volatility of Cryptos",
    subtitle = "Year 2020 - 2022",
    caption = "Data: Yahoo Finance",
    x = "Crypto",
    y = "Average Return / Volatility (%)",
    fill = "Metric"
  )

# Two Y-axis visualization

scale_factor <- max(performance_metrics$avg_daily_ret) /
  max(performance_metrics$vol_daily)


performance_metrics |>
  ggplot(
    aes(x = fct_reorder(symbol, desc(avg_daily_ret)))
  ) +
  geom_col(
    aes(y = avg_daily_ret, fill = "Average Return"),
    width = 0.4,
    position = position_nudge(x = -0.25)
  ) +
  geom_col(
    aes(y = vol_daily * scale_factor, fill = "SD Return"),
    width = 0.4,
    position = position_nudge(x = 0.25)
  ) +
  scale_y_continuous(
    labels = scales::label_percent(),
    sec.axis = sec_axis(
      \(x) x / scale_factor,
      labels = scales::label_percent()
    )
  )

?sec_axis
sec_axis(
  \(x) x / scale_factor,
  name = "Volatility (%)",
  labels = scales::percent_format()
)


# Portfolio sorting

ranks <- crypto_data |>
  group_by(symbol) |>
  summarize(avg_daily_volume = mean(volume, na.rm = TRUE))

ranks <- ranks |>
  mutate(volume_rank = ntile(avg_daily_volume, 5)) # 5 being highest (ascending)

# get future data to test

future_crypto <- tq_get(crypto_coins, from = "2023-01-02", to = "2023-02-01")
future_crypto <- future_crypto |>
  arrange(symbol, date) |>
  group_by(symbol) |>
  mutate(daily_ret = adjusted / lag(adjusted) - 1)

future_crypto <- future_crypto |>
  left_join(ranks, by = join_by(symbol))


future_crypto |>
  group_by(volume_rank) |>
  summarize(avg_daily_ret = mean(dail_ret, na.rm = TRUE))
