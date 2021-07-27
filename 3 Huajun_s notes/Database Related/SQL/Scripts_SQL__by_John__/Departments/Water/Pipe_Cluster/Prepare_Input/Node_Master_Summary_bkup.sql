--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	================================================================
--	NODE MASTER EXTRACT REPORT
--	Considers:
--		WATER_PIPE & WATER_VALVE
--		FEATURE_COORDINATES for 'WTPI' & 'WTVA'
--		VIEW_NODE_MASTER
--	================================================================

	select count(*) NODE_MASTER	from garland.view_Node_Master;

	select count(distinct pipe_id)  NODE_PIPES  from garland.view_Node_Master;
	select count(*) WTPI	from gis.feature_coordinates where featureclass = 'WTPI';   
	select count(*) PIPE	from gis.water_PIPE;		

	select count(distinct valve_id) NODE_VALVES from garland.view_Node_Master;
	select count(*) WTVA	from gis.feature_coordinates where featureclass = 'WTVA';   
	select count(*) VALVE	from gis.water_VALVE;			

--	========================================================================================

	select sum(dupes) pipe_extract_dupes from 
	(
	select featureid pipe_extract, count(*) dupes
	from gis.feature_coordinates 
	where featureclass = 'WTPI'
	group by featureid
	having count(*) > 1
	);

	select sum(dupes) valve_extract_dupes from 
	(
	select featureid valve, count(*) dupes
	from gis.feature_coordinates 
	where featureclass = 'WTVA'
	group by featureid
	having count(*) > 1
	);

--	========================================================================================
	
	select count(*) lost_pipes from 
	(
	select feature_id lost_valve from gis.water_pipe
	minus
	select featureid from gis.feature_coordinates where featureclass = 'WTPI'
	);

	select count(*) lost_pipe_extracts from 
	(
	select featureid lost_valve_extract from gis.feature_coordinates where featureclass = 'WTPI'
	minus
	select pipe_id + 0  from garland.view_node_master
	);

--	========================================================================================

	select count(*) lost_valves from 
	(
	select feature_id lost_valve from gis.water_valve
	minus
	select featureid from gis.feature_coordinates where featureclass = 'WTVA'
	);

	select count(*) lost_valve_extracts from 
	(
	select featureid lost_valve_extract from gis.feature_coordinates where featureclass = 'WTVA'
	minus
	select valve_id + 0  from garland.view_node_master
	);

--	========================================================================================

	select counter "Pipes/Node", count(*) total from 
	(
	select node_id, count(*) counter
	from garland.view_node_master	group by node_id
	) group by counter;

--	================================================================
