	set echo 		off;
	set fetchrows	1111;
--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table		for
--	=================================================================================

	select 
		rpad(CC, 12)	Cluster_ID,
		rpad(GG, 10)	Group_ID,
		lpad(TT, 05)	Total
	from
(
	Select
		w.Cluster_ID,
		g.Group_ID,

		rtrim(w.Cluster_ID)		CC,
		rtrim(g.Group_ID)			GG,
		rtrim(count(g.Pipe_ID))		TT

	from	garland.Water_IVR_Pipe		W,
		garland.View_Pipe_Group		G

	where	w.Pipe_ID  =  g.Pipe_ID
	group by Cluster_ID, Group_ID

	UNION

	select distinct

		w.Cluster_ID,
		' ',
		' ',' ',' '

	from	garland.Water_IVR_Pipe		W

	order by 1, 2
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
	set fetchrows;

