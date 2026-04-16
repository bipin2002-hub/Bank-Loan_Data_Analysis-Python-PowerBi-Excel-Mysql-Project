create database BankLoan_DB;
use BankLoan_DB;
select * from  bank_data;

SET SQL_SAFE_UPDATES = 0;

UPDATE bank_data SET issue_date            = STR_TO_DATE(issue_date,            '%d-%m-%Y');
UPDATE bank_data SET last_credit_pull_date = STR_TO_DATE(last_credit_pull_date, '%d-%m-%Y');
UPDATE bank_data SET last_payment_date     = STR_TO_DATE(last_payment_date,     '%d-%m-%Y');
UPDATE bank_data SET next_payment_date     = STR_TO_DATE(next_payment_date,     '%d-%m-%Y');

SET SQL_SAFE_UPDATES = 1;

-- count Total no of rows
 select count(*) from bank_data;  

-- KPI's 
--  total no. of  total_loan_application 
select count(id)  as  total_loan_application from  bank_data; -- 38576 

-- Month to date total laon application 
select count(id)  as  MTD from  bank_data 
where month(issue_date)= 12 and year(issue_date)= 2021;  -- 4314

-- Previous Month to date total laon application
 select count(id)  as PMTD from  bank_data 
where month(issue_date)= 11 and year(issue_date)= 2021; -- 4035

-- MOM= (MTD-PMTD)/PMID ------- Month On Month
SELECT 
    (MTD - PMTD) / PMTD * 100 AS MOM_growth_pct
FROM (
    SELECT 
        COUNT(id) AS MTD,
        (SELECT COUNT(id) 
         FROM bank_data 
         WHERE MONTH(issue_date) = 11 
           AND YEAR(issue_date) = 2021) AS PMTD
    FROM bank_data
    WHERE MONTH(issue_date) = 12
      AND YEAR(issue_date) = 2021
) AS summary; -- 6.9145 

-- MTD total funded amount 
 select round(sum(loan_amount)/1000000,3) as MTD_total_funded_amount_Million 
 from bank_data
 where month (issue_date)=12 and  year(issue_date)=2021;

-- PMTD total funded amount  
 select round(sum(loan_amount)/1000000,3) as PMTD_total_funded_amount_Million 
 from bank_data
 where month (issue_date)=11 and  year(issue_date)=2021;

--  MOM_growth_pct 
SELECT 
    (MTD - PMTD) / PMTD * 100 AS MOM_growth_pct
FROM (
    SELECT 
        sum(loan_amount) AS MTD ,
        (SELECT  sum(loan_amount)
         FROM bank_data 
         WHERE MONTH(issue_date) = 11 
           AND YEAR(issue_date) = 2021) AS PMTD
    FROM bank_data
    WHERE MONTH(issue_date) = 12
      AND YEAR(issue_date) = 2021
) AS summary; -- 13.0387

-- -------------------Total Amount Received back to the  customers ----------------
  select round(sum(total_payment)/1000000,2) as Total_amount_received_Mn from bank_data; -- 473.07 
  
-- for current month 
 select round(sum(total_payment)/1000000,2) as MTD_Total_amount_received_Mn from bank_data
 where month(issue_date)=12 and  year(issue_date)=2021;   

 -- for Previous Month 
  select round(sum(total_payment)/1000000,2) as MTD_Total_amount_received_Mn from bank_data
 where month(issue_date)=11 and  year(issue_date)=2021;
 
 
 -- ------------------------Average Interest Rate--------------------------- 
 select round(avg(int_rate)*100,2)  as  avg_interest_rate from bank_data; -- 12.05%  
 
  -- Current Month Average Interest Rate
 select round(avg(int_rate)*100,2)  as  avg_interest_rate from bank_data 
 where month(issue_date)=12 and year(issue_date)=2021;
 
 -- Prevois Month Average Interest Rate
 select round(avg(int_rate)*100,2)  as  avg_interest_rate from bank_data 
 where month(issue_date)=11 and year(issue_date)=2021;
select * from banK_data;

-- ----------------Avg Dept To Income Ratio (DTI)--------------
select round(avg(dti)*100,2) as Avg_DTI  from bank_data; -- 13.33 % 

-- current month Avg Dept To Income Ratio (DTI)
select round(avg(dti)*100,2) as Avg_DTI  from bank_data
where month(issue_date)=12 and  year(issue_date)=2021; -- 13.67%

-- previous month Avg Dept To Income Ratio (DTI)
select round(avg(dti)*100,2) as Avg_DTI  from bank_data
where month(issue_date)=11 and  year(issue_date)=2021; -- 13.30%

--   ----------------Loan Status---------------------  
 select loan_status from bank_data;
--  ---------------Good Loan-----------------------  
 -- good Loan PCT %
SELECT 
    ROUND(
        COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0
        / COUNT(id), 2
    ) AS Good_loan_PCT
FROM bank_data;
-- or  
SELECT 
    ROUND(
        COUNT(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN id END) * 100.0
        / COUNT(id), 2
    ) AS Good_loan_PCT
FROM bank_data;
 
-- Good Loan application 
select count(id) as Good_loan_application from bank_data where loan_status = "Fully Paid" or  loan_status="Current"; 
-- or 
SELECT 
    COUNT(id) AS Good_loan_application 
FROM bank_data 
WHERE loan_status IN ('Fully Paid', 'Current'); -- 33243  

-- ----------------Good Funded Amount------------- 
SELECT 
    round(sum(loan_amount)/1000000,3) AS Good_loan_funded_amount
FROM bank_data 
WHERE loan_status IN ('Fully Paid', 'Current');

-- Good load Total Payment Recieved
SELECT 
    round(sum(Total_Payment)/1000000,3) AS Good_loan_payment_received
FROM bank_data 
WHERE loan_status IN ('Fully Paid', 'Current') ;-- 435.786Mn 


-- ----------------------Bad loan-----------------------
 -- Bad Loan PCT %
SELECT 
    ROUND(
        COUNT(CASE WHEN loan_status = "Charged Off" THEN id END) * 100.0
        / COUNT(id), 2
    ) AS bad_loan_PCT
FROM bank_data; -- 13.82% 

-- -- Bad loan Application 
select count(id) as Bad_loan_application from bank_data 
where loan_status = "Charged Off"; -- 5333 

-- Total  funded Amount of Bad loan 
select round(sum(loan_amount)/1000000,2) as  Bad_loan_amount from bank_data 
where loan_status ="Charged Off"; -- 65.53Mn 

-- Bad Loan  Payment Received  
select round(sum(Total_payment)/1000000,2) as  Bad_loan_amount_received from bank_data 
where loan_status ="Charged Off"; -- 37.28 Mn

-- -------------------------------Loan Grid Status----------------------------
select 
      loan_status,
      count(id) as  total_loan_applications,
      round(sum(total_payment)/1000000,2) as Total_Amount_Received_Mn,
      round(sum(loan_amount)/1000000,2) as total_funded_amount_Mn,
      round(avg(int_rate)*100,2) as  interest_Rate,
      round(avg(dti)*100,2) as DTI 
	from 
       bank_data
       group by loan_status;
       
--  Current Month
select 
      loan_status,
      round(sum(total_payment)/1000000,2) as MTD_Total_Amount_Received_Mn,
      round(sum(loan_amount)/1000000,2) as MTD_total_funded_amount_Mn
from bank_data
where month(issue_date)=12
group by loan_status;

-- Previous Month  
select 
      loan_status,
      round(sum(total_payment)/1000000,2) as MTD_Total_Amount_Received_Mn,
      round(sum(loan_amount)/1000000,2) as MTD_total_funded_amount_Mn
from bank_data
where month(issue_date)=11
group by loan_status;


-- ----------------------------------------- Overview---------------------------------------------- 
-- -------------------- Mothly Trend------------------------------------- 
-- month wise  Application,Total_funded_amount and total_received_amount_Mn 
SELECT 
    MONTHNAME(issue_date)                  AS month_name,
    COUNT(id)                              AS total_loan_applications,
    ROUND(SUM(loan_amount) / 1000000, 2)   AS total_funded_amount_Mn,
    ROUND(SUM(total_payment) / 1000000, 2) AS total_received_amount_Mn
FROM bank_data
GROUP BY 
    MONTHNAME(issue_date),
    MONTH(issue_date)
ORDER BY 
    MONTH(issue_date);

-- Address State 

select address_state,
count(id) as  Total_loan_application,
round(sum(loan_amount)/1000000,2) as  total_funded_amount_Mn ,
round(sum(total_payment)/1000000,2) as total_Recieved_Amount_Mn
from bank_data
group by address_state
order by count(id) desc;

-- --------------Loan Term---------- 
select term,
count(id) as  Total_loan_application,
round(sum(loan_amount)/1000000,2) as  total_funded_amount_Mn ,
round(sum(total_payment)/1000000,2) as total_Recieved_Amount_Mn
from bank_data
group by term
order by term desc;

-- Employee lenth 
-- Employee Length Analysis
SELECT 
    emp_length,
    COUNT(id)                              AS total_loan_applications,
    ROUND(SUM(loan_amount) / 1000000, 2)   AS total_funded_amount_mn,
    ROUND(SUM(total_payment) / 1000000, 2) AS total_received_amount_mn
FROM bank_data
GROUP BY emp_length
ORDER BY 
    CAST(REGEXP_SUBSTR(emp_length, '[0-9]+') AS UNSIGNED) DESC;
   
-- Purpose 
SELECT 
    purpose,
    COUNT(id)                              AS total_loan_applications,
    ROUND(SUM(loan_amount) / 1000000, 2)   AS total_funded_amount_mn,
    ROUND(SUM(total_payment) / 1000000, 2) AS total_received_amount_mn
FROM bank_data
GROUP BY purpose
ORDER BY  count(id) desc;

-- Home  Ownership 
SELECT 
    home_ownership,
    COUNT(id)                              AS total_loan_applications,
    ROUND(SUM(loan_amount) / 1000000, 2)   AS total_funded_amount_mn,
    ROUND(SUM(total_payment) / 1000000, 2) AS total_received_amount_mn
FROM bank_data
GROUP BY home_ownership
ORDER BY  count(id) desc;

-- A grade 
SELECT 
    home_ownership,
    COUNT(id)                              AS total_loan_applications,
    ROUND(SUM(loan_amount) / 1000000, 2)   AS total_funded_amount_mn,
    ROUND(SUM(total_payment) / 1000000, 2) AS total_received_amount_mn
FROM bank_data
where grade="A"
GROUP BY home_ownership
ORDER BY  count(id) desc; 

-- B grade
SELECT 
    home_ownership,
    COUNT(id)                              AS total_loan_applications,
    ROUND(SUM(loan_amount) / 1000000, 2)   AS total_funded_amount_mn,
    ROUND(SUM(total_payment) / 1000000, 2) AS total_received_amount_mn
FROM bank_data
where grade="B"
GROUP BY home_ownership
ORDER BY  count(id) desc;  
--  
 SELECT 
     grade,
    COUNT(id)                              AS total_loan_applications,
    ROUND(SUM(loan_amount) / 1000000, 2)   AS total_funded_amount_mn,
    ROUND(SUM(total_payment) / 1000000, 2) AS total_received_amount_mn
FROM bank_data
GROUP BY grade
ORDER BY  grade;   

select * from  bank_data;

select month(issue_date) as month_name ,count(id) as count_loan_applicatant from bank_data;