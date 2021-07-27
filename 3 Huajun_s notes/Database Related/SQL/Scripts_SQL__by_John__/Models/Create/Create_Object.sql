
--	================================================
--	define table specs for table group
--	obtain table group names to be created

--	call routine to create table, index, constraint, or reference
--	================================================

	set echo 		off;
	set timing		on;
	set serveroutput	on;

--	========================================================================
--	look at current table & index statistics
/*	
	select rpad (segment_name,25),  segment_type, bytes, extents, owner, tablespace_name	
	from	dba_segments
	where	segment_name 	in (select remarks from plan_table)
	and 	owner			= 'GARLAND'
	and	tablespace_name	= 'GIS_DATA'  
	order by extents desc, segment_name;

	select rpad (segment_name,25),  segment_type, bytes, extents, owner, tablespace_name	
	from	dba_segments
	where	segment_name 	in (select  index_name	from ind 
							where table_name in (select remarks from plan_table) )
	and 	owner			= 'GARLAND'
	and	tablespace_name	= 'GISINDX'  
	order by extents desc, segment_name;
*/

--	========================================================================
/*
	create or replace view		tmp_view
		( key_,    schema_,      tablespace_,  initial_,     next_,       pctfree_, pctused_,   maxextents_, maxtrans_ )
	as
	select  remarks, object_owner, statement_id, object_type,  object_name, id,       parent_id,  position,    object_instance
	from	  plan_table;			 
*/
--	========================================================================
--	========================================================================

	truncate table	plan_table;

	insert into 	tmp_view	
	(   key_,		schema_,	  tablespace_,   initial_,      next_,        pctfree_,  pctused_,   maxextents_,  maxtrans_	) 
	values
	(  'TABLE SPECS', 'GARLAND',   'GIS_DATA',    '500K',        '500K',       10, 	  40,         249,	    255		);

	insert into 	tmp_view	
	values
	(  'FROM SCHEMA', 'GARLAND',     null, null, null, null, null, null, null );

	insert into		tmp_view	(key_)	
		select	segment_name		
		from   	user_segments
		where		segment_type = 'TABLE'

--		and	segment_name	like 'HY%'

--		and	segment_name	in ( 'AE', 'EHSWTPET',			' ')

--		and	bytes			between 1000000	and 5999999	


		and	segment_name in
(
'MGSM_DYN_OX_CONFIG',            
'MGSM_LABEL',                    
'MGSM_LABELX',                   
'MGSM_LIST_DOMAIN',              
'MGSM_MATERIAL',                 
'MGSM_RANGE_DOMAIN',             
'MGSM_SEG_LINE',                 
'MGSM_SEG_PT',                   
'MGSM_SEG_PT2',                  

' ' )
;  

	commit;


--	================================================

	@c:\deacutis\scripts\models\redefine\create_table.sql;		--	create table as select\

--	@c:\deacutis\scripts\models\redefines\create_index.sql;		--	create index

--	@c:\deacutis\scripts\models\redefines\create_constraint.sql;	--	create constraint

--	@c:\deacutis\scripts\models\redefine\create_foreign.sql;		--	create foreign key

--	================================================
--	drop view 	tmp_view;
--	================================================
