	set echo	off;

	select '	drop trigger  garland.' || table_name || '_Security;'	" "
	from		tabs

	where	table_name like 'UT%';		-- filter

	set echo	on;
