--declare @header_tens varChar(94) = '_.__:__._1_.__:__._2_.__:__._3_.__:__._4_.__:__._5_.__:__._6_.__:__._7_.__:__._8_.__:__._9_.__'

create table #TT (  record varChar(132) )
--insert into  #TT
--select  @header_tens

--------------------------------------------------------------------------------
-- Block 1 ---------------------------------------------------------------------
--------------------------------------------------------------------------------
declare @L1_1  char(1) = ''
declare @L1_2  char(2) = ''
declare @L1_3  char(10) = ''
declare @L1_4  char(10) = ''
declare @L1_5  char(6) = ''
declare @L1_6  char(4) = ''
declare @L1_7  char(1) = ''
declare @L1_8  char(3) = ''
declare @L1_9  char(2) = ''
declare @L1_10 char(1) = ''
declare @L1_11 char(23) = ''
declare @L1_12 char(23) = ''
declare @L1_13 char(8) = ''

-- F1 ---------------------------
declare @Record_Type_Code      char(1) = '1'

-- F2 --------------------------------------
declare @Priority_Code         char(2)  = '01'

-- F3 -------------------------------
declare @Immediate_Destination char(11) = ' 00011122233' -- The Bank

-- F4 --------------------------                                        
declare                                         @PCN_Tax_ID char(9)  = '123456789'
declare @Immediate_Origin      char(10) = ' ' + @PCN_Tax_ID

-- F5 --------------------------------------
declare                                       @today dateTime = getDate()
declare @today_F char(11) = convert(char(11), @today, 101)

declare                               @YYMMDD char(6) = convert( char(6), @today, 12) 
declare @File_Creation_Date char(6) = @YYMMDD

-- F6 -----------------------------------
declare @HH_MM char(5)  
set     @HH_MM = convert( char(5), @today, 108) 
declare @HH    char(2) =  left( @HH_MM, 2)
declare @MM    char(2) = right( @HH_MM, 2)

declare @HH_MM_F char(4) = @HH + @MM

-- F7 -------------
declare @File_ID_Modifier char(1) = 1

-- F8 --------------------------
declare @Record_Size char(3) = '094'

-- F9 -------------------------
declare @Blocking_Factor char(2) = '10'

-- F10 ---------------------
declare @Format_Code     varChar(1) = '1' 

-- F11 ------------------------------
--                                                          1         2   '     
--                                                 12345678901234567890123  
declare @Immediate_Destination_Name varChar(23) = 'X NATIONAL BANK __'

--- F12 ---------------------
--                                                 12345678901234567890123  
declare @Immediate_Origin_Name      varChar(23) = 'MY MANUFACTURING CO'

-- F13 ------------------------------
declare @Blank_8 char(8) = '_ _ _ _ '

--------------------------------------------------------------
set     @L1_1 =  @Record_Type_Code
set     @L1_2 =  @Priority_Code 
set     @L1_3 =  @Immediate_Destination
set     @L1_4 =  @Immediate_Origin
set     @L1_5 =  @File_Creation_Date
set     @L1_6 =  @HH_MM_F
set     @L1_7 =  @File_ID_Modifier
set     @L1_8 =  @Record_Size
set     @L1_9 =  @Blocking_Factor
set     @L1_10 = @Format_Code
set     @L1_11 = @Immediate_Destination_Name
set     @L1_12 = @Immediate_Origin_Name
set     @L1_13 = @Blank_8

insert into #TT 
select
          @L1_1 +
          @L1_2 +
          @L1_3 +
          @L1_4 +
          @L1_5 +
          @L1_6 +
          @L1_7 +
          @L1_8 +
          @L1_9 +
          @L1_10 +
          @L1_11 +
          @L1_12 +
          @L1_13 +
           ''

--------------------------------------------------------------------------------
-- Block 5 ----------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

declare @L5_1  char(1) = ''
declare @L5_2  char(3) = ''
declare @L5_3  char(16) = ''
declare @L5_4  char(20) = ''
declare @L5_5  char(10) = ''
declare @L5_6  char(3) = ''
declare @L5_7  char(10) = ''
declare @L5_8  char(6) = ''
declare @L5_9  char(6) = ''
declare @L5_10 char(3) = ''
declare @L5_11 char(1) = ''
declare @L5_12 char(8) = ''
declare @L5_13 char(7) = ''

-- F1 -----------------
set     @Record_Type_Code = '5'

-- F2   -----------------------
declare @Service_Class_Code char(3) = '225' -- Debits Only

-- F3   -----------------------
declare @Company_Name               char(16) = left(@Immediate_Origin_Name, 16)

-- F4   -----------------------
--                                                       1         2   
--                                              12345678901234567890 
declare @Company_Discretionary_Data char(20) = '_ _ _ _ _ _ _ _ _ __'

-- F5   -----------------------
declare @Company_ID                 char(10) = '1' + @PCN_Tax_ID

-- F6   -----------------------
declare @Standard_Entry_Class_Code char(3) = 'PPD'

-- F7   -----------------------
declare @Company_Entry_Description char(10) = 'EFT Paymen'

-- F8   -----------------------
--                                            123456
declare @Company_Descriptive_Date  char(6) = '_ _ __'

-- F9   -----------------------
declare @Effective_Entry_Date      char(6) = @YYMMDD

-- F10   -----------------------
declare @this_year varChar(4) = datePart(yy, @today)
declare @last_year varChar(4) = @this_year - 1
declare @Jan_01    varChar(11) = '01/01/' + @this_year
declare @Dec_31    varChar(11) = '12/31/' + @last_year

declare @Julian      int = dateDiff(dd, @Dec_31, @today_F)
declare @Julian_Plus int = @Julian + 1000

declare @Julian_Plus_F varChar(4)
set     @Julian_Plus_F = convert( varChar(4), @Julian_Plus ) 

declare @Julian_F varChar(3) 
set     @Julian_F = right(@Julian_Plus_F, 3)

declare @Settlement_Date char(3) = @Julian_F

-- F11   -----------------------
declare @Originator_Status_Code    char(1) = 'V'

-- F12   -----------------------
declare @Originating_DFI_ID        char(8) = '123456789'

-- F13   -----------------------
declare @Batch char(7) 
set     @Batch = (select
                           '0' + @YYMMDD
                 )  
                        

--------------------------------------------------------------
set     @L5_1 =  @Record_Type_Code
set     @L5_2 =  @Service_Class_Code 
set     @L5_3 =  @Company_Name
set     @L5_4 =  @Company_Discretionary_Data
set     @L5_5 =  @Company_ID
set     @L5_6 =  @Standard_Entry_Class_Code 
set     @L5_7 =  @Company_Entry_Description
set     @L5_8 =  @Company_Descriptive_Date
set     @L5_9 =  @Effective_Entry_Date
set     @L5_10 = @Settlement_Date
set     @L5_11 = @Originator_Status_Code
set     @L5_12 = @Originating_DFI_ID
set     @L5_13 = @Batch

--------------------------------------------------------------------------------
insert into #TT 
select
            @L5_1 + 
            @L5_2 + 
            @L5_3 + 
            @L5_4 + 
            @L5_5 + 
            @L5_6 + 
            @L5_7 + 
            @L5_8 + 
            @L5_9 + 
            @L5_10 + 
            @L5_11 + 
            @L5_12 + 
            @L5_13 + 
            ''
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
create table #TN (
--                     cc int identity(1, 1)
                     
                     supplier_code varChar(50)
                   , supplier_nbr  int
                   
                   , DFI_ID          varChar(50) -- Routing
                   , DFI_Account_Nbr varChar(50)
                   
                   , paid            varChar(11)
                   , amount          decimal(11,2)
                   
                   , payment_type    varChar(50)
                   , supplier_type   varChar(50)
                   
                   , check_link      int
                   , eMail           varChar(max)
                 )   
----------------------------------------       
--declare @ach_only bit         = 0
--declare @starts_F varChar(11) = '2/19/2025'
--declare @ends_F   varChar(11) = '2/21/2025'

----------------------------------------------------------------------------------
insert into #TN 
  exec sproc121792_2024277_2234530 @x_Date_F   -- Payments_One_Date_s102
------------------------------------------------------------------------------------
create table #TP (
                     cc int identity(1, 1)
                     
                   , supplier_code varChar(50)
                   , supplier_nbr  int
                   
                   , DFI_ID          varChar(50) -- Routing
                   , DFI_Account_Nbr varChar(50)
                   
                   , paid            varChar(11)
                   , amount          decimal(11,2)
                   
                   , payment_type    varChar(50)
                   , supplier_type   varChar(50)
                   
                   , check_link      int
                   , eMail           varChar(max)
                 )   
--------------------------------------------------------------------------------
insert into #TP
select
         TN.*
from #TN TN

where len(TN.DFI_ID) > 1
and   len(TN.eMail ) > 2
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
declare @total_nbr_Payments int

set     @total_nbr_Payments = (
                                select count(TP.cc)
                                        
                                from     #TP TP
                              )
----------------------------------------------------------------------------------
---- Block 6 ---------------------------------------------------------------------
----------------------------------------------------------------------------------

    declare @L6_1  char(1) = ''
    declare @L6_2  char(2) = ''
    declare @L6_3  char(8) = ''
    declare @L6_4  char(1) = ''
    declare @L6_5  char(17) = ''
    declare @L6_6  char(10) = ''
    declare @L6_7  char(15) = ''
    declare @L6_8  char(22) = ''
    declare @L6_9  char(2) = ''
    declare @L6_10 char(1) = ''
    declare @L6_11 char(15) = ''
    
    declare @Receiving_DFI_ID   Char(9) = ''
    declare @TransAction_Code   Char(2) = '22'
    declare @Check_Digit        char(1) = 3

    declare @DFI_Account_Nbr    char(17) = ''
    declare @DFI_Account_Nbr_F  char(17) = ''
    
    declare @Individual_ID      int
    declare @Individual_ID_F    char(15) = ''
    declare @Individual_ID_G    char(15) = ''

    declare @Individual_Name          char(22) = ''

    declare @Discretionary_Data       char(2)  = '__'
    declare @Addenda_Record_Indicator int = 0
    declare @Trace_Nbr                int
    
    declare @Trace_Nbr_F              char(15) = ''
    declare @Trace_Nbr_G              char(15) = ''

    declare @this_Amount  decimal(15,2) = 0.0
    declare @amount_Total decimal(15,2) = 0.0
    
    set @Record_Type_Code = '6'
    
    declare @cc_this int = 0
----------------------------------------------------------------------------------
while ( @cc_this < @total_nbr_Payments )
begin
        set @cc_this = @cc_this + 1
        ----------------------------------
        set @Receiving_DFI_ID =  ( select
                                            TP.DFI_ID
                                   from #TP TP
                                                         where TP.cc = @cc_this
                                  )
                                  
        set @DFI_Account_Nbr =  ( select
                                            TP.DFI_Account_Nbr
                                   from #TP TP
                                                         where TP.cc = @cc_this
                                  )

        set @this_Amount =  ( select
                                            TP.amount
                                   from #TP TP
                                                         where TP.cc = @cc_this
                                  )

        set @DFI_Account_Nbr_F =  left ( @DFI_Account_Nbr + '_________________', 17)
        
        set @Individual_ID =  ( select
                                            TP.supplier_nbr
                                   from #TP TP
                                                         where TP.cc = @cc_this
                                  )
                                  
                                  set @Individual_ID_F =  cast (@individual_ID as varChar(15) ) 
        set @Individual_ID_G = left ( @Individual_ID_F + '______________________', 15)


        set @Individual_Name =  ( select
                                            TP.supplier_code
                                   from #TP TP
                                                         where TP.cc = @cc_this
                                  )

        set @Trace_Nbr =  ( select
                                            TP.check_link
                                   from #TP TP
                                                         where TP.cc = @cc_this
                                  )
                                  
                               set @Trace_Nbr_F = cast(@Trace_Nbr as char(15) )                                 
         set @Trace_Nbr_G = left( @Trace_Nbr_F + '_______________', 15 )


        
          ---------------------------------------------------
          set @L6_1 = @Record_Type_Code                                   
          set @L6_2 = @TransAction_Code                                   
          set @L6_3 = @Receiving_DFI_ID                                   
          set @L6_4 = @Check_Digit                                   
          set @L6_5 = @DFI_Account_Nbr_F                                   
          set @L6_6 = @this_Amount                                   
          set @L6_7 = @Individual_ID_G                                   
          set @L6_8 = @Individual_Name                                   
          set @L6_9 = @Discretionary_Data                                   
          set @L6_10 = @Addenda_Record_Indicator                                   
          set @L6_11 = @Trace_Nbr_G                                  
                                  
        -------------------------------  
        insert into #TT
        select 
        @L6_1 +
        @L6_2 +
        @L6_3 +
        @L6_4 +
        @L6_5 +
        @L6_6 +
        @L6_7 +
        @L6_8 +
        @L6_9 +
        @L6_10 +
        @L6_11 +
        ''
        set @amount_Total += @this_Amount

end

----------------------------------------------------------------------------------
---- Block 8 ---------------------------------------------------------------------
----------------------------------------------------------------------------------

declare @L8_1  char(1) = ''
declare @L8_2  char(3) = ''
declare @L8_3  char(6) = ''
declare @L8_4  char(10) = ''
declare @L8_5  char(12) = ''
declare @L8_6  char(12) = ''
declare @L8_7  char(10) = ''
declare @L8_8  char(19) = ''
declare @L8_9  char(6) = ''
declare @L8_10 char(8) = ''
declare @L8_11 char(7) = ''

--declare @Entry_Count int = 0
--set     @Entry_Count = 0

-- F1 --------------------------------------
set @Record_Type_Code = '8'

-- F2  ---------------------------------------
declare @ServiceClassCode char(3) = '225'

-- F3  ---------------------------------------
declare @Entry_Count int = 0
set     @Entry_Count = 1000000 + @cc_this

declare @Entry_Count_F char(6) = ''
set     @Entry_Count_F         = right ( str(@Entry_Count) , 6)

-- F4  ---------------------------------------
declare @Entry_Hash char(10) = '3513535135'

-- F5  ---------------------------------------
declare @Total_Debit decimal(11,2) = @amount_Total

declare @Total_Debit_Str varChar(12) = ''
set     @Total_Debit_Str = cast(@Amount_Total as varChar(12) )

declare                                         @Total_Debit_Dollars int = floor(@Amount_Total)
declare @Total_Debit_Dollars_Str char(12) = str(@Total_Debit_Dollars)

declare @Total_Debit_Cents Char(2) = right(@Total_Debit_Str, 2) 

declare @Total_Debit_F char(50) = ''
set     @Total_Debit_F          = right ( (concat( trim('000000000000'), trim(@Total_Debit_Dollars_Str) , trim(@Total_Debit_Cents)) ), 12)

-- F6  ---------------------------------------
declare @total_Credit_F varChar(12) = replicate('0', 12)


-- F7  --- Company ID ------------------------------------

-- F8  ---------------------------------------
declare @Message_Auth_Code char(19) = replicate('_', 19)

-- F9  ---------------------------------------
declare @Reserved char(6) = replicate('_', 6)

-- F10  --- Originating DFI ID ------------------------------------

-- F11 ---- Batch - 5.13 -------------------------------------------------------

--------------------------------------------------------------------------------
set       @L8_1  = @Record_Type_Code 
set       @L8_2  = @Service_Class_Code 
set       @L8_3  = @Entry_Count_F
set       @L8_4  = @Entry_Hash
set       @L8_5  = @Total_Debit_F
set       @L8_6  = @Total_Credit_F
set       @L8_7  = @Company_ID
set       @L8_8  = @Message_Auth_Code
set       @L8_9  = @Reserved
set       @L8_10 = @Originating_DFI_ID
set       @L8_11 = @Batch

-----------------------------------------------------        
        insert into #TT
        select
          @L8_1 + 
          @L8_2 + 
          @L8_3 + 
          @L8_4 + 
          @L8_5 + 
          @L8_6 + 
          @L8_7 + 
          @L8_8 + 
          @L8_9 + 
          @L8_10 + 
          @L8_11 + 
          ''
----------------------------------------------------------------------------------
---- Block 9 ---------------------------------------------------------------------
----------------------------------------------------------------------------------
--
declare @L9_1  char(1) = ''
declare @L9_2  char(6) = ''
declare @L9_3  char(6) = ''
declare @L9_4  char(8) = ''
declare @L9_5  char(10) = ''
declare @L9_6  char(12) = ''
declare @L9_7  char(12) = ''
declare @L9_8  char(39) = ''

-- F1 ------------------------------------------
       set @Record_Type_Code = '9'

-- F2  -----------------------------------------
       declare @Batch_Count varChar(11) = cast(@cc_this as int )
       
       declare @Batch_Count_F char(6) = right ( concat ( trim('000000'), trim(@Batch_Count) ), 6 )
       
-- F3  -----------------------------------------
       declare @Block_Count char(6) = '000005'  

-- F4  -----------------------------------------
       declare @Entry_Addenda_Count char(8) = replicate('0', 8)
       
-- F5  -- Entry Hash 8_4  ---------------------------------------

-- F6  --  Total Debit ---------------------------------------

-- F7  --- Total Credit --------------------------------------

-- F8  ---- Reserved  -------------------------------------
       declare @Reserved_9_8 char(39) = replicate('_', 39)

---------------------------------------------

        set @L9_1 = @Record_Type_Code
        set @L9_2 = @Batch_Count_F
        set @L9_3 = @Block_Count
        set @L9_4 = @Entry_Addenda_Count
        set @L9_5 = @Entry_Hash
        set @L9_6 = @Total_Debit_F
        set @L9_7 = @Total_Credit_F
        set @L9_8 = @Reserved_9_8

        insert into #TT
        select
          @L9_1 + 
          @L9_2 + 
          @L9_3 + 
          @L9_4 + 
          @L9_5 + 
          @L9_6 + 
          @L9_7 + 
          @L9_8 + 
          ''
------------------------------------------------------------------------------------
select
         TT.record
from #TT TT