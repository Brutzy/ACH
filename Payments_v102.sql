declare @today dateTime = getDate()
declare @two_weeks_ago   dateTime = dateAdd(dd, -14, @today)

--------------------------------------------------------------------------------
declare @starts_F dateTime = @two_weeks_ago
declare @ends_F   dateTime = @today

--------------------------------------------------------------------------------
create table #TT (
                      supplier       varChar(max)
                    , supplier_nbr   int   
                    
                    , bank_routing   varChar(max)
                    , bank_acct      varChar(max)
                    
                    , dated          varChar(max)
                    , amount         decimal(11,2)
                    
                    , payment_type   varChar(max)
                    , supplier_type  varChar(max)
                    
                    , check_link     int
                    , eMail          varChar(max)

                 )
--------------------------------------------------------------------------------
insert into #TT 

  exec sproc121792_2024277_2234522 @ach_only, @starts_F, @ends_F -- Payments_s103
----------------------------------------------------------------------------------
select
  TT.dated 
, TT.supplier      as 'Supplier'
, TT.supplier_nbr  as 'Supplier_Nbr'

, TT.bank_routing as 'Bank_Routing_No'
, TT.bank_acct    as 'Bank_Account_No'

, TT.amount

, TT.payment_type
, TT.supplier_type

, TT.check_link
, TT.eMail

, ''              as 'zz'

from #TT TT