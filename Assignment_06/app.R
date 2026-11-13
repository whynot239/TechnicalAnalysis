# AI-assisted draft. Install shiny, ggplot2, quantmod and TTR before running.
library(shiny)
library(ggplot2)
library(quantmod)
library(TTR)
source('indicators.R')
ui <- fluidPage(
  titlePanel('Portfolio dashboard'),
  sidebarLayout(sidebarPanel(
    textInput('symbol', 'Stock symbol', 'AAPL'),
    dateRangeInput('dates', 'Date range', start = '2023-01-01', end = '2024-01-01'),
    selectInput('frequency', 'Time frame', c('Daily', 'Weekly', 'Monthly')),
    selectInput('chart', 'Chart', c('Line', 'Area', 'Candlestick')),
    checkboxGroupInput('indicators', 'Indicators', c('Moving averages', 'RSI', 'MACD'), selected = 'Moving averages'),
    actionButton('load', 'Load data')
  ), mainPanel(plotOutput('price', height = '400px'), conditionalPanel("input.indicators.includes('RSI')", plotOutput('rsi', height = '200px')), conditionalPanel("input.indicators.includes('MACD')", plotOutput('macd', height = '200px'))))
)
server <- function(input, output, session) {
  prices <- eventReactive(input$load, {
    req(input$symbol, input$dates)
    validate(need(input$dates[1] < input$dates[2], 'Choose a valid date range.'))
    x <- tryCatch(getSymbols(toupper(trimws(input$symbol)), src = 'yahoo', from = input$dates[1], to = input$dates[2] + 1, auto.assign = FALSE), error = function(e) NULL)
    validate(need(!is.null(x) && NROW(x) > 0, 'No data returned. Check the symbol, dates and internet connection.'))
    if (input$frequency == 'Weekly') x <- to.weekly(x, indexAt = 'endof', drop.time = TRUE)
    if (input$frequency == 'Monthly') x <- to.monthly(x, indexAt = 'endof', drop.time = TRUE)
    d <- data.frame(date = as.Date(zoo::index(x)), open = as.numeric(Op(x)), high = as.numeric(Hi(x)), low = as.numeric(Lo(x)), close = as.numeric(Cl(x)))
    d$ma20 <- if (nrow(d) >= 20) c(rep(NA_real_, 19), sma(d$close, 20)) else NA_real_
    d$ma50 <- if (nrow(d) >= 50) c(rep(NA_real_, 49), sma(d$close, 50)) else NA_real_
    d$rsi <- if (nrow(d) >= 15) rsi(d$close, 14) else NA_real_
    m <- if (nrow(d) >= 26) macd(d$close, 12, 26, 9) else NULL
    d$macd <- if (is.null(m)) NA_real_ else m$macd_line
    d$signal_line <- if (is.null(m)) NA_real_ else m$signal_line
    prev <- c(NA, head(d$ma20 - d$ma50, -1)); curr <- d$ma20 - d$ma50
    d$signal <- ifelse(!is.na(prev) & !is.na(curr) & prev <= 0 & curr > 0, 'Buy', ifelse(!is.na(prev) & !is.na(curr) & prev >= 0 & curr < 0, 'Sell', 'Hold'))
    d
  }, ignoreInit = FALSE)
  output$price <- renderPlot({
    d <- prices(); p <- ggplot(d, aes(date, close))
    if (input$chart == 'Line') p <- p + geom_line(colour = '#285678')
    if (input$chart == 'Area') p <- p + geom_area(fill = '#a8c9d8')
    if (input$chart == 'Candlestick') p <- p + geom_segment(aes(xend = date, y = low, yend = high)) + geom_segment(aes(xend = date, y = open, yend = close, colour = close >= open), linewidth = 2, show.legend = FALSE)
    if ('Moving averages' %in% input$indicators) p <- p + geom_line(aes(y = ma20), colour = '#d27d25', na.rm = TRUE) + geom_line(aes(y = ma50), colour = '#8a4e8b', na.rm = TRUE)
    events <- d[d$signal %in% c('Buy', 'Sell'), , drop = FALSE]
    p + geom_text(data = events, aes(label = signal), vjust = -0.6, size = 3) + labs(x = NULL, y = 'Price', title = toupper(input$symbol), subtitle = 'Orange: 20-period average; purple: 50-period average') + theme_minimal()
  })
  output$rsi <- renderPlot({ d <- prices(); ggplot(d, aes(date, rsi)) + geom_line(colour = '#70538b', na.rm = TRUE) + geom_hline(yintercept = c(30, 70), linetype = 2) + labs(x = NULL, y = 'RSI') + theme_minimal() })
  output$macd <- renderPlot({ d <- prices(); ggplot(d, aes(date)) + geom_line(aes(y = macd), colour = '#285678', na.rm = TRUE) + geom_line(aes(y = signal_line), colour = '#d27d25', na.rm = TRUE) + labs(x = NULL, y = 'MACD') + theme_minimal() })
}
shinyApp(ui, server)
