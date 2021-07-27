	set echo off;
	set charwidth	100;
--	====================================================================


	select '	insert into plan_table (object_owner, object_name) values (''SFG'',''' || table_name ||''');'
	" "	from

(

	select table_name from all_tab_columns@umsp.world
	where	column_name = 'LOCATION_NO'

	INTERSECT

	select table_name from all_tab_columns@umsp.world
	where column_name like '%SERIAL%'
);


--	====================================================================
	set charwidth;
	set echo on;
