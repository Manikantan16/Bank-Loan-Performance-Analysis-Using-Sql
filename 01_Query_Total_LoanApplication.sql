/*
-- Calculate the total number of loan applications
-- Includes Month-to-Date (MTD) and Month-over-Month (MoM) metrics
*/
-- Total Loan Application
Select  distinct count(id) as Tot_Loan_Appln from Tbl_BankLoanData

-- Total MTD Loan Application
Declare @Mtd_LoanAppln int, @PrevMtd_LoanAppln int

Select count(id) as MTD, cast(count(id)/1000.0 as decimal(10,2)) as MTD_InThousand 
from Tbl_BankLoanData 
where month(issue_date) = 12 and year(issue_date) = 2021

-- Prev MTD Loan Application
Select count(id) as Prev_MTD,cast(count(id)/1000.0 as decimal(10,2)) as Prev_MTD_InThousand 
from Tbl_BankLoanData 
where month(issue_date) = 11 and year(issue_date) = 2021

Select @Mtd_LoanAppln = count(id)  from Tbl_BankLoanData where month(issue_date) = 12 and year(issue_date) = 2021
Select @PrevMtd_LoanAppln = count(id)  from Tbl_BankLoanData where month(issue_date) = 11 and year(issue_date) = 2021

-- MOMLoanAppln = ([_MtdLoanApplication] - [_PrevMtdLoanApplication])/[_PrevMtdLoanApplication]
Select cast(cast(@Mtd_LoanAppln  - @PrevMtd_LoanAppln  as decimal(10,2))/ cast(@PrevMtd_LoanAppln as decimal(10,2)) * 100 as decimal(10,2)) as MOM_Total_Loan_Appln

