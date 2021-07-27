
--	make "create table as select" command
--	Define_Table.sql + "Select As" clause

--	========================================================================
	set echo 		off;
	set timing		on;
	set serveroutput	on;
--	=========================================================================================================
--	=========================================================================================================

select 	'create table   ' || schema_ || '.' || table_name		" ",
		' -- ' " ", table_name, 01 seq
from 		dba_tables,
		tmp_view	vw
where		table_name 	in (select key_ from tmp_view )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner

--	------------------------------------------------------------------------

union all
select 	'(',	
		' -- ' " ", table_name, 02 seq
from 		dba_tables,
		tmp_view	vw
where		table_name 	in (select key_ from tmp_view )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner

--	------------------------------------------------------------------------

union all
select

rpad 	(	nvl (rpad ( ',', sign ( column_id - 1) ), ' ') 	||	

		rpad (column_name, 25) || rpad (data_type, 08)  ||

decode  (	data_type,	

		upper ('number'),		' (' || least (data_length, nvl (data_precision, 9999)) || 	
						decode ( nvl (data_scale, 0), 
							   0, ')',	',' ||  data_scale || ')'  ),	


		upper ('varchar2'),	' (' || data_length || ')',
		upper ('char'),		' (' || data_length || ')',
		upper ('float'),		' (' || least (data_length, nvl (data_precision, 9999)),	
		upper ('raw'),		' (' || data_length || ')',

	  	null	)	||													

		decode  (nullable, upper ('n'), '  not null', null)		


,60)		" ",
		' -- ' " ", table_name, 1000 + column_id  seq

from		dba_tab_columns,
		tmp_view	vw
where		table_name 	in (select key_ from tmp_view )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner

--	------------------------------------------------------------------------

union all
select 	')',	
		' -- ' " ", table_name, 1999 seq
from 		dba_tables,
		tmp_view	vw
where		table_name 	in (select key_ from tmp_view )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner



--	------------------------------------------------------------------------
--	------------------------------------------------------------------------
--	------------------------------------------------------------------------
/*

union all
select 	'tablespace ' || tablespace_ || '   pctfree ' || pctfree_ || '  pctused ' || pctused_ || '      initrans 1    maxtrans ' || maxtrans_,
		' -- ' " ", table_name, 9001 seq
from 		dba_tables,
		tmp_view	vw
where		table_name 	in (select key_ from tmp_view )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner

--	------------------------------------------------------------------------

union all
select	'storage (initial ' || initial_ || '  next ' || next_ || '  pctincrease 0   minextents 1  maxextents ' || maxextents_,
		' -- ' " ", table_name, 9002 seq
from 		dba_tables,
		tmp_view	vw
where		table_name 	in (select key_ from tmp_view )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner

--	------------------------------------------------------------------------

union all
select	'         ' || 'freelists 1   freelist groups 1' || ')',
		' -- ' " ", table_name, 9003 seq
from 		dba_tables,
		tmp_view	vw
where		table_name 	in (select key_ from tmp_view )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner
		
--	------------------------------------------------------------------------
--	------------------------------------------------------------------------

union all
select	'as select * from ' || schema_ || '.' || table_name,

		' -- ' " ", table_name, 9901 seq
from 		dba_tables,
		tmp_view	vw
where		table_name 	in ( select key_ from tmp_view )
and		vw.key_	= 'FROM SCHEMA'
and		vw.schema_	= owner


*/
--	------------------------------------------------------------------------
--	------------------------------------------------------------------------
--	------------------------------------------------------------------------

union all
select 	';',	
		' -- ' " ", table_name, 9999 seq
from 		dba_tables,
		tmp_view	vw
where		table_name 	in (select key_ from tmp_view )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner

--	------------------------------------------------------------------------
order by	table_name, seq;
--	------------------------------------------------------------------------


