
-- _/ Parameters \_
--@x_Date_F varChar(11) = ''

select 

  C_S.Supplier_Code  as 'Supplier'
, C_S.Supplier_No    as 'Supplier_Nbr'  

, C_S.Bank_Routing_No
, C_S.Bank_Account_No 

, convert( varChar(11), A_APC.Check_Date, 101) as 'Check_Date'
, A_APC.Amount  

, A_APC.Payment_Type  
, C_ST.Supplier_Type  

, A_APC.Check_Link

, C_S.eMail

from Accounting_v_AP_Check   A_APC

left join Common_v_Supplier C_S
on                          C_S.Supplier_No = A_APC.Supplier_No

left join Common_v_Supplier_Type C_ST
on                               C_ST.Supplier_Type = C_S.Supplier_Type

where convert( varChar(11), A_APC.Check_Date, 101 ) = @x_Date_F
and  A_APC.Amount > 0.99

order by
  C_S.Supplier_Code