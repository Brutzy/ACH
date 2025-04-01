select
  
  C_S.Supplier_Code      as 'Supplier'
, C_S.Supplier_No
, C_S.Bank_Routing_No    as 'Routing_Nbr'   
, C_S.Bank_Account_No    as 'Bank_Account'
, C_S.eMail

, case
    when ( 
            len(C_S.Bank_Routing_No) > 3  and
            len(C_S.Bank_Account_No) > 3  and
            len(C_S.eMail          ) > 3  
          ) then 1
    else 0
  end as 'status'
            
, ''                   as 'zz'

from Common_v_Supplier C_S

where len(C_S.Bank_Account_No ) > 1

order by
  C_S.Supplier_Code