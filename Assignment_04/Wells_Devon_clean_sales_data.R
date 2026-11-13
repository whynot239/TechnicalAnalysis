# BDA 400 Assignment 4 - Devon Wells
# AI-assisted draft. Run with sales_data_dirty.csv in the working directory.
library(dplyr)
raw <- read.csv('sales_data_dirty.csv', stringsAsFactors = FALSE, na.strings = c('', 'NA'))
cat('BEFORE\n'); print(summary(raw)); print(colSums(is.na(raw))); cat('Exact duplicate rows:', sum(duplicated(raw)), '\n')
valid_qty <- raw$Quantity[!is.na(raw$Quantity) & raw$Quantity > 0]
q <- quantile(valid_qty, c(.25, .75), names = FALSE)
upper <- q[2] + 1.5 * (q[2] - q[1])
prepared <- raw %>%
  distinct() %>%
  mutate(Product = trimws(tolower(Product)), Customer = trimws(tolower(Customer)),
         Product = ifelse(is.na(Product) | Product == '', NA_character_, tools::toTitleCase(Product)),
         Customer = ifelse(is.na(Customer) | Customer == '', NA_character_, tools::toTitleCase(Customer))) %>%
  mutate(Needs_review = is.na(Customer) | is.na(Product) | is.na(Quantity) | is.na(Price) | Quantity <= 0 | Price <= 0 | Quantity > upper,
         Revenue = Quantity * Price)
cleaned <- prepared %>% filter(!Needs_review)
review <- prepared %>% filter(Needs_review)
cat('\nAFTER\n'); print(summary(cleaned)); print(colSums(is.na(cleaned))); cat('Quantity upper fence:', upper, '\n'); cat('Rows retained:', nrow(cleaned), '\n'); cat('Rows requiring review:', nrow(review), '\n'); print(table(cleaned$Product, useNA = 'ifany'))
stopifnot(nrow(cleaned) + nrow(review) == nrow(distinct(raw)), !anyNA(cleaned), sum(duplicated(cleaned)) == 0)
write.csv(cleaned, 'sales_data_cleaned.csv', row.names = FALSE, na = '')
write.csv(review, 'sales_data_review.csv', row.names = FALSE, na = '')
