	set echo off;
--	====================================================================
	create or replace view		garland.explain_TABLE			as

	select	distinct
		rpad(t.owner,	10)				"** TABLE **",
		rpad(t.table_name,20)				" ",
		to_char(t.num_rows,'99,999,999')		"       Rows",
		lpad(t.avg_row_len,6)				"AvgLen",
		lpad(t.empty_blocks,6)				" Empty",
		lpad(t.chain_cnt,6)				"Chains",

		lpad(t.pct_free, 4)				"Free",
		lpad(t.pct_used, 4)				"Used",

		to_char(s.extents,'9,999')				"Extent",
		to_char(t.blocks, '99,999')				" Blocks",

		to_char(floor(s.bytes/1000), '999,999') || 'K'			"    Bytes",
		to_char(floor(s.initial_extent/1000), '99,999')	||'K'		" Initial",
		to_char(floor(s.next_extent/1000),    '99,999') ||'K'		"    Next",

		rpad(t.iot_type, 3)				"IOT",
		rpad(t.tablespace_name,10)			"Tablespace"

	from		all_tables 			t,
			user_segments 		s,
			garland.plan_table	p

	where		p.object_name	= s.segment_name	(+)
--	and		p.object_owner	= s.owner		(+)	
	and		p.object_owner	= t.owner
	and    	p.object_name	= t.table_name;

--	====================================================================
	create or replace view		garland.explain_INDEX			as

	select	distinct
		rpad(i.table_owner,10)				"** TABLE **",
		rpad(i.table_name,20)				" ",
		rpad(i.index_name,25)				"** INDEX **",
		i.uniqueness					"Unique",
		to_char(i.distinct_keys,'999,999')		"Distinct",
--		lpad(i.avg_leaf_blocks_per_key,04)		"Leaf",
--		lpad(i.avg_data_blocks_per_key,04)		"Data",
		to_char(s.extents,'9,999')			"Extents",
		to_char(s.blocks, '999,999')			"  Blocks",

		to_char(floor(s.bytes/1000), '999,999') ||'K'		"Bytes",
		to_char(floor(s.initial_extent/1000), '99,999') ||'K'	" Initial",
		to_char(floor(s.next_extent/1000),    '99,999') ||'K'	"    Next",

		rpad(i.index_type,10)				"Type",
		rpad(i.tablespace_name,10)			"Tablespace"

	from		all_indexes 		i,
			user_segments 		s,
			garland.plan_table	p

	where		i.index_name	= s.segment_name	(+)
--	and		i.owner		= s.owner		(+)
	and		p.object_owner	= i.owner
	and   	p.object_name	= i.index_name
--	and		s.owner		= i.owner
--	and		s.segment_name	= i.index_name
	;

--	====================================================================
	create or replace view		garland.explain_INDEXED			as

	select *	from
(
	select	distinct
		rpad(i.table_owner,10)		"Owner",
		rpad(i.table_name, 20)		"Table",
		rpad(i.index_name, 25)		"                 ** INDEXED",
		lpad(i.column_position,03)	" ",
		rpad(i.column_name,25)		"COLUMN **",
		rpad(c.data_type,12)		"Type",
		rpad(c.nullable, 04)		"Null"

	from		all_ind_columns	 	i,
			all_tab_columns 		c,
			garland.plan_table	p

	where		i.index_owner	= p.object_owner	
	and		i.index_name	= p.object_name
	and		i.table_name	= c.table_name
	and		i.column_name	= c.column_name
)
	order by 1,2,3;

--	====================================================================
	create or replace view		garland.explain_CONSTRAINT		as

	select	distinct
		rpad(c.owner,	10)		"Table",
		rpad(c.table_name,20)		" ",
		rpad(c.constraint_name,25)	"** CONSTRAINT **",
		rpad(c.constraint_type,04)	"Type",
		c.r_constraint_name		"Reference",
		c.status				"Status",
		c.validated				"Validated",
		c.delete_rule			"Rule"

	from		all_constraints 		c,
			garland.plan_table	p

	where		p.object_owner	= c.owner
	and		p.object_name	= c.table_name
	and		c.constraint_type in  ('P', 'U', 'R');

--	====================================================================
	create or replace view		garland.explain_COLUMN			as

	select *	from
(
	select	distinct
		rpad(t.owner,		12)			"Owner",
		rpad(t.table_name,	20)			"Table",
		lpad(t.column_id,	03)				" ",
		rpad(t.column_name,	20)			"** COLUMN **",
		rpad(t.data_type,	10)				"Type",
		lpad(t.data_length,	04)			"Leng",
		lpad(t.data_scale,	05)			"Scale",
		to_char(t.avg_col_len, '99999')		"AvgLen",
		to_char(t.num_nulls,   '999,999') 
		||' '|| t.nullable 				"     Nulls",
		to_char(t.num_distinct,'999,999')	"Distinct"
--		to_char(t.density,     '9.9999') 	"Density"

	from		all_tab_columns 		t,
			garland.plan_table	p
	where		p.object_owner	= t.owner
	and    	p.object_name 	= t.table_name	
)
	order by 	1,2,3;


--	====================================================================
	create or replace view		garland.explain_ANALYZE			as

	select	' ' "   Table",  ' ' "   Date"	from dual
	union all 

	select	distinct
		rpad('-- ' || owner || '.'|| table_name, 35) || ' Comments ', 
		'   ' || comments
	from		all_tab_comments		c,
			garland.plan_table	p
	where		c.table_name	= p.object_name
	and		c.owner		= p.object_owner
	and		c.comments > ' '

	union all 
	select ' ', ' ' from dual
	union all 

	select	distinct
		rpad('-- '  || rpad(o.owner || '.' || o.object_name, 35) ||
		'           ' || o.object_type, 65),

		rpad('   Last DDL: ' || to_char(last_ddl_time,'Mon dd,yyyy'), 25)

	from		all_objects	 		o,
			garland.plan_table	p
	where		o.owner		= p.object_owner
	and		o.object_name	= p.object_name
	and		o.object_type	= 'TABLE'

	union all 
	select ' ', ' ' from dual
	union all 

	select	distinct
		rpad('   ANALYZE table  '			|| 
		rpad(t.owner || '.' || t.table_name, 40)	|| 
		' Compute Statistics; ', 80),		

		rpad('-- Last Run: ' || to_char(t.last_analyzed, 'Mon dd,yyyy'),24)	

	from		all_tables 			t,
			garland.plan_table	p
	where		p.object_owner	= t.owner
	and		p.object_name	= t.table_name
	;

--	====================================================================
	create or replace view		garland.explain_DEPENDENT		as

	select
		rpad(d.referenced_owner,10)	"Owner", 
		rpad(d.referenced_name, 25)	"Object", 
		rpad(referenced_type,15)	"Obj Type", 
		d.name				"Dependent", 
		d.type				"Dep Type"
	from	all_dependencies 		d, 	
		garland.plan_table	p
	where d.referenced_owner	= p.object_owner
	and	d.referenced_name 	= p.object_name

	union

	select
		rpad(s.table_owner,10)	"Owner",	
		rpad(s.table_name, 25)	"Object",	
		o.object_type 		"Type", 
		s.synonym_name	    	"Dependent",	
		'SYNONYM'  			"Type"

	from	all_synonyms 		s,
		all_objects			o,
		garland.plan_table	p

	where s.table_owner	= p.object_owner
	and	s.synonym_name 	= p.object_name
	and	s.table_name	= o.object_name
	and	p.object_owner	= o.owner

	order by 1,2,3,4;


--	====================================================================
	set echo on;

