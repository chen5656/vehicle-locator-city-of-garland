	set echo off;
		
	select
			lpad(this_node, 8)		this,
			lpad(road_id,   8)		road,		
			lpad(that_node, 8)		that,		
			lpad(junction,  4)		junc

	from		garland.Temp_View2

	where		rownum < 11
	;

		
	set echo on;

