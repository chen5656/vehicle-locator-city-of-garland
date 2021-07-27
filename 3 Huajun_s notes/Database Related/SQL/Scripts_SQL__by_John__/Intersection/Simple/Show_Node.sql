	set echo off;
	
	select
			lpad(node_id, 8)		node_id,
			lpad(x_coord, 8)		x_coord,
			lpad(y_coord, 8)		y_coord

	from		garland.Temp_View1

	where		rownum < 11
	;
		
	set echo on;
