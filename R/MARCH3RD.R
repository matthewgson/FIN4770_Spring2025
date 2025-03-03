# Given a vector of stock prices:
# prices <- c(25, 45, 55, 65)

# Write R code using a for loop with if-else to compute dividends for each stock. Use the following rules:
# • If the price is greater than $50, dividend = price × 0.03
# • If the price is between $30 and $50 (inclusive), dividend = price × 0.02
# • Otherwise, dividend = price × 0.01
# What is the resulting dividend vector, when added ? (i.e.  Calculate sum(dividend) )

prices <- c(25, 45, 55, 65)
dividend <- vector("numeric", length = length(prices))
for (i in seq_along(prices)) {
  if (prices[[i]] > 50) {
    dividend[[i]] <- prices[[i]] * 0.03
  } else if (prices[[i]] > 30) {
    dividend[[i]] <- prices[[i]] * 0.02
  } else {
    dividend[[i]] <- prices[[i]] * 0.01
  }
}
sum(dividend)

library(tidyverse)
dividends <- case_when(
  prices > 50 ~ 0.03 * prices,
  prices > 30 ~ 0.02 * prices,
  TRUE ~ 0.01 * prices
)

sum(dividends)

# dplyr
getwd()
library(tidyverse)
fin_data <- read_csv("Company_financials.csv")
fin_data |> head()

names(fin_data)


fin_data |>
  select(ticker, Industry)

fin_data |>
  select(1:5, 7:10)

fin_data |>
  select(starts_with("net"))

fin_data |>
  select(ticker)

fin_data |>
  pull(ticker)


# filter

fin_data |>
  filter(
    year > 2022,
    year < 2024,
    Industry %in% c("Financials", "Healthcare")
  )

fin_data |>
  select(starts_with("current"))


fin_data |>
  filter(
    if_all(starts_with("current"), \(x) x > 1e11)
  )


fin_data |>
  slice_max(current_assets, n = 3) |>
  relocate(current_assets)


fin_data |>
  distinct(Industry) # distinct values of Industry

fin_data |>
  distinct(Industry, .keep_all = TRUE) # keeps other columns


# arrange
fin_data |>
  arrange(ticker, year)
