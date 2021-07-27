	set echo off;
--	============================================================================================

	variable	 tablename	varchar2(30);
	execute	:tablename := 'PAVE_MAST';

--	============================================================================================

	select '  select '''	||:tablename|| '''' " " from dual
	union all


	select 
		'  ||'',''|| '		||
		column_name
	from	all_tab_columns
	where	owner = 'GARLAND'
	and	table_name = :tablename

	union all
	select '  from garland.' ||:tablename|| ';'	from dual
	;

--	============================================================================================


