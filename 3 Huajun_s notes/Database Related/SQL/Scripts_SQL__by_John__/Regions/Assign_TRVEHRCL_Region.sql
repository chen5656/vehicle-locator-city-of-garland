	set echo 		off;
	set stoponerror	on;
--	=================================================================================
--	Assign TRVEHRCL region from Loader extract
--	=================================================================================
/*
	create or replace view	garland.temp_view		as
		select item01	mslink, 
			 item02	district, 
			 item03	sector, 
			 item04	beat
		from  garland.GIS_Objects;
*/
--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	update garland.trvehrcl		RR
	set	pol_beat =
(
	select nvl(v.beat, r.pol_beat)

	from	 garland.trvehrcl		R,
		 garland.temp_view	V

	where	r.rowid		= rr.rowid
	and	v.mslink (+)	= rtrim(r.mslink)
);

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

--	Rollback;
	Commit;

--	=================================================================================
	set echo on;

