	set echo		off;
	set charwidth	200;
--	=============================================================
--	Save adrResult into application adrResult
--	=============================================================

	variable	 owner_name		varchar2(30);
	execute	:owner_name	:=	'GARLAND';		--	SPECIFY

--	=============================================================

	drop synonym	garland.syn_input_table;
	drop synonym	garland.syn_output_table;

	create synonym	garland.syn_input_table		for garland.adrResult;				--	CHANGE
	create synonym	garland.syn_output_table	for garland.adrResult_EXTRACT;		--	CHANGE

--	create synonym	garland.syn_input_table		for garland.adrResult_TAX_GDS;		--	CHANGE
--	create synonym	garland.syn_output_table	for garland.adrResult_Input;			--	CHANGE

--	=============================================================
--	table comments

	comment on table	garland.syn_output_table	is
	'VERIZON  JULY 2005';									--	CHANGE

--	=============================================================

	spool	c:\deacutis\scripts\EXECUTE.sql
	spool off
	spool	c:\deacutis\scripts\EXECUTE.sql

--	=============================================================

	select 
		'   TRUNCATE table	' || s.table_owner ||'.'|| s.table_name  || 
		'   reuse storage;' 									||chr(10)

	" "
	from  all_synonyms	s
	where	synonym_name  =	'SYN_OUTPUT_TABLE'
	and	owner = 		:owner_name

	union all

	select	'   insert /*+ append */	into ' || table_owner ||'.'|| table_name   " "
	from  all_synonyms	s
	where	synonym_name = 'SYN_OUTPUT_TABLE'
	and	owner = 		:owner_name

	union all
	select * from
(
	select	'   select all *		from ' || s.table_owner ||'.'|| s.table_name ||';'
	from  all_synonyms	s
	where	 s.synonym_name = 'SYN_INPUT_TABLE'
	and	owner = 		:owner_name

)

	union all
	select	chr(10) ||
		'   commit;  '							|| chr(10)
--		'   alter rollback segment rb1  offline;	  '		|| chr(10)
	from dual

	union all
	select	chr(10) ||
			'   select rpad(count(*),30) "' || table_name || '" from ' || 
				table_owner   ||'.'|| table_name ||';' ||chr(10)
			from  all_synonyms	s
			where	synonym_name = 'SYN_INPUT_TABLE'	
			and	owner = 		:owner_name

	union all
	select	'   select rpad(count(*),30) "' || table_name || '" from ' || 
				table_owner   ||'.'|| table_name ||';' ||chr(10)
			from  all_synonyms	s
			where	synonym_name = 'SYN_OUTPUT_TABLE'	
			and	owner = 		:owner_name

	union all
	select	'   analyze table   ' || s.table_owner ||'.'|| table_name || '	compute statistics;'
			from  all_synonyms	s
			where	synonym_name = 'SYN_OUTPUT_TABLE'	
			and	owner = 		:owner_name
	;

--	=============================================================

	spool	off;

	@c:\deacutis\scripts\EXECUTE.sql

--	=============================================================================

	select * from all_tab_comments  where table_name = 'ADRRESULT_EXTRACT';

--	=============================================================================
	set charwidth;
	set echo	on;


