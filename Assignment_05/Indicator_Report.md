# Technical Analysis Indicator Development

Devon Wells | BDA 400 | Assignment 5

## Implementation

The indicator scripts use base R, with a common copy in `indicators.R` and separate files for the nine named functions. `sma()` returns a mean for each complete window. `ema()` uses the first observation as its initial value and the multiplier 2/(period + 1). `macd()` returns the short-minus-long EMA, its signal EMA and their difference. `stdev()` follows the brief's population-variance formula, dividing by the number of observations.

`linreg()` computes the slope, intercept and fitted values for a fixed-length window ending at the supplied offset. `rsi()` uses Wilder smoothing, and `stoch_rsi()` applies the brief's global RSI range followed by smoothing. `crossover()` returns Up, Down or None, following the pseudocode, while `crossunder()` returns logical values. These conventions are stated because the brief contains conflicting descriptions or examples for some indicators.

## Testing

`verify_indicators.R` checks moving averages, population standard deviation, regression, crossover and crossunder, selected RSI edge cases, the MACD histogram identity and StochRSI bounds. The script passed in R 4.6.2; see `test_output.txt`. These examples do not establish compatibility with an undisclosed grading test, and more edge cases should be checked before using the functions for real decisions.

## Running the files

Open this folder in R or RStudio and run `source('indicators.R')`, then call the desired function. Run `source('verify_indicators.R')` for the included checks. The individual files contain their own required helper definitions.

The brief's regression-offset pseudocode uses a varying-size window, whereas this implementation uses a fixed-size window. Its crossover description says Boolean values while its pseudocode uses direction labels. The RSI and StochRSI pseudocode also leaves edge cases ambiguous. Confirm expected conventions with the instructor or provided test file.

## AI assistance

ChatGPT through Codex prepared the scripts, tests and explanation. The tests were run on 13 November 2026; Devon must review the code and reported conventions.
