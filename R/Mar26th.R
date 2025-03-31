library(tidyverse)

# The valid bond ratings
rating_levels <- c("AAA", "AA", "A", "BBB", "BB", "B", "CCC")

# Create a factor of bond ratings using valid levels
ratings <- fct(c("BBB", "AA", "A", "CCC"), levels = rating_levels)
ratings


sort(ratings)

fct(c("BBB", "AA", "D", "A"), levels = rating_levels)


# attributes

attributes(ratings)

# levels attribute

levels(ratings)


rating_levels <- c(
  "AAA",
  "AA",
  "A",
  "BBB",
  "BB",
  "B",
  "CCC"
) # possible values

bond_ratings <- fct(
  c("AAA", "BBB", "A", "BB", "AA"),
  levels = rating_levels
)
bond_ratings

# recode

fct_recode(bond_ratings, "Top Tier" = "AAA", "Junk" = "BB")

# fct_collapse
bond_ratings = fct(c("AAA", "AA", "A", "BBB", "BB", "B"))

collapsed_ratings <- fct_collapse(
  bond_ratings,
  "Investment Grade" = c("AAA", "AA", "A"),
  "Junk" = c("BBB", "BB", "B")
)
print(collapsed_ratings)


stock_returns <- tibble(
  Ticker = fct(c("AAPL", "MSFT", "GOOG", "JPM", "BAC")),
  Sector = fct(c(
    "Technology",
    "Technology",
    "Technology",
    "Financial",
    "Financial"
  )),
  Return = c(0.12, 0.08, 0.10, 0.05, 0.04)
)

stock_returns$Ticker

stock_returns |>
  mutate(Reordered_Ticker = fct_relevel(Ticker, "GOOG")) |>
  pull(Reordered_Ticker)

ratings_full <- factor(
  c(
    "AAA",
    "AA",
    "A",
    "BBB",
    "BB",
    "B",
    "CCC",
    "AA",
    "CCC",
    "B",
    "BBB",
    "D",
    "E",
    "A",
    "BBB",
    "BBB"
  )
)

ratings_full

fct_other(ratings_full, keep = c("AAA", "AA", "A"), other_level = "JUNK") # only investment grade
?fct_other
ratings_full

fct_lump(ratings_full, n = 2)

# Excercise

market_regime <- fct(
  c("Bear", "Sideways", "Bull"),
  levels = c("Bull", "Sideways", "Bear")
)
print(market_regime)

market_regime2 <- fct_recode(
  market_regime,
  "Downturn" = "Bear",
  "Flat" = "Sideways",
  "Upturn" = "Bull"
)
print(market_regime2)

# Exercise 2

regional_sales <- tibble(
  region = c(
    "Northwest",
    "Southeast",
    "Midwest",
    "Northeast"
  ),
  avg_sales = c(120, 80, 150, 100)
)

regional_sales |>
  ggplot(aes(x = fct_reorder(region, avg_sales), y = avg_sales)) +
  geom_col()


investment_style <-
  fct(
    c(
      "Growth",
      "Value",
      "Blend",
      "Contrarian",
      "Speculative",
      "Growth",
      "Value"
    )
  )

investment_style

fct_collapse(
  investment_style,
  "Traditional" = c("Growth", "Value", "Blend"),
  "Alternative" = c("Contrarian", "Speculative")
)

currencies <- c(
  "USD",
  "EUR",
  "JPY",
  "USD",
  "GBP",
  "AUD",
  "KRW",
  "EUR",
  "USD",
  "USD",
  "EUR"
)

fct_other(currencies, keep = "USD")
?fct_other

fct_lump(currencies, n = 2)
fct_lump(currencies, prop = 0.25)
