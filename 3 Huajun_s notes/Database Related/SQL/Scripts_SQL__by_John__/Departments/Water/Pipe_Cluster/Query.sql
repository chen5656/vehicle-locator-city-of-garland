	set echo		off;
	set fetchrows	111;
--	=================================================================================
--	SUMMARIES
--	=================================================================================

	Truncate table	garland.plan_table	reuse storage;

--	=================================================================================

--	The same number of Pipes (Pipe Master) 	
--	in each temporary Group  (Pipe Group) 
--	should have changed to a given permanent Group (Water IVR Group).

--	Explain plan	set statement_id = 'count'	into garland.plan_table		for

	Select
		w.Cluster_ID,
		g.Group_ID,
		count(g.Pipe_ID)
	
	from	garland.Water_IVR_Pipe		W,
		garland.View_Pipe_Group		G

	where	w.Pipe_ID  =  g.Pipe_ID

	group by Cluster_ID, Group_ID
	order by 1, 2;	

--	=================================================================================
--	Two Groups that map to the same Cluster should contain the same Pipes
--	Are there Pipes that belong to one Group but not to an equivalent Group

	Explain plan	set statement_id = 'mis-match'	into garland.plan_table		for

	Select distinct
		w1.Cluster_ID,	
		w1.Pipe_ID,
		g1.Group_ID,	-- does have pipe
		g2.Group_ID		-- does not have pipe

	from	garland.Water_IVR_Pipe		W1,
		garland.Water_IVR_Pipe		W2,
		garland.View_Pipe_Group		G1,
		garland.View_Pipe_Group		G2

	where	w1.Cluster_ID =  w2.Cluster_ID
	and	w1.Pipe_ID	  =  g1.Pipe_ID
	and	w2.Pipe_ID	  =  g2.Pipe_ID
	and	g1.Group_ID	  <> g2.Group_ID

	and not exists
(
	select 'x'
	from	garland.View_Pipe_Group		G
	where	g.Group_ID =  g2.Group_ID
	and	g.Pipe_ID  =  g1.Pipe_ID
);

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


