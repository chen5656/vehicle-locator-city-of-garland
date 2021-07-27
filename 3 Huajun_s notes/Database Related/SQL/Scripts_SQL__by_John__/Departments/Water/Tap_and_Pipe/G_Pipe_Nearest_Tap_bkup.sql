	set echo off;
--	=========================================================


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
		item09	arms_length,
		item10	drop_length

	from	garland.GIS_Temp1;


--	=========================================================

	truncate table	garland.GIS_Temp1		reuse storage;

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
		 min(arms_length)		min_arms_length
	from	 garland.Temp_View4	
	group by tap_id
)						PP
	where	p.tap_id		= pp.tap_id
	and	p.arms_length	= pp.min_arms_length
	;

	commit;

--	======================================================================

--	select * from garland.explain_plan;

	analyze table	garland.GIS_Temp1		compute statistics;

--	======================================================================

	select tap_id, count(*)
	from	garland.temp_view1
	group by tap_id
	having count(*) > 1;

--	======================================================================
	set echo on;



