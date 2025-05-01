Select Id,home_ownership as OwnerShip,purpose,grade,sub_grade,issue_date,loan_amount as [Funded_Amount],
 cast(int_rate as decimal(10,2)) as [Int Rate],cast(installment as decimal(10,2)) [Installment Amount],total_payment
from Tbl_BankLoanData