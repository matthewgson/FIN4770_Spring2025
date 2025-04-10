library(tidyverse)

current_date <- today()
current_datetime <- now()

class(current_date)
print(current_date)
class(current_datetime)

sample_table <- tibble(
  date = current_date,
  datetime = current_datetime
)

sample_table


csv <- "
  date, datetime
  2022-01-02,2022-01-02 05:12
"
read_csv(csv)


read_csv(csv, col_types = cols(date = col_date("%m/%d/%y")))
read_csv(csv, col_types = cols(date = col_date("%d/%m/%y")))
read_csv(csv, col_types = cols(date = col_date("%y/%m/%d")))


csv <- "
  date
  01/02/15
  02/01/15
  03/02/15
"

read_csv(csv) |>
  mutate(date_formatted = mdy(date))


trade_datetime_24 <- "2023-05-15 09:30:00"
trade_datetime_12 <- "May 15, 2023 09:30 AM"
trade_datetime_24_tz <- "2023-05-15 09:30:00 EST"

ymd_hms(trade_datetime_24) # UTC by default
ymd_hms(trade_datetime_24, tz = "EST") # set time zone at EST
mdy_hm(trade_datetime_12)
ymd_hms(trade_datetime_24_tz) # time zone should be mentioned


datetime <- ymd_hms("2023-01-01 12:00:00", tz = "America/New_York")
print(datetime)

datatime_converted <- with_tz(datetime, tzone = "America/Los_Angeles")

unclass(datetime)
unclass(datatime_converted)


market_close <- ymd_hms("2023-01-01 16:00:00", tz = "America/Chicago")
print(market_close)
unclass(market_close)
a <- force_tz(market_close, tzone = "America/New_York")
unclass(a)

market_close


datetime <- ymd_hms("2026-07-08 12:34:56")
class(datetime) # POSIXct
datetime
year(datetime)
month(datetime)
day(datetime)

mday(datetime) # same as day()


yday(datetime)

wday(datetime)


wday(datetime, label = TRUE)

hour(datetime)
minute(datetime)
second(datetime)


last_traded_time <- "2024-09-08 13:33:45.653 EST"
last_traded_time <- ymd_hms(last_traded_time, tz = "America/New_York")
last_traded_time

floor_date(last_traded_time, unit = "14 hours")

# Round down above trading time by “1 day”, “10 hours”, “5 minutes”, “10 seconds”

floor_date(last_traded_time) # by default, second
ceiling_date(last_traded_time)
floor_date(last_traded_time, unit = "10 seconds")
floor_date(last_traded_time, unit = "15 mins")
floor_date(last_traded_time, unit = "2 hours")
