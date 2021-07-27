--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
--	================================================================
--	Obtain more Node Master records for Feature_Coord valves minus Node_Work valves
--	================================================================

--	Node Types
--		'V'		Valve			external node	(cxact match)
--		'v'		Valve			external node	(near  match)
--		'D'		Dead End		external node	(exact match)
--		'd'		Dead End		external node	(near  match)
--		'I'		Interior		internal node	(pipe-to-pipe)
--		'i'		Interior		internal node	(near  match)
--	====================================================================

--	analyze table gis.Feature_Coordinates	compute statistics;

	select to_char(sysdate,'hh24:mi:ss') || '   START' "CLOCK"  from dual;

--	================================================================
--   Valve should be within a Tolerance distance of pipe endpoint
--   Length of pipe should be at least a Multiple of the Tolerance

	variable tolerance   number;
	variable multiplier  number;

	execute  :tolerance  := 05;
	execute  :multiplier := 04;

--	=====================================================================
	truncate table	jdeacutis.plan_table	reuse storage;
	explain plan set statement_id = 'aaa' into jdeacutis.plan_table for
--	=====================================================================
	insert --+ append
	into	garland.Water_IVR_Node_Work

	select 
		p.Featureid					PipeID,
		v.Featureid					ValveID,		
		'v'						NodeType,
		p.x1 || p.y1				NodeID
	from	gis.feature_coordinates		P,
		gis.feature_coordinates		V
	where	p.FeatureClass    = 'WTPI'
	and	v.FeatureClass(+) = 'WTVA'
	and	p.x1	between (v.x1 - :tolerance) and (v.x1 + :tolerance)
	and	p.y1	between (v.y1 - :tolerance) and (v.y1 + :tolerance)
	and 	p.Lengths >= :multiplier * :tolerance
	and	v.Featureid	in
(
	select FeatureID 		from gis.feature_coordinates  where featureclass = 'WTVA'
	minus
	select ValveID		from garland.Water_IVR_Node_Work
)

	UNION ALL
	select 
		p.featureid					PipeID,
		v.featureid					ValveID,		
		'v'						NodeType,
		p.x2 || p.y2				NodeID
	from	gis.feature_coordinates		P,
		gis.feature_coordinates		V
	where	p.featureclass    = 'WTPI'
	and	v.featureclass(+) = 'WTVA'
	and	p.x2	between (v.x1 - :tolerance) and (v.x1 + :tolerance)
	and	p.y2	between (v.y1 - :tolerance) and (v.y1 + :tolerance)
	and 	p.lengths >= :multiplier * :tolerance
	and	v.featureid in
(
	select featureid 		from gis.feature_coordinates  where featureclass = 'WTVA'
	minus
	select (valve_id + 0)	from garland.Water_IVR_Node_Work
)
;
	
	Commit;

--	=====================================================================
	select * from jdeacutis.explain_Plan;
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Table;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

	select to_char(sysdate,'hh24:mi:ss') || '   STOP'  "CLOCK" from dual;

--	=====================================================================

	@c:\deacutis\scripts\departments\water\pipe_cluster\prep_input\NODE_MASTER_MORE_SUMMARY.sql

--	=====================================================================

