	set echo 		off;
	set fetchrows;
--	============================================================================================
--	An External Dangle node is a Dangle node that is connected to only 1 Pipe
--	Since it is and end node, it will treated as a pseudo Valve (v) for path tracing purposes, 
--	============================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table		for
--	============================================================================================

	update garland.view_node_master
	set	node_type = 'v'
	where	node_id	IN
(
	select node_id
	from	garland.view_node_master
	where	node_type = 'D'
	and	node_id	IN
(
	select node_id	from
(
	select pipe_id, from_node node_id	from garland.view_pipe_master
	union all
	select pipe_id, to_node	  node_id	from garland.view_pipe_master
)
	group by node_id
	having count(pipe_id) = 1
)
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

