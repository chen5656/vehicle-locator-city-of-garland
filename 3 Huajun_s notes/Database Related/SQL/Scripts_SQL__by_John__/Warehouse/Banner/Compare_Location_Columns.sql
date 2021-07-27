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
--	adrResult_UMS_Location	filters out the following
--	=====================================================================

	select count(*) ums_culled		-- 3887
	from	sfg.um00100m@umsrep.world	
	where	location_stat <> 'ACT'
	or	street_nm like 'FLOATING%'
	or	street_nm like 'FIRE HYDRANT%'
	or	translate (house_no, '/1234567890 ', '/') is not null
	;

--	=====================================================================
--	UCBPREM_CODE minus LOCATION_NO
--	=====================================================================

	select count(*) ucb_ums	
	from
(
	select 
		ucbprem_code,			-- 3866
		ucbprem_street_name,		-- 3522
		ucbprem_street_number,		-- 4888
		' '
	from UCBPREM@banbprd
   
	MINUS
   
	select
		location_no,
		addr_name,
		addr_num,
		' '
	from garland.COMMON_UMS
);   


--	=====================================================================
--	LOCATION_NO minus UCBPREM_CODE
--	=====================================================================

	select count(*)  ums_ucb
	from
(
	select
		location_no,				-- 167
		addr_name,				-- 0957
		addr_num,				-- 1189
		' '
	from garland.COMMON_UMS

	MINUS

	select 
		ucbprem_code,		
		ucbprem_street_name,	
		ucbprem_street_number,
		' '
	from UCBPREM@banbprd
);   


