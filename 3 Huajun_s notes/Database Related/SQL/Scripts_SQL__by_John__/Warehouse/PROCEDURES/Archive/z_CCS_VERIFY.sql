--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
--	=====================================================================

--	execute	garland.CCS_VERIFY;

--	create or replace procedure garland.CCS_VERIFY		as

	DECLARE

--	=====================================================================

	compile_only	integer	:= 0;

	script		varchar2(1000);
	title			varchar2(100);
	heading		varchar2(100);

BEGIN
	if	compile_only > 0		then
		return;
	end if;

--	=================================================================================
	title := '****  CCS VERIFY ****  ';
	dbms_output.put_line(title);
--	=================================================================================

	garland.CCS_COMPILE;
	garland.CCS_VERIFY_TAX;

	garland.CCS_COMPILE;
	garland.CCS_VERIFY_UMS;

--	=================================================================================

END;
