# 🚗 Nigerian Car Prices Data Cleaning Task (Python)


## Executive Summary

This project focuses on cleaning and preparing a Nigerian car prices dataset using Python. The objective was to improve data quality by handling missing values, removing inconsistencies, and ensuring the dataset is analysis-ready.

After cleaning, the dataset is now structured, reliable, and suitable for data analysis, visualization, and predictive modeling.


## Business Problem

Raw datasets often contain missing values, inconsistencies, and redundant information that can lead to inaccurate insights and poor decision-making. In the context of car pricing, unreliable data can affect pricing strategies, market analysis, and customer decision processes.

This project addresses the challenge of transforming messy car listing data into a reliable dataset for analysis.


## Methodology

### Data Exploration
	•	Viewed dataset structure using .head(), .tail(), .info()
	•	Assessed missing values and their percentages

### Data Cleaning
	•	Dropped irrelevant columns (Build, Unnamed: 0)
	•	Handled missing values:
	•	Mode → Fuel, Condition, Transmission
	•	Median → Year of manufacture
	•	Mean → Engine Size, Mileage

### Data Validation
* Checked unique values for consistency
* Identified and removed duplicate records

### Data Export
	•	Saved cleaned dataset as:
cleaned_Nigerian_Car_Prices.csv


## Skills Demonstrated
* Data Cleaning & Preprocessing
* Exploratory Data Analysis (EDA)
* Handling Missing Data (Mean, Median, Mode)
* Data Validation Techniques
* Python Scripting
* File Handling with pathlib
* Use of pandas & numpy


## Results & Insights
* All missing values successfully handled
* Irrelevant columns removed
* Duplicate rows eliminated
* Dataset standardized and cleaned

The dataset is now fully prepared for:
* Data analysis
* Visualization


## Business Recommendations
* Implement data validation at the point of data entry
* Standardize data collection formats
* Perform routine data cleaning before analysis
* Leverage cleaned data for pricing strategies and insights


## Next Steps
* Conduct detailed Exploratory Data Analysis (EDA)
* Perform data transformation and standardization for machine learning
* Build a car price prediction model
* Create dashboards (Power BI / Plotly)
* Deploy a simple prediction app

## Tools & Technologies Used
* Python
* Pandas
* NumPy
* VS Code

## Project Structure

Nigerian-Car-Prices-Data-Cleaning/
│
├── Nigerian_Car_Prices.csv
├── cleaned_Nigerian_Car_Prices.csv
├── data_cleaning_script.py
└── README.md


