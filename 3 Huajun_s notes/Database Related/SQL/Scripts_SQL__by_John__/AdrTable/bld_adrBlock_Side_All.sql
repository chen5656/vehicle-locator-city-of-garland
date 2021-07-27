	set echo	off;
--	======================================================================

--	rebuild Block_Side table

	@c:\deacutis\scripts\adrTable\bld_adrBlock_Side.sql;

	@c:\deacutis\scripts\adrTable\bld_adrBlock_Side_Beat.sql;

	@c:\deacutis\scripts\adrTable\bld_adrBlock_Side_Dist.sql;

	@c:\deacutis\scripts\adrTable\bld_adrBlock_Side_Code.sql;

	@c:\deacutis\scripts\adrTable\bld_adrBlock_Side_Coun.sql;

	@c:\deacutis\scripts\adrTable\bld_adrBlock_Side_Fire.sql;

	@c:\deacutis\scripts\adrTable\bld_adrBlock_Side_Subdiv.sql;

	@c:\deacutis\scripts\adrTable\bld_adrBlock_Side_Zip.sql;

--	======================================================================
	set echo	on;
