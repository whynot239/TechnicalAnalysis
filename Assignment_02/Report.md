# Technical Analysis Using R Preliminary Stage

Devon Wells | BDA 400 | Assignment 2

## Purpose and setup

The project loads historical prices for three symbols and calculates descriptive statistics on closing prices. R 4.6.2 was installed in the working environment, with quantmod and TTR installed in a project library. The work was run using Rscript; it has not been documented as an RStudio installation. `portfolio.txt` lists AAPL, MSFT and RY.TO, one symbol per line.

## Import and statistics

`technical_analysis.R` uses `quantmod::getSymbols()` with Yahoo Finance and stores date, open, high, low, close and volume in a separate data frame for each symbol. The sample run requested 1 January 2023 to 1 January 2024 and returned 250 observations for each symbol. Yahoo's end date is exclusive in this request.

| Symbol | Mean close | Median close | Sample standard deviation |
|---|---:|---:|---:|
| AAPL | 172.549 | 175.475 | 17.332 |
| MSFT | 313.951 | 324.650 | 40.976 |
| RY.TO | 126.638 | 127.225 | 7.223 |

The function also returns the most frequently occurring closing prices and a 20-observation simple moving average. If each closing price occurs once, it returns an empty mode rather than calling every value a useful mode. The detailed console output is in `test_output.txt`; prices can be adjusted or revised by the data provider.

## Running the project

Install `quantmod` and `TTR`, set the working directory to this folder, and run `source('technical_analysis.R')`. Then run `stocks <- load_stock_data()` followed by `display_portfolio(stocks)`. Internet access is needed for Yahoo Finance. The function prints the first records and statistics and draws a line chart for each stock.

## AI assistance and limitations

ChatGPT through Codex drafted the code and this report and ran the R command shown in the test log on 13 November 2026. The repository is https://github.com/whynot239/TechnicalAnalysis. Devon should inspect the code and verify selected calculations. RStudio installation evidence and screenshots of the required setup steps remain outstanding.
