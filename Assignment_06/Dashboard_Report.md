# Portfolio Dashboard

Devon Wells | BDA 400 | Assignment 6

## Project

The Shiny dashboard retrieves Yahoo Finance price data and displays a line, area or candlestick chart. The interface accepts a symbol and date range and offers daily, weekly and monthly views. The price chart can display 20- and 50-period moving averages. RSI and MACD appear in separate panels when selected because their scales differ from price. Moving-average crossovers are annotated as Buy or Sell events; these are illustrative signals rather than investment advice.

The app uses the Assignment 5 implementations in `indicators.R`. The moving averages require enough observations for their windows, so a short monthly series may have no moving-average line. To run the app, install `shiny`, `ggplot2`, `quantmod` and `TTR`, open this folder in R, and run `shiny::runApp()`. An internet connection is needed for the stock data.

## Observed checks

On 13 November 2026, the app was started locally using R 4.6.2. In the browser, AAPL daily prices, the moving averages, RSI and MACD panels were displayed; the chart selector also displayed a candlestick view. A weekly aggregation error was found and corrected by changing the period indexing option; the weekly and monthly price charts then displayed. `dashboard_screenshot.png` shows the daily view with the indicators selected. This is a limited functional check, not an exhaustive test of all symbols, ranges or network failures.

## AI assistance and submission

ChatGPT through Codex helped write, debug and test the code and draft this report. The public repository is https://github.com/whynot239/TechnicalAnalysis. Devon should review the code and results before submitting.
