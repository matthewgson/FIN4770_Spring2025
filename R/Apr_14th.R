library(tidyverse)
library(quanteda)

data_corpus_inaugural

inaugural_address <- summary(data_corpus_inaugural) |> as_tibble()
inaugural_address <- inaugural_address |>
  mutate(
    Document = data_corpus_inaugural
  )
inaugural_address |> tail()

str_view(fruit, "berry")


my_words <- c("ca", "oca", "caan", "cat", "call", "candy")

str_view(my_words, "ca*")


iris |>
  select(matches("^Sepal"))


another_words <- c("taxi", "flux", "pixie", "axial", "exude")

str_view(another_words, "[aeiou]x[aeiou]?")
str_view(another_words, "flux|pixie")

str_detect(another_words, "flux|pixie")
str_subset(another_words, "flux|pixie")
str_which(another_words, "flux|pixie")

inaugural_address |>
  mutate(doc = str_to_lower(Document)) |>
  mutate(number_freedom = str_count(doc, "freedom"))


inaugural_address |>
  mutate(
    number_freedom = str_count(Document, regex("freedom", ignore_case = TRUE))
  )


df1 <- tibble(x = c("a,b,c", "d,e", "f"))
df1

df1 |>
  separate_longer_delim(x, delim = ",")


# seprate_wider : you need "names"

df1 |>
  separate_wider_delim(
    x,
    delim = ",",
    names = c("first", "second"),
    too_few = "align_start",
    too_many = "drop"
  )


df3 <- tibble(x = c("202215TX", "202122LA", "202325CAL"))
df3 |>
  separate_wider_position(
    x,
    widths = c(year = 4, age = 2, state = 2),
    too_many = "drop"
  )


df <- tribble(
  ~string,
  "<Sheryl>-F_34",
  "<Kisha>-F_45",
  "<Brandon>-N_33",
  "<Sharon>-F_38",
  "<Penny>-F_58",
  "<Justin>-M_41",
  "<Patricia>-F_84",
)
print(df)

df |>
  separate_wider_regex(
    string,
    patterns = c(
      "<",
      name = "[A-Za-z]+",
      ">-",
      letter = ".",
      "_",
      number = "[0-9]+"
    )
  )


str_view(df$string, "[0-9]+")
