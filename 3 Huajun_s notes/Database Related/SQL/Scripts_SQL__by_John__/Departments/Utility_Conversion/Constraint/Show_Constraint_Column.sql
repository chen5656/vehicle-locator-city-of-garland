	set echo	off;
--	======================================================================
--	display table name & object abbreviation in utility tables
--	======================================================================

	select	table_name				||','||
			rtrim(substr(column_name, 01), '_ID')	
			" "

	from		cols

	where		table_name		like 'UT%'
	and		table_name not	in ( 'UTELETVT',	'UTSTOCOM', 'UTSTOCTY', 'UTSTOMDU' )
	and		table_name not	in ( 'UTWATPLG' )
	and		length(table_name) < 10

	and		column_name		like '%_ID'
	and		column_name not	like 'MAP%'
	and		column_name not	like '%NODE%'
	and		column_name not	like '%BASIN%'
	and		column_name not	like '%PARCEL%'
	;

	set echo	on;
