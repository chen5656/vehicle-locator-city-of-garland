--	=====================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
--	=======================================================================
--	Define adrResult_Local  as adrResult_Source
--	=======================================================================

	drop synonym	garland.adrResult;
	create synonym	garland.adrResult		for garland.GIS_Verify_Addr;

--	=======================================================================

	@c:\deacutis\scripts\address_resolve\views\adrResult_Source.sql;	
	@c:\deacutis\scripts\address_resolve\views\adrResult_vw.sql;	
	@c:\deacutis\scripts\address_resolve\views\adrAlter_vw.sql;	

--	=======================================================================

	truncate table	garland.adrResult_Input		reuse storage;

	insert --+ append
	into	garland.adrResult_Input
	select all *  
	from 	garland.adrResult_Source;

	commit;		

--	=======================================================================
	select '*** Set App RowID ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

	@c:\deacutis\scripts\address_resolve\12_App_Rowid.sql;

	select '*** Finished ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

--	=======================================================================
