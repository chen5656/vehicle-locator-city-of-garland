--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
--	=====================================================================

--	execute	garland.CCS_COMPILE_SCRUB_ADDRESS;

	create or replace procedure	garland.CCS_COMPILE_SCRUB_ADDRESS	AS

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
--	title := '***  CCS COMPILE SCRUB ADDRESS  *** ';	dbms_output.put_line(title);
--	=====================================================================

	script := 'drop synonym	garland.adrResult';
	execute immediate(script);

	script := 'create synonym garland.adrResult for garland.gis_verify_addr';
	execute immediate(script);

--	=====================================================================
--	okay

	title := 'SCRUB_ADDRESS  ';  dbms_output.put_line(title);

	script := 'alter view garland.ADRRESULT_USER compile';
	execute immediate (script);

	script := 'alter package garland.ADR_RESOLVE_RULES compile';
	execute immediate (script);

	script := 'alter package garland.RESOLVE_ADDRESS compile';
	execute immediate (script);

	script := 'alter package garland.RESOLVE_ADDRESS compile body';
	execute immediate (script);

--	=====================================================================

	script := 'alter procedure garland.SCRUB_ADDRESS_LOAD_INPUT compile';
	execute immediate (script);

	script := 'alter procedure garland.SCRUB_ADDRESS_RESOLVE compile';
	execute immediate (script);

	script := 'alter procedure garland.SCRUB_ADDRESS_FIX_ADRRESULT compile';
	execute immediate (script);

	script := 'alter procedure garland.SCRUB_ADDRESS compile';
	execute immediate (script);

--	=====================================================================

--	script := 'alter package garland.SCRUB_RULE compile package';
--	execute immediate (script);
--	script := 'alter procedure garland.SCRUB_ADDRESS_UNPARSED compile';
--	execute immediate (script);
--	script := 'alter procedure garland.SCRUB_ADDRESS_PARSED compile';
--	execute immediate (script);
--	script := 'alter package garland.SCRUB_ADDRESSES compile package';
--	execute immediate (script);
--	script := 'alter package garland.SCRUB_ADDRESSES compile body';
--	execute immediate (script);
--	script := 'alter procedure garland.SCRUB_ADDRESS_RESOLVE compile';
--	execute immediate (script);

--	=====================================================================

	script := 'alter procedure garland.CCS_VERIFY_TAX compile';
	execute immediate (script);

	script := 'alter procedure garland.CCS_VERIFY_UMS compile';
	execute immediate (script);

--	=====================================================================

END;


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

