	set echo		off;
	set charwidth	200;
--	===========================================================================
--	template to copy current table to re-designed table
--	===========================================================================

	variable	user1		varchar2(40);
	variable	user2		varchar2(40);

	execute	:user1	:= 'JDEACUTIS';
	execute	:user2	:= 'GARLAND';

--	===========================================================================

	select text " "	from

(
select	' '		text, 
		' '		table_name, 
		0		sequence	
from dual

union all
select	'select ''' || t.table_name || ''' " "  from dual;' ||chr(10),
		t.table_name, 10
from		tabs  t,	gis_objects  g
where		t.table_name = g.item01


union all	
select	'alter rollback segment rb1   online;'  			    ||chr(10)||
		'commit;'  								    ||chr(10)||
		'set transaction use rollback segment rb1;'  		    ||chr(10)||chr(10)||
		'	explain plan  set statement_id = ''' || t.table_name || ''' for '	|| chr(10),
												
		t.table_name,	20
from		tabs  t,	gis_objects  g
where		t.table_name = g.item01


union all
select	'insert into ' || :user2 ||'.'|| t.table_name || chr(10) || '(',
		t.table_name,	2000
from		tabs  t,	gis_objects  g
where		t.table_name = g.item01


union all	
select	decode (column_id, 01, '	 ',	'	,') || lower(column_name),
		table_name,	3000 + column_id
from		cols  t,	gis_objects  g
where		t.table_name = g.item01

union all
select	')' ||chr(10)|| 'select ',
		t.table_name,	4000
from		tabs  t,	gis_objects  g
where		t.table_name = g.item01


union all	
select	decode (column_id, 01, '	 ',	'	,') || lower(column_name),
		table_name,	5000 + column_id
from		cols  t,	gis_objects  g
where		t.table_name = g.item01


union all	
select	'from   ' || :user1 ||'.'|| t.table_name || ';'			||chr(10)
												||chr(10)||
		'commit;'  									||chr(10)||
		'alter rollback segment rb1   offline;'  				||chr(10)
												||chr(10)
												||chr(10)||
		'--	***************************************************'	||chr(10),		
		table_name,	9000 
from		tabs  t,	gis_objects  g
where		t.table_name = g.item01
)

	order by	table_name, sequence;

--	===========================================================================
	set echo		on;
	set charwidth;
