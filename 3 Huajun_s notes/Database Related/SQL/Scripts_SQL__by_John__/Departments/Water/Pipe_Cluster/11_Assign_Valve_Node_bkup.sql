	set echo 		off;
	set fetchrows;
--	=================================================================================
--	ASSIGN VALVE NODE TYPES
--	=================================================================================

--	NODE PREPARATION
--		Load entire Node ASCII as Dangle nodes (D)
--		Set Valve nodes (V) per Valve ASCII
--		Set external Dangle nodes (v) = Dangle (D) connected to only 1 Pipe
--		[Only internal Dangle nodes remain (D)]	
--		Set Pipe Node Types for From & To Nodes

--	=================================================================================
--	Initialize all Node Types to Dangle (D)

	update garland.View_Node_Master
	set	node_type = 'D';
	
--	Commit;

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table		for
--	=================================================================================

	update garland.View_Node_Master	N
	set (	Node_Type, Valve_ID )
	= 
(
	select 'V', min(v.Valve_ID)
	from	 garland.View_Valve_Master	V
	where	 v.Node_ID = n.Node_ID
	group by v.Node_ID
)
	where exists
(
	select 'x'
	from	 garland.View_Valve_Master	W
	where	 w.Node_ID = n.Node_ID
);

	Commit;

--	=================================================================================
--	Node Type Totals

	select lpad(node_type,	9)	node_type,
		 lpad(count(*),	7) 	total
	from	garland.view_node_master
	group by node_type;

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



