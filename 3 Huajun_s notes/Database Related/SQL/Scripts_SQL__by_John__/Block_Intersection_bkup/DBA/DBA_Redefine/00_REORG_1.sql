	set echo	off;
	set timing	off;
	spool		off;

--	=====================================================================================================
--	DEFINE RE-ORG


	@c:\deacutis\scripts\ora_create\09_SUMMARY.sql;		--	display data dictionary info


	@c:\deacutis\scripts\ora_create\02_SCRIPTS.sql;		--	generate re-org scripts


--	=====================================================================================================
--	Optional:  Remove '__ rows selected' from each Script_   (prevents harmless but confusing error messages)
--	==========================================================================================================
