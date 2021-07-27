--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	800;
set pagesize	9999;
--	alter session	set nls_date_format = 'yyyymmdd';  
--	=====================================================================

--	INCLUDES ALL BANNER RECORDS  
--	MANY HAVE INVALID ADDRESSES
--	FILTER OUT THE INVALID AND THE COUNT WILL DECREASE

--	JOIN COUNT	= 64064 
--	COMMON_UMS	= 62830

--	select count(*) from garland.adrResult_ums_location 
--	where verify_code = 55
--	and rtrim(addr_unit1) is null;
--	65673

--	=====================================================================
--	truncate table	.plan_table		reuse storage;
--	explain plan set	statement_id = 'x'	into .plan_table for
--	=====================================================================

	select count(*) 
	from	ucracct@banbprd		A,
		ucbprem@banbprd		P,
		ucbcust@banbprd		C

	where	a.ucracct_prem_code	= p.ucbprem_code
	and	a.ucracct_cust_code	= c.ucbcust_cust_code

	and	ucracct_status_ind	= 'A'
	and	ucbcust_status_ind	= 'A'
	and	p.ucbprem_date_retired	is null
	and	rtrim(p.ucbprem_unit)	is null

--	and	rownum < 111
	;

--	=====================================================================
/*

	where	a.ucracct_prem_code	= p.ucbprem_code
	and	a.ucracct_cust_code	= c.ucbcust_cust_code
----------
    222458

*/
--	=====================================================================
