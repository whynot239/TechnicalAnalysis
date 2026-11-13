# Draft prepared with AI assistance. Review and run in R before submission.
# Install once: install.packages(c('quantmod', 'TTR'))
library(quantmod)
library(TTR)
load_stock_data <- function(path = 'portfolio.txt', from = '2023-01-01', to = '2024-01-01') {
  symbols <- trimws(readLines(path, warn = FALSE)); symbols <- unique(symbols[nzchar(symbols)])
  if (!length(symbols)) stop('No symbols were found in the portfolio file.')
  out <- lapply(symbols, function(symbol) {
    x <- quantmod::getSymbols(symbol, src = 'yahoo', from = from, to = to, auto.assign = FALSE)
    data.frame(Date = as.Date(zoo::index(x)), Open = as.numeric(Op(x)), High = as.numeric(Hi(x)), Low = as.numeric(Lo(x)), Close = as.numeric(Cl(x)), Volume = as.numeric(Vo(x)))
  })
  names(out) <- symbols; out
}
calculate_statistics <- function(df, period = 20) {
  x <- na.omit(df$Close); if (length(x) < period) stop('Not enough observations for the moving average')
  frequencies <- table(x); modes <- as.numeric(names(frequencies)[frequencies == max(frequencies)])
  list(mean = mean(x), median = median(x), mode = if (max(frequencies) > 1) modes else numeric(), standard_deviation = sd(x), moving_average = TTR::SMA(x, n = period))
}
display_portfolio <- function(stocks) {
  for (symbol in names(stocks)) {
    cat('\n', symbol, '\n'); print(head(stocks[[symbol]])); print(calculate_statistics(stocks[[symbol]])[1:4])
    plot(stocks[[symbol]]$Date, stocks[[symbol]]$Close, type = 'l', xlab = 'Date', ylab = 'Close', main = symbol)
  }
}
# Run interactively from this folder:
# stocks <- load_stock_data(); display_portfolio(stocks)
