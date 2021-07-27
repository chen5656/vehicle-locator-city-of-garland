	set echo 		off;
	set fetchrows;
--	=============================================================================================
--	BUILD PIPE PAIR	of connected pipes
--	A Pipe with Valves at both ends constitute a Group of one.  It requires no further analysis.
--	=============================================================================================

	Truncate table	garland.gis_TEMP2		reuse storage;

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table		for
--	=================================================================================

	Insert --+ append
	into	garland.View_Pipe_Pair
	select 
		P1.Pipe_ID,
		P2.Pipe_ID
	from	garland.View_Pipe_Master	P1,
		garland.View_Pipe_Master	P2
	where	p1.FROM_Node	=  p2.FROM_Node		--  FROM - FROM
	and	p1.Pipe_ID		<> p2.Pipe_ID
	and	upper(p1.Node_Types) not like 'V%'
	and	upper(p2.Node_Types) not like 'V%'
	UNION
	select 
		P1.Pipe_ID,
		P2.Pipe_ID
	from	garland.View_Pipe_Master	P1,
		garland.View_Pipe_Master	P2
	where	p1.TO_Node		=  p2.TO_Node		--  TO - TO
	and	p1.Pipe_ID		<> p2.Pipe_ID
	and	upper(p1.Node_Types) not like '%V'
	and	upper(p2.Node_Types) not like '%V'
	UNION
	select 
		P1.Pipe_ID,
		P2.Pipe_ID
	from	garland.View_Pipe_Master	P1,
		garland.View_Pipe_Master	P2
	where	p1.FROM_Node	=  p2.TO_Node		--  FROM - TO
	and	p1.Pipe_ID		<> p2.Pipe_ID
	and	upper(p1.Node_Types) not like 'V%'
	and	upper(p2.Node_Types) not like '%V'
	UNION
	select 
		P1.Pipe_ID,
		P2.Pipe_ID
	from	garland.View_Pipe_Master	P1,
		garland.View_Pipe_Master	P2
	where	p1.TO_Node		=  p2.FROM_Node		--  TO - FROM
	and	p1.Pipe_ID		<> p2.Pipe_ID
	and	upper(p1.Node_Types) not like '%V'
	and	upper(p2.Node_Types) not like 'V%'
	;
	
--	=================================================================================

	Commit;

	Analyze table	garland.GIS_Temp2		compute statistics;

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

