--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
--set serveroutput	on	size 99999;
--alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	================================================================
--	Obtain Pipe Node information
--	Includes Nodes at both ends of the pipe
--	Nodes can be Dangles, Valves or Dead Ends
--	================================================================

	select to_char(sysdate,'hh24:mi:ss') || '   START' "CLOCK"  from dual;

	analyze table gis.feature_coordinates	compute statistics;
   
	TRUNCATE table	garland.gis_Objects	reuse storage;

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set statement_id = 'aaa' into jdeacutis.plan_table for
--	=====================================================================
	insert --+ append
	into	garland.view_Node_Master
	select 
		p.x1 || p.y1				From_Node,
		decode(v.featureid,null,'D','V')	Node_Type,
		v.featureid					Valve_ID,		
		p.featureid					Pipe_ID,
		p.x1						x_coord,
		p.y1						y_coord
	from	gis.feature_coordinates		P,
		gis.feature_coordinates		V
	where	p.featureclass    = 'WTPI'
	and	v.featureclass(+) = 'WTVA'
	and	p.x1	= v.x1  (+)
	and	p.y1	= v.y1  (+)
	UNION
	select 
		p.x2 || p.y2				To_Node,
		decode(v.featureid,null,'D','V')	Node_Type,
		v.featureid					Valve_ID,		
		p.featureid					Pipe_ID,
		p.x2						x_coord,
		p.y2						y_coord
	from	gis.feature_coordinates		P,
		gis.feature_coordinates		V
	where	p.featureclass    = 'WTPI'
	and	v.featureclass(+) = 'WTVA'
	and	p.x2	= v.x1  (+)
	and	p.y2	= v.y1  (+)
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

	@c:\deacutis\scripts\departments\water\pipe_cluster\prep_input\NODE_MASTER_SUMMARY.sql

--	=====================================================================


