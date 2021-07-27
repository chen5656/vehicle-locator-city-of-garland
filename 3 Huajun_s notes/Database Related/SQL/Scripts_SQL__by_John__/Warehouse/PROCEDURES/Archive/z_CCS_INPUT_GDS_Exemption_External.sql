--	=====================================================================
set echo		off;
set linesize	2000;
set pagesize	9999;
set sqlblanklines	on;
set timing		off;
set serveroutput	on	size 99999;
--	=====================================================================
--	Load GDS_ACCOUNT from EXTERNAL_GDS_ACCOUNT
--	=====================================================================

--	execute	garland.CCS_INPUT_GDS_EXEMPTION;

	create or replace procedure garland.CCS_INPUT_GDS_EXEMPTION	AS

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

	select '*** CCS INPUT GDS EXEMPTION  '||to_char(sysdate,'Mon dd hh24:mi') into heading from dual; 
	dbms_output.put_line(heading);

--	=====================================================================

	script := 'Truncate table garland.GDS_EXEMPTION	reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (Script);

--	===========================================================================

	insert --+ append
	into   garland.gds_exemption
	select * from garland.GDS_EXEMPTION_External;

	total_processed := sql%rowcount;
	dbms_output.put_line ( '*** CCS INPUT GDS EXEMPTION total = ' || total_processed);

	COMMIT;

--	==============================================================================

	title := '*** CCS INPUT EXEMPTION Analyze  ';  dbms_output.put_line(title);

	script := 'analyze table garland.GDS_EXEMPTION compute statistics';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	==============================================================================

END;


