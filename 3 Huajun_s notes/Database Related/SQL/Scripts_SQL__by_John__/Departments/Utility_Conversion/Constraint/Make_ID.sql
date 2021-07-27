	set echo		off;
	set charwidth	200;

--	===============================================================================

--	explain plan set statement_id = 'ID'  into garland.plan_table  for

	select

	'alter table  GARLAND.' || new_table 			||chr(10)||
	' add	constraint	'  || new_table  || '_ID'		||chr(10)||
	'	unique	(' || new_object || '_ID)'		||chr(10)||
	'using index '							||chr(10)||
	'tablespace	gisindx '						||chr(10)||
	'storage	(initial 50K  next 50K  pctincrease 0);'	||chr(10)

	" "
	from	temp_view;

--	===============================================================================
--	===============================================================================

	set echo		on;
	set charwidth;



