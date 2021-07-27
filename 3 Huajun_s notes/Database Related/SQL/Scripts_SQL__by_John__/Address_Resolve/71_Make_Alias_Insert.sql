
	set echo		off;
	set timing		off;
	set charwidth	200;

--	==============================================================================
--	generate adrAlias insert command file from current adrAlias table
--	==============================================================================

	spool		c:\deacutis\scripts\address_resolve\alterations\Insert_Alias.sql;

	select	string " "		from
(
	select	
			alias_how,
			alias_name,

			'insert into adrAlias_vw values ('	||

			rpad (
			rpad (
			'''' || alias_pfx	|| ''', '		||
			'''' || alias_name|| ''', '	,30)	||
			'''' || alias_type|| ''','		||
			'''' || alias_sfx	|| ''','	,42)	||

			'   '						||
			rpad (
				alias_lo	||','			||
				alias_hi	||','		,12)	||
--				addr_min	||','			||

			'   '						||
			rpad (
			rpad (
			'''' || addr_pfx	|| ''', '		||
			'''' || addr_name || ''', '	,30)	||
			'''' || addr_type || ''', '		||
			'''' || addr_sfx	|| ''', '	,42)	||

			'   '						||
			'''' || alias_how ||''''		||					
			');'			
			string

	from		garland.adrAlias
	where		alias_how < 'a'


	union all	select 'zzzz', 'zzzz', '/*'	from dual
)
	order by	alias_how, alias_name;

	
	select	'*/'	|| chr(10) || 'commit;' || chr(10) || '/*' " "	from dual;
	spool	off;
	
	set	echo	on;
	set	charwidth;
