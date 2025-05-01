
-- Get the Total Data count in table
Select count(*) as Tot_Count from Tbl_BankLoanData

-- Total Loan Application
Select  distinct count(id) as Tot_Loan_Appln from Tbl_BankLoanData

-- Total MTD Loan Application

Select count(id) as MTD from Tbl_BankLoanData
where month(issue_date) = 12 and year(issue_date) = 2021

-- Prev MTD Loan Application
Select count(id) as Prev_MTD from Tbl_BankLoanData
where month(issue_date) = 11 and year(issue_date) = 2021

-- Tot Funded Amount
Select cast(sum(loan_amount)/1000000.0 as decimal(10,2)) as Tot_Funded_Amt_Millions from Tbl_BankLoanData
	

-- Total MTD Funded Amount

Select cast(sum(loan_amount)/1000000.0 as decimal(10,2)) as MTD_Funded_Amt_Millions from Tbl_BankLoanData
where month(issue_date) = 12 and year(issue_date) = 2021

-- Prev Month MTD Funded Amount
Select cast(sum(loan_amount)/1000000.0 as decimal(10,2)) as Prev_Month_MTD_Funded_Amt_Millions from Tbl_BankLoanData
where month(issue_date) = 11 and year(issue_date) = 2021

-- select * from Tbl_BankLoanData
-- Tot Amount Received
Select cast(sum(total_payment)/1000000.0 as decimal(10,2)) as Tot_Amt_Received_Millions from Tbl_BankLoanData
	
-- Total MTD Amount Received
Select cast(sum(total_payment)/1000000.0 as decimal(10,2)) as MTD_Amt_Received_Millions from Tbl_BankLoanData
where month(issue_date) = 12 and year(issue_date) = 2021

-- Prev Month MTD Amount Received
Select cast(sum(total_payment)/1000000.0 as decimal(10,2)) as Prev_Month_MTD_Amt_Received_Millions from Tbl_BankLoanData
where month(issue_date) = 11 and year(issue_date) = 2021

-- Avg Interest Rate
Select cast(avg(int_rate) * 100 as decimal(10,2)) as  Avg_Interest_Rate from Tbl_BankLoanData

-- MTD Avg Interest Rate
Select cast(avg(int_rate) * 100 as decimal(10,2)) as  MTD_Avg_Interest_Rate from Tbl_BankLoanData
where month(issue_date) = 12 and year(issue_date) = 2021

-- Prev Month MTD  Avg Interest Rate
Select cast(avg(int_rate) * 100 as decimal(10,2)) as  MTD_Prev_Month_Avg_Interest_Rate from Tbl_BankLoanData
where month(issue_date) = 11 and year(issue_date) = 2021

-- Avg DTI Rate
Select cast(avg(dti) * 100 as decimal(10,2)) as  Avg_DTI_Rate from Tbl_BankLoanData

-- MTD Avg DTI Rate
Select cast(avg(dti) * 100 as decimal(10,2)) as  MTD_Avg_DTI_Rate from Tbl_BankLoanData
where month(issue_date) = 12 and year(issue_date) = 2021

-- Prev Month MTD  Avg DTI Rate
Select cast(avg(dti) * 100 as decimal(10,2)) as  MTD_Avg_DTI_Rate from Tbl_BankLoanData
where month(issue_date) = 11 and year(issue_date) = 2021

--select distinct loan_status from Tbl_BankLoanData
Declare @LoanAppln_Count int, @GoodLoan_Count int,@BadLoan_Count int,@Good_Loan_Funded_Amt decimal(10,2),@Good_Loan_Amt_Received decimal(10,2),
		@Bad_Loan_Funded_Amt decimal(10,2),@Bad_Loan_Amt_Received decimal(10,2)

select @LoanAppln_Count = COUNT(member_id) from Tbl_BankLoanData

select @GoodLoan_Count = count(member_id),@Good_Loan_Funded_Amt = cast(sum(loan_amount)/1000000.0 as decimal(10,2)), 
    @Good_Loan_Amt_Received = cast(sum(total_payment)/1000000.0 as decimal(10,2))
from Tbl_BankLoanData where loan_status in ('Fully Paid','Current')

select @BadLoan_Count = count(member_id),@Bad_Loan_Funded_Amt = cast(sum(loan_amount)/1000000.0 as decimal(10,2)), 
    @Bad_Loan_Amt_Received = cast(sum(total_payment)/1000000.0 as decimal(10,2))
from Tbl_BankLoanData where loan_status in ('Charged Off')



Select @LoanAppln_Count as Tot_Loan_Appln,
	@GoodLoan_Count as Good_Loan_Appln_Count, cast(cast(@GoodLoan_Count as decimal(10,2))/ cast(@LoanAppln_Count as decimal(10,2)) * 100 as decimal(10,2)) as  Good_Loan_Percent,
	@Good_Loan_Funded_Amt as Good_Loan_Funded_Amt,@Good_Loan_Amt_Received as Good_Loan_Amt_Received,
	@BadLoan_Count as Bad_Loan_Appln_Count,cast(cast(@BadLoan_Count as decimal(10,2))/ cast(@LoanAppln_Count as decimal(10,2)) * 100 as decimal(10,2)) as Bad_Loan_Percent,
	@Bad_Loan_Funded_Amt Bad_Loan_Funded_Amt,@Bad_Loan_Amt_Received as Bad_Loan_Amt_Received

	-- Monthly Loan Application Summary 

	Select month(issue_date) as Month_No, FORMAT(issue_date,'MMM') as Month_Name, count(member_id) as Loan_appln_count,sum(loan_amount) as Tot_Funded_Amt,Sum(total_payment) as Tot_Received_Amt
	from Tbl_BankLoanData
	group by FORMAT(issue_date,'MMM'),month(issue_date)
	order by 1

	-- Loan Application, Funded Amount, Received Amount - State Wise
	select row_number() over(order by state_name) as Sno,State_Name,Loan_Appln_Count_State_Wise,sum(Loan_Appln_Count_State_Wise) over() as Tot_Loan_Appln,
		Tot_Funded_Amt,Tot_Funded_Amt_Millions,Tot_Received_Amt,Tot_Received_Amt_Millions
	from
	(
		Select address_state as State_Name, count(member_id) as Loan_Appln_Count_State_Wise,
		sum(loan_amount) as Tot_Funded_Amt,cast(sum(loan_amount)/1000000.0 as decimal(10,2)) as Tot_Funded_Amt_Millions,
		Sum(total_payment) as Tot_Received_Amt,cast(sum(total_payment)/1000000.0 as decimal(10,2)) as Tot_Received_Amt_Millions
		from Tbl_BankLoanData
		group by address_state
	)
	as TblState
	order by State_Name

	
	-- Loan Application, Funded Amount, Received Amount - Loan Term Wise
	select Loan_Term,Loan_Appln_Count_TermWise,Sum(Loan_Appln_Count_TermWise) over() as Tot_Loan_Appln,
		cast(cast(Loan_Appln_Count_TermWise as decimal(10,2))/ cast(Sum(Loan_Appln_Count_TermWise) over() as decimal(10,2)) * 100 as decimal(10,2))as Loan_Appln_TermWise_WPercentage,
		Tot_Funded_Amt,Tot_Funded_Amt_Millions,Tot_Received_Amt,Tot_Received_Amt_Millions
	from
	(
		Select term as Loan_Term, count(member_id) as Loan_Appln_Count_TermWise,
		sum(loan_amount) as Tot_Funded_Amt,cast(sum(loan_amount)/1000000.0 as decimal(10,2)) as Tot_Funded_Amt_Millions,
		Sum(total_payment) as Tot_Received_Amt,cast(sum(total_payment)/1000000.0 as decimal(10,2)) as Tot_Received_Amt_Millions
		from Tbl_BankLoanData
		group by term
	) as Tbl_LoanTerm
	order by Loan_Term

	-- Loan Application, Funded Amount, Received Amount - Years of Employment
	select Employment_Years,Loan_Appln_Count_EmpYearWise,Cast(Loan_Appln_Count_EmpYearWise / 1000.0 as decimal(10,1)) as Loan_Appln_Count_EmpYearWise_Truncated,
		cast(cast(Loan_Appln_Count_EmpYearWise as decimal(10,2))/ cast(Sum(Loan_Appln_Count_EmpYearWise) over() as decimal(10,2)) * 100 as decimal(10,2))as Loan_Appln_EmpYearWise_Percentage,
		Sum(Loan_Appln_Count_EmpYearWise) over() as Tot_Loan_Appln,Tot_Funded_Amt,Tot_Funded_Amt_Millions,Tot_Received_Amt,Tot_Received_Amt_Millions
	from
	(
		Select emp_length as Employment_Years, count(member_id) as Loan_Appln_Count_EmpYearWise,
		sum(loan_amount) as Tot_Funded_Amt,cast(sum(loan_amount)/1000000.0 as decimal(10,2)) as Tot_Funded_Amt_Millions,
		Sum(total_payment) as Tot_Received_Amt,cast(sum(total_payment)/1000000.0 as decimal(10,2)) as Tot_Received_Amt_Millions
		from Tbl_BankLoanData
		group by emp_length
	) as Tbl_EmpLength
	order by 1

	-- Loan Application, Funded Amount, Received Amount - Purpose
	-- Loan Application, Funded Amount, Received Amount - Purpose
	select Purpose,Loan_Appln_Count_Purpose,Cast(Loan_Appln_Count_Purpose / 1000.0 as decimal(10,1)) as Loan_Appln_Count_Purpose_Truncated,
		cast(cast(Loan_Appln_Count_Purpose as decimal(10,2))/ cast(Sum(Loan_Appln_Count_Purpose) over() as decimal(10,2)) * 100 as decimal(10,2))as Loan_Appln_Purpose_Percentage,
		Sum(Loan_Appln_Count_Purpose) over() as Tot_Loan_Appln,Tot_Funded_Amt,Tot_Funded_Amt_Millions,Tot_Received_Amt,Tot_Received_Amt_Millions
	from
	(
		Select purpose, count(member_id) as Loan_Appln_Count_Purpose,
		sum(loan_amount) as Tot_Funded_Amt,cast(sum(loan_amount)/1000000.0 as decimal(10,2)) as Tot_Funded_Amt_Millions,
		Sum(total_payment) as Tot_Received_Amt,cast(sum(total_payment)/1000000.0 as decimal(10,2)) as Tot_Received_Amt_Millions
		from Tbl_BankLoanData
		group by purpose
	) as Tbl_Purpose
	order by 3 desc

-- Loan Application, Funded Amount, Received Amount - OwnerShip
select
   OwnerShip,
   Loan_Appln_Count_OwnershipWise,
   Cast(Loan_Appln_Count_OwnershipWise / 1000.0 as decimal(10, 1)) as Loan_Appln_Count_OwnershipWise_Truncated,
   cast(cast(Loan_Appln_Count_OwnershipWise as decimal(10, 2)) / cast(Sum(Loan_Appln_Count_OwnershipWise) over() as decimal(10, 2)) * 100 as decimal(10, 2))as Loan_Appln_OwnerShipWise_Percentage,
   Sum(Loan_Appln_Count_OwnershipWise) over() as Tot_Loan_Appln,
   Tot_Funded_Amt,
   Tot_Funded_Amt_Millions,
   Tot_Received_Amt,
   Tot_Received_Amt_Millions 
from
   (
      Select
         home_ownership as OwnerShip,
         count(member_id) as Loan_Appln_Count_OwnershipWise,
         sum(loan_amount) as Tot_Funded_Amt,
         cast(sum(loan_amount) / 1000000.0 as decimal(10, 2)) as Tot_Funded_Amt_Millions,
         Sum(total_payment) as Tot_Received_Amt,
         cast(sum(total_payment) / 1000000.0 as decimal(10, 2)) as Tot_Received_Amt_Millions 
      from
         Tbl_BankLoanData 
      group by
         home_ownership 
   )
   as Tbl_OwnerShip 
order by 3 desc

-- Details

Select Id,home_ownership as OwnerShip,purpose,grade,sub_grade,issue_date,loan_amount as [Funded_Amount],
 cast(int_rate as decimal(10,2)) as [Int Rate],cast(installment as decimal(10,2)) [Installment Amount],total_payment
from Tbl_BankLoanData