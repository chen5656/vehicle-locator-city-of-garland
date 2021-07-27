	set echo off;
	set charwidth	300;

	select rpad(' ',70) " " from dual;

--	==========================================================
--	is mscatalog.nextoff = max(mslink)
--	==========================================================

	select	'	set echo off;' || chr(10) " "	from dual
	union all


	select	distinct
		'	select distinct m.tablename, u.mslink, m.nextocc, ''         '' ' || 
						table_name							||chr(10)||
		'	from mscatalog m,	feature f, ' 						||chr(10)|| 
		'(	select max(mslink) mslink from ' || table_name || '  ) u'		||chr(10)||	
		'	where m.tablename = f.tablename '						||chr(10)||
		'	and	nvl(u.mslink(+) ,0) > 0 '  						||chr(10)||
		'	and   m.tablename = ''' || lower(table_name) || ''';'			||chr(10)	
			" "

	from		cols		c
	where		table_name like 'UT%'
	and		replace (table_name, '_') = table_name
	and		table_name <> 'UTWATMTR'

	and exists
(
	select 'x'
	from	 feature
	where	 tablename = lower(c.table_name)
)

	
	union all
	select	'	set echo on;' " "	from dual
	;

--	==========================================================

	select rpad(' ',70) " " from dual;
	set echo on;
	
