	set echo off;
--	=======================================================================
--	create reference table containing 
--		old ut table name
--		new ut table name
--		asbuilt column name (old ut table)
--	=======================================================================

	create or replace view		garland.temp_view1  
			(old_table, new_table,	column_name)
	as select	 item01,	item02,	item03	
	from		garland.gis_temp1;

--	=======================================================================

	truncate table	garland.gis_temp1   reuse storage;

	insert into garland.temp_view1

	select x.old_table, x.new_table, c.column_name
	from	 garland.temp_view	x,
		 cols				c
	where	 c.table_name	= x.old_table
	and	 c.column_name like '%BUILT%'
	;

--	=======================================================================

	select * from temp_view1;

--	=======================================================================
	set echo on;

	

