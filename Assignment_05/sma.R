# BDA 400 - AI-assisted R implementation for Devon Wells

check_series <- function(data, period) {
  if (!is.numeric(data) || anyNA(data) || any(!is.finite(data))) stop('data must be finite numbers')
  if (length(period) != 1 || is.na(period) || period < 1 || period != as.integer(period) || length(data) < period) stop('invalid period or insufficient data')
}

sma <- function(data, period) {
  check_series(data, period)
  vapply(seq_len(length(data) - period + 1L), function(i) mean(data[i:(i + period - 1L)]), numeric(1))
}
