	set echo off;
--	=================================================================================

	@c:\deacutis\scripts\departments\water\tap_and_pipe\F_Measure_Proximity_View.sql

--	=================================================================================

	Create or replace view	garland.Temp_View1		as
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
	from	garland.GIS_Objects;

--	=========================================================

	truncate table	garland.GIS_Objects		reuse storage;

--	=========================================================================================================
--	truncate table	garland.plan_table		reuse storage;
--	explain plan  	set statement_id = 'xxx'	into garland.plan_table	for
--	=========================================================================================================

	insert --+ append
	into	garland.Temp_View1

	select p.*
	from	garland.Temp_View4	P,
(
	select tap_id,
		 min(arms_length||'.'||drop_length)		min_length
	from	 garland.Temp_View4	
	group by tap_id
)						PP

	where	p.tap_id = pp.tap_id

	and	p.arms_length||'.'||p.drop_length	= pp.min_length

--	and	p.drop_length > 0
	;

	commit;

--	======================================================================

--	select * from garland.explain_plan;

	analyze table	garland.GIS_Objects		compute statistics;

--	======================================================================
	set echo on;
