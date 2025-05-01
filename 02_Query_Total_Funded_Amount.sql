/*
-- Calculate the Total Funded Amount
-- Includes Month-to-Date (MTD) and Month-over-Month (MoM) metrics
*/
-- Tot Funded Amount
Select sum(loan_amount) as Tot_Funded_Amt, cast(sum(loan_amount)/1000000.0 as decimal(10,2)) as Tot_Funded_Amt_Millions  from Tbl_BankLoanData

Declare @Mtd_FundedAmt int, @Prev_Month_MTD_Funded_Amt int

-- Total MTD Funded Amt
Select sum(loan_amount) as MTD_Funded_Amt,cast(sum(loan_amount)/1000000.0 as decimal(10,2)) as MTD_Funded_Amt_Millions  
from Tbl_BankLoanData
where month(issue_date) = 12 and year(issue_date) = 2021

-- Prev Month MTD Funded Amount
Select sum(loan_amount) as Prev_Month_MTD_Funded_Amt,cast(sum(loan_amount)/1000000.0 as decimal(10,2)) as Prev_Month_MTD_Funded_Amt_Millions 
from Tbl_BankLoanData
where month(issue_date) = 11 and year(issue_date) = 2021

Select @Mtd_FundedAmt = sum(loan_amount)      from Tbl_BankLoanData where month(issue_date) = 12 and year(issue_date) = 2021
Select @Prev_Month_MTD_Funded_Amt = sum(loan_amount)  from Tbl_BankLoanData where month(issue_date) = 11 and year(issue_date) = 2021

-- MOMLoanAppln = ([_MtdLoanApplication] - [_PrevMtdLoanApplication])/[_PrevMtdLoanApplication]
Select cast(cast(@Mtd_FundedAmt  - @Prev_Month_MTD_Funded_Amt  as decimal(10,2))/ cast(@Prev_Month_MTD_Funded_Amt as decimal(10,2)) * 100 as decimal(10,2)) as MOM_Funded_Amt

