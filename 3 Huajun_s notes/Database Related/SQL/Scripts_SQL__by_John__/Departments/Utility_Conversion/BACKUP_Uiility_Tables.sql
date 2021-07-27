	set echo off;
	set charwidth	400;
--	==========================================================================================================
--	rebuild table name cases
--	\\ scripts\departments\utility_conversion\Name\Build_Name_Cases	
--	==========================================================================================================

--	select 
--		' Truncate table jdeacutis.' || new_table || '  reuse storage;'				||chr(10)||
--		' Insert /*+ append */  into jdeacutis.' || new_table 					||chr(10)|| 
--		' select * from garland.'	|| new_table	||';'						||chr(10)
--	" "	from	 garland.Temp_View;

--	==========================================================================================================

	select
		' Create table jdeacutis.' || new_table 	 || '_POST_MIGRATE'				||chr(10)||
		' TableSpace	GIS_Data		NoLogging		PctFree 5 '				||chr(10)||
		' As  select * from garland.' || new_table || ';' 						||chr(10)
	" "	from	 garland.Temp_View
	order by new_table;

--	==========================================================================================================
