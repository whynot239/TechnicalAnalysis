# BDA 400 - AI-assisted R implementation for Devon Wells

check_series <- function(data, period) {
  if (!is.numeric(data) || anyNA(data) || any(!is.finite(data))) stop('data must be finite numbers')
  if (length(period) != 1 || is.na(period) || period < 1 || period != as.integer(period) || length(data) < period) stop('invalid period or insufficient data')
}

rsi <- function(data, period) {
  check_series(data, period + 1L)
  change <- diff(data); gains <- pmax(change, 0); losses <- pmax(-change, 0)
  average_gain <- mean(gains[seq_len(period)]); average_loss <- mean(losses[seq_len(period)])
  result <- rep(NA_real_, length(data))
  score <- function(g, l) if (l == 0 && g == 0) 50 else if (l == 0) 100 else 100 - 100 / (1 + g / l)
  result[period + 1L] <- score(average_gain, average_loss)
  if (length(data) > period + 1L) for (i in (period + 2L):length(data)) {
    average_gain <- (average_gain * (period - 1) + gains[i - 1L]) / period
    average_loss <- (average_loss * (period - 1) + losses[i - 1L]) / period
    result[i] <- score(average_gain, average_loss)
  }
  result
}
