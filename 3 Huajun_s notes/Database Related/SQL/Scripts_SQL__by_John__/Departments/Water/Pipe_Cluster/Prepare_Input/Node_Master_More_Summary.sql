 --	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
--set serveroutput	on	size 99999;
--alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	================================================================

	select count(*)  water_valve
	from gis.water_valve; 

	select	count(distinct
			Node_ID		||
			Node_Type		||
			Valve_ID		)
	node_master
	from garland.view_Node_Master
	where node_type = 'V';

	select counter master_dupes, count(*) occurs	from
(
	select 	count(*)  counter	from
(
	select	distinct node_id, node_type, valve_id
	from	garland.view_Node_Master
	where	node_type = 'V'
)
	group by valve_id
	having count(*) > 1
)
	group by counter;

