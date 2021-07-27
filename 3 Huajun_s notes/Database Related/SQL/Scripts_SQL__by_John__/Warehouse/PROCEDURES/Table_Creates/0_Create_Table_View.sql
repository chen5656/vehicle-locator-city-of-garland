--	=====================================================================
set echo		off;
set linesize		2000;
set pagesize		999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

	create or replace view jdeacutis.Temp_View	as
	select x.*,
					'tablespace GIS_DATA  nologging'
		specs 
	from all_tab_columns	X
	where	table_name like	'CCS_%'
	and	owner =		'GARLAND';

--	=====================================================================

select TEXT " "	from	(

select distinct table_name, 01 seq, 
	'--drop   ' || decode(v.view_name, null, 'table', 'view') ||' '|| 
				nvl(v.owner,t.owner) || '.' || nvl(v.view_name,table_name) || ';'
	TEXT	
from	jdeacutis.Temp_View     T,
	all_views               V
where t.table_name = v.view_name (+)
and   t.owner = v.owner (+)

UNION ALL
select distinct table_name, 02 seq, 
	'  create ' || decode(v.view_name, null, 'table', 'view') ||' '|| 
				nvl(v.owner,t.owner) || '.' || nvl(v.view_name,table_name)
	TEXT	
from	jdeacutis.Temp_View     T,
	all_views               V
where t.table_name = v.view_name (+)
and   t.owner = v.owner (+)

UNION ALL
select table_name, 1000 + column_id seq,
	decode(column_id, 1,'  ', ' ,')			||

	rpad(column_name,30) ||'    '|| data_type		||

	decode (data_type, 'DATE',' ','LONG RAW',' ',  
				'(')					||

	decode (data_type,'DATE',null,'LONG RAW',null, 
				decode(data_precision, null,data_length, data_precision))	||	

	decode (data_type,'DATE',null,'LONG RAW',null, 
				decode(data_scale, null,null, ','||data_scale))			||	

	decode (data_type, 'DATE',' ','LONG RAW',' ',  
				')')						||

	decode (nullable, 'N', '  Not Null', null)

TEXT	from	jdeacutis.Temp_View

UNION ALL
select distinct table_name, 8000  seq, 	
	'  )  '|| specs
TEXT	from	jdeacutis.Temp_View

UNION ALL
select distinct table_name, 9000  seq, 	'  ;'
TEXT	from	jdeacutis.Temp_View
	)
order by table_name, seq;

--	=====================================================================