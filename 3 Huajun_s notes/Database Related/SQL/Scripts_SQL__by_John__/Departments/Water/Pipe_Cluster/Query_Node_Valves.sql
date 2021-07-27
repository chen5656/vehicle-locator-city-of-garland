	set echo off;

--	what Node IDs have multiple Valve IDs

	select rpad(node_id,		08)	node_id, 
		 rpad(min(valve_id),	08)	valve1, 
		 rpad(max(valve_id),	08)	valve2
	from	 garland.view_valve_master
	group by node_id
	having count(distinct valve_id) > 1
	order by 1;