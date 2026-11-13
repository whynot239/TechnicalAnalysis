# Reflection draft

The task was to identify unusually high or low observations using the interquartile range. The initial function calculated quartiles and compared each value with the lower and upper fences. It worked for a complete numeric vector, but missing values needed a deliberate policy. The revised version keeps the original positions and returns a missing result for an observation that cannot be classified. It also checks that the input is numeric and that the multiplier is valid.

Testing helped clarify the difference between code that runs on one example and a function that handles less convenient inputs. For the sample of 10, 15, 20, 25 and 999, the revised function flagged 999, matching `boxplot.stats()` for that example. Separate checks covered an empty vector, missing values, constant values and an invalid input. Different quartile conventions can give different results on other samples, so one agreement is not enough to establish that two methods always match.

AI helped produce a starting point and organize the tests. Its output still needed execution and review, especially around missing data and assumptions. This draft should be reviewed and personalized by Devon to reflect his own experience before submission.
