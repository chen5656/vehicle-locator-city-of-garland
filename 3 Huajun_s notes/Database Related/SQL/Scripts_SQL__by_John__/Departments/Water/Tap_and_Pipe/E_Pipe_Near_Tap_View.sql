--	=========================================================
--	PIPE NEAR TAP

	Create or replace view	garland.Temp_View3	as

	select	item01	tap_id,
			item02	pipe_id,

			item03	tap_x,
			item04	tap_y,

			item05	pipe_x1,
			item06	pipe_y1,
			item07	pipe_x2,
			item08	pipe_y2
	from	garland.GIS_Temp3;

--	=========================================================

