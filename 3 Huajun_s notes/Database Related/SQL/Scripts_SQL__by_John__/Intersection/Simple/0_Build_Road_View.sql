--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
--	===========================================================================================
--	0_Build_Road_View
--	===========================================================================================
/*
	select 'ROAD VIEW  ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

	create or replace view	garland.Temp_View2	as
	select
			item01		this_node,		--  hub node
			item02		roadid,		--  road segment id
			item03		that_node,		--  opposite node
			item04		fromto_IN,		--  'F'= -1   'T'= +1
			item05		fromto_SET		--  'F'= -1   'T'= +1
	from		garland.GIS_Temp2;
*/
--	===========================================================================================

	Truncate table	garland.GIS_Temp2	reuse storage;

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================

	insert --+  append
	into		garland.Temp_View2
	(
			this_node,
			roadid,
			that_node,
			fromto_IN,
			fromto_SET
	)
	select	f.X1 || f.Y1,
			r.RoadID,
			f.X2 || f.Y2,
			+1, 
			 0
	from		gis.Feature_Coordinates		F,
			gis.ROAD				R
	where		r.roadid = f.featureid
	and		f.featureclass = 'ROAD'

	UNION

	select	f.X2 || f.Y2,
			r.RoadID,
			f.X1 || f.Y1,
			-1, 
			 0
	from		gis.Feature_Coordinates		F,
			gis.ROAD				R
	where		r.roadid = f.featureid
	and		f.featureclass = 'ROAD'
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

--	===========================================================================================

	analyze table garland.GIS_Temp2  compute statistics;

--	===========================================================================================


