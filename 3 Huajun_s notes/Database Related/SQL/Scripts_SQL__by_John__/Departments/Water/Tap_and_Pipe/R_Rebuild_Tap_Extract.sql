

	truncate table  garland.gis_temp1	reuse storage;

	insert --+ append
	into	 garland.gis_temp1  
			(   item03, item01,item02	)
	select distinct tap_id, tap_x, tap_y
	from	garland.temp_view3;