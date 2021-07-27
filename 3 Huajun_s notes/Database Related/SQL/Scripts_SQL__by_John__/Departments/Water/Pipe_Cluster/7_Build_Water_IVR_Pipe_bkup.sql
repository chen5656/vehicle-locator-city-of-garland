	set echo 		off;
	set fetchrows;
--	=================================================================================
--	BUILD WATER IVR PIPE
--	=================================================================================

	Analyze table	garland.gis_TEMP3			compute statistics;

	Truncate table	garland.WATER_IVR_PIPE		reuse storage;

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table		for
--	=================================================================================

	insert --+ append
	into garland.Water_IVR_Pipe

	select 
		min(Group_ID),
		Pipe_ID

	from	garland.View_Pipe_Group
	group by Pipe_ID


/*
	UNION ALL

	select
		Pipe_ID,
		Pipe_ID

	from	garland.View_Pipe_Master
	where	Node_Types = 'VV'
*/
;

	Commit;

--	=================================================================================
--	select * from garland.explain_Plan;
--	insert into garland.plan_table (object_owner, object_name) values ('GARLAND', '');
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;
--	=================================================================================

	select lpad(count(distinct Cluster_ID),13) Clusters	from garland.Water_IVR_Pipe;

	select lpad(count(*),13) Cluster_Pipes			from garland.Water_IVR_Pipe;

	Analyze table	garland.Water_IVR_Pipe		compute statistics;

--	=================================================================================
	set fetchrows;


