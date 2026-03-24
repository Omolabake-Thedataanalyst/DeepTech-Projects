# 💰 Business Funding Data Cleaning Task (Python - Jupyter Notebook)


## Executive Summary

This project focuses on cleaning and preparing a business funding dataset using Python in a Jupyter Notebook environment. The dataset contained significant missing values, inconsistent entries, and irrelevant columns.

Through structured data cleaning techniques, the dataset was transformed into a consistent and analysis-ready format suitable for financial insights and trend analysis.


## Business Problem

Business funding datasets often suffer from incomplete and inconsistent records, which can affect investment analysis and decision-making.

In this dataset:
* Key columns had over 50–75% missing values
* Some fields contained inconsistent or empty entries ([], NaN)
* Irrelevant columns added noise to the dataset

This project solves the problem by improving data reliability and usability.


## Methodology

### Data Exploration
	•	Loaded dataset using pandas
	•	Inspected structure with .head() and .info()
	•	Calculated percentage of missing values

### Data Cleaning
	•	Dropped irrelevant columns: 'Effective date', 'Financing Type', 'Found At'
	•	Handled missing values:
	•	Filled 'Financing Type Normalized', 'Investors' columns with “Not Provided”
	•	Replaced empty lists ([]) in Categories with "Not Provided"
	•	Filled Investors Count with 0

### Data Validation
	•	Checked for duplicate rows (none found)
	•	Verified all columns for completeness

### Data Export
	•	Exported cleaned dataset as:
cleaned_Business_Funding_Data.csv


## Skills Demonstrated
* Data Cleaning & Preprocessing
* Handling Missing Data Strategically
* Data Exploration & Validation
* Working with Excel files in Python (.xlsx)
* Data transformation and standardization
* Jupyter Notebook workflow
* Use of pandas and numpy


## Results & Insights
* Successfully handled all missing values across key columns
* Standardized inconsistent entries (e.g., empty lists → meaningful labels)
* Removed irrelevant features to improve dataset quality
* Ensured dataset consistency and completeness

The dataset is now ready for:
* Investment trend analysis
* Financial data visualization
* Predictive modeling


## Business Recommendations
* Standardize data entry formats at the source
* Avoid use of empty placeholders like []
* Ensure completeness of key financial fields before storage
* Implement periodic data cleaning processes


## Next Steps
* Perform exploratory data analysis (EDA) on funding trends
* Analyze investor patterns and funding types
* Build dashboards (Power BI / Tableau)
* Develop predictive models for funding insights


## Tools & Technologies Used
* Python - Core programming language
* Pandas - Data cleaning & manipulation
* NumPy - Numerical operations
* Jupyter Notebook - Interactive development environment
* Openpyxl - Excel file handling



