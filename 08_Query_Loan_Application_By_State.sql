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