	set echo 		off;
	set fetchrows;
	set charwidth;
	set stoponerror	on;
--	=================================================================================

	select count(*) pipe_pair  from garland.view_pipe_pair;

--	=================================================================================

--	What kind of Nodes are at either end of connected Pipes

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table		for
--	=================================================================================

	select rpad(replace(p1.node_types,'v','d'), 9)	"Node Type", 
		 rpad(replace(p2.node_types,'v','d'), 9)	"Node_Type",
		 lpad(count(*),	6)				"Total"

	from	garland.View_Pipe_Pair		P,
		garland.View_Pipe_Master	P1,
		garland.View_Pipe_Master	P2

	where	p.Pipe1_ID	= p1.pipe_ID
	and	p.Pipe2_ID	= p2.pipe_ID

	and	upper(p1.Node_Types) in ('DD', 'DV', 'VD')
	and	upper(p2.Node_Types) in ('DD', 'DV', 'VD')

	group by	p1.node_types, p2.node_types;

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
	set echo		on;
	set fetchrows;
	set charwidth;


