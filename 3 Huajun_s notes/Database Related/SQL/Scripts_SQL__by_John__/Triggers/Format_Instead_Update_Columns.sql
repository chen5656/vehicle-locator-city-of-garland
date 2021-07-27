	set echo	off;
--	================================================================================================
--	format column statements to be used in instead trigger update command
--	================================================================================================

--	================================================================================================

	select
	'		'	|| lower(column_name) || '		= :new.' || lower(column_name) ||','	" "
	from	cols
	where	table_name = 'CDRELSUBDV'		--	specify table name
	order by 	column_id;

--	================================================================================================
/*
	select
	'		'	|| lower(column_name) || '		= nvl(:new.' || lower(column_name) 
				||',	:old.'|| lower(column_name) ||'),'		" "
	from	cols
	where	table_name = 'CDRELSUBDV'		--	specify table name
	order by 	column_id;
*/
--	================================================================================================
	set echo	on;
