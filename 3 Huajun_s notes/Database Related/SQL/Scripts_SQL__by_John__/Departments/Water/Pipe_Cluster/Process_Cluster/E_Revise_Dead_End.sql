--	=====================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================
--	A Dead End may be "near" another node.
--	If so give it to the same Node ID and same Node Type as the other node.

--	====================================================================
--	Node Types
--		'V'		Valve			external node	(cxact match)
--		'v'		Valve			external node	(near  match)
--		'D'		Dead End		external node	(exact match)
--		'd'		Dead End		external node	(near  match)
--		'I'		Interior		internal node	(pipe-to-pipe)
--		'i'		Interior		internal node	(near  match)

--	=====================================================================
--	Coordinates of Dead End nodes

	create or replace view	garland.Temp_View	as
	select item01	PipeID,
		 item02	Lengths,
		 item03	X,
		 item04	Y
	from	garland.GIS_Objects;

--	=====================================================================

	select sysdate || '***   Revise Dead End   ***' " "	from dual;

	variable	tolerance	number;
	variable	muliplier	number;
	execute	:Tolerance	:= 02;
	execute	:Multiplier	:= 04;

--	=====================================================================================
--	If two connected pipes do not have the same coordinates then they appear to be Dead Ends
--	Look for pseudo Dead Ends that are  "close" to each other and make them Interior nodes
--	=====================================================================================

--	=====================================================================
--	GET X,Y COORDINATES FOR ALL DEAD END NODES
--	=====================================================================
	truncate table	jdeacutis.plan_table	reuse storage;
--	=====================================================================

	Truncate table	garland.GIS_Objects	reuse storage;

	explain plan	set statement_id = 'aa'	into jdeacutis.plan_table for

	insert --+ append
	into	garland.Temp_View
(
	select c.PipeID, c.Lengths, c.X1, c.Y1
	from	gis.Feature_Coordinates		C,
		garland.Water_IVR_Node_Work	N

	where	upper(n.NodeType)	= 'D'
	and	n.NodeID		= c.X || n.Y
	and	n.PipeID		= c.Feature_ID
	and	c.FeatureClass	= 'WTPI'
);

	COMMIT;

	analyze table	garland.GIS_Objects	compute statistics;

--	=====================================================================
--	Look for close Dead End Nodes
--	Set Node Type = Interior for one of the Dead End Nodes
--	=====================================================================

	explain plan	set statement_id = 'bb'	into jdeacutis.plan_table for

	update garland.Water_IVR_Node_Work		W
	set (w.NodeID, w.NodeType) =
(
	select max(n.NodeID), 'i' 
	from	garland.Temp_View			D,
		gis.Feature_Coordinates		C,
		garland.Water_IVR_Node_Work	N

	where	d.PipeID	= w.PipeID||''
	and	d.X || d.Y	= w.NodeID	

	and	c.PipeID <> d.PipeID+0
	and	c.X	between (d.X - :tolerance)||''	and (d.X + :tolerance)||''
	and	c.Y	between (d.Y - :tolerance)||''	and (d.Y + :tolerance)||''

--	and	c.lengths 	>= :multiplier * :tolerance
--	and	d.lengths+0	>= :multiplier * :tolerance

	and	n.NodeID   <> w.NodeID
	and	n.NodeID	= c.X || c.Y
	and	n.PipeID	= c.PipeID
)
	where	upper(w.NodeType) = 'D';

	COMMIT;

--	=====================================================================
--	Reclassify connected Dead Ends as either Valves or Interior Nodes
--	=====================================================================

	explain plan	set statement_id = 'cc'	into jdeacutis.plan_table for

	update	WaterIVR_Node_Word	N
	set		upper(NodeType) = 'V'
	where		upper(NodeType) = 'D'
	and		exists
(
	select	'x'
	from		Water_IVR_Node_Work	M
	where		m.NodeID = n.NodeID
	and		upper(m.NodeType) = 'V'
);

	COMMIT;

	explain plan	set statement_id = 'dd'	into jdeacutis.plan_table for

	update	WaterIVR_Node_Word	N
	set		upper(NodeType) = 'I'
	where		upper(NodeType) = 'D'
	and		exists
(
	select	'x'
	from		Water_IVR_Node_Work	M
	where		m.NodeID =  n.NodeID
	and		m.PipeID <> n.PipeID
);

	COMMIT;

--	=====================================================================
	select * from jdeacutis.explain_Plan;
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================
