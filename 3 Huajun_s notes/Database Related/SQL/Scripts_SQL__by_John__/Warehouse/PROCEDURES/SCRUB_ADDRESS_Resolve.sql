--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	execute	garland.SCRUB_ADDRESS_Resolve;

	create or replace procedure garland.SCRUB_ADDRESS_Resolve	AS

--	DECLARE

--	=====================================================================

	compile_only	integer	:= 0;

	total_processed	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

	spec_insert		integer	:= 01;
	spec_seq		integer	:= 0;

BEGIN
	if	compile_only > 0		then
		return;
	end if;

	select '*** SCRUB ADDRESS Resolve  ' into heading from dual; 
	dbms_output.put_line(heading);

--	=====================================================================
	
	script := 'truncate table garland.gis_verify_addr reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

	garland.Resolve_Address.Batch_Driver (spec_insert, spec_seq);	
	
	script := 'analyze table garland.gis_verify_addr compute statistics';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	=====================================================================

END;

