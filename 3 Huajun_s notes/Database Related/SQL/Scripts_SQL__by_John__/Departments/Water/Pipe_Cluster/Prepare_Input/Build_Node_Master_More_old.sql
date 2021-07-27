--  Connect jdeacutis/****@sdet_gis-2k3-tstdbs
--	================================================================
--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
--set serveroutput	on	size 99999;
--alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	================================================================
--	Obtain more Node Master records for Feature_Coord valves minus Node_Master valves
--	================================================================

--	analyze table gis.Feature_Coordinates	compute statistics;
--	analyze table garland.GIS_Objects		compute statistics;

	delete from garland.view_node_master 
	where node_type = 'VV';
	commit;

	select to_char(sysdate,'hh24:mi:ss') || '   START' "CLOCK"  from dual;
   
--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set statement_id = 'aaa' into jdeacutis.plan_table for
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
	and	p.x1	between (v.x1 - 05) and (v.x1 + 05)
	and	p.y1	between (v.y1 - 05) and (v.y1 + 05)
	and	v.featureid in
(
	select featureid 		from gis.feature_coordinates  where featureclass = 'WTVA'
	minus
	select (valve_id + 0)	from garland.view_Node_Master
)
	UNION
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
	and	p.x2	between (v.x1 - 05) and (v.x1 + 05)
	and	p.y2	between (v.y1 - 05) and (v.y1 + 05)
	and	v.featureid in
(
	select featureid 		from gis.feature_coordinates  where featureclass = 'WTVA'
	minus
	select (valve_id + 0)	from garland.view_Node_Master
)
;
	
	Commit;

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
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

