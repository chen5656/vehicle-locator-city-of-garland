	set echo 		off;
	set serveroutput	on;
	set charwidth	400;
--	=================================================================================
--	create script for ascii extract of oracle table

--	INSTRUCTIONS:
--	specify table name where upper case appears
--	specify file path  where upper case appears

--	=================================================================================

	@c:\deacutis\scripts\models\Make_ASCII_Table_Header.sql;

--	=================================================================================

	variable spec_table varchar2;
	execute :spec_table := 	'TEMP_VIEW'	;			-- CHANGE	<<<<<<<<<<<<<<

--	=================================================================================

	select '	set echo off;	' " ",			' -- ', 1 seq	from dual

	union all
	select '	set termout off; ' " ",				' -- ', 2 seq	from dual

	union all
	select '	spool  C:\DEACUTIS\EXTRACT\' 
 			|| :spec_table 		|| '.TXT' " ",	' -- ' " ", 3 seq	from dual	


	union all
	select	'   ', 						' -- ', 4 seq	from dual

--	==============================================

	union all
	select '	select ' || temp_function(:spec_table) || ' " " from dual', ' --', 10 seq  from dual

--	==============================================

	union all
	select	'	union all select ',			' -- ', 100 seq	from dual

	union all
	select	'	' || rpad (column_name, 25) 
			|| '  ||' || ''';''' || '||',			' -- ', 100 + column_id seq
	from		cols
	where		table_name = :spec_table

	union all
	select	'	'' ''',	 				' -- ', 1000 seq	from dual		-- <<<<<<<

	union all
	select	'	from	garland.' || :spec_table || ';', 	' -- ', 1001 seq	from dual		-- <<<<<<<

	union all
	select	' ',	 						' -- ', 1002 seq	from dual

--	==============================================

	union all
	select '	spool off; ',					' -- ', 9001 seq	from dual

	union all
	select '	set termout on;	',				' -- ', 9002 seq	from dual

	union all
	select '	set echo on;	',				' -- ', 9003 seq	from dual

	order by	seq
	;

--	==============================================

	set echo on;

--	==============================================
