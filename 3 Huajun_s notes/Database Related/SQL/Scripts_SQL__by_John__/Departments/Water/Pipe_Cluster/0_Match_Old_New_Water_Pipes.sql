
--	ARCHIVE  = gis_water_pipe_2
--	in order to match old water pipes with new water pipes
--	use pipe id, pipe length, pipe diameter
--	the nulls and dupes are relative fewly in number


	select count(*) from gis.water_pipe_2  					-- 834
	where pipe_id is null or pipe_length is null or pipe_diameter is null;


	select pipe_id, pipe_length, pipe_diameter, count(*) 			-- 200
	from gis.water_pipe_2  
	where rtrim(pipe_id) is not null and pipe_length is not null and pipe_diameter is not null
	group by pipe_id, pipe_length, pipe_diameter 
	having count(*) > 1;


