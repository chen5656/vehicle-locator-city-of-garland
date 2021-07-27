--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
--	===========================================================================================
--	1_Build_Spoke

--	A_View_Node  creates Temp_View1
--	C_View_Spoke creates Temp_View3
--	===========================================================================================

	select 'BUILD SPOKE  ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

	Truncate table	garland.GIS_Temp3		reuse storage;

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================

	insert --+ append
	into	 garland.Temp_View3
	(
		hub_node,
		roadid,
		end_node,

		fromto,
		addr_blok,

		addr_pfx,
		addr_name,
		addr_type,
		addr_sfx,

		x_vector,
		y_vector
	)
	select	
		r.this_node,
		r.roadid,
		r.that_node,

		r.fromto_IN,
		trunc(decode(r.fromto_IN, '+1', c.addr_lo, c.addr_hi),-2),

		c.addr_pfx,
		c.addr_name,
		c.addr_type,
		c.addr_sfx,

		(e.x_coord - h.x_coord) * r.fromto_IN + 0,
		(e.y_coord - h.y_coord) * r.fromto_IN + 0
		
	from	garland.TRVEHRCL		C,	-- Centerline
		garland.Temp_View2	R,	-- ESRI Road
		garland.Temp_View1	H,	-- Hub Node
		garland.Temp_View1	E	-- End Node

	where	c.mslink	=  r.roadid + 0
	and	r.this_node	=  h.node_id
	and	r.that_node =  e.node_id

	and	c.addr_name > 'A'
	;

	COMMIT;

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

--	==========================================================================

	analyze table garland.GIS_Temp3  compute statistics;

--	==========================================================================

