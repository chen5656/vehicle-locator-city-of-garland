
	set echo	off;
	set timing	on;

--	RE-ORG ALL TABLES SPECIFIED IN 01_SPECS

--	=====================================================================================================
--	follow preparations described in 01_SPECS
--	follow preparations described in 02_SCRIPTS
--	=====================================================================================================

	@c:\deacutis\scripts\ora_create\01_SPECS.sql;		--	specify job controls


	@c:\deacutis\scripts\ora_create\09_SUMMARY.sql;		--	display data dictionary info


	@c:\deacutis\scripts\ora_create\02_SCRIPTS.sql;		--	generate re-org scripts


--	optional:  Remove '__ rows selected' from Scripts_ to prevent harmless SQL error messages


--	=====================================================================================================

--	@c:\deacutis\scripts\ora_create\03_TABLES.sql;		--	create new table copies

--	=====================================================================================================
/*

	@c:\deacutis\scripts\ora_create\04_REDEFINE.sql;	--	drop old, rename new, & build indexes


	@c:\deacutis\scripts\ora_create\05_ANALYZE.sql;		--	analyze (compute) tables


	@c:\deacutis\scripts\ora_create\06_RECOMPILE.sql;	--	recompile invalidated objects


	@c:\deacutis\scripts\ora_create\09_SUMMARY.sql;		--	display data dictionary info

*/
--	===================================================================================================

	set echo 	on;
	set timing 	off;
