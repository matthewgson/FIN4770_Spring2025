library(tidyverse)

fin_data <- read_csv("Company_financials.csv")

fin_data |>
  mutate(
    debt_asset_ratio = current_debt / current_assets,
    total_equity = total_assets - total_debt
  )


fin_data |>
  arrange(ticker, year)

fin_data |>
  mutate(
    debt_to_asset_ratio = current_debt / current_assets
  )


# summarize

fin_data |>
  summarize(
    avg_current_assets = mean(current_assets, na.rm = TRUE),
    max_current_assets = max(current_assets, na.rm = TRUE)
  )

fin_data |>
  group_by(ticker) |>
  summarize(
    avg_current_assets = mean(current_assets, na.rm = TRUE),
    max_current_assets = max(current_assets, na.rm = TRUE)
  )

fin_data |>
  filter(ticker == "BRK-B") |>
  select(
    ticker,
    year,
    current_assets,
    starts_with("current"),
    ends_with("assets")
  )


summary_data <- fin_data |>
  group_by(ticker) |>
  summarize(
    avg_current_assets = mean(current_assets, na.rm = TRUE),
    max_current_assets = max(current_assets, na.rm = TRUE)
  ) |>
  ungroup()

fin_data |>
  summarize(
    avg_current_assets = mean(current_assets, na.rm = TRUE),
    max_current_assets = max(current_assets, na.rm = TRUE),
    .by = ticker
  )


summary_table <- fin_data |>
  select(ticker, year, current_assets) |>
  arrange(ticker, year) |>
  group_by(ticker) |>
  mutate(
    yearly_asset_growth = current_assets / lag(current_assets) - 1,
  ) |>
  summarize(
    avg_asset_growth = mean(yearly_asset_growth, na.rm = TRUE),
  )

summary_table |>
  summarize(max(avg_asset_growth, na.rm = TRUE))
