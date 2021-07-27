	set echo		off;
	set charwidth	100;
--	=========================================================================

	select  '	truncate table  garland.' || item02  || '_BKUP  reuse storage;'	" "
	from	gis_objects;	


--	=========================================================================

	select '	insert --+ append ' 					||chr(10)|| 
		 '	into garland.' || item02 || '_BKUP'			||chr(10)||
		 '	select * from garland.'  ||  item02		|| ';'||chr(10)	" "

	from		garland.gis_objects


	union all
	select	'	commit;'							||chr(10)||
			'	alter rollback segment rb1  offline;'		||chr(10)
			" "
	from		dual;


--	=========================================================================
	set echo		on;
	set charwidth;
