/*
-- Calculate the Avg DTI
-- Includes Month-to-Date (MTD) and Month-over-Month (MoM) metrics
*/

-- Avg DTI
Select cast(avg(dti) * 100 as decimal(10,2)) as  Avg_DTI_Rate from Tbl_BankLoanData

Declare @MTD_Avg_DTI_Rate decimal(10,2), @Prev_Month_MTD_Avg_DTI_Rate decimal(10,2)

-- MTD Avg DTI Rate
Select cast(avg(dti) * 100 as decimal(10,2)) as  MTD_Avg_DTI_Rate from Tbl_BankLoanData
where month(issue_date) = 12 and year(issue_date) = 2021

-- Prev Month MTD Avg DTI Rate
Select cast(avg(dti) * 100 as decimal(10,2)) as  MTD_Avg_DTI_Rate from Tbl_BankLoanData
where month(issue_date) = 11 and year(issue_date) = 2021

Select @MTD_Avg_DTI_Rate = cast(avg(dti) * 100 as decimal(10,2)) from Tbl_BankLoanData where month(issue_date) = 12 and year(issue_date) = 2021
Select @Prev_Month_MTD_Avg_DTI_Rate = cast(avg(dti) * 100 as decimal(10,2))  from Tbl_BankLoanData where month(issue_date) = 11 and year(issue_date) = 2021

-- MOMAvgDTIRate% = ([MTD_Avg_DTI_Rate] - [Prev_Month_MTD_Avg_DTI_Rate])/[Prev_Month_MTD_Avg_DTI_Rate]
Select Cast((@MTD_Avg_DTI_Rate - @Prev_Month_MTD_Avg_DTI_Rate)  / @Prev_Month_MTD_Avg_DTI_Rate * 100 as decimal(10,2)) as MOM_AvgDTIRate

