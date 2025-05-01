/*
-- Calculate the Avg Interest Rate
-- Includes Month-to-Date (MTD) and Month-over-Month (MoM) metrics
*/

-- Avg Interest Rate
Select cast(avg(int_rate) * 100 as decimal(10,2)) as  Avg_Interest_Rate from Tbl_BankLoanData

Declare @MTD_Avg_Interest_Rate decimal(10,2), @Prev_Month_MTD_Avg_Interest_Rate decimal(10,2)

-- MTD Avg Interest Rate
Select cast(avg(int_rate) * 100 as decimal(10,2)) as  MTD_Avg_Interest_Rate from Tbl_BankLoanData
where month(issue_date) = 12 and year(issue_date) = 2021

-- Prev Month MTD  Avg Interest Rate
Select cast(avg(int_rate) * 100 as decimal(10,2)) as  MTD_Prev_Month_Avg_Interest_Rate from Tbl_BankLoanData
where month(issue_date) = 11 and year(issue_date) = 2021

Select @MTD_Avg_Interest_Rate = cast(avg(int_rate) * 100 as decimal(10,2)) from Tbl_BankLoanData where month(issue_date) = 12 and year(issue_date) = 2021
Select @Prev_Month_MTD_Avg_Interest_Rate = cast(avg(int_rate) * 100 as decimal(10,2))  from Tbl_BankLoanData where month(issue_date) = 11 and year(issue_date) = 2021

-- MOMAvgInterestRate% = ([MTD_Avg_Int_Rate] - [Prev_Month_MTD_Avg_Int_Rate])/[Prev_Month_MTD_Avg_Int_Rate]
Select Cast((@MTD_Avg_Interest_Rate - @Prev_Month_MTD_Avg_Interest_Rate)  / @Prev_Month_MTD_Avg_Interest_Rate * 100 as decimal(10,2)) as MOM_AvgIntRate

