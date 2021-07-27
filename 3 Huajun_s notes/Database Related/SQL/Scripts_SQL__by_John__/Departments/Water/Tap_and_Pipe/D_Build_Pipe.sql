	set echo off;
--	=========================================================
--	BUILD PIPE TABLE

	truncate table garland.GIS_Temp2	reuse storage;

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	insert --+ append
	into garland.Temp_View2

	select	p.pipe_id,

			n.node_x,
			n.node_y,
			m.node_x,
			m.node_y,

			to_number(least   (n.node_x, m.node_x)) - c.buffer,
			to_number(greatest(n.node_x, m.node_x)) + c.buffer,
			to_number(least   (n.node_y, m.node_y)) - c.buffer,
			to_number(greatest(n.node_y, m.node_y)) + c.buffer

	from	garland.Temp_View3	P,
		garland.Temp_View4	N,
		garland.Temp_View4	M,
		garland.Temp_View		C

	where	p.node1 = n.pipe_node
	and	p.node2 = m.pipe_node
	and	p.pipe_id > '0'
	;

	commit;


	select * from garland.temp_view2  where rownum < 11;


--	=================================================================================
--	select * from garland.explain_Plan;
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;

--	=========================================================
	set echo on;
