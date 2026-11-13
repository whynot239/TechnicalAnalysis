# Assignment 4 sales data cleaning

Devon Wells | BDA 400

The supplied CSV has columns `OrderID`, `Product`, `Quantity`, `Price` and `Customer`. It does not have `CustomerID` or `Region`, which appear in the assignment's example prompts. At least one Quantity is blank in the provided first rows. Examine the entire file before deciding which other issues are present.

1. Copy `08 BDA400 Assignment 4 - sales_data_dirty.csv` into this folder. Inspect column types, missing values, duplicated records, customer and product spelling/case, and numeric distributions in RStudio. Record findings from your actual run.
2. Ask for design guidance using the real column names. Decide how to handle missing quantities and customer names, duplicate orders, inconsistent labels and potential outliers. Preserve or flag questionable values rather than deleting a valid extreme merely because it is large. Explain each choice.
3. Following the instructor's AI rules, write and test the cleaning pipeline using dplyr. Capture before-and-after summaries and checks of row counts, missingness and categories. The requested script name is `Wells_Devon_clean_sales_data.R`.
4. Make the primary relevant calculations in Sheets, perform an independent cross-check and a self spot-check. Keep actual prompts, key responses and verification steps in an appendix.
5. Write your own 100–150 word reflection based on your real experience; the brief explicitly says not to use AI to write it. Save it as `Wells_Devon_reflection.txt`, and bundle the required materials as `Wells_Devon_dataset_cleaning.zip`.

The brief requests AI-generated code in one section but says elsewhere that AI should not generate code or answers. Ask the instructor to clarify if needed. No cleaning or test result is claimed in this guide.
