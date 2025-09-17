CREATE DATABASE db;

 USE db;
 
CREATE TABLE telecom_churn_dataset (
    customerID VARCHAR(50) PRIMARY KEY,
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(20),
    MultipleLines VARCHAR(30),
    InternetService VARCHAR(50),
    OnlineSecurity VARCHAR(20),
    OnlineBackup VARCHAR(20),
    DeviceProtection VARCHAR(20),
    TechSupport VARCHAR(20),
    StreamingTV VARCHAR(20),
    StreamingMovies VARCHAR(20),
    Contract VARCHAR(50),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges DECIMAL(10,2),
    Churn VARCHAR(5)
);
 
 select * from telecom_churn_dataset 
 
-- KPIs
 -- 1. Find the Total Number of Customers

SELECT COUNT(customerID) AS total_customers
FROM telecom_churn_dataset;

--  2. Find the Total Number of Customers who Churned

SELECT COUNT(*) AS churn_count
FROM telecom_churn_dataset
WHERE Churn = 'Yes';

-- 3. Find the Churn Percentage

SELECT 
    ROUND(
        (COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) * 100.0) 
        / COUNT(customerID), 2
    ) AS churn_percentage
FROM telecom_churn_dataset;

-- 4. Find the Total Revenue of the Telecom Company

SELECT ROUND(SUM(TotalCharges), 2) AS total_revenue
FROM telecom_churn_dataset;


-- 6. Find the Total Monthly Charges

SELECT ROUND(SUM(MonthlyCharges), 2) AS total_monthly_charges
FROM telecom_churn_dataset;

--  CUSTOMER DETAILS

-- 1. Customer Gender Distribution

SELECT gender, COUNT(customerID) AS customer_count
FROM telecom_churn_dataset
GROUP BY gender;

-- 2. Customer’s Tenure Distribution

SELECT CASE
           WHEN tenure <= 12 THEN 'New Customer'
           WHEN tenure <= 36 THEN 'Mid-Level Customer'
           ELSE 'Loyal Customer'
       END AS customer_type,
       gender,
       COUNT(customerID) AS customer_count
FROM telecom_churn_dataset
GROUP BY customer_type, gender
ORDER BY customer_type, customer_count DESC;

-- CUSTOMER ACCOUNT INFORMATION

-- 1. Total Churn Rate

SELECT
    ROUND(
        (COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) * 100.0) 
        / COUNT(customerID), 2
    ) AS churn_percentage
FROM telecom_churn_dataset;

-- 2. Churn Count by Contract Type

SELECT 
    Contract, 
    COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) AS churn_count
FROM telecom_churn_dataset
GROUP BY Contract
ORDER BY churn_count DESC;

-- 3. Churn Rate by Contract Type

SELECT 
    Contract, 
    ROUND(
        (COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) * 100.0) 
        / COUNT(customerID), 2
    ) AS churn_rate
FROM telecom_churn_dataset
GROUP BY Contract
ORDER BY churn_rate DESC;

-- 4. Average Monthly Charges for Churned vs. Non-Churned Customers

SELECT
    Churn,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM telecom_churn_dataset
GROUP BY Churn;