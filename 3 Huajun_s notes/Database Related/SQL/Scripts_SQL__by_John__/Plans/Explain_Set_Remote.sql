	set echo off;
--	====================================================================
	create or replace view		garland.explain_table			as

	select	distinct
			rpad(t.table_name,20)				"** TABLE **",
			rpad(t.iot_type, 3)				"IOT",
			to_char(t.num_rows,'99,999,999')		"       Rows",
			lpad(t.avg_row_len,6)				"AvgLen",
			lpad(t.empty_blocks,6)				" Empty",
			lpad(t.avg_space,5)				" Free",
			lpad(t.chain_cnt,6)				"Chains",
			to_char(s.extents,'9,999')				"Extent",
			to_char(t.blocks, '99,999')				" Blocks",
			to_char(s.bytes, '999,999,999')		"       Bytes",
			to_char(s.initial_extent, '99,999,999')	"    Initial",
			to_char(s.next_extent,    '99,999,999')	"       Next",
			rpad(t.tablespace_name,10)			"Tablespace"

	from		syn_dba_tables		t,
			syn_dba_segments		s,
			syn_plan_table		p

	where		p.object_owner	= s.owner	
	and		p.object_name	= s.segment_name
	and		p.object_owner	= t.owner
	and    	p.object_name	= t.table_name;

--	====================================================================
	create or replace view		garland.explain_index			as

	select	distinct
			rpad(i.table_name,20)				"Table",
			rpad(i.index_name,25)				"** INDEX **",
			i.uniqueness					"Unique",
			to_char(i.distinct_keys,'999,999')		"Distinct",
--			lpad(i.avg_leaf_blocks_per_key,04)		"Leaf",
--			lpad(i.avg_data_blocks_per_key,04)		"Data",
			to_char(s.extents,'9,999')			"Extents",
			to_char(s.blocks, '999,999')			"  Blocks",
			to_char(s.bytes, '999,999,999')		"  Bytes",
			to_char(s.initial_extent, '99,999,999')	"    Initial",
			to_char(s.next_extent,    '99,999,999')	"       Next",
			rpad(i.index_type,10)				"Type",
			rpad(i.tablespace_name,10)			"Tablespace"

	from		syn_dba_indexes		i,
			syn_dba_segments		s,
			syn_plan_table		p

	where		i.owner		= s.owner
	and		i.index_name	= s.segment_name
	and		p.object_owner	= i.owner
	and   	p.object_name	= i.index_name
	and		s.owner		= i.owner
	and		s.segment_name	= i.index_name;

--	====================================================================
	create or replace view		garland.explain_indexed			as

	select *	from
(
	select	distinct
			rpad(i.table_name,25)		"Table",
			rpad(i.index_name,30)		"                 ** INDEXED",
			lpad(i.column_position,03)	" ",
			rpad(i.column_name,25)		"COLUMN **",
			rpad(c.data_type,12)		"Type"

	from		syn_dba_ind_columns	i,
			syn_dba_tab_columns	c,
			syn_plan_table		p

	where		i.index_owner	= p.object_owner	
	and		i.index_name	= p.object_name
	and		i.table_name	= c.table_name
	and		i.column_name	= c.column_name
)
	order by 1,2,3;

--	====================================================================
	create or replace view		garland.explain_constraint		as

	select	distinct
			rpad(c.table_name,20)		"Table",
			rpad(c.constraint_name,20)	"** CONSTRAINT **",
			rpad(c.constraint_type,04)	"Type",
			c.r_constraint_name		"Reference",
			c.status				"Status"

	from		syn_dba_constraints	c,
			syn_plan_table		p

	where		p.object_owner	= c.owner
	and		p.object_name	= c.table_name
	and		c.constraint_type in  ('P', 'U', 'R');

--	====================================================================
	create or replace view		garland.explain_analyze			as

	select	'	ANALYZE table  ' || t.owner || '.' || 
			rpad(t.table_name,20) || ' compute statistics; '		"Tablename",
			rpad('-- ' || to_char(t.last_analyzed, 'Mon dd,yyyy'),20)	"      Last_Analyzed"	
	from		syn_dba_tables		t,
			syn_plan_table		p
	where		p.object_owner	= t.owner
	and		p.object_name	= t.table_name

	union 

	select	'	ANALYZE table  ' || i.owner || '.' || 
			rpad(i.table_name,20) || ' compute statistics; ',
			rpad('-- ' || to_char(i.last_analyzed, 'Mon dd,yyyy'),20)
	from		syn_dba_indexes		i,
			syn_plan_table		p
	where		i.owner		= p.object_owner
	and		i.index_name	= p.object_name;

--	====================================================================
	create or replace view		garland.explain_column			as

	select *	from
(
	select	distinct
			rpad(t.owner,		12)			"Owner",
			rpad(t.table_name,	20)			"Table",
			lpad(t.column_id,	03)			" ",
			rpad(t.column_name,	20)			"** COLUMN **",
			rpad(t.data_type,	10)				"Type",
			lpad(t.data_length,	04)			"Leng",
			to_char(t.avg_col_len, '99999')		"AvgLen",
			to_char(t.num_nulls,   '999,999') 
			||' '|| t.nullable 				"     Nulls",
			to_char(t.num_distinct,'999,999')	"Distinct",
			to_char(t.density,     '9.9999') 	"Density"
	from		syn_dba_tab_columns	t,
			syn_plan_table		p
	where		p.object_owner	= t.owner
	and    	p.object_name 	= t.table_name	
)
	order by 	1,2,3;

--	====================================================================
	set echo on;
