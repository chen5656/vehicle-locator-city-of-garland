	set echo 		off;
	set charwidth	100;

--	=============================================================
--	Large Rollback Insert/Update
--	=============================================================

	alter rollback segment rb1	online;
	commit;
	set transaction use rollback segment rb1;

--	----------------------------------------------------------------------------------

--	----------------------------------------------------------------------------------

	Rollback;
	commit;
	alter rollback segment rb1	offline;

--	=============================================================

--	======================================================================================================

	select	'	truncate table garland.' || table_name || '	reuse storage;'
	" "
	from
	(select table_name from tabs where table_name like 'UT%' and table_name like '%OLD');


--	======================================================================================================

	select	'	insert /*+ append */  into garland.' || table_name || ' select * from garland.' ||
			replace (table_name, '_OLD')  || ';'
	" "
	from
	(select table_name from tabs where table_name like 'UT%' and table_name like '%OLD');

--	======================================================================================================
	set echo 		on;
	set charwidth;

