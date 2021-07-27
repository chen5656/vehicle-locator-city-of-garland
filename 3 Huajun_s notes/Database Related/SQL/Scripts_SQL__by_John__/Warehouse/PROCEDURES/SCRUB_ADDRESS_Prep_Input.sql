--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================
--	Update Address info in Basic UMS with scrubbed address info
--	=====================================================================

--	execute	garland.SCRUB_ADDRESS_Prep_Input;

	create or replace procedure garland.SCRUB_ADDRESS_Prep_Input	as

--	DECLARE

--	=====================================================================

	compile_only	integer	:= 0;

	total_processed	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

BEGIN
	if	compile_only > 0		then
		return;
	end if;

--	=======================================================================

	script := 'analyze table garland.adrResult_INPUT  compute statistics';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	=======================================================================

	script := 'truncate table garland.GIS_App_RowID reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

	insert into	garland.GIS_APP_ROWID
	select	rownum,
			rec_rowid
	from	
(
	select
		addr_name,
		addr_type,
		addr_pfx,
		addr_sfx,
		addr_num,
		rowid	rec_rowid
	from		garland.adrResult_Input
	order by	rec_seq,  1,2,3,4,5	
);

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'AppRowid total = ' || total_processed);

	COMMIT;

	script := 'analyze table garland.gis_app_rowid compute statistics';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	======================================================================

END;
