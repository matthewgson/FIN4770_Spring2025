a <- c(1, 2, 3, NA)

typeof(a)

iris
library(tidyverse)
iris[151, ] <- c(1.5, 1.5, 1.5, NA, "example")
iris |>
  filter() |>
  summarize(mean(Petal.Width, na.rm = TRUE))
?bind_rows

a[!is.na(a)]

sum(a, na.rm = TRUE)
?sum


TRUE | NA
FALSE & NA
FALSE | NA

c(TRUE, FALSE) | c(FALSE, TRUE)

c(TRUE, FALSE) && c(FALSE, TRUE)

numbers <- 1:10
numbers

numbers[(numbers %% 2) == 0]


x <- c(1, 2, 3, 4, 5)


(x > 3) | (x < 5)
(x > 3) & (x < 5)


x <- c("apple", "banana", "cherry")
x %in% c("apple", "grape")

x[x %in% c("apple", "grape")]
library(tidyverse)

my_sample <- c("Banana", "setosa")

iris |>
  distinct(Species)

iris |>
  filter(Species %in% my_sample)


print(1 / 49, digits = 22)


any(c(NA, TRUE, FALSE, TRUE, FALSE, NA))
all(c(NA, TRUE, TRUE), na.rm = TRUE)


x <- c(TRUE, FALSE, TRUE)
any(x)
all(x)

y <- c(FALSE, FALSE, FALSE)
any(y)
all(y)


q1 <- 1:10 > 5


q2 <- 1:20
q2[(q2 %% 2) == 0]


tickers <- c("AAPL", "MSFT", "GOOG", "AMZN")
portfolio <- c("AAPL", "TSLA", "GOOG")

tickers[tickers %in% portfolio]

library(tidyverse)

iris |>
  filter(Species %in% c("Banana", "setosa"))


daily_returns <- c(0.01, NA, -0.005, 0.02, NA)

(daily_returns > 0) |> any()

all(daily_returns > 0)

daily_returns > 0
