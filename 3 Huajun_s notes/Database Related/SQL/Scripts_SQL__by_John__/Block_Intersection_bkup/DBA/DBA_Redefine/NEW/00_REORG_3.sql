
	set echo	off;
	set timing	off;


--	APPLY TABLE CHANGES

--	=====================================================================================================

	@c:\deacutis\scripts\ora_create\04_REDEFINE.sql;	--	drop old, rename new, & build indexes


	@c:\deacutis\scripts\ora_create\05_ANALYZE.sql;		--	analyze (compute) tables


	@c:\deacutis\scripts\ora_create\06_RECOMPILE.sql;	--	recompile invalidated objects


	@c:\deacutis\scripts\ora_create\09_SUMMARY.sql;		--	display data dictionary info

--	===================================================================================================

	set echo 	on;
	set timing 	off;


