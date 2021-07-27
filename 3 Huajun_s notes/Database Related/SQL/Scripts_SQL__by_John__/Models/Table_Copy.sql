	set echo	off;
--	===================================================================
--	copy one table to another table
--	===================================================================


	drop view		garland.temp_view;
	create view		garland.temp_view	
(
	key,
	user_name1,
	user_name2,
	table_prefix,
	table_suffix,
	first_comma,
	storage
)
	as select
	item01, item02, item03, item04, item05, item06, item07
	from	garland.gis_objects;

--	===================================================================
	
	truncate table	garland.gis_objects		reuse storage;

--	===================================================================

	insert into		garland.temp_view			values
	(	'REFORMAT', 
		'GARLAND',	'GARLAND',	'UT%',  '_BKUP',  ' ', 
		'Storage (Initial 1m Next 1m PctIncrease 0)'	
	);

--	===================================================================

	insert into		garland.temp_view	(key, user_name1)
	select	'column', column_name
	from		cols
	where		table_name = 'CDRELPAR'
	intersect
	select	'column', column_name
	from		cols
	where		table_name = 'CDRELPAR_COPY';

--	===================================================================

	insert into		garland.temp_view	
	(	key,
		first_comma,

		user_name1,
		user_name2,
		table_prefix,
		table_suffix
	)
	select	'COPY',
			01,			-- First Comma 

			t1.owner,
			t2.owner,
			t1.object_name, 
			t2.object_name
	from		dba_objects		t1,
			dba_objects		t2
	where		t2.object_name	like	t1.object_name ||'%'
	and		t2.object_name	<>	t1.object_name

	and		t1.object_name	like 'UT%'
	and		t2.object_name	like 'UT%'
	and		t2.object_name	like '%ATS1'
	;


--	===================================================================
--	===================================================================

--	explain plan	set statement_id = 'xxx'	for

	select	'	' || string	" "
	from
(
	select	v.table_prefix		tabname, 
			0				seq, 
			chr(10)			string
			from	dba_tables	t,
				temp_view	v
	where		v.key	= 'COPY'
	and		v.table_prefix = t.table_name
	and		v.user_name1   = t.owner

--	--------------------------------------------------------------------------------

	union	
	select	v.table_prefix tabname, 100000 seq, 
			'Insert /*+ append */ into table	' || owner ||'.'|| table_name 
			|| chr(10) || '	('		
			from	dba_tables		t,
				temp_view		v
			where	v.key	= 'COPY'
			and	v.table_prefix = t.table_name
			and	v.user_name1   = t.owner

	union
	select	table_prefix									tabname, 
			100000 + (100 * column_id) 							seq,	
			decode (column_id, first_comma, ' ', ',') || rpad(column_name,30) ||
			'			-- ' || rtrim(100000 + (100 * column_id))		string
	from
(
	select	v.table_prefix,
			column_name,
			column_id,
			v.user_name1,
			v.first_comma,
			' '

	from		dba_tab_columns	c,
			temp_view		v
	where		v.key	= 'COPY'
	and		v.table_prefix = c.table_name
	and		v.user_name1   = c.owner

	and		column_name not in 		
			( 'PROJECT_NAME' )			-- REMOVAL COLUMN NAMES
)

--	--------------------------------------------------------------------------------

	union	
	select	v.table_prefix tabname, 200000 seq, 
			')' || chr(10) || 'Select' 
			from	dba_tables		t,
				temp_view		v
			where	v.key	= 'COPY'
			and	v.table_prefix = t.table_name
			and	v.user_name1   = t.owner

	union
	select	table_prefix									tabname, 
			200000 + (100 * column_id) 							seq,
			decode (column_id, first_comma, ' ', ',') || rpad(column_name,30) ||
			'			-- ' || rtrim(200000 + (100 * column_id))		string
	from
(
	select	v.table_prefix,
			column_name,
			column_id,
			v.user_name1,
			v.first_comma,
			' '

	from		dba_tab_columns	c,
			temp_view		v
	where		v.key	= 'COPY'
	and		v.table_suffix = c.table_name
	and		v.user_name2   = c.owner

	and		column_name not in 		
			( 'PROJECT_NAME' )			-- REMOVAL COLUMN NAMES

)
--	--------------------------------------------------------------------------------


--	--------------------------------------------------------------------------------

	union
	select	v.table_prefix tabname, 900001 seq, 
			'from	' || v.user_name2 ||'.'|| v.table_suffix		
			from	dba_tables		t,
				temp_view		v
			where	v.key	= 'COPY'
			and	v.table_prefix = t.table_name
			and	v.user_name1   = t.owner

	union
	select	v.table_prefix tabname, 999999 seq, 
			';'
			from	dba_tables		t,
				temp_view		v
			where	v.key	= 'COPY'
			and	v.table_prefix = t.table_name
			and	v.user_name1   = t.owner
)

	order by	tabname, seq;

--	=========================================================================
	set echo	on;
