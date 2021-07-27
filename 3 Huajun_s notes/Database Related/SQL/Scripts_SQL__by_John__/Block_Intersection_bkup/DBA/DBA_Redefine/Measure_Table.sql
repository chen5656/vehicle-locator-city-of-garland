
	set echo off;


--	calculate the number of data bytes in specified tables


	select	'select ''' || table_name || ''' " ",  to_char (sum ('	" ",
			' -- ', table_name, '0001' seq	
	from		dba_tables
	where		(table_name, owner) in (select key_, schema_ from tmp_view )


	union all	
	select
	rpad 	(	nvl (rpad ( '+', sign ( column_id - 1) ), ' ') 	||	
		' nvl (vsize (' || column_name || '), 0)',	40)			" ",
		' -- ', table_name, rtrim(column_id + 1000) seq	
	from		dba_tab_columns
	where		(table_name, owner) in (select key_, schema_ from tmp_view )

	union all
	select	'), ''999,999,999'') " "    from ' || table_name		" ",
			' -- ', table_name, '9001' seq	
	from		dba_tables
	where		(table_name, owner) in (select key_, schema_ from tmp_view )

	union all
	select	';'						" ",
			' -- ', table_name, '9999' seq	
	from		dba_tables
	where		(table_name, owner) in (select key_, schema_ from tmp_view )

--	------------------------------------------------------------------------
	order by	table_name, seq;
--	------------------------------------------------------------------------
;
