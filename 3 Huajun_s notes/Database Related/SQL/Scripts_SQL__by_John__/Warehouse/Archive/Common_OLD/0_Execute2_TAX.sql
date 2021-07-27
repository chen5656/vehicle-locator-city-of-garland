--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
-- set serveroutput	on	size 99999;
-- alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
-- select sysdate from dual;	
--	===================================================================
--	Job series to rebuild Common_TAX table
--	used by CCS_ADDRESSES  (Code Compliance Address view)
--	===================================================================

	select 'FORMAT OWNER ADDRESS  '|| to_char(sysdate,'hh24:mi')  " " from dual;
	@c:\deacutis\scripts\warehouse\Common\FORMAT_OWNER_ADDR.sql


	select 'BUILD EXEMPT CODE    '|| to_char(sysdate,'hh24:mi')  " " from dual;
	@c:\deacutis\scripts\warehouse\Common\BUILD_EXEMPT_CODE.sql


	select 'BUILD COMMON TAX    '|| to_char(sysdate,'hh24:mi')  " " from dual;
	@c:\deacutis\scripts\warehouse\Common\BUILD_COMMON_TAX.sql


--	select 'REMOVE DUPE TAX   ' || to_char(sysdate,'hh24:mi')  " " from dual;
--	@c:\deacutis\scripts\warehouse\Common\REMOVE_DUPE_TAX.sql

--	======================================================================

