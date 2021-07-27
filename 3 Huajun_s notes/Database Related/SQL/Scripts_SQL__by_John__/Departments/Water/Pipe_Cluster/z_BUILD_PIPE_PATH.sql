	set echo 		off;
	set timing		off;
	set fetchrows;
	set charwidth;
--	---------------------------------------------------------------------------------
--	Generate Hierarchal paths of water pipes from node to node
--	Each path begins and ends at a "valve" (real) node
--	Intermediate nodes are "dangle" (phony) nodes	
--	---------------------------------------------------------------------------------

--	X,Y Limits
--	2519119 to 2570549
--	6991532 to 7046500

--	---------------------------------------------------------------------------------

	Truncate table	garland.gis_Temp2		reuse storage;

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table		for
--	=================================================================================

	insert --+ append
	into	 garland.Temp_View2				-- PIPE PATH

	select 
		Pipe_ID,
		From_Node,	
		To_Node,
		Node_Type,
		9999999			Group_ID,
		9999999			Path_ID,
		lpad(level, 2,'0')	Level_ID,	
		lpad(rownum,6,'0')	Seq	

	from	 garland.Temp_View3		V2		-- PIPE MASTER

	where(Level 	=  1   
	or	Node_Type 	= 'D'	)	-- Dangle Node
	and	exists
(
	select 'x'
	from	garland.Temp_View4		V4		-- NODE INPUT
	where	v4.Node_id = v2.From_Node
	and	v4.x_coord between	2541000	and 2544000
	and	v4.y_coord between	7021000	and 7024000
)

	Start with	(Node_Type,	From_Node)	 in 
	(	select 'V', 	Node_ID	
		from garland.Temp_View4 	V4		-- NODE INPUT
		where v4.x_coord between 	2542000	and 2543000
		and	v4.y_coord between	7022000	and 7023000
	)

	Connect By	Prior To_Node = From_Node
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
	set echo		on;
	set timing		off;
	set fetchrows;
	set charwidth;
