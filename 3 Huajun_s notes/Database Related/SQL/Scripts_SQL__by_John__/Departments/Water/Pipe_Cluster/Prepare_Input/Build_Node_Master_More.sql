--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
--	================================================================
--	Obtain more Node Master records for Feature_Coord valves minus Node_Master valves
--	================================================================

--	analyze table gis.Feature_Coordinates	compute statistics;
--	analyze table garland.GIS_Objects		compute statistics;

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
	into	garland.view_Node_Master
	select 
		p.x1 || p.y1				From_Node,
		'VV'						Node_Type,
		v.featureid					Valve_ID,		
		p.featureid					Pipe_ID,
		p.x1						x_coord,
		p.y1						y_coord
	from	gis.feature_coordinates		P,
		gis.feature_coordinates		V
	where	p.featureclass    = 'WTPI'
	and	v.featureclass(+) = 'WTVA'
	and	p.x1	between (v.x1 - :tolerance) and (v.x1 + :tolerance)
	and	p.y1	between (v.y1 - :tolerance) and (v.y1 + :tolerance)
	and 	p.lengths >= :multiplier * :tolerance
	and	v.featureid in
(
	select featureid 		from gis.feature_coordinates  where featureclass = 'WTVA'
	minus
	select (valve_id + 0)	from garland.view_Node_Master
)
	UNION
	select 
		p.x2 || p.y2				From_Node,
		'VV'						Node_Type,
		v.featureid					Valve_ID,		
		p.featureid					Pipe_ID,
		p.x2						x_coord,
		p.y2						y_coord
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
	select (valve_id + 0)	from garland.view_Node_Master
);
	
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

