# 🛒 Zepto Inventory & Product Analysis Using SQL

![SQL](https://img.shields.io/badge/SQL-MySQL-blue)
![Database](https://img.shields.io/badge/Database-MySQL%20Workbench-orange)
![Analysis](https://img.shields.io/badge/Analysis-Exploratory%20Data%20Analysis-purple)
![Status](https://img.shields.io/badge/Status-Complete-success)

A SQL-based data analytics project focused on exploring **Zepto product, pricing, discount, and inventory data** using MySQL. The project applies data exploration, data quality auditing, aggregation, conditional filtering, and category-level analysis to identify pricing inconsistencies, high-discount products, stock availability issues, and product assortment trends.

## ✨ Key Features

- **Dataset Exploration**: Examines the dataset structure, total records, distinct products, category distribution, and basic price statistics.
- **Data Quality Audit**: Identifies missing values, duplicate-looking product records, invalid prices, suspicious quantities, and inconsistencies between stated and calculated discounts.
- **Product and Pricing Analysis**: Identifies the most expensive and cheapest products, calculates average selling prices by category, and examines products with discounts greater than 20%.
- **Inventory and Stock Analysis**: Analyzes stock status, identifies out-of-stock products, detects low-stock items, and compares stock availability across categories.
- **Discount Analysis**: Calculates actual discount percentages using MRP and selling prices and compares them against listed discount percentages.
- **Business Insights**: Generates overall and category-level summaries covering product counts, average discounts, selling prices, and stock availability.
- **Inventory Risk Identification**: Highlights discounted products that are out of stock and products with high discounts but limited availability.

## 🛠️ Tech Stack

- **Query Language**: SQL
- **Database Management System**: MySQL
- **Database Tool**: MySQL Workbench
- **Data Source**: CSV dataset
- **Analysis Techniques**: Data aggregation, filtering, grouping, sorting, conditional logic, and data quality checks

---

## 🚀 Getting Started

### Prerequisites

- MySQL Server 8.0 or a compatible MySQL version
- MySQL Workbench
- Zepto product dataset in CSV format
- Basic knowledge of SQL queries

### Installation & Setup

1. **Clone the repository**

   ```bash
   git clone https://github.com/MHMSiddiqui/Zepto-Inventory-Analysis-SQL.git
   cd Zepto-Inventory-Analysis-SQL
   ```

2. **Create the database**

   Open MySQL Workbench and execute:

   ```sql
   CREATE DATABASE IF NOT EXISTS zepto_inventory_raw;
   USE zepto_inventory_raw;
   ```

3. **Import the dataset**

   - Open MySQL Workbench.
   - Select the `zepto_inventory_raw` database.
   - Use the Table Data Import Wizard to import `zepto_v2.csv`.
   - Name the table `zepto_v2`.
   - Confirm that the imported column names match those used in the SQL script.

4. **Run the SQL queries**

   Open `Zepto_Analysis_SQL.sql` in MySQL Workbench and execute the queries section by section.

   The script includes a column-renaming statement to correct the imported `Category` column header if it contains a UTF-8 byte-order-mark artifact. If the column name is already correct, skip that statement.

5. **Review the results**

   Execute the queries to inspect data quality, analyze pricing and discounts, investigate inventory availability, and generate category-level summaries.

---

## 📖 Usage Guide

The project is organized into five analytical sections.

### 1. Dataset Exploration
### 2. Data Quality Audit
### 3. Product and Pricing Analysis
### 4. Inventory and Stock Analysis
### 5. Business Insights and Final Summary

## 📊 Business Questions Answered

- How many product records, distinct product names, and categories are present?
- Which categories contain the most listed products?
- Which products have the highest and lowest selling prices?
- Are the stated discount percentages consistent with the actual price reductions?
- Which categories have the highest average discounts?
- How many products are out of stock?
- Which categories have the greatest number of out-of-stock products?
- Which discounted products are unavailable or have limited stock?
- What pricing and inventory patterns can help prioritize further investigation?

## 📂 Project Structure

```text
Zepto-Inventory-Analysis-SQL/
│
├── Zepto_Analysis_SQL.sql   # SQL queries for exploration and analysis
├── zepto_v2.csv             # Source product dataset
└── README.md                # Project documentation
```

## ⚙️ Key SQL Concepts Used

| SQL Concept | Application |
|---|---|
| `SELECT` | Retrieve product and inventory information |
| `WHERE` | Filter products based on prices, discounts, and stock status |
| `GROUP BY` | Summarize product counts and metrics by category |
| `ORDER BY` | Rank products and categories |
| `COUNT()` | Count records, distinct products, and categories |
| `SUM()` | Calculate stock-status totals and missing-value counts |
| `AVG()`, `MIN()`, `MAX()` | Analyze prices and discount statistics |
| `ROUND()` | Format calculated metrics |
| `CASE`-style conditional logic | Evaluate data quality and business conditions |
| `HAVING` | Identify repeated product records |
| `NULLIF()` | Avoid division by zero in discount calculations |

## 📈 Skills Demonstrated

- SQL querying and data exploration
- Data quality auditing
- Missing-value and duplicate detection
- Data validation and price consistency checks
- Product pricing and discount analysis
- Inventory and stock availability analysis
- Aggregation and category-level reporting
- Business-oriented analytical thinking

## 🔍 Business Applications

The analytical techniques demonstrated in this project can support:

- **Inventory Monitoring**: Identify products with limited availability or out-of-stock status.
- **Pricing Analysis**: Compare listed and selling prices to identify potential inconsistencies.
- **Discount Evaluation**: Investigate discount patterns across products and categories.
- **Assortment Analysis**: Understand the distribution of products across categories.
- **Operational Prioritization**: Flag high-discount, low-stock products for further review.

*Note: The dataset contains product and inventory attributes. The project does not establish actual sales, revenue, profitability, customer demand, or stockout causes because these outcomes are not directly measured by the included queries.*

## 🤝 Contributing

Contributions are welcome! To contribute:

1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/YourFeature`).
3. Commit your changes (`git commit -m "Add YourFeature"`).
4. Push your branch (`git push origin feature/YourFeature`).
5. Open a Pull Request.


