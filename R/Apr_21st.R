library(tidyverse)
library(ellmer)

chat <- chat_gemini(model = "gemini-2.0-flash")
chat$chat("how's the weather today?")
live_console(chat)


news_analyzer <- chat_gemini(
  system_prompt = r"{
  You are an expert financial analyst. 
  You will be provided news article title to analyze, which will be wrapped with tripple backticks ```.
  Your task is to assess the market sentiment of a news article.
  Return valid JSON with curly braces without any other formatting:  
    – "score": a real number between [0, 1] (0 = extremely negative, 1 = extremely positive).  
    – "rationale": less than 25 words.  
  Do not add any keys, text, or commentary outside the JSON object.  
  }",
  model = "gemini-2.0-flash",
  api_args = list(
    generationConfig = list(
      temperature = 0,
      maxOutputTokens = 100
    )
  )
)

news_analyzer

# get news data

library(newsanchor)

news_data <- get_everything(
  "Financial Markets",
  language = "en",
  page = 1,
)
news_frame <- news_data[[2]]
news_frame <- news_frame |>
  select(author, published_at, title, content) |>
  head(10)

news_frame


news_frame$title[[1]]

str_glue("Tell me the sentiment of this article: ```{news_frame$title[[1]]}```")

test_ans <- news_analyzer$chat(str_glue(
  "Tell me the sentiment of this article: ```{news_frame$title[[1]]}```"
))

print(test_ans)
# remove \n
test_ans <- str_replace_all(test_ans, "\\n", "")

# remove markdown formatter
test_ans <- str_replace(test_ans, "^```json(.*)```$", "\\1")


# Transform JSON to R list

library(jsonlite)
fromJSON(test_ans)


get_sentiment <- function(title) {
  llm_response <- news_analyzer$chat(str_glue(
    "Tell me the sentiment of this article: ```{title}```"
  ))
  # remove \n
  cleaned_response <- str_replace_all(llm_response, "\\n", "")
  # remove markdown formatter
  cleaned_response <- str_replace(cleaned_response, "^```json(.*)```$", "\\1")

  # Parse into R list
  final_response <- fromJSON(cleaned_response)
  return(final_response)
}

news_frame$title[[2]]
a <- get_sentiment(news_frame$title[[2]])

news_frame |> select(title)


analyzed_data <- news_frame |>
  mutate(
    response = map(title, get_sentiment)
  )


analyzed_data
