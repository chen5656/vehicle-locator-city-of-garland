

	select distinct
		 'analyze table ' || table_name || ' compute statistics;'		" "

	from 		cols

	where		last_analyzed is null
--	where		nvl (last_analyzed, sysdate - 0 )	< sysdate - 100 

	and		table_name in
(
	select 	table_name from tabs
	minus
	select	view_name from user_views
);