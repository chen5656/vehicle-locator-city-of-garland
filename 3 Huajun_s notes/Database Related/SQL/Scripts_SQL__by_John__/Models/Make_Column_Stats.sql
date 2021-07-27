--	obtain statistics for table columns
--	display each statistic on a separate line

--	INSTRUCTION:  specify table name where upper case name appears

--	=============================================================================================

	set echo off;
	set charwidth	300;

	variable spec_table varchar2;
	execute :spec_table := 		'CDRELADR'		;

--	=============================================================================================

	select	'set echo off;'		from dual
	union all

--	=============================================================================================
--	=============================================================================================

	select	'select  '				||
			'''' || :spec_table || ''''							|| ' "table"'  || ', '  ||
			'rpad (count(*), 20)'								|| ' "total"'  || '  '	||
			'from ' || :spec_table || ';'


	from		dual


	union all
	select	'select  '				||
			'rpad (''' || column_name || ''', 20) '					|| ' "column"'  || ', '	||
			'rpad (count (ltrim ('    || column_name || ', '' 0'')), 08) '	|| ' "exist"'   || ', '	||
			'rpad (min (' ||  column_name || '), 20) '  				|| ' "minimum"' || ', '	||	
			'rpad (max (' ||  column_name || '), 20) '  				|| ' "maximum"' || ' '	||

			'from ' || :spec_table || ';'


	from		cols
	where 	table_name = :spec_table


--	=============================================================================================

	union all
	select	'set echo on;'		from dual;

--	=============================================================================================

	set charwidth	80;

	set echo on;








