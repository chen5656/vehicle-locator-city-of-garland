	set echo off;
--	==========================================================================
--	build standard case table for utility clones
--	==========================================================================
   

	truncate table	garland.gis_temp1		reuse storage;

	insert into		garland.gis_temp1		(item01, item02, item03, item04, item05)

	select	item01, 				--  table name		AAA	
			item03 || '_NUM',			--  object num		BBB
			item03 || '_ID',			--  object id		CCC
			item06,				--  object prefix		DDD
			item07				--  object suffix		EEE

	from		garland.gis_objects

	where		item03 > '0';
	
	commit;

--	==========================================================================
	set echo on;
