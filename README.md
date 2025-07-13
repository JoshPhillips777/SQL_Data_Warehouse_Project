# Data Warehouse And Analytics Project

This project has been created as hands-on experience for building an SQL Data Warehouse from Scratch. This project is heavily based on the hands-on data Engineering Project shared by Data with Baraa on YouTube: https://www.youtube.com/watch?v=9GVqKuTVANE.

## Purpose

This project demonstrates a comprehensive data warehousing and analytics solution, from building a data warehouse to generating actionable insights. Designed as a portfolio project that highlights industry best practices in data engineering and analytics.

---

# Project 1: Building A Data Warehouse (Data Engineering)

## Objective

Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

## Specifications

- **Data Sources**: Import data from two source systems (ERP and CRM) provided as CSV files.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope**: Focus on the latest dataset only; historization of data is not required.
- **Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics teams.

## Outcomes

- Conducting an analysis of the project objectives and understanding the requirements
- Choosing the data management approach, factoring in architecture, database and ETL methodology, layer design and naming conventions
- Utilizing Notion and Draw.io to plan, document and track project work, including creating visual representations of the architecture, data flow, integration model and data marts
- Building out data warehousing layers based on Medallion Architecture using SQL Server Management Studio (SSMS) 21, includingL
    - A bronze layer for raw, unprocessed data loaded from source systems
    - A silver layer to clean, standardize and enrich data from the bronze layer
    - A gold layer to integrate and aggregate data from the silver layer, incorporating business logic/rules and creating business-ready views for data analysts/business users
- Conducting effective data quality checking throughout the ETL development process to ensure data integrity is maintained
- Utilizing GitHub as a repository for data project documentation, scripts and testing, and regularly committing new code in the Git Repo throughout the project

---

# Project 2: Conducting Advanced Data Analysis In SQL (Data Analytics)

## Objective

Creating queries in SMSS to perform advanced analysis of the sales, customer and product data loaded in the previous Project, and creating reports for analysts and end users to utilize for further reporting and dashboards.

## Outcomes

- Conducting Time Series Analysis to understand trend and seasonality, aggregating sales data yearly to view long-term trends, and monthly to view seasonality trends and patterns    
- Conducting Cumulative Analysis to understand business growth and decline, utilizing window functions to view running totals and moving averages
- Conducting Performance Analysis to compare performance against business targets and Month-On-Month (MOM)/Year-On-Year (YOY) trends
- Conducting Proportional Analysis to compare performance for specific categories/dimensions compared to the overall, to understand business impact
- Conducting Data Segmentation to review correlation between different measures, utilizing CASE statements to convert measures into dimensions for comparison
- Creating customer and product reports/views inclusive of the key metrics identified in the prior analyses, utilizing intermediate CTEs to create a business ready view for each report

---

## License
This project is licensed under the [MIT License][LICENSE]. You are free to use, modify, and share this project with proper attribution.

## About Me
Hey! I'm **Josh Phillips**. I'm an Analyst, with a wide range of experience across multiple industries, primarily within Contact Centre operations. I have a passion for data engineering, analytics and visualization, and use projects like these to continue to enhance my capability of transforming raw data into digestible and meaningful insights.
