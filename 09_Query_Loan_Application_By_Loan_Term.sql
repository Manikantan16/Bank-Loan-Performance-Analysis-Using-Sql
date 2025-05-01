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