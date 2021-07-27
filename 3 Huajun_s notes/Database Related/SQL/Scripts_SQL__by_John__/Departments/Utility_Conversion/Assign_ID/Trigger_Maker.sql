	set echo	off;
--	========================================================================

	drop synonym	garland.syn_user_table1;
	create synonym	garland.syn_user_table1	for garland.GIS_OBJECTS;	--  TEMPLATE

	drop synonym	garland.syn_user_table2;
	create synonym	garland.syn_user_table2	for garland.TEMP_VIEW1;		--  CASES

--	========================================================================

	@c:\deacutis\scripts\departments\Utility_Conversion\CLONE_MAKER.sql;

--	========================================================================

