# importing libraries
import sys
from pathlib import Path

import numpy as np

try:
    import pandas as pd
except ImportError as e:
    raise SystemExit('This script requires pandas. Install it with: pip install pandas') from e

# loading the dataset
csv_path = Path(__file__).resolve().parent / 'Nigerian_Car_Prices.csv'
if not csv_path.exists():
    raise FileNotFoundError(f"Could not find dataset at {csv_path}")

df = pd.read_csv(csv_path)

# view first 5 rows of the dataset
print(df.head())

# view last 5 rows of the datas
print(df.tail())

#view summary of dataset
print(df.info())

## check for missing values
missing_values = df.isnull().sum()
print("Missing values in each column:")
print(missing_values)

# check for percentage of missing values in each column
missing_percentage = df.isnull().sum() / len(df) * 100
print("Percentage of missing values in each column:")
print(missing_percentage)

#rverify the unique value in 'Build' column
print(df['Build'].unique())

#removing 'Build' column as it has only one unique value
df.drop(columns=['Build'], inplace=True)
print(df.head())


#verify the unique value in 'Fuel' column
print(df['Fuel'].unique())

#filling missing values in the 'Fuel' column with the mode (most frequent value)
mode_fuel = df['Fuel'].dropna().mode()
if not mode_fuel.empty:
    df['Fuel'] = df['Fuel'].fillna(mode_fuel[0])
    print(f"Filled NaNs with: {mode_fuel[0]}")
else:
    print("No non-NaN values in Fuel column to use as mode.")
print(df.head())

# verify the unique values in the 'Fuel' column after filling NaNs
print(df['Fuel'].unique())

#verify the unique value in 'Condition' column
print(df['Condition'].unique())

#filling missing values in the 'Condition' column with the mode (most frequent value)
mode_condition = df['Condition'].dropna().mode()
if not mode_condition.empty:
    df['Condition'] = df['Condition'].fillna(mode_condition[0])
    print(f"Filled NaNs with: {mode_condition[0]}")
else:
    print("No non-NaN values in Condition column to use as mode.")
print(df.head())

# verify the unique values in the 'Condition' column after filling NaNs
print(df['Condition'].unique())

#Removing 'Unnamed: 0' column as it is irrelevant
df.drop(columns=['Unnamed: 0'], inplace=True)
print(df.head())

#filling missing values in the 'Year of Manufacture' column with the median value
median_year = df['Year of manufacture'].dropna().median()
df['Year of manufacture'] = df['Year of manufacture'].fillna(median_year)
print(f"Filled NaNs with: {median_year}")
print(df.head())

# verify the unique values in the 'Year of manufacture' column after filling NaNs
print(df['Year of manufacture'].unique())

# verify the unique values in the 'Engine Size' column
print(df['Engine Size'].unique())

print(df.info())

#filling missing values in the 'Engine Size' column with the mean value
mean_engine_size = df['Engine Size'].dropna().mean()
df['Engine Size'] = df['Engine Size'].fillna(mean_engine_size)
print(f"Filled NaNs with: {mean_engine_size}")
print(df.head())

print(df.info())

#filling missing values in the 'Mileage' column with the mean value
mean_mileage = df['Mileage'].dropna().mean()
df['Mileage'] = df['Mileage'].fillna(mean_mileage)
print(f"Filled NaNs with: {mean_mileage}")
print(df.head())

print(df.info())

# verify the unique values in the 'Transmission' column
print(df['Transmission'].unique())

#filling missing values in the 'Transmission' column with the mode (most frequent value)
mode_Transmission = df['Transmission'].dropna().mode()
if not mode_Transmission.empty:
    df['Transmission'] = df['Transmission'].fillna(mode_Transmission[0])
    print(f"Filled NaNs with: {mode_Transmission[0]}")
else:
    print("No non-NaN values in Transmission column to use as mode.")
print(df.head())

# verify the unique values in the 'Transmission' column after filling NaNs
print(df['Transmission'].unique())

print(df.info())

#Check for duplicates
duplicates = df.duplicated().sum()
print(f"Number of duplicate rows: {duplicates}")

#Identifying duplicate rows
duplicate_rows = df[df.duplicated(keep=False)]
print("Duplicate rows:")
print(duplicate_rows)

#Removing duplicates
df.drop_duplicates(inplace=True)

#verify number of duplicates is now zero
print(f"Number of duplicate rows after dropping: {df.duplicated().sum()}")

#All null values and duplicate rows have been handled accordingly to ensure consistency and enhance data quality for better analysis

# Export the cleaned dataset to a new CSV file
df.to_csv('cleaned_Nigerian_Car_Prices.csv', index=False)
print("Cleaned dataset exported to 'cleaned_Nigerian_Car_Prices.csv'")
