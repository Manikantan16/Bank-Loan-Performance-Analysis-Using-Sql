# Bank-Loan-Performance-Analysis-Using-Sql
- This project focuses on Bank Loan Performance Analysis using SQL, targeting key financial and operational metrics.
- This project utilizes SQL Server to perform in-depth analysis of bank loan data, focusing on efficient data extraction, transformation, and querying.
- It tracks Total Loan Applications, Month-to-Date (MTD) Applications, Funded and Received Amounts, Average Interest Rate, and Debt-to-Income (DTI) Ratio.
- By leveraging SQL queries on loan databases, the analysis provides a Monthly Loan Application Summary, enabling insights into lending trends, customer behavior, and 
  financial health.
- Aggregations, filters, and date functions are used to monitor performance over time, helping stakeholders assess loan quality and risk.
- The project supports data-driven decision-making for loan strategy optimization and improved credit risk management in banking operations.
## Tools Used: ⚙️🖥️
- SQL Server Management Studio V20.2.1
## Dataset:📊📁
- The dataset used in this project is sourced from a CSV file that contains detailed loan application data. It is imported into MS SQL Server for querying and 
 analysis.
- Steps to import the CSV Data:
   - Open SQL Server Management Studio (SSMS) and click connect
     ![image](https://github.com/user-attachments/assets/ec607e15-c391-4e36-bec8-df86161e74c8)
   - At the left Expand the Object Explorer panel and **Right-click** on the target database (where you want to import the data).
     ![image](https://github.com/user-attachments/assets/de3b3378-d3c0-4ad6-b703-6651133d6c53)
   - Navigate to Tasks → Select Import Flat File - >This opens the Import Flat File Wizard.
   - Click Next
   - Specify Input File
     
    ![image](https://github.com/user-attachments/assets/4283fe47-783b-4cb5-a519-42343d8123a1)

   - Preview Data -> Click Next
   - Modify Columns If Required ->Click Next (In my case I assigned **Primary Key** to **Id** Column, **Emp_title** column increased column size to **nvarchar(150).**
   - Click Next again, and finally, click Finish to complete the Import.
   - A New Table is now successfully created in the database.

## Dashboard 1: Summary
**Key Performance Indicators (KPIs) Requirements:**
- **Total Loan Applications:** Calculate the total number of loan applications received during a specified period, including Month-to-Date (MTD) and Month-over-Month (MoM) changes.

![image](https://github.com/user-attachments/assets/e605c321-9d60-4b3d-939f-2097ae974f32)

- **Total Funded Amount:** Understand the total amount of funds disbursed as loans, monitor MTD Total Funded Amount, and analyze MoM changes.

![image](https://github.com/user-attachments/assets/62d24f3c-d909-4e6d-bdc9-6084e7094ca1)

- **Total Amount Received:** Track the total amount received from borrowers to assess cash flow and loan repayment, including MTD Total Amount Received and MoM changes.

![image](https://github.com/user-attachments/assets/2d7fbfb1-6491-4224-b5c8-d111252d756b)

- **Average Interest Rate:** Calculate the average interest rate across all loans, MTD, and monitor MoM variations.

![image](https://github.com/user-attachments/assets/83121c04-c01b-408f-9e86-b76bc157c7c2)

- **Average Debt-to-Income Ratio (DTI):** Evaluate the average DTI for borrowers, compute the average DTI for all loans, MTD, and track MoM fluctuations.
![image](https://github.com/user-attachments/assets/29b6cda3-5d14-47df-9f97-a5848a118332)

- **Good Loan Vs Bad Loan**:
  - Key metrics such as Loan Issuance Percentage, Number of Loan Applications, Funded Amount, and Repayment Received are evaluated across both Good and Bad loan 
   categories to provide a comprehensive view of loan performance

![image](https://github.com/user-attachments/assets/f8a20652-690c-4e57-8108-7a208b532399)

## Dashboard 2: Overview 

- **Monthly Loan Application Summary**:

![image](https://github.com/user-attachments/assets/e402e3e4-7fe2-438f-9993-d13650513874)

- **Loan Application by State**:
  
![image](https://github.com/user-attachments/assets/b15265c2-5fca-4333-aaad-278ba9b312d4)

- **Loan Application by Loan Term**:
  
![image](https://github.com/user-attachments/assets/63ee816a-d95e-4cf2-8d21-00e53b498f77)

- **Loan Application by Employment Duration**:

![image](https://github.com/user-attachments/assets/b5632604-a5ad-4289-82ed-f15988e20542)

- **Loan Application by Purpose**:
  
![image](https://github.com/user-attachments/assets/6b723c51-1e4b-48fb-bc86-535695dd6a05)

- **Loan Application by Ownership**:
  
![image](https://github.com/user-attachments/assets/dc6f9045-8928-44c8-aa8f-ff6151869a72)

## Dashboard 3: Details

![image](https://github.com/user-attachments/assets/2d7c4af1-8686-4a11-9d00-10d151931fdd)

## Conclusion
The project will demonstrate how SQL Server can serve as a powerful platform for storing, querying, and analyzing bank loan data. It will help decision-makers monitor loan performance and optimize risk management practices based on reliable data insights.

Also I’d like to thank my friend **Sunitha Mekala** 👫🙏 for being an incredible source of inspiration.
