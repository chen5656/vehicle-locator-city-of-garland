	set echo off;
--	======================================================
--	PIPE

	select
		lpad(pipe_id,7)		pipe_id,
		'   '  " ",

		lpad(pipe_x1,7)		pipe_x1,
		lpad(pipe_y1,7)		pipe_y1,
		'   '  " ",
		lpad(pipe_x2,7)		pipe_x2,
		lpad(pipe_y2,7)		pipe_y2,
		'   '  " ",

		lpad(minx,	7)		minx,
		lpad(maxx,	7)		maxx,
		'   '  " ",
		lpad(miny,	7)		miny,
		lpad(maxy,	7)		maxy

	from	garland.Temp_View2
	where	rownum < 11

	;

--	======================================================
--	TAP NEAR PIPE

	select 

		lpad(tap_id, 7)		tap_id,
		lpad(pipe_id,7)		pipe_id,
		'   '				" ",
		lpad(tap_x,  7)		tap_x,
		lpad(tap_y,	 7)		tap_y,
		'   '				" ",
		lpad(pipe_x1,7)		pipe_x1,
		lpad(pipe_y1,7)		pipe_y1,
		'   '				" ",
		lpad(pipe_x2,7)		pipe_x2,
		lpad(pipe_y2,7)		pipe_y2,
		' ' " "

	from	garland.temp_view3
	where	rownum < 11
	;		


--	======================================================
--	TAP & PIPE

	select

		lpad(tap_id,	7)		tap_id,
		lpad(pipe_id,	7)		pipe_id,
		'  ' " ",
		lpad(extend_x,	8)		extend_x,
		lpad(extend_y,	8)		extend_y,
		'  ' " ",
		lpad(drop_x,	7)		drop_x,
		lpad(drop_y,	7)		drop_y,
		'  ' " ",
		lpad(tap_x,		7)		tap_x,
		lpad(tap_y,		7)		tap_y,
		'  ' " ",
		lpad(pipe_length,   9)		pipe_leng,
		lpad(arms_length,   9)		arms_leng,
		lpad(drop_length,   9)		drop_leng,
		lpad(extend_length, 9)		extd_leng

	from	garland.Temp_View1
	where rownum < 11

--	and	pipe_length 	= 0
	and	arms_length		> 2000
--	and	drop_length 	= 0
--	and	extend_length 	= 0
	;

--	======================================================
--	HORIZONTAL & VERTICAL PIPES

	select count(*) 	pipes
	from	garland.temp_view2;

	select count(*)	tap_pipes
	from	garland.temp_view1;

	select count(*) 	horizontal
	from	garland.temp_view3 
	where pipe_y1 = pipe_y2;

	select count(*) 	vertical
	from	garland.temp_view3 
	where pipe_x1 = pipe_x2;

--	======================================================
	set echo on;


