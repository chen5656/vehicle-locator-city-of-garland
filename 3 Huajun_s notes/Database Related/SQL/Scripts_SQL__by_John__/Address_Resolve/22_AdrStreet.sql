	set echo	off;
	set timing	off;
--	==================================================================================

	drop   synonym	garland.adrStreet_syn;
	create synonym	garland.adrStreet_syn	for garland.ADRSTREETS;

--	==================================================================================
--	rebuild adrStreets table

	select '*** build adrStreet ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

	@c:\deacutis\scripts\adrtable\bld_adrSTREETS.sql;		

--	==================================================================================
--	rebuild adrBlock table

	select '*** build adrBlock ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;
	@c:\deacutis\scripts\adrtable\bld_adrBLOCKS.sql;		

--	==================================================================================
--	rebuild adrAlias table

	select '*** build adrAlias ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

	@c:\deacutis\scripts\address_resolve\tables\adrAlias\adrAlias_Rebuild.sql;	

--	===========================================================================
/*
	select	'invalid adrAlias:		'	"INVALID",
		alias_how,
		alias_pfx, alias_name, alias_type, alias_sfx
	from	garland.adrAlias
	where	nvl(alias_pfx, ' ') = ' '
	or	nvl(alias_type,' ') = ' '	
	or	nvl(alias_sfx, ' ') = ' ';
*/	
--	==================================================================================
