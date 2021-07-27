	set echo off;
	set charwidth	200;
--	=============================================
/*
--	=============================================

--	show columns in table
--	show tables with column

	select table_name, column_name
	from	 all_tab_columns@umsrep.world

	where	 owner = 'SFG'

--	and	 table_name = 'UM00261T'

	and	 column_name like '%SERIAL%'

	order by 2	;


--	=============================================

--	show water residential

	select location_no, meter_serial_no, detail_cd, detail_tp	

	from	 sfg.um00261t@umsrep.world
	where	 detail_tp = 2
	and	 detail_cd = 'WRES'
	and	 rownum < 111
	;

--	does meter serial exist ?

	select count(meter_serial_no) from sfg.um00261t@umsrep.world;

	select meter_serial_no from sfg.um00261t@umsrep.world  
	where	meter_serial_no > '0'
	and	rownum < 11
	;


--	=============================================
*/
--	=============================================




/*
--	show columns in table



	select table_name 
--		 ,column_name

	from	 all_tab_columns@umsrep.world

	where	 owner = 'SFG'

--	and	 table_name = 'UM00261T'

	and	 column_name like '%SERIAL%'

--	order by 1
	;

*/



	select 
		'	select ' || column_name || ' "' || table_name || '" ' ||
		'  from sfg.' || table_name ||'@umsrep.world ' ||
				 '	where rownum < 22; '
	" "
	from
(
	select distinct table_name, column_name, last_analyzed 
	from	 all_tab_Columns@umsrep.world
	where	 owner = 'SFG'
	and	 column_name like '%SERIAL%'
)	;



--	======================================================================================
	set charwidth;
	set echo on;
