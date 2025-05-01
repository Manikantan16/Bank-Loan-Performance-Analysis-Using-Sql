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
