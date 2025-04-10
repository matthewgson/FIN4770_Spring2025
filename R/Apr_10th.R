# Missing Values

library(tidyverse)
financial_data <- tibble(
  company = c(
    "AAPL",
    "AAPL",
    "AAPL",
    "AAPL",
    "AAPL",
    "AAPL",
    "TSLA",
    "TSLA",
    "TSLA",
    "TSLA",
    "TSLA",
    "TSLA"
  ),
  year = c(
    2020,
    2020,
    2020,
    2021,
    2021,
    2021,
    2020,
    2020,
    2020,
    2021,
    2021,
    2021
  ),
  quarter = c(1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3),
  revenue = c(100, NA, 110, 200, NA, NA, NA, NA, NA, 210, 220, NA)
)

# Use tidyr::complete()

exp_financial_data <- financial_data |>
  complete(company, year, quarter = 1:4)


# Fill NA with designated value
exp_financial_data |>
  mutate(revenue = ifelse(is.na(revenue), 0, revenue))

exp_financial_data |>
  replace_na(list(revenue = 100))


# Fill with LOCF ("down") / NOCB ("up")

exp_financial_data |>
  fill(revenue, .direction = "down") # error, needs fix

exp_financial_data |>
  arrange(company, year, quarter) |>
  group_by(company) |>
  fill(revenue, .direction = "down") # correct one


# Linear Interpolation

daily_return <- c(0.01, NA, -0.01, NA, 0.05) # considered as y axis
length(daily_return) # length 5

approx(daily_return) |>
  as_tibble() |>
  ggplot(aes(x = x, y = y)) +
  geom_line() +
  geom_point() +
  theme_bw()


approx(daily_return, xout = 1:5) |>
  as_tibble() |>
  ggplot(aes(x = x, y = y)) +
  geom_line() +
  geom_point() +
  theme_bw()

approx(daily_return, xout = 1:5)$y


day <- c(1, 2, 16, 20, 26)
daily_return <- c(0.01, NA, -0.01, NA, 0.05)

approx(x = day, y = daily_return, xout = day) |>
  as_tibble() |>
  ggplot(aes(x = x, y = y)) +
  geom_line() +
  geom_point() +
  theme_bw()

approx(x = day, y = daily_return, xout = day)$y


# Treasury yield interpolation

treasury_data <- tibble(
  date = as.Date(c("2025-04-01", "2025-04-02", "2025-04-03", "2025-04-04")),
  x6_mo = c(4.23, 4.24, 4.20, 4.14),
  x1_yr = c(4.01, 4.04, 3.92, 3.86),
  x2_yr = c(3.87, 3.91, 3.71, 3.68)
)

print(treasury_data)

treasury_data |>
  pivot_longer(cols = !date) |>
  complete(date, name = c("x6_mo", "x9_mo", "x1_yr", "x2_yr")) |>
  mutate(name = fct(name, levels = c("x6_mo", "x9_mo", "x1_yr", "x2_yr"))) |>
  arrange(date, name) |>
  mutate(
    days = case_when(
      name == "x6_mo" ~ 180,
      name == "x9_mo" ~ 270,
      name == "x1_yr" ~ 360,
      name == "x2_yr" ~ 720,
    )
  ) |>
  mutate(
    interpolated_yield = approx(x = days, y = value, xout = days)$y
  )

# Character Vectors

announcement1 <- 'Tariff will be 34%'
announcement2 <- "Actually, it will be 125%!"
quote_in_quotes <- 'If you want to include "quote" inside, mix \' and \"'

error <- 'If you want to inclue \'quote\' inside'

print(quote_in_quotes)
cat(quote_in_quotes)
str_view(quote_in_quotes)


double_quotes <- c("\"", '"')
print(double_quotes)
cat(double_quotes)
str_view(double_quotes)

backslashes <- c("\\", '\\')
print(backslashes)
cat(backslashes)
str_view(backslashes)

x <- c("one\ntwo", "one\ttwo", "\U0001f604")
print(x) # print gives you the structure
cat(x)
str_view(x)


tricky <- "
Without raw strings,
Double backslashes \\\\ and 
double double quotes '\"\"' with quotes
will make you crazy."
cat(tricky)

not_so_tricky <- r"(
With raw strings,
writing double backslashes \\ and
double double quotes '""' wrapped with quotes
will not be so hard.
)"

cat(not_so_tricky)
str_view(not_so_tricky)


# str_c()

str_c("Report for", c("Acme Corp", "Beta Inc"), sep = " ") |> str_view()

# str_glue()

company <- c("Microsoft Inc.", "Apple Inc.")

naive <- "Earnings: {company} reported strong results."

str_glue("Earnings: {company} reported strong results.")


# str_flatten()

forecast <- c("There", "will", "be", "a", "strong", "market", "volatility.")
length(forecast)
print(forecast)
str_view(forecast)

str_flatten(forecast, collapse = " ")


length(forecast)


# Letters: str_length()

example_string <- c("risk free rates", "earnings announcements")
length(example_string)

str_length(example_string)


# Subsetting with positional arguments: str_sub()

?str_sub()

str_sub(example_string, -3, -1)


# Padding strings

x <- c("Apple", "Microsoft")
str_length(x)

str_pad(x, width = 10) |> str_view()

numbers <- c("1", "15", "563")
str_view(numbers)

str_pad(numbers, width = 3, pad = "0")


# Letter case transformation

x <- "Economists say that it can cause stagflation."
str_to_upper(x)
str_to_lower(x)
str_to_title(x)
