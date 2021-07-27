--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
--	=====================================================================

--	execute	garland.CCS_LINK;

	create or replace procedure garland.CCS_LINK	As

--	DECLARE

--	=====================================================================

	compile_only	integer	:= 0;

	total_process	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);

BEGIN
	if	compile_only > 0		then
		return;
	end if;

--	=====================================================================
	title := '****  CCS LINK ****  ';
	dbms_output.put_line(title);
--	=====================================================================

--	garland.CCS_LINK_Views;

	garland.CCS_LINK_Build_Common_Keys;

	garland.CCS_LINK_Copy_Keys;

	garland.CCS_LINK_Remove_Null_UMS;

	garland.CCS_LINK_Build_Record_Seq;

--	=====================================================================

END;

			