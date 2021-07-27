

	select	'	truncate table  garland.' || table_name || '     reuse storage;'
			" "
	from		tabs
	where		table_name like 'UT%';