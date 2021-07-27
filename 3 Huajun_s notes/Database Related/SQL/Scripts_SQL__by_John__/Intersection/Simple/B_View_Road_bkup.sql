
	create or replace view	garland.Temp_View1	as
		
	select	item01		road_id,		--  road segment id
			item02		this_node,		--  hub node
			item03		that_node,		--  opposite node
			item04		terminal		--  'F' or 'T' hub node

	from		garland.GIS_Temp1;
		

