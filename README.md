# Customer Rescue AI — Customer Churn Prediction

## Project Overview
Customer Rescue AI is a machine learning and business analytics project that predicts customer churn risk and helps businesses prioritize customer retention.

The project uses Python for data preparation and machine learning, SQL for business analysis, and Power BI for interactive reporting.

## Objectives
- Analyze customer churn patterns.
- Identify customers at higher risk of leaving.
- Evaluate churn by contract, internet service, tenure, payment method, and customer characteristics.
- Support data-driven customer retention decisions.

## Tools and Technologies
- **Python:** Pandas, NumPy, Matplotlib, Seaborn, Scikit-learn
- **SQL:** MySQL, aggregations, CASE statements, CTEs, window functions, views
- **Power BI:** KPI cards, charts, slicers, and customer risk reporting
- **Machine Learning:** Logistic Regression and Random Forest

## Project Structure
- `data/` — Original and cleaned customer datasets
- `notebooks/` — Customer churn analysis and model development
- `models/` — Saved machine learning model and preprocessing pipeline
- `powerbi/` — Power BI dashboard and screenshot
- `reports/` — Customer churn risk report and business summary
- `sql/` — SQL business analysis queries

## Key Findings
- The overall churn rate in the cleaned dataset is **26.58%**.
- Month-to-month customers have a churn rate of **42.71%**.
- Fiber optic customers have a churn rate of **41.89%**.
- Customers with 12 months or less of tenure have a churn rate of **47.68%**.
- Customers paying by electronic check have a churn rate of **45.29%**.

These are descriptive findings from the dataset; they do not establish causation.

## Machine Learning Results
The Random Forest model achieved the following results on the held-out test set at a 0.50 classification threshold:

- Accuracy: **76.62%**
- Churn precision: **54.37%**
- Churn recall: **74.87%**
- Churn F1-score: **62.99%**

The model's probability scores are used to categorize customers into low-, medium-, and high-risk groups.

## Business Applications
- Prioritize high-risk customers for retention outreach.
- Identify customer segments with elevated churn.
- Support targeted offers and customer engagement strategies.
- Monitor churn patterns using an interactive Power BI dashboard.

## How to Explore
1. Open the notebook in `notebooks/` to review data preparation and model development.
2. Review the SQL scripts in `sql/` for business analysis.
3. Open the Power BI report in `powerbi/` using Power BI Desktop.
4. Explore the CSV reports in `reports/`.

## Limitations
Model performance depends on the dataset and evaluation method. Predictions indicate estimated risk, not certainty. Retention strategies should be evaluated against business outcomes before deployment.

## Dataset
This project uses the Telco Customer Churn dataset. Check the dataset source and its terms before redistributing the data.

## Author
**Bala Ankanna**

GitHub: https://github.com/BalaAnkanna
