--	=================================================================
--	PIPE TAP PROXIMITY

	create or replace view	garland.Temp_View4	as
	select
		item01	tap_id,
		item02	pipe_id,
		item03	extend_x,
		item04	extend_y,
		item05	drop_x,
		item06	drop_y,
		item07	tap_x,
		item08	tap_y,
		item09	pipe_length,
		item10	arms_length,
		item11	drop_length,
		item12	extend_length
	from	garland.GIS_Temp4;

--	=================================================================

