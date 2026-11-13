# BDA 400 - AI-assisted R implementation for Devon Wells

check_series <- function(data, period) {
  if (!is.numeric(data) || anyNA(data) || any(!is.finite(data))) stop('data must be finite numbers')
  if (length(period) != 1 || is.na(period) || period < 1 || period != as.integer(period) || length(data) < period) stop('invalid period or insufficient data')
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
