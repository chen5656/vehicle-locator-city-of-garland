--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	=====================================================================

--	execute	garland.CCS_

--	create or replace procedure garland.CCS_		AS

	DECLARE

--	=====================================================================

	compile_only	integer	:= 01;

	total_processed	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

BEGIN
	if	compile_only > 0		then
		return;
	end if;

	select '   '||to_char(sysdate,'Mon dd hh24:mi') into heading from dual; 
	dbms_output.put_line(heading);

--	-----------------------------------------------------------
/*
	title := '   ';  dbms_output.put_line(title);

	total_processed := sql%rowcount;
	dbms_output.put_line ( '  total = ' || total_processed);

	title := '***  total =  ' || total_processed;  dbms_output.put_line(title);

	script := 'analyze table garland.	compute statistics';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);
*/

END;

