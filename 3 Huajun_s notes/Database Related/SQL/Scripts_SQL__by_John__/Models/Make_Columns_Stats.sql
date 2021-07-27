
--	obtain table column statistics from data dictionary
--	display all statistics in a single line

--	INSTRUCTION:  specify table name where upper case name appears

--	=============================================================================================

	set echo off;
	set charwidth	200;

	variable spec_table varchar2;
	execute :spec_table := 		'CDRELADR'		;

--	=============================================================================================

	select	'set echo off;'		from dual
	union all

--	=============================================================================================
--	=============================================================================================

	select	'select'			from dual
	union all


	select
			'rpad (count (ltrim ('   || column_name || ', '' 0'')), 12)   '	|| column_name || ',  '	||

			'rpad (min (' || column_name || '), 12)   '  || ' "minimum",   '	|| 
			'rpad (max (' || column_name || '), 12)   '  || ' "maximium",  '	 
	from		cols
	where 	table_name = :spec_table

	union all
	select	''' '''					from dual

	union all
	select	'from ' || :spec_table || ';'		from dual

	union all
	select	' '						from dual


--	=============================================================================================

	union all
	select	'set echo on;'		from dual;

--	=============================================================================================

	set charwidth	80;

	set echo on;




