--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
-- set pagesize	74;
-- set pagesize	57;
-- alter session set nls_date_format = 'yyyymmdd hh24:mi:ss';  
--	===============================================================================

--	===============================================================================
--	Look for missing RoadID in Source or Extract
--	===============================================================================

	select count(*) lost_road	from
(
	select roadid	from gis.ROAD
	minus
	select featureid	from gis.Feature_Coordinates
	where	featureclass = 'ROAD'
);

	select count(*)	lost_feature	from
(
	select featureid	from gis.Feature_Coordinates
	where	featureclass = 'ROAD'
	minus
	select roadid	from gis.ROAD
);

--	===============================================================================
--	Look for missing Road shape in ESRI extract

	select count(*) lost_shape	from
(
	select shape || ' 0'	from gis.Road
	minus
	select text 	from jdeacutis.External_View1
);


	select shape	from gis.ROAD
	minus
	select fid		from jdeacutis.road_ftable;

--	===============================================================================

	select streetname, streettype, streetprefix, streetsuffix, rangelo, 'R'
	from	gis.ROAD
	where	roadid in 
(
	select roadid	from gis.ROAD
	minus
	select featureid	from gis.Feature_Coordinates
	where	featureclass = 'ROAD'
);
	

--	===============================================================================
--	Find ROAD segments next to missing extract segments


--	=====================================================================
	truncate table	jdeacutis.plan_table	reuse storage;
	explain plan	set statement_id = ' '	into jdeacutis.plan_table for
--	=====================================================================

	select streetname, streettype, streetprefix, streetsuffix, rangehi, 'F'
	from	gis.ROAD			R,
		gis.Feature_Coordinates	F
	where	r.roadid = f.featureid
	and	(streetname, streettype, streetprefix, streetsuffix)	in
(
	select streetname, streettype, streetprefix, streetsuffix
	from	gis.Road
	where	roadid in
(
	select roadid	from gis.ROAD
	minus
	select featureid	from gis.Feature_Coordinates
	where	featureclass = 'ROAD'
)
);

--	=====================================================================
	select * from jdeacutis.explain_Plan;
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================


