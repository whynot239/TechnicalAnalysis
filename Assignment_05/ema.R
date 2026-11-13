# BDA 400 - AI-assisted R implementation for Devon Wells

check_series <- function(data, period) {
  if (!is.numeric(data) || anyNA(data) || any(!is.finite(data))) stop('data must be finite numbers')
  if (length(period) != 1 || is.na(period) || period < 1 || period != as.integer(period) || length(data) < period) stop('invalid period or insufficient data')
}

ema <- function(data, period) {
  check_series(data, period)
  result <- numeric(length(data)); result[1] <- data[1]; alpha <- 2 / (period + 1)
  if (length(data) > 1) for (i in 2:length(data)) result[i] <- alpha * data[i] + (1 - alpha) * result[i - 1]
  result
}
