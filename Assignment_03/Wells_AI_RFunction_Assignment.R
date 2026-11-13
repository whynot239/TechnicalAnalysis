# BDA 400 Assignment 3 - Devon Wells
# AI-assisted draft; see Appendix.md for the actual request and details.
# Task: Flag numeric observations outside the 1.5 IQR fences.

# Initial implementation: it does not yet handle missing values.
flag_outliers_initial <- function(x) {
  q <- quantile(x, c(0.25, 0.75))
  spread <- q[2] - q[1]
  x < q[1] - 1.5 * spread | x > q[2] + 1.5 * spread
}

# Revised implementation preserves the position of missing values.
flag_outliers <- function(x, multiplier = 1.5) {
  if (!is.numeric(x)) stop('x must be numeric')
  if (length(multiplier) != 1L || !is.finite(multiplier) || multiplier < 0) stop('multiplier must be a non-negative finite number')
  if (any(is.infinite(x), na.rm = TRUE)) stop('x must not contain infinite values')
  out <- rep(NA, length(x))
  valid <- !is.na(x)
  if (!any(valid)) return(out)
  q <- quantile(x[valid], c(0.25, 0.75), names = FALSE)
  width <- q[2] - q[1]
  out[valid] <- x[valid] < q[1] - multiplier * width | x[valid] > q[2] + multiplier * width
  out
}

# Validation examples: compare against boxplot.stats on this sample only.
sample_data <- c(10, 15, 20, 25, 999)
print(data.frame(value = sample_data, outlier = flag_outliers(sample_data)))
print(boxplot.stats(sample_data)$out)
stopifnot(identical(which(flag_outliers(sample_data)), which(sample_data %in% boxplot.stats(sample_data)$out)))
stopifnot(identical(flag_outliers(c(1, NA, 1)), c(FALSE, NA, FALSE)))
stopifnot(identical(flag_outliers(numeric()), logical()))
stopifnot(identical(flag_outliers(rep(7, 4)), rep(FALSE, 4)))
stopifnot(inherits(try(flag_outliers('bad'), silent = TRUE), 'try-error'))
cat('All function checks passed.\n')
