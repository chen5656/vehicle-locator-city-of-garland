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
--	ucraddt_CODE minus LOCATION_NO
--	=====================================================================

	select count(*) ucr_ums_acct	
	from
(
	select 
		ucracct_old_account + 0,
		' '
	from UCRACCT@banbprd
	where	ucracct_status_ind = 'A'
   
	MINUS
   
	select
		account_no + 0,
		' '
	from	sfg.um00200m@umsrep.world
--	from	garland.COMMON_UMS
);   


--	=====================================================================
--	LOCATION_NO minus ucraddt_CODE
--	=====================================================================

	select count(*)  ums_ucr_acct
	from
(
	select
		account_no + 0,		
		' '
	from	sfg.um00200m@umsrep.world
--	from garland.COMMON_UMS

	MINUS

	select 
		ucracct_old_account + 0,
		' '
	from UCRACCT@banbprd
	where	ucracct_status_ind = 'A'
);   


