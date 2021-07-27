
	set echo	off;
	set timing	on;

--	DEFINE RE-ORG

--	=====================================================================================================

--	do preparations described in 01_SPECS

--	do preparations described in 02_SCRIPTS

--	=====================================================================================================


	@c:\deacutis\scripts\ora_create\01_SPECS.sql;		--	specify job controls


	@c:\deacutis\scripts\ora_create\09_SUMMARY.sql;		--	display data dictionary info

	
	set charwidth 100;

	@c:\deacutis\scripts\ora_create\02_SCRIPTS.sql;		--	generate re-org scripts


--	=====================================================================================================

--	optional:  Remove '__ rows selected' from Script_ to prevent harmless but confusing error messages

--	=====================================================================================================

	set echo 	on;
	set timing 	off;

