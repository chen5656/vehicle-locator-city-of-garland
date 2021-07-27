	set echo	off;
	set timing	off;

--	==================================================================================
--	extend adrAlias table using adrAlter table

	select '*** build adrAlter ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;

	@c:\deacutis\scripts\address_resolve\62_Load_Alter.sql;	

	@c:\deacutis\scripts\address_resolve\63_Load_Alien_Alias.sql;	

	@c:\deacutis\scripts\address_resolve\tables\adrAlias\bld_adrAlias_Compress.sql;

--	==================================================================================
/*

--	show breakdown of garland.adrAlien by class
	select	alias_how			"ALIEN", 
			count(*) 		"     COUNT "
	from		garland.adrAlien
	group by	alias_how;


--	show breakdown of garland.adrAlias by class
	select	alias_how			"ALIAS", 
			count(*) 		"     COUNT "
	from		garland.adrAlias
	group by	alias_how;


--	how many records in adrAlias
	select 	count(*)			"ALIAS SIZE"	
	from 		garland.adrAlias;

--	how many records in adrAlien
	select 	count(*)			"ALIEN SIZE"	
	from 		garland.adrAlien;

--	how many manually added records in adrAlias
	select	count(*)			"ALTER"
	from		garland.adrAlias
	where		alias_how < 'A';

--	how many manually added records in adrAlias
	select	count(*)			"INSERT"
	from		garland.adrAlias
	where		alias_how between 'A' and 'Zzz';

*/
--	==================================================================================
/*

	alter rollback segment rb1	online;

--	rebuild AdrGap table

	select '*** build adrGap ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

--	@c:\deacutis\scripts\adrtable\bld_adrgap.sql;	


--	rebuild AdrPermute table

	select '*** build adrPermute ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

--	@c:\deacutis\scripts\adrtable\bld_adrpermute.sql;	

	alter rollback segment rb1	offline;

*/
--	============================================================================
