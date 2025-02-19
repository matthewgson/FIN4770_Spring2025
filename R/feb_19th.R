for (i in 1:10) {
  print(i)
}

count <- 1
while (count < 11) {
  if (count == 5) {
    break
  }
  print(count)
  count <- count + 1 # add 1
}

# map

plus_one <- function(a) {
  return(a + 1)
}
library(tidyverse)
map(1:3, plus_one)

output <- vector("list", 3)

for (i in 1:3) {
  output[[i]] <- plus_one(i)
}
output

stock_prices <- c(100, 200, 300)
holdings <- c(10, 30, 60)

# vectorization
stock_prices * holdings
# for loop
portfolio_value <- vector("numeric", 3)
for (i in 1:3) {
  portfolio_value[[i]] <- stock_prices[[i]] * holdings[[i]]
}
print(portfolio_value)

map2(stock_prices, holdings, `*`) |> class()
map2_dbl(stock_prices, holdings, `*`) |> class()

# Exercise

stock_prices <- c(150, 250, 100, 250, 300)
shares_held <- c(10, 5, 20, 5, 10)

portfolio_value <- vector("numeric", length(stock_prices))

for (i in seq_along(stock_prices)) {
  portfolio_value[[i]] <- stock_prices[[i]] * shares_held[[i]]
}
portfolio_value
stock_prices * shares_held

# vectorized if-else

stock_prices <- c(45, 60, 52, 48, 55, 49)

ifelse(
  stock_prices > 53,
  "Bull",
  "Bear"
)

#
iris |>
  head(2)
