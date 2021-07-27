	set echo	off;
--	-----------------------------------------------------------------------

	select	item03		table_id,
			0			seq,
			chr(10)		text
	from	gis_objects		where	item01 = 'TRIGGER' and item02	= 'TABLE'

--	-----------------------------------------------------------------------

	union all
	select	item03,	01,

	'create or replace trigger garland.' || item03 || chr(10)

	from	gis_objects		where	item01 = 'TRIGGER' and item02	= 'TABLE'

--	-----------------------------------------------------------------------

	union all
	select	item03,	02,

	'before insert or update or delete	on garland.' || item03 || 'for each row' || chr(10)

	from	gis_objects		where	item01 = 'TRIGGER' and item02	= 'TABLE'

--	-----------------------------------------------------------------------

	union all
	select	item03,	03,

	'declare  user_terminal varchar2(40); table_id varchar2(40):= ''' || item03 || ''';'

	from	gis_objects		where	item01 = 'TRIGGER' and item02	= 'TABLE'

--	-----------------------------------------------------------------------

	union all
	select	item03,	04,

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
	select	item03,	10,

	'or	user_terminal like ''%' || lower(item03) || ''''

	from	gis_objects		where	item01 = 'TRIGGER' and item02	= 'TABLE'

--	-----------------------------------------------------------------------

	union all
	select	item03,	20,

	'then	null;	else raise_application_error (-20101, ''Update not executed on '' || table_id );  end if;'

	from	dual

--	-----------------------------------------------------------------------

	union all
	select	item03,	99,

	'end;' || chr(10)

	from	dual;

--	-----------------------------------------------------------------------

	set echo	on;
