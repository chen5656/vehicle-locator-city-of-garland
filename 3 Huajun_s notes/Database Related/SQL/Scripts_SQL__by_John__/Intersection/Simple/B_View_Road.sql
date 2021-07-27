--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
--	===========================================================================================
--	B_View_Road
--	===========================================================================================
	select 'ROAD VIEW  ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;


	create or replace view	garland.Temp_View2	as
		
	select
			item01		this_node,		--  hub node
			item02		roadid,		--  road segment id
			item03		that_node,		--  opposite node
			item04		fromto_IN,		--  'F'=+1   'T'=-1
			item05		fromto_SET		--  'F'=+1   'T'=-1
	from		garland.GIS_Temp2;
		

