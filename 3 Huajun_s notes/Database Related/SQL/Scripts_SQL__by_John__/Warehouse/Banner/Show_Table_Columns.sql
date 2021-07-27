--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	800;
set pagesize	9999;
--	=====================================================================

	select 
		rpad(owner,		10)	owner,
		rpad(table_name,	20)	table_name,
		rpad(column_name,	30)	column_name,
		rpad(data_type,	10)	data_type,
		lpad(data_length,	05)	width,
		lpad(column_id,	04)	posn 		
	from	all_tab_columns@banbprd 

	where 1=1
	and	owner = 'UIMSMGR' 
	and	table_name in ( 'UCBPREM',  'UCBCUST', 'UCRACCT'  ) 

	and ( 1=1
	or	column_name like '%ACCT_CODE' 
	or	column_name like '%PREM_CODE'
	or	column_name like '%CUST_CODE' 
	)

	and	table_name not like 'BIN%'

	order by table_name, column_id;

--	======================================================================

	select 'UCRACCT' " ", count(*) from UCRACCT@banbprd;	
	select 'UCBPREM' " ", count(*) from UCBPREM@banbprd;	
	select 'UCRCUST' " ", count(*) from UCBCUST@banbprd	;	

--	======================================================================

	select 
		rpad(owner,		10)	owner,
		rpad(table_name,	20)	table_name,
		rpad(column_name,	30)	column_name,
		rpad(data_type,	10)	data_type,
		lpad(data_length,	05)	width,
		lpad(column_id,	04)	posn 		
	from	all_tab_columns

	where 1=1
	and	owner = 'GARLAND' 
	and	table_name in ( 'CCS_ADDRESS',  'COMMON_UMS', ''  ) 

	and ( 1=1
	or	column_name like '%%' 
	)

	order by table_name, column_id;

--	======================================================================

	select 'COMMON UMS'  " ", count(*) from garland.common_ums;
	select 'CCS ADDRESS' " ", count(*) from garland.ccs_address;

--	======================================================================
