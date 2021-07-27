--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
-- set pagesize	74;
-- set pagesize	57;
-- alter session set nls_date_format = 'yyyymmdd hh24:mi:ss';  
--	=====================================================================

	select '*** Start adrAlias ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;

--	==================================================================================
--	rebuild adrAlias table

	@c:\deacutis\scripts\address_resolve\tables\adrAlias\bld_adrAlias.sql;	

	@c:\deacutis\scripts\address_resolve\tables\adrAlias\bld_adrAlias_Insert.sql;

	@c:\deacutis\scripts\address_resolve\tables\adrAlias\bld_adrAlias_Transpose.sql;

--	@c:\deacutis\scripts\address_resolve\tables\adrAlias\bld_adrAlias_Rhyme.sql;

	@c:\deacutis\scripts\address_resolve\tables\adrAlias\bld_adrAlias_Abbreviate.sql;

	@c:\deacutis\scripts\address_resolve\tables\adrAlias\bld_adrAlias_Compress.sql;

--	@c:\deacutis\scripts\address_resolve\tables\adrAlias\Mark_Alias_for_Fuzzy.sql;

--	=================================================================================================
	select 'ALTERATIONS'	" "	from dual;

	delete from garland.adrAlien	where alias_how <= '9';
	delete from garland.adrAlias	where alias_how <= '9';
	delete from garland.adrAlias	where upper(alias_how)  in ('A', 'B', 'C');
	commit;

	set echo	on;

	@c:\deacutis\scripts\address_resolve\Alteration\COMMON_UMS\Insert_Alias_ABC.sql

	@c:\deacutis\scripts\address_resolve\Alteration\COMMON_UMS\Insert_Alias_NonAdr.sql

	@c:\deacutis\scripts\address_resolve\Alteration\COMMON_UMS\Insert_Alias_NonGar.sql

	@c:\deacutis\scripts\address_resolve\Alteration\COMMON_UMS\Insert_Alias_New.sql

	set echo	off;

	@c:\deacutis\scripts\address_resolve\tables\adrAlias\bld_adrAlias_Compress.sql;

--	=================================================================================================

--	==================================================================================
--	adrAlias summary

	select alias_how method, alias_weight weight, count(*) total
	from	 garland.adrAlias
	group by alias_how, alias_weight;

	select rpad(alias_weight,6) weight, alias_how method, count(*) total
	from	 garland.adrAlias
	group by alias_weight, alias_how;


	select count(*) "Alien"  from garland.adrAlien;

	select count(*) "Alias"  from garland.adrAlias;

	select count(*) "Added"  from garland.adrAlias where alias_how < 'a';

--	==================================================================================

	select '*** Finish adrAlias ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;

