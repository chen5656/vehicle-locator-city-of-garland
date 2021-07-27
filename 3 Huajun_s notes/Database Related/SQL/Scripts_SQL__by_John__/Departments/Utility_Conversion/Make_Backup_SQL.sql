.	set echo		off;
	set charwidth	200;
--	============================================================================================

	select

			'	create table jdeacutis.' || table_name || '_BKUP'		||chr(10)||
			'	tablespace	gis_data'							||chr(10)||
			'	storage	(initial 100k  next 100k pctincrease 0)'		||chr(10)||
			'	as select * from garland.' || table_name || ';'			||chr(10)||
			' '	" "
	from		tabs
	where		table_name like 'UTSTO%'
	and		table_name not like '%BKUP'


	union all
	select
			'	drop table	 garland.' || table_name || '_BKUP;'		||chr(10)||
			' '	" "
	from		tabs
	where		table_name like 'UTSTO%'
	and		table_name not like '%BKUP'
;


--	============================================================================================
	set echo		on;
	set charwidth;

