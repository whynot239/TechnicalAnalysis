# Assignment 6 portfolio dashboard

Devon Wells | BDA 400

The AI-assisted `app.R` retrieves Yahoo historical data, offers daily, weekly and monthly views and displays price, moving averages, RSI, MACD and moving-average crossover events. RSI and MACD use their own panels because their scales differ from prices. It sources the accompanying Assignment 5 implementations. A local browser test displayed the daily, weekly and monthly price charts, candlesticks and the RSI and MACD panels; see `Dashboard_Report.md` for the scope and a bug fixed during testing.

Install the required packages, open this folder in RStudio and run `shiny::runApp()`. Test each input, symbol, chart type, frequency, indicator toggle, short date range, unavailable ticker and network failure. Capture actual screenshots and fix issues found. Data retrieval requires an internet connection.

The actual browser screenshot is `dashboard_screenshot.png`. Add the code to the appropriate folder of `TechnicalAnalysis` and put the public repository URL on the cover page. Repository evidence remains to be added; expand testing before submitting.
