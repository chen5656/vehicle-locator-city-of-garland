	set echo	off;

--	===================================================
--	Get total bytes in GIS tables and indexes

--	740 MB
--	===================================================

	select	sum (bytes)
	from		user_segments
	where		segment_name 	in

(
	select table_name 	from tabs
	where	table_name not like 'EVT%'
	and	table_name not like 'SM%'
	and	table_name not like 'RI%'
	and	table_name not like 'XXX%'
	and	table_name not like 'POPCN%'

	union

	select index_name		from ind
	where	 table_name 	in
(
	select table_name 	from tabs
	where	table_name not like 'EVT%'
	and	table_name not like 'SM%'
	and	table_name not like 'RI%'
	and	table_name not like 'XXX%'
	and	table_name not like 'POPCN%'
)
);

--	===================================================
	set echo	off;
