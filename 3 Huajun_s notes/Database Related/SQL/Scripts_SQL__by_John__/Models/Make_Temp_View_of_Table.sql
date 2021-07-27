	set echo		off;
	set charwidth	100;

--	============================================================================
--	define view on temporary table to hold columns copied from any GIS table
--	============================================================================

--	============================================================================
--	specify source, target, view 

	truncate table	garland.gis_objects	reuse storage;

	insert into garland.gis_objects (item01, item02, item03)	values
(
	'UTWATPIP',				--	source = GIS table to be copied
	'GIS_TEMP1',			--	target = temporary table to hold the copy
	'UTWATPIP_TEMP'			--	view   = temporary view name
);
	commit;


--	============================================================================
--	make view definition

	select '     ' ||	
		'create or replace view  garland.'	||  item03 ||
		chr(10) || '(' 
		" "	from garland.gis_objects

	union all	select '     ' || string
	from
(
		select
		decode (column_id, 1, ' ', ',')  || column_name		string
		from	cols,
			garland.gis_objects
		where	table_name = item01
		order by	column_id
)

	union all	select ')'		|| chr(10) ||
		'     as  select' 
		from dual

	union all	select '     ' || string
	from
(		select
		decode (column_id, 1, ' ', ',') || 'ITEM' || lpad(column_id, 2, '0')	string
		from	cols,
			garland.gis_objects
		where	table_name = item01
		order by	column_id
)

	union all	select  '     ' ||
		'from garland.' || item02 ||
		';' || chr(10)
		from garland.gis_objects;


--	============================================================================
	set echo	on;
	set charwidth;

