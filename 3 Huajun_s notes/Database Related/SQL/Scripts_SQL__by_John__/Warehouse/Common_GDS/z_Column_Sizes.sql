	set echo off;
--	==================================================================================
--	Column Sizes
--	==================================================================================


--	select  '	max(length(rtrim(' || column_name ||'))) ' || column_name ||','		" "
--	from	  cols
--	where	  table_name = 'GDS_ACCOUNT';



--	==================================================================================



	select
                                             
	max(length(rtrim(ACCOUNT))) ACCOUNT,                                           
	max(length(rtrim(PIDN))) PIDN,                                                 
	max(length(rtrim(ADDR_NUM))) ADDR_NUM,                                         
	max(length(rtrim(ADDR_NAME))) ADDR_NAME,                                       
	max(length(rtrim(OWNER_NAME))) OWNER_NAME,                                     
	max(length(rtrim(OWNER_ADDR1))) OWNER_ADDR1,                                   
	max(length(rtrim(OWNER_ADDR2))) OWNER_ADDR2,                                   
	max(length(rtrim(OWNER_ADDR3))) OWNER_ADDR3,                                   
	max(length(rtrim(OWNER_ADDR4))) OWNER_ADDR4,                                   
	max(length(rtrim(OWNER_ZIP))) OWNER_ZIP,                                       
	max(length(rtrim(LEGAL1))) LEGAL1,                                             
	max(length(rtrim(LEGAL2))) LEGAL2,                                             
	max(length(rtrim(LEGAL3))) LEGAL3,                                             
	max(length(rtrim(LEGAL4))) LEGAL4,                                             
	max(length(rtrim(MORTGAGE_CO))) MORTGAGE_CO,                                   
	max(length(rtrim(ACCT_TYPE))) ACCT_TYPE,                                       
	max(length(rtrim(ACCT_USE))) ACCT_USE,

	null
	from	garland.Temp_View1;



--	==================================================================================
	set echo on;

