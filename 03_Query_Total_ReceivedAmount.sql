/*
-- Calculate the Total Received Amount
-- Includes Month-to-Date (MTD) and Month-over-Month (MoM) metrics
*/
-- Tot Received Amount
Select sum(total_payment) as Tot_Amt_Received,cast(sum(total_payment)/1000000.0 as decimal(10,2)) as Tot_Amt_Received_Millions from Tbl_BankLoanData

Declare @Mtd_ReceivedAmt int, @Prev_Month_MTD_Received_Amt int

-- Total MTD Received Amt
Select sum(total_payment) as MTD_Amt_Received, cast(sum(total_payment)/1000000.0 as decimal(10,2)) as MTD_Amt_Received_Millions from Tbl_BankLoanData
where month(issue_date) = 12 and year(issue_date) = 2021

-- Prev Month MTD Received Amount
Select sum(total_payment) as Prev_Month_MTD_Amt_Received, cast(sum(total_payment)/1000000.0 as decimal(10,2)) as Prev_Month_MTD_Amt_Received_Millions 
from Tbl_BankLoanData
where month(issue_date) = 11 and year(issue_date) = 2021

Select @Mtd_ReceivedAmt = sum(total_payment) from Tbl_BankLoanData where month(issue_date) = 12 and year(issue_date) = 2021
Select @Prev_Month_MTD_Received_Amt = sum(total_payment)  from Tbl_BankLoanData where month(issue_date) = 11 and year(issue_date) = 2021

-- MOMReceivedLoanAmt% = ([MTD_Amt_Received] - [Prev_Month_MTD_Received_Amt])/[Prev_Month_MTD_Received_Amt]
Select cast(cast(@Mtd_ReceivedAmt  - @Prev_Month_MTD_Received_Amt  as decimal(10,2))/ cast(@Prev_Month_MTD_Received_Amt as decimal(10,2)) * 100 as decimal(10,2)) 
as MOM_Received_Amt

