--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
-- set serveroutput	on	size 99999;
-- alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
-- select sysdate from dual;	
--	======================================================================
--	Job series to rebuild Common_UMS table
--	used by CCS_ADDRESSES  (Code Compliance Address view)
--	======================================================================

--	select 'GET UMS KEYS  ' || to_char(sysdate,'hh24:mi') " " from dual;	-- done in EXECUTE_ADR
--	@c:\deacutis\scripts\warehouse\common\Common_ums\1_GET_UMS_KEYS.sql


	select 'BUILD BASIC UMS  ' || to_char(sysdate,'hh24:mi') " " from dual;
	@c:\deacutis\scripts\warehouse\common\Common_ums\2_BUILD_BASIC_UMS.sql


	select 'UPDATE BASIC ADDRESS  ' || to_char(sysdate,'hh24:mi') " " from dual;
	@c:\deacutis\scripts\warehouse\common\Common_ums\3_UPDATE_BASIC_ADDRESS.sql


	select 'REMOVE DUPE UMS  ' || to_char(sysdate,'hh24:mi') " " from dual;
	@c:\deacutis\scripts\warehouse\common\Common_ums\4_REMOVE_DUPE_UMS.sql

 
	select 'BUILD COMMON UMS  ' || to_char(sysdate,'hh24:mi') " " from dual;
	@c:\deacutis\scripts\warehouse\common\Common_ums\5_BUILD_COMMON_UMS.sql


--	======================================================================
