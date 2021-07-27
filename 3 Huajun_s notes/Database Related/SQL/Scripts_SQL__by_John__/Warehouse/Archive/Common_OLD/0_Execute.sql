	set echo off;
--	==================================================================================

--	DOES TAX CONTAIN 2005 & 2006 RECORDS ????

--	==================================================================================
--	>>>>>>>>>>>>>>>>>>>>>>		PREPARATION		<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

--	Extract GDS_ACCOUNTS	using Crystal Reports
--	into \Deacutis\LOADER\GDS_Account_Extract.chr

--	SQL Loader	  GDS_ACCOUNTS	into	GIS_OBJECTS

--	==================================================================================

	@c:\deacutis\scripts\warehouse\Common\LOAD_GDS_ACCOUNT.sql

--	==================================================================================

--	@c:\deacutis\scripts\warehouse\common\0_EXECUTE0_ADR.sql


--	@c:\deacutis\scripts\warehouse\common\0_EXECUTE1_GIS.sql


--	@c:\deacutis\scripts\warehouse\common\0_EXECUTE2_TAX.sql


--	@c:\deacutis\scripts\warehouse\common\0_EXECUTE3_UMS.sql


--	@c:\deacutis\scripts\warehouse\common\0_EXECUTE4_COPY.sql


--	@c:\deacutis\scripts\warehouse\common\0_EXECUTE5_KEY.sql


--	@c:\deacutis\scripts\warehouse\common\0_EXECUTE6_VIEW.sql


--	======================================================================
--	show times of latest Table Generations

/*
	select owner, object_name, to_char(last_ddl_time,'yyyy-mm-dd hh24:mi   ') last_ddl_time, timestamp
	from	all_objects  
	where object_type = 'TABLE'

	and (	owner	= 'GARLAND'
	and	object_name in 
	(	'ADRRESULT_TAX_GDS',	'ADRRESULT_UMS_LOCATION',	'GDS_ACCOUNT', 
		'COMMON_ADDRESS_KEYS',	'COMMON_RECORD_SEQ', 
		'CDRELADR',	'CDRELPAR',	'TRVEHRCL',	'BLOCK', 'INTERSECTION') 	)

	or (	owner	= 'JDEACUTIS'
	and	object_name in 
	(	'COMMON_GIS', 'COMMON_TAX', 'COMMON_UMS')		)

	order by 2;

*/
--	======================================================================
