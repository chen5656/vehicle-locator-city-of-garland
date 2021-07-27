--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
--	======================================================================

--	execute	garland.CCS_UMS;

	create or replace procedure garland.CCS_UMS	AS

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

--	======================================================================
	title := '***   CCS UMS   ***';
	dbms_output.put_line(title);
--	======================================================================
	
	garland.CCS_UMS_Get_Keys;

	garland.CCS_UMS_Build_Basic_UMS;

	garland.CCS_UMS_Get_Address;

	garland.CCS_UMS_Remove_Dupe;

	garland.CCS_UMS_Build_Common_UMS;

--	======================================================================

END;

