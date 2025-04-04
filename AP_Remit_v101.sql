select 

  convert( varChar(11), A_APC.Check_Date, 101)   as 'cut'
, C_S.Supplier_Code                              as 'payee'
, A_APC.Check_No    
, A_APC.Amount                                   as 'check_amount'
, A_APCD.Amount                                  as 'item_amount'
, A_API.Invoice_No
, convert( varChar(11), A_API.Invoice_Date, 101) as 'Invoiced'
, C_S.eMail
, C_S.Bank_Routing_No                            as 'Routing'   
, C_S.Bank_Account_No                            as 'Account'
, ''                                             as 'zz'

from Accounting_v_AP_Check A_APC

left join Common_v_Supplier C_S
on                          C_S.Supplier_No = A_APC.Supplier_No

left join Accounting_v_Bank_Account A_BA
on                                  A_BA.Bank_Account_Key = A_APC.Bank_Account_Key

left join Accounting_v_AP_Check_Dist A_APCD
on                                   A_APCD.Check_Link = A_APC.Check_Link

left join Accounting_v_AP_Invoice A_API
on                                A_API.Invoice_Link = A_APCD.Invoice_Link

where A_APC.Check_Date = @check_cut
and len(C_S.eMail) > 1
and len( C_S.Bank_Routing_No ) > 1 
and len( C_S.Bank_Account_No ) > 1 

order by
  A_APC.Check_Date desc
, C_S.Supplier_Code