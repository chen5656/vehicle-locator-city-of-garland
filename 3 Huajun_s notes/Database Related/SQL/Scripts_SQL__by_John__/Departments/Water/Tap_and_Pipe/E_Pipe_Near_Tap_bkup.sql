	set echo	off;
	set timing	on;
--	====================================================================================

--	analyze table	garland.gis_temp1		compute statistics;
--	analyze table	garland.gis_temp2		compute statistics;

	@C:\deacutis\scripts\departments\water\tap_and_pipe\E_PIPE_NEAR_TAP_VIEW.sql

--	====================================================================================

	truncate table garland.GIS_Temp3	reuse storage;

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	insert --+ append		
	into garland.Temp_View3

	select	t.tap_id,
			p.pipe_id,

			t.tap_x,
			t.tap_y,

			p.pipe_x1,
			p.pipe_y1,
			p.pipe_x2,
			p.pipe_y2

	from	garland.Temp_View1	T,
		garland.Temp_View2	P

	where	t.tap_x	between  p.minx  and  p.maxx
	and	t.tap_y	between  p.miny  and  p.maxy
	;

	commit;

	analyze table	garland.gis_temp3		compute statistics;

	select * from garland.temp_view3		where rownum < 11;


--	=================================================================================
--	select * from garland.explain_Plan;
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;

--	====================================================================================
	set echo on;
	set timing	off;


