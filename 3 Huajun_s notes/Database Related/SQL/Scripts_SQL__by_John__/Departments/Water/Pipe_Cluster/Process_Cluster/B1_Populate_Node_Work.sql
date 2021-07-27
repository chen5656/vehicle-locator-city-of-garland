--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
--	================================================================
--	Obtain all Pipe Nodes and form a Node table from them
--	Classify them as either Valve or Interior to begin with
--	Each Node ID is the concantenation of the X & Y coordinates

--	====================================================================
--	Node Types
--		'V'		Valve			external node	(cxact match)
--		'v'		Valve			external node	(near  match)
--		'D'		Dead End		external node	(exact match)
--		'd'		Dead End		external node	(near  match)
--		'I'		Interior		internal node	(pipe-to-pipe)
--		'i'		Interior		internal node	(near  match)
--	====================================================================

	select sysdate) || '***   Analyze Feature Coordinates   ***' " "  from dual;
	analyze table gis.Feature_Coordinates	compute statistics;

	select sysdate) || '***   Populate Node Work   ***' " "  from dual;
   
	TRUNCATE table	garland.Water_IVR_Node_Work	reuse storage;

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set statement_id = 'aaa' into jdeacutis.plan_table for
--	=====================================================================
	insert --+ append
	into	garland.Water_IVR_Node_Work
	select 
		p.featureid					Pipe_ID,
		v.featureid					Valve_ID,		
		decode(v.featureid,null,'I','V')	Node_Type,
		p.x1 || p.y1				NodeID
	from	gis.feature_coordinates		P,
		gis.feature_coordinates		V
	where	p.featureclass    = 'WTPI'
	and	v.featureclass(+) = 'WTVA'
	and	p.x1 = v.x1   (+)
	and	p.y1 = v.y1   (+)

	UNION ALL
	select 
		p.featureid					Pipe_ID,
		v.featureid					Valve_ID,		
		decode(v.featureid,null,'I','V')	Node_Type,
		p.x2 || p.y2				NodeID
	from	gis.feature_coordinates		P,
		gis.feature_coordinates		V
	where	p.featureclass    = 'WTPI'
	and	v.featureclass(+) = 'WTVA'
	and	p.x2 = v.x1   (+)
	and	p.y2 = v.y1   (+)
	;
	
	COMMIT;

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Table;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

	select sysdate) || '***   Analyze Node Work   ***' " "  from dual;
	analyze table garland.Water_IVR_Node_Work		compute statistics;

--	@c:\deacutis\scripts\departments\water\pipe_cluster\prep_input\NODE_MASTER_SUMMARY.sql

--	=====================================================================


