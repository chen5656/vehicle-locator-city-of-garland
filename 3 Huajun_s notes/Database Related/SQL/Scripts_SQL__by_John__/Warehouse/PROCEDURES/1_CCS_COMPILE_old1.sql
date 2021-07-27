--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
--	=====================================================================

--	////////////////////////////////////////////////////////////////////////////
--	COMPILE somtimes Fails because the definition of Temporary Views are changing.
--	////////////////////////////////////////////////////////////////////////////

--	=====================================================================
/*
	select owner, object_name , object_type, status 
	from	all_objects 
	where	object_name like 'CCS%' 
	and	object_name not like '%TEST%'
	and	owner	 = 'GARLAND'
	and	status = 'INVALID'
	;
*/
--	=====================================================================

--	execute	garland.CCS_COMPILE;

	create or replace procedure	garland.CCS_COMPILE	AS

--	DECLARE

--	=====================================================================

	compile_only	integer	:= 0;

	script		varchar2(1000);
	title			varchar2(100);
	heading		varchar2(100);

BEGIN
	if	compile_only > 0		then
		return;
	end if;

--	=====================================================================
	title := '***  CCS COMPILE *** ';
	select title||to_char(sysdate,'Mon dd hh24:mi') into heading from dual;	
	dbms_output.put_line(heading);
--	=====================================================================
--	okay

	garland.CCS_COMPILE_SCRUB_ADDRESS;

--	=====================================================================
--	okay

	title := 'CCS_VERIFY  ';  dbms_output.put_line(title);

	script := 'alter procedure garland.CCS_VERIFY_TAX compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_VERIFY_UMS compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

--	=====================================================================
--	okay

	title := 'CCS_INPUT  ';  dbms_output.put_line(title);

	script := 'alter procedure garland.CCS_INPUT_GDS_ACCOUNT compile';
--	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_INPUT_GDS_EXEMPTION compile';
--	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_INPUT_GDS_YEAR compile';
--	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

--	=====================================================================
--	okay

	title := 'CCS_GIS  ';  dbms_output.put_line(title);

	script := 'alter procedure garland.CCS_GIS_BUILD_COMMON_GIS compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_GIS_REMOVE_DUPE compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_GIS_GET_INTERSECT_ID compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_GIS_PUT_INTERSECT_ID compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_GIS_UPDATE_INTERSECTIONS compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

--	=====================================================================
--	okay

	title := 'CCS_TAX  ';  dbms_output.put_line(title);

	script := 'alter procedure garland.CCS_TAX_FORMAT_OWNER_PREP compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_TAX_FORMAT_OWNER compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_TAX_BUILD_EXEMPTION compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_TAX_BUILD_COMMON_TAX compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

--	=====================================================================
--	okay

	title := 'CCS_UMS  ';  dbms_output.put_line(title);

	script := 'alter procedure garland.CCS_UMS_GET_KEYS compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_UMS_BUILD_BASIC_UMS compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_UMS_GET_ADDRESS compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_UMS_REMOVE_DUPE compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_UMS_BUILD_COMMON_UMS compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

--	=====================================================================
--	okay

	title := 'CCS_LINK  ';  dbms_output.put_line(title);

	script := 'alter procedure garland.CCS_LINK_BUILD_COMMON_KEYS compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_LINK_COPY_KEYS compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_LINK_REMOVE_NULL_UMS compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_LINK_BUILD_RECORD_SEQ compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

--	=====================================================================
--	okay

	title := 'CCS_LOAD  ';  dbms_output.put_line(title);

	script := 'alter function garland.CCS_LOAD_QUALITY_CHECK compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_LOAD_SET_CODE_DISTRICT compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_LOAD_DIRECTIONS compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

--	script := 'alter procedure garland.CCS_LOAD_MAKE_VIEW compile';
	script := 'alter procedure garland.CCS_LOAD_VIEW_TO_TABLE compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

--	=====================================================================
--	okay

	title := 'CCS GROUP  ';  dbms_output.put_line(title);

--	script := 'alter procedure garland.CCS_INPUT compile';
--	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_VERIFY compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_GIS compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_TAX compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_UMS compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_LINK compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	script := 'alter procedure garland.CCS_LOAD compile';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

--	=====================================================================
--	okay

--	title := 'CCS_GENERATE  ';  dbms_output.put_line(title);
--	script := 'alter procedure garland.CCS_GENERATE compile';
--	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

--	=====================================================================

END;
