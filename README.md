# ACH, SQL & Batch eMail Remittances

Instead of printing checks on a MICR laser printer, stuffing envelopes, and mailing _ via postal service _

Step 1. run _ Supplier_Bank_Accounts_v101.sql _ to make sure that the system has Routing #, Account #, eMail

Step 2. run _ main program _ Payments_v102.sql.  Feed in a date _ mm/dd/yyyy to 

Step 3. ACH_Payments_v103.sql which uses Payments_One_Date_s102.sql _ a sub-program.
            
Step 4. Download result _ save as _ ach.csv

Step 5. build a goLang app via build ach-prep.go _ from Terminal prompt.

Step 6. run _ ach-prep.exe _ to convert underscores to blank spaces (SQL cannot handle this) in ach.csv to ACH_YYYY_MM_DD.txt

Step 7. upload ACH_YYYY_MM_DD.txt to your Bank.

Step 8. run AP_Remit_v101.sql _ to generate _ remit.csv

Step 9. build go app _ remit-prep.go

Step 10. run _ remit-prep.exe to batch send Remittances (check footer stubs, indicating unique invoices and total payment.

Step 11. Your eMail __/ Sent \_ folder will likely have a copy of the eMail that was sent.


