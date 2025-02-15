stock_prices <- c(100, 250, 200, 300)
attributes(stock_prices)
names(stock_prices) <- c("AAPL", "MSFT", "NVDA", "AMZN")

names(stock_prices)
attributes(stock_prices)

today <- Sys.Date()

attributes(today)
unclass(today)
today + 1
