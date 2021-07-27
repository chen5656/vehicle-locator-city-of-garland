
	select '*** rebuild adrAlias ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;

--	==================================================================================
--	rebuild adrAlias table

	@c:\deacutis\scripts\address_resolve\tables\adrAlias\bld_adrAlias.sql;	

	@c:\deacutis\scripts\address_resolve\tables\adrAlias\bld_adrAlias_Insert.sql;

	@c:\deacutis\scripts\address_resolve\tables\adrAlias\bld_adrAlias_Transpose.sql;

	@c:\deacutis\scripts\address_resolve\tables\adrAlias\bld_adrAlias_Rhyme.sql;

	@c:\deacutis\scripts\address_resolve\tables\adrAlias\bld_adrAlias_Abbreviate.sql;

	@c:\deacutis\scripts\address_resolve\tables\adrAlias\bld_adrAlias_Compress.sql;

	@c:\deacutis\scripts\address_resolve\tables\adrAlias\Mark_Alias_for_Fuzzy.sql;

--	==================================================================================
--	adrAlias summary

	select alias_how method, alias_weight weight, count(*) total
	from	 garland.adrAlias
	group by alias_how, alias_weight;

	select rpad(alias_weight,6) weight, alias_how method, count(*) total
	from	 garland.adrAlias
	group by alias_weight, alias_how;


	select count(*) "Alien"  from garland.adrAlien;

	select count(*) "Alias"  from adrAlias;

	select count(*) "Added"  from adrAlias where alias_how < 'a';

--	==================================================================================

	select '*** built adrAlias ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;
