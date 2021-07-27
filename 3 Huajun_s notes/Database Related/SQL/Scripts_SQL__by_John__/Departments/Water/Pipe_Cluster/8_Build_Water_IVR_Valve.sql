	set echo 		off;
	set fetchrows;
--	=================================================================================
--	BUILD WATER IVR VALVE
--	=================================================================================

	Truncate table	garland.WATER_IVR_VALVE		reuse storage;

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table		for
--	=================================================================================

	insert --+ append
	into garland.Water_IVR_Valve

	select
		w.Cluster_ID,
		n.Valve_ID

	from	garland.Water_IVR_Pipe		W,
		garland.View_Pipe_Master	P,
		garland.View_Node_Master	N

	where	w.Pipe_ID	= p.Pipe_ID
	and	n.Node_ID	= p.From_Node
	and	p.Node_Types = 'VD'

	UNION

	select
		w.Cluster_ID,
		n.Valve_ID

	from	garland.Water_IVR_Pipe		W,
		garland.View_Pipe_Master	P,
		garland.View_Node_Master	N

	where	w.Pipe_ID	= p.Pipe_ID
	and	n.Node_ID	= p.To_Node
	and	p.Node_Types = 'DV';


--	=================================================================================

	Commit;

	select lpad(count(distinct Cluster_ID),13) Clusters	from garland.Water_IVR_Valve;

	select lpad(count(*),13) Cluster_Valve			from garland.Water_IVR_Valve;

	Analyze table	garland.Water_IVR_Valve		compute statistics;

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
	set fetchrows;

