select
   OwnerShip,
   Loan_Appln_Count_OwnershipWise,
   Cast(Loan_Appln_Count_OwnershipWise / 1000.0 as decimal(10, 1)) as Loan_Appln_Count_OwnershipWise_Truncated,
   cast(cast(Loan_Appln_Count_OwnershipWise as decimal(10, 2)) / cast(Sum(Loan_Appln_Count_OwnershipWise) over() as decimal(10, 2)) * 100 as decimal(10, 2))as Loan_Appln_OwnerShipWise_Percentage,
   Sum(Loan_Appln_Count_OwnershipWise) over() as Tot_Loan_Appln,Tot_Funded_Amt,Tot_Funded_Amt_Millions,
   Tot_Received_Amt,Tot_Received_Amt_Millions 
from
   (
      Select
         home_ownership as OwnerShip,count(member_id) as Loan_Appln_Count_OwnershipWise,sum(loan_amount) as Tot_Funded_Amt,
         cast(sum(loan_amount) / 1000000.0 as decimal(10, 2)) as Tot_Funded_Amt_Millions,
         Sum(total_payment) as Tot_Received_Amt,cast(sum(total_payment) / 1000000.0 as decimal(10, 2)) as Tot_Received_Amt_Millions 
      from
         Tbl_BankLoanData 
      group by
         home_ownership 
   )
   as Tbl_OwnerShip 
order by 3 desc