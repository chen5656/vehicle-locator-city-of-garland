	set echo		off;
	set serveroutput	on	size 999999;;
	set charwidth	160;
	set fetchrows;

--	=========================================================
--	generate adrAlias Insert commands from current adrAlias
--	copy results to bld_adrAlias_insert.sql
--	=========================================================

	select 'delete from garland.adrAlias where alias_how < ''a'';' " "	from dual;


	select string " "		from
(
	select distinct
		 alias_how,
		 alias_name,

		'insert into garland.adrAlias_vw values '	||
		chr(10) || chr(09) ||

--	======================================================

		rpad (		

		'('''				||
		alias_pfx			||''', '	||

		rpad ( ''''			||	
		alias_name			||''','
		,23)				||' '''	||

		rpad ( 
		alias_type			||''','
		,06)				||' '''	||

		alias_sfx			||''','
		,42)				||

--	======================================================

		alias_lo			||','		||
		alias_hi			||', '	||
--		nvl(addr_min,0)		||', '	||

--	======================================================

		rpad (		
		''''				||
		addr_pfx			||''', '''	||

		rpad ( 
		addr_name			||''','
		,23)				||' '''	||

		rpad ( 
		addr_type			||''','
		,06)				||

		''''				||
		addr_sfx			||''','
		,42)				||

--	======================================================

		''''				||
		nvl(ltrim(rtrim(alias_how),'0123'),' ')		||
		''');'

		String
	from	garland.adrAlias
	where	alias_how < 'a'
);

--	======================================================
	
	select 'commit;' " " from dual;

	set echo		on;
	set serveroutput	off;
	set fetchrows;

