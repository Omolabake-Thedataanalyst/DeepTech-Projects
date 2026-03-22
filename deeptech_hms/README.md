# DeepTech HMS SQL Assignment

## Title

**Patient & Appointment Data Analysis using SQL**

---

## Executive Summary

This project analyzes a Hospital Management System (HMS) dataset to extract meaningful insights about patients, gender distribution, and doctor appointments. Using SQL, I explored the dataset to answer key business questions and demonstrate fundamental data querying techniques such as filtering, aggregation, and table joins.

---

## Business Problem

Healthcare administrators need quick access to:

* Patient distribution across locations
* Gender demographics for planning and resource allocation
* Visibility into doctors handling confirmed appointments

Without structured queries, extracting these insights from raw data can be inefficient and time-consuming.

---

## Methodology

* Imported CSV dataset into phpMyAdmin
* Structured data into relational tables (`patient_table`, `doctor_table`, `appointment_table`)
* Wrote SQL queries to:

  * Filter patients by state
  * Aggregate gender counts
  * Join multiple tables to retrieve appointment and doctor details
* Validated outputs to ensure accuracy

---

## Specific Skills Demonstrated

* SQL querying (SELECT, WHERE, GROUP BY)
* Data filtering using `IN`
* Aggregation with `COUNT()`
* Table joins for relational data analysis
* Database management using phpMyAdmin

---

## Results & Insights

### 1. Regional Patient Distribution

Patients were successfully filtered for **FCT Abuja** and **Plateau**, enabling targeted regional analysis.

### 2. Gender Breakdown

The dataset showed a balanced distribution between male and female patients, useful for demographic insights.

### 3. Confirmed Appointments Analysis

By joining appointment and doctor tables, I identified doctors with confirmed appointments along with their:

* Specialities
* Locations
* Appointment details

This provides visibility into active healthcare service delivery.

---

## Business Recommendations

* Allocate medical resources based on regional patient concentration (e.g., FCT Abuja, Plateau)
* Use gender distribution insights to plan specialized healthcare programs
* Monitor confirmed appointments regularly to optimize doctor workload and scheduling
* Improve data structure consistency to enhance reporting accuracy

---

## Next Steps

If given more time, I would:

* Add more advanced queries (e.g., appointment trends over time)
* Build a dashboard for visualization (using Power BI)
* Perform data validation for higher data quality
* Optimize queries for performance on larger datasets
* Introduce indexing for faster data retrieval

---

## Tools Used

* MySQL / phpMyAdmin
* SQL

---

*This project is part of my ongoing journey in SQL and data analysis. Feedback is welcome!*
