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
