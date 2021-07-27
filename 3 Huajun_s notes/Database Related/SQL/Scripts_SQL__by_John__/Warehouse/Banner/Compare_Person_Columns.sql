--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	800;
set pagesize	9999;
--	alter session	set nls_date_format = 'yyyymmdd';  
--	=====================================================================


--	=====================================================================
--	
--	=====================================================================


--	=====================================================================
--	UCBcust_CODE minus LOCATION_NO
--	=====================================================================

	select count(*) ucb_ums	
	from
(
	select 
		ucbcust_cust_code,		
		ucbcust_last_name,	
		ucbcust_first_name,
		' '
	from UCBCUST@banbprd
   
	MINUS
   
	select
		person_no,
		last_name,
		first_name,
		' '
	from garland.COMMON_UMS
);   


--	=====================================================================
--	LOCATION_NO minus UCBcust_CODE
--	=====================================================================

	select count(*)  ums_ucb
	from
(
	select
		person_no,		
		last_name,
		first_name,
		' '
	from garland.COMMON_UMS

	MINUS

	select 
		ucbcust_cust_code,		
		ucbcust_last_name,	
		ucbcust_first_name,
		' '
	from UCBCUST@banbprd
);   


