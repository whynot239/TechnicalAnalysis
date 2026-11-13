# Sales Data Quality Report

Devon Wells | BDA 400 | Assignment 4

## Findings

The supplied file has 610 rows and five fields: OrderID, Product, Quantity, Price and Customer. The initial summary found 49 missing product values, 95 missing quantities and nine exact duplicate records. Quantity ranged from -5 to 1,000, making nonpositive quantities and unusually large values important to review. The brief's example fields CustomerID and Region are not present; the script uses the actual column names.

## Cleaning decisions

The R script removes exact duplicate rows and standardizes product and customer capitalization. Rather than invent missing values or silently discard questionable records, it separates them into a review file. A 1.5-IQR upper fence of 67.5 was calculated using positive quantities; values above that threshold, nonpositive values and incomplete records are set aside. An extreme value is a review flag, not proof of a data error. Revenue is quantity multiplied by price when both are available.

## Results and verification

After removing the nine exact duplicates, 601 unique records remained. Of these, 328 were retained in `sales_data_cleaned.csv` and 273 were placed in `sales_data_review.csv`. The retained records have no missing values in the resulting fields. The script checks the row accounting and duplicate count; the complete before-and-after output appears in `cleaning_output.txt`. An independent Python check reproduced the row counts and found no missing fields, invalid quantities or revenue mismatches in the retained records; its output is in `independent_check.txt`. These counts overlap across issue types, so missing values and flags should not be added together as though they identified different rows.

The process excludes a substantial share of records from the reporting dataset. The review file should be checked against the source before these records are permanently removed. A Sheets calculation and Devon's own spot-check and reflection remain required by the assignment.

## AI assistance

ChatGPT through Codex helped prepare the script, explanation and checks on 13 November 2026. The prompt record is in `Appendix.md`. The course brief requires the personal reflection to be written in Devon's own words.
