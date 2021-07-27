--	=====================================================================
	select * from viewer.me;
	BEGIN  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  END;
set	TIMING		OFF;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	linesize		1000;
set	pagesize		0000;
--	execute jdeacutis.show_table_column	('', '', '');
--	execute jdeacutis.show_source		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_error		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_view		('', '', '');
--	execute jdeacutis.show_index_column	('', '', '');
--	SELECT  to_char(sysdate,'Mon dd,yyyy hh24:mi')||'  ***  ' " "  from dual;
--	EXECUTE jdeacutis.TEST_PROC;
--	CREATE or replace procedure jdeacutis.TEST_PROC  as
--	DECLARE
--	=====================================================================	
--	=====================================================================
set	sqlblanklines	on;
set	serveroutput	on	size 9999;
set	linesize		140;
set	pagesize		40;
--	alter session	set nls_date_format = 'yyyy-mm-dd hh24:mi';  
--	=====================================================================

--	=====================================================================
	truncate table	jdeacutis.plan_table	reuse storage;
	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================
--	=====================================================================
	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

--	=====================================================================
--	Spool & Execute

	spool off
	spool	c:\deacutis\sde\EXECUTE.sql
	spool off
	spool	c:\deacutis\sde\EXECUTE.sql
--	-------------------------------------------------------------------
--	-------------------------------------------------------------------
	spool off

--	@c:\deacutis\sde\EXECUTE.sql
--	=====================================================================


--	=====================================================================
--	=====================================================================
--	Describe Table

	select
		rpad(t.owner,			10)	owner,
		rpad(t.table_name,		30)	table_name,
		rpad(x.column_position,		08)	indexed,
		rpad(t.column_name,		30)	column_name,
		rpad(t.data_type,			10)	data_type,
		lpad(t.data_length,		08)	data_len,
		lpad(t.data_precision,		09)	precision,
		lpad(t.data_scale,		05)	scale,
		lpad(t.nullable,			04)	nulls
	from	all_tab_columns	T,
		all_ind_columns	X
	where	t.owner		= x.index_owner	(+)
	and	t.table_name	= x.table_name	(+)
	and	t.column_name	= x.column_name	(+)
	and	t.owner	like	'%'
	and	t.table_name in ( '' )
	order by t.owner, t.table_name, t.column_id;

--	=====================================================================
--	Describe Index

	select rpad(index_owner,     	20)	owner,
		 rpad(table_name, 	30)	table_name, 
		 rpad(index_name, 	30)	index_name, 
		 rpad(column_name,	30)	column_name   
	from	all_IND_columns
	where table_name = 	upper	('')
	and	table_owner like	upper	('%')
	order by index_owner, table_name, column_position;

--	=====================================================================
--	show Error

	variable ownername	varchar2(40);
	variable procname		varchar2(40);
	execute :ownername := 'GARLAND';
--	execute :ownername := 'JDEACUTIS';
	execute :procname  := '';

	select 	rpad (name,24)			"object name",
			type					"object type",
			lpad (line,04)			"line",
			text					"text 1",	 
			substr(text, 081, 80)		"text 2" 
	from 		all_ERRORS
	where		name  like upper(:procname)
	and		owner like :ownername
	;

--	----------------------------------------------------------------------
--	show Procedure

	variable ownername	varchar2(40);
	variable procname		varchar2(40);
--	execute :ownername := 'GARLAND';
	execute :ownername := 'JDEACUTIS';
	execute :procname  := '';

	select 
		lpad(line,6) ||'  '|| 
		text   " "
	from	all_SOURCE
	where upper(name)	like :procname
	and upper (owner) like :ownername
	and upper(type) in    ( 'PROCEDURE', 'FUNCTION', 'PACKAGE BODY' )
--	and upper(type) in    ( 'PACKAGE' )
	Order by line;


--	=====================================================================
--	=====================================================================
--	CREATE TABLE
/*
	create or replace view jdeacutis.Temp_View	as
	select T.*,
		'tablespace SDE_DATA  nologging'		specs 
	from	all_tab_columns	T
	where	table_name	like	''
	and	owner 	like '%'
	;
*/

	create or replace view jdeacutis.Temp_View	as
	select x.*,
		'tablespace SDE_DATA  nologging'		specs 
	from	all_tab_columns		X,
		sde.SHOWTABLE		T
	where x.table_name = t.table_name
	and	t.table_name like	upper('')
	and	t.dataset	 like	upper('%')
	and	t.owner 	 like upper('%')
	;

--	=====================================================================

--	create or replace view jdeacutis.Temp_View1	as

select TEXT " "	from	(
select distinct table_name, 01 seq, 
	'--drop   ' || decode(v.view_name, null, 'table', 'view') ||' '|| 
			upper(nvl(v.owner,t.owner)) || '.' || upper(nvl(v.view_name,table_name)) || ';'
	TEXT	
from	jdeacutis.Temp_View     T,
	all_views       V
where t.table_name = v.view_name (+)
and   t.owner = v.owner (+)
UNION ALL
select distinct table_name, 02 seq, 
	'  create ' || decode(v.view_name, null, 'table', 'view') ||' '|| 
				nvl(v.owner,t.owner) || '.' || nvl(v.view_name,table_name) || ' ('
	TEXT	
from	jdeacutis.Temp_View     T,
	all_views       V
where t.table_name = v.view_name (+)
and   t.owner = v.owner (+)
UNION ALL
select table_name, 1000 + column_id seq,
	lower(
	decode(column_id, 1,'  ', ' ,')			||
	rpad(column_name,30) ||'    '|| data_type		||
	decode (data_type, 'DATE',' ','LONG RAW',' ',  
				'(')					||
	decode (data_type,'DATE',null,'LONG RAW',null, 
				decode(data_precision, null,data_length, data_precision))	||	
	decode (data_type,'DATE',null,'LONG RAW',null, 
				decode(data_scale, null,null, ','||data_scale))			||	
	decode (data_type, 'DATE',' ','LONG RAW',' ',  
				')')					||
	decode (nullable, 'N', '  Not Null', null)
	)
TEXT	from	jdeacutis.Temp_View
UNION ALL
select distinct table_name, 8000  seq, 	
	lower(
	'  )  '|| specs
	)
TEXT	from	jdeacutis.Temp_View
UNION ALL
select distinct table_name, 9000  seq, 	'  ;'
TEXT	from	jdeacutis.Temp_View
	)
order by table_name, seq;

--	=====================================================================

 
