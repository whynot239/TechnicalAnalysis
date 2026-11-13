# Assignment 5 indicator development

Devon Wells | BDA 400

`indicators.R` contains the nine named functions using base R. The individual indicator scripts contain their implementations and any helper functions they need. The supplied automated examples passed in R 4.6.2; they are limited checks and do not establish compatibility with the instructor's hidden tests.

Run each function in RStudio and compare results with independently calculated examples. Record actual outputs and correct problems before submitting. Create a Word or PDF report explaining each implementation and how to run it, and place the scripts in the `TechnicalAnalysis` repository.

The brief has ambiguities to resolve with the instructor or test file: its SMA pseudocode returns only complete windows; its EMA starts with the first observation; its standard deviation is population rather than sample; its crossover prose requests Boolean results but its pseudocode returns Up/Down/None; its StochRSI pseudocode uses a global range rather than the more common rolling range. The regression offset pseudocode also produces a varying window length, unlike the fixed-length window in this draft. Its RSI pseudocode appears to reuse the first period's last change during smoothing. This draft uses a fixed-length regression window and conventional first RSI value, so it is not guaranteed to match the course's hidden tests. Confirm the expected conventions before finalizing.
