# 📊 AdventureWorks SQL Analysis Project  
### *Google Data Analytics Certificate – SQL Case Study*

## 📌 Project Overview
This project uses the **Microsoft AdventureWorks** sample database to answer a set of business-focused analytical questions using **SQL**.

The objective of this project was to demonstrate practical SQL skills by:
- Querying a real-world relational dataset
- Answering business questions related to sales, customers, products, and operations
- Preparing query outputs suitable for data visualisation
- Applying SQL concepts commonly required in entry-level data analyst roles

This work was completed as part of the requirements for the **Google Data Analytics Certificate**.

---

## 🗂️ Dataset Used
**AdventureWorks Sample Database**  
Source: Microsoft  
Official documentation and installation guide:  
https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure

AdventureWorks is a fictional retail company dataset designed to simulate:
- Internet and reseller sales.
- Customers and geographic regions.
- Products, inventory, and logistics.
- Time-based sales data.

The dataset follows a **star schema** structure, including fact and dimension tables such as:
- `FactInternetSales`
- `FactResellerSales`
- `DimCustomer`
- `DimProduct`
- `DimDate`
- `DimSalesTerritory`
- `DimGeography`

---

## 🎯 Purpose of the Analysis
The goal of this project was to answer realistic business questions such as:
- How sales perform over time.
- Which products and customers generate the most revenue.
- How sales differ by region.
- Inventory and operational performance insights.

Each question was answered using **SQL queries only**, focusing on clarity, correctness, and business relevance.

---

## 🛠️ SQL Techniques Used
- `JOIN` operations across multiple dimension and fact tables
- Aggregate functions (`SUM`, `COUNT`, `AVG`)
- Date-based analysis using time dimensions
- Subqueries and derived tables
- Sorting and ranking results
- Filtering using `WHERE` and `GROUP BY`
- Preparing query outputs for visualisation
- Union

---

## 🎓 Skills Demonstrated
- SQL querying for analytical use cases
- Working with a star schema data model
- Translating business questions into SQL queries
- Data aggregation and summarisation
- Customer, product, and regional analysis
- Time-series analysis
- Inventory and operational insights
- Preparing datasets for dashboarding and reporting

---

## 📎 Notes
- This project focuses on **query logic and analysis**, not data cleaning, as AdventureWorks is a pre-cleaned sample dataset.
- All analysis was completed using SQL in a Microsoft SQL Server environment.