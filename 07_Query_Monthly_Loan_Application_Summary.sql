-- Monthly Loan Application Summary 

	Select month(issue_date) as Month_No, FORMAT(issue_date,'MMM') as Month_Name, count(member_id) as Loan_appln_count,sum(loan_amount) as Tot_Funded_Amt,
		Sum(total_payment) as Tot_Received_Amt
	from Tbl_BankLoanData
	group by FORMAT(issue_date,'MMM'),month(issue_date)
	order by 1