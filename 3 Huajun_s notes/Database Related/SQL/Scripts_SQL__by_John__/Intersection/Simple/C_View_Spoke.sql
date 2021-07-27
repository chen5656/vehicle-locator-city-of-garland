--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
--	===========================================================================================
--	C-View_Spoke
--	===========================================================================================
	select 'SPOKE VIEW  ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

	create or replace view	garland.Temp_View3	as
	select	
			item01	hub_node,
			item02	roadid,
			item03	end_node,
			item04	fromto,

			item05	addr_blok,
			item06	addr_pfx,
			item07	addr_name,
			item08	addr_type,
			item09	addr_sfx,

			item10	x_vector,
			item11	y_vector

	from		garland.GIS_Temp3;
		
