	set echo 		off;
	set fetchrows;
--	=================================================================================
--	ASSIGN NODE TYPES
--	A Pipe has a Node at each end.
--	Node Types are Valve (V) and Dangle (D)
--	=================================================================================

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table		for
--	=================================================================================

	update garland.View_Pipe_Master	P
	set	Node_Types = 
(
	select n1.Node_Type || n2.Node_Type
	from	garland.View_Node_Master	N1,
		garland.View_Node_Master	N2
	where	p.From_Node	= n1.Node_ID
	and	p.To_Node	= n2.Node_ID
);

	Commit;

--	=================================================================================

	select lpad(node_types, 10)		node_types,
		 lpad(count(*),	06) 		total
	from garland.View_Pipe_Master
	group by node_types;

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

