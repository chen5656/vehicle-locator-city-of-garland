	set echo 		off;
	set fetchrows;
--	=====================================================================================================
--	INITIALIZE PIPE GROUP
--	Each Pipe ID that is connected to a Valve ID specifies a Group ID.  The Pipe belongs to the Group.
--	=====================================================================================================

	Truncate table	garland.gis_TEMP3		reuse storage;

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table		for
--	=================================================================================

	insert --+ append
	into	 garland.View_Pipe_Group	
	select 
		Pipe_ID,		-- Pipe  ID
		Pipe_ID		-- Group ID
	from	garland.View_Pipe_Master
	where	upper(Node_Types) in ('VD', 'DV');

	Commit;

--	=================================================================================

--	select count(*) "1st_group"	from garland.view_pipe_group;

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


