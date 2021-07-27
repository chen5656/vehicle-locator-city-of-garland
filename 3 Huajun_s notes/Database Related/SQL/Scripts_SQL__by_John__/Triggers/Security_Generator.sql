	set echo		off;
	set charwidth	800;
--	=========================================================================================
--	generate security triggers for table & user names found in table gis_objects
--	=========================================================================================

	select	text " "	from
(
--	-----------------------------------------------------------------------

	select	item03		table_id,
			0			seq,
			' '			text
	from	gis_objects		where	item01 = 'TRIGGER' and item02	= 'TABLE'

--	-----------------------------------------------------------------------

	union all
	select	item03 table_id,		01 seq,
	'create or replace trigger garland.' || item03 || '_Security'
	from	gis_objects		where	item01 = 'TRIGGER' and item02	= 'TABLE'

--	-----------------------------------------------------------------------

	union all
	select	item03 table_id,		02 seq,
	'before insert or update or delete	on garland.' || item03 || ' for each row'
	from	gis_objects		where	item01 = 'TRIGGER' and item02	= 'TABLE'

--	-----------------------------------------------------------------------

	union all
	select	item03 table_id,		03 seq,
	'declare user_terminal varchar2(40); table_id varchar2(40):= ''' || item03 || ''';'
	from	gis_objects		where	item01 = 'TRIGGER' and item02	= 'TABLE'

--	-----------------------------------------------------------------------

	union all
	select	item03 table_id,		04 seq,

	'begin' 											|| chr(10) ||
	'select lower(userenv(''TERMINAL'')) into user_terminal from dual;'	|| chr(10) ||

	'if	user_terminal like ''%jdeacuti''	'	|| chr(10) ||
	'or	user_terminal like ''%staplin''	'	|| chr(10) ||
	'or	user_terminal like ''%njones''	'	|| chr(10) ||
	'or	user_terminal like ''%fsouza''	'	|| chr(10) ||
	'or	user_terminal like ''%wlangley''	'	|| chr(10) ||
	'or	user_terminal like ''%enavarro''	'	|| chr(10) ||
	'or	user_terminal like ''%nstimely''	'

	from	gis_objects		where	item01 = 'TRIGGER' and item02	= 'TABLE'

--	-----------------------------------------------------------------------

	union all
	select	t.item03 table_id,	10 seq,

	'or	user_terminal like ''%' || lower(u.item03) || ''''

	from	gis_objects		t,
		gis_objects		u

	where	t.item01 =  u.item01
	and	t.item01 = 'TRIGGER' 	
	and	t.item02 = 'TABLE'
	and	u.item02 = 'USER'

--	-----------------------------------------------------------------------

	union all
	select	item03 table_id,		20 seq,
	'then	null;' || chr(10) ||	
	'else	raise_application_error (-20101, ''Update not executed on '' || table_id );  end if;'
	from	gis_objects		where	item01 = 'TRIGGER' and item02	= 'TABLE'

--	-----------------------------------------------------------------------

	union all
	select	item03 table_id,		90 seq,
	'end;' || chr(10)
	from	gis_objects		where	item01 = 'TRIGGER' and item02	= 'TABLE'

--	-----------------------------------------------------------------------
)
	order by	table_id, seq;

--	=========================================================================================

	set charwidth;
	set echo		on;
