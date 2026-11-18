CREATE DATABASE customer_rescue_ai;
USE customer_rescue_ai;

CREATE TABLE customer_churn (
    customerID VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(10),
    SeniorCitizen TINYINT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(30),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(30),
    OnlineBackup VARCHAR(30),
    DeviceProtection VARCHAR(30),
    TechSupport VARCHAR(30),
    StreamingTV VARCHAR(30),
    StreamingMovies VARCHAR(30),
    Contract VARCHAR(30),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges DECIMAL(10,2),
    Churn VARCHAR(5)
);

USE customer_rescue_ai;

SELECT COUNT(*) AS total_customers
FROM customer_churn;

SELECT *
FROM customer_churn
LIMIT 10;

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS retained_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS churn_rate_percentage
FROM customer_churn;

SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_churn
GROUP BY Contract
ORDER BY churn_rate_percentage DESC;


SELECT
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_churn
GROUP BY InternetService
ORDER BY churn_rate_percentage DESC;

SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 Months'
        WHEN tenure <= 24 THEN '13-24 Months'
        WHEN tenure <= 48 THEN '25-48 Months'
        ELSE '49-72 Months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_churn
GROUP BY tenure_group
ORDER BY MIN(tenure);

SELECT
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_churn
GROUP BY PaymentMethod
ORDER BY churn_rate_percentage DESC;

SELECT
    Churn,
    COUNT(*) AS total_customers,
    ROUND(AVG(MonthlyCharges), 2) AS average_monthly_charges,
    ROUND(MIN(MonthlyCharges), 2) AS minimum_monthly_charges,
    ROUND(MAX(MonthlyCharges), 2) AS maximum_monthly_charges
FROM customer_churn
GROUP BY Churn;

SELECT
    CASE
        WHEN SeniorCitizen = 1 THEN 'Senior Citizen'
        ELSE 'Non-Senior Citizen'
    END AS customer_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_churn
GROUP BY SeniorCitizen
ORDER BY SeniorCitizen;

SELECT
    customerID,
    Contract,
    tenure,
    MonthlyCharges,
    TotalCharges
FROM customer_churn
WHERE Churn = 'Yes'
  AND MonthlyCharges >= 80
ORDER BY MonthlyCharges DESC
LIMIT 20;

WITH CustomerRanking AS (
    SELECT
        customerID,
        Contract,
        MonthlyCharges,
        Churn,
        DENSE_RANK() OVER (
            ORDER BY MonthlyCharges DESC
        ) AS charge_rank
    FROM customer_churn
)
SELECT
    customerID,
    Contract,
    MonthlyCharges,
    Churn,
    charge_rank
FROM CustomerRanking
WHERE charge_rank <= 10
ORDER BY charge_rank, customerID;

CREATE OR REPLACE VIEW churn_summary_by_contract AS
SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM customer_churn
GROUP BY Contract;

SELECT *
FROM churn_summary_by_contract
ORDER BY churn_rate_percentage DESC;