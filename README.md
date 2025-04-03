# ACH

Step 1. run _ Supplier_Bank_Accounts _ to make sure that the system has Routing #, Account #, eMail
Step 2. run _ Payments _ click on a date _ to launch _
Step 3. ACH_Payments
Step 4. Download result _ save as _ ach.csv
Step 5. build go app _ ach-prep.go _ 
Step 6. run _ ach-prep.exe _ to convert underscores to blank spaces (SQL cannot handle this) in ach.csv to ACH_YYYY_MM_DD.txt
Step 7. upload ACH_YYYY_MM_DD.txt to your Bank.
