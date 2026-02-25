CREATE DATABASE telco_project;
USE telco_project;
SELECT DATABASE();
show tables;
show tables;

show databases;
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_type = 'BASE TABLE';

USE newschema;
SELECT * FROM `telco customer churn` LIMIT 10;
RENAME TABLE `telco customer churn` TO churn;
SELECT COUNT(*) AS total_customers
FROM churn;

SELECT Churn, COUNT(*) AS total_customers
FROM churn
GROUP BY Churn;

SELECT 
ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_percentage
FROM churn;

SELECT 
ROUND(SUM(MonthlyCharges) ,2) AS revenue_lost_per_month
FROM churn
WHERE Churn = 'Yes';

SELECT Contract, COUNT(*) AS churned_customers,
ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM churn WHERE Contract = Contract), 2) AS churn_percentage
FROM churn
WHERE Churn = 'Yes'
GROUP BY Contract
ORDER BY churned_customers DESC;

SELECT
Churn, ROUND(AVG(MonthlyCharges),2) AS avg_monthly_charges
FROM churn
GROUP BY Churn;

SELECT Contract, tenure, COUNT(*) AS churned_customers
FROM churn
WHERE Churn = 'Yes'
GROUP BY Contract, tenure
ORDER BY churned_customers DESC
LIMIT 10;

SELECT InternetService, OnlineSecurity, OnlineBackup, COUNT(*) AS churned_customers
FROM churn
WHERE Churn = 'Yes'
GROUP BY InternetService, OnlineSecurity, OnlineBackup
ORDER BY churned_customers DESC
LIMIT 10;

SELECT PaymentMethod, COUNT(*) AS churned_customers
FROM churn
WHERE Churn = 'Yes'
GROUP BY PaymentMethod
ORDER BY churned_customers DESC;

SELECT 
CASE 
    WHEN tenure BETWEEN 0 AND 12 THEN '0-12'
    WHEN tenure BETWEEN 13 AND 24 THEN '13-24'
    WHEN tenure BETWEEN 25 AND 48 THEN '25-48'
    ELSE '49+' 
END AS tenure_group,
COUNT(*) AS churned_customers
FROM churn
WHERE Churn = 'Yes'
GROUP BY tenure_group
ORDER BY tenure_group;
