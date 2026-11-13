# AI-assisted draft for Devon Wells. Review and test before submission.
# Base R implementation; no indicator packages are used.
check_series <- function(data, period) {
  if (!is.numeric(data) || anyNA(data) || any(!is.finite(data))) stop('data must be finite numbers')
  if (length(period) != 1 || is.na(period) || period < 1 || period != as.integer(period) || length(data) < period) stop('invalid period or insufficient data')
}
sma <- function(data, period) {
  check_series(data, period)
  vapply(seq_len(length(data) - period + 1L), function(i) mean(data[i:(i + period - 1L)]), numeric(1))
}
ema <- function(data, period) {
  check_series(data, period)
  result <- numeric(length(data)); result[1] <- data[1]; alpha <- 2 / (period + 1)
  if (length(data) > 1) for (i in 2:length(data)) result[i] <- alpha * data[i] + (1 - alpha) * result[i - 1]
  result
}
macd <- function(data, short_period, long_period, signal_period) {
  line <- ema(data, short_period) - ema(data, long_period)
  signal <- ema(line, signal_period)
  list(macd_line = line, signal_line = signal, histogram = line - signal)
}
stdev <- function(data) {
  check_series(data, 1)
  sqrt(sum((data - mean(data))^2) / length(data))
}
linreg <- function(regressionSource, regressionLength, regressionOffset) {
  check_series(regressionSource, regressionLength)
  if (regressionLength < 2 || length(regressionOffset) != 1 || is.na(regressionOffset) || regressionOffset < 0 || regressionOffset != as.integer(regressionOffset) || regressionOffset + regressionLength > length(regressionSource)) stop('invalid length or offset')
  end <- length(regressionSource) - regressionOffset
  y <- regressionSource[(end - regressionLength + 1L):end]; x <- seq_along(y)
  slope <- sum((x - mean(x)) * (y - mean(y))) / sum((x - mean(x))^2)
  intercept <- mean(y) - slope * mean(x)
  list(slope = slope, intercept = intercept, predicted_values = intercept + slope * x)
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
stoch_rsi <- function(data, period, k_period, d_period) {
  values <- rsi(data, period); valid <- values[!is.na(values)]
  check_series(valid, k_period)
  span <- max(valid) - min(valid)
  raw <- if (span == 0) rep(NA_real_, length(valid)) else (valid - min(valid)) / span
  if (span == 0) return(list(k_line = rep(NA_real_, length(valid) - k_period + 1L), d_line = numeric()))
  k <- sma(raw, k_period); check_series(k, d_period)
  list(k_line = k, d_line = sma(k, d_period))
}
crossover <- function(arr1, arr2) {
  if (length(arr1) != length(arr2)) stop('Both arrays should have the same length')
  out <- rep('None', length(arr1))
  if (length(arr1) > 1) for (i in 2:length(arr1)) if (!anyNA(c(arr1[i], arr2[i], arr1[i-1], arr2[i-1]))) {
    if (arr1[i] > arr2[i] && arr1[i-1] <= arr2[i-1]) out[i] <- 'Up'
    else if (arr1[i] < arr2[i] && arr1[i-1] >= arr2[i-1]) out[i] <- 'Down'
  }
  out
}
crossunder <- function(arr1, arr2) {
  if (length(arr1) != length(arr2)) stop('Both arrays should have the same length')
  out <- rep(FALSE, length(arr1))
  if (length(arr1) > 1) for (i in 2:length(arr1)) if (!anyNA(c(arr1[i], arr2[i], arr1[i-1], arr2[i-1]))) out[i] <- arr1[i] < arr2[i] && arr1[i-1] >= arr2[i-1]
  out
}
