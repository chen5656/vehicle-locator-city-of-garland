--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================
--	TO DO
--		adrResult_Viewer = adrResult_(app)
--	=====================================================================

	@c:\deacutis\scripts\address_resolve\50_Base_Report.sql;

	@c:\deacutis\scripts\address_resolve\51_Name_Report.sql;
