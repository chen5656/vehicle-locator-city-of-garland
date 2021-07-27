
	set echo	off;

	select	rpad (' ', 70)	" "	from dual;

	select
			rpad (min (ix.table_name), 25)			table_name,
			rpad (ex.segment_name, 25)				index_name,
			to_char (sum (ex.bytes), '999,999,999') 		space,
			lpad (max  (ex.extent_id) + 01, 03)			extents

	from		user_extents		ex,
			user_indexes		ix
			
	where		ex.segment_type = 'INDEX'
	and		ex.segment_name = ix.index_name

	group by	segment_name

--	order by	space;
	order by	extents;

	set echo on;

