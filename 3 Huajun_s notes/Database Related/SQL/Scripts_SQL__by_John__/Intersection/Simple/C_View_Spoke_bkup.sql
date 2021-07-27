
	create or replace view	garland.Temp_View2	as
		
	select	item01	road_id,
			item02	node_id,
			item03	terminal,

			item04	addr_block,
			item05	addr_pfx,
			item06	addr_name,
			item07	addr_type,
			item08	addr_sfx

	from		garland.GIS_Temp2;
		
