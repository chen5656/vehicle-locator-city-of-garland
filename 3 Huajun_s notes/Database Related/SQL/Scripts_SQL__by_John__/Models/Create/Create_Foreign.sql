
--	make referential integrity definitions for specified tables 

--	========================================================================
	set echo 	off;
	set timing	off;
--	========================================================================

select	'alter table ' || cn.owner || '.' || cn.table_name		" ",
		' -- ' " ", table_name, constraint_name, 01 seq
from 		dba_constraints	cn,
		tmp_view		vw
where		cn.table_name 	in (select key_ from tmp_view )
and		cn.constraint_type   = 'R'			
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= cn.owner

--	------------------------------------------------------------------------

union all
select	'add constraint ' || cn.constraint_name || ' foreign key '	" ",
		' -- ' " ", table_name, constraint_name, 02 seq
from 		dba_constraints	cn,
		tmp_view		vw
where		cn.table_name 	in (select key_ from tmp_view )
and		cn.constraint_type   = 'R'			
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= cn.owner

--	------------------------------------------------------------------------

union all
select	'('	" ",
		' -- ' " ", table_name, constraint_name, 03 seq
from 		dba_constraints	cn,
		tmp_view		vw
where		cn.table_name 	in (select key_ from tmp_view )
and		cn.constraint_type   = 'R'			
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= cn.owner

--	------------------------------------------------------------------------

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

union all
select
rpad 		( nvl (rpad ( ',', sign ( ch.position - 1) ), ' ') || rpad (ch.column_name, 25), 50)	" ",
		' -- ' " ", cn.table_name, cn.constraint_name, ch.position + 1000 seq
from		dba_constraints	cn,
		dba_cons_columns	ch,
		tmp_view		vw
where		cn.table_name 	in (select key_ from tmp_view )
and		cn.constraint_type   = 'R'			
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	=  cn.owner
and		cn.constraint_name = ch.constraint_name

--	@c:\deacutis\scripts\plans\exhibit.sql;

--	------------------------------------------------------------------------

union all
select	')'	" ",
		' -- ' " ", table_name, constraint_name, 1999 seq
from 		dba_constraints	cn,
		tmp_view		vw
where		cn.table_name 	in (select key_ from tmp_view )
and		cn.constraint_type   = 'R'			
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= cn.owner

--	------------------------------------------------------------------------

union all
select	' references '	|| cn.r_owner || '.' || pr.table_name 	" ",
		' -- ' " ", cn.table_name, cn.constraint_name, 2001 seq
from 		dba_constraints	cn,
		dba_cons_columns	pr,
		tmp_view		vw
where		cn.table_name 	in (select key_ from tmp_view )
and		cn.constraint_type   = 'R'			
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= cn.owner
and		cn.r_constraint_name = pr.constraint_name

--	------------------------------------------------------------------------

union all
select	'(' 	" ",
		' -- ' " ", table_name, constraint_name, 2002 seq
from 		dba_constraints	cn,
		tmp_view		vw
where		cn.table_name 	in (select key_ from tmp_view )
and		cn.constraint_type   = 'R'			
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= cn.owner

--	------------------------------------------------------------------------

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

union all
select
rpad 		( nvl (rpad ( ',', sign ( pr.position - 1) ), ' ') || rpad (pr.column_name, 25), 50)	" ",
		' -- ' " ", cn.table_name, cn.constraint_name, pr.position + 3000 seq
from		dba_constraints		cn,
		dba_cons_columns		pr,
		tmp_view			vw
where		cn.table_name 	in (select key_ from tmp_view )
and		cn.constraint_type   = 'R'			
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	=  cn.owner
and		cn.r_constraint_name = pr.constraint_name

--	@c:\deacutis\scripts\plans\exhibit.sql;

--	------------------------------------------------------------------------

union all
select	')' 	" ",
		' -- ' " ", table_name, constraint_name, 3999 seq
from 		dba_constraints	cn,
		tmp_view		vw
where		cn.table_name 	in (select key_ from tmp_view )
and		cn.constraint_type   = 'R'			
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= cn.owner

--	------------------------------------------------------------------------

union all
select	decode ( delete_rule, 'CASCADE', 'ON DELETE CASCADE', ' ' )		" ",
		' -- ' " ", table_name, constraint_name, 4001 seq
from 		dba_constraints	cn,
		tmp_view		vw
where		cn.table_name 	in (select key_ from tmp_view )
and		cn.constraint_type   = 'R'			
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= cn.owner

--	------------------------------------------------------------------------

union all
select 	'tablespace ' || tablespace_ || '   pctfree ' || pctfree_ || '  pctused ' || pctused_ || '      initrans 1    maxtrans ' || maxtrans_,
		' -- ' " ", table_name, constraint_name, 9001 seq
from 		dba_constraints	cn,
		tmp_view		vw
where		table_name 	in (select key_ from tmp_view )
and		cn.constraint_type   = 'R'			
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= cn.owner

--	------------------------------------------------------------------------

union all
select	'storage (initial ' || initial_ || '  next ' || next_ || '  pctincrease 0   minextents 1  maxextents ' || maxextents_,
		' -- ' " ", table_name, constraint_name, 9002 seq
from 		dba_constraints	cn,
		tmp_view		vw
where		table_name 	in (select key_ from tmp_view )
and		cn.constraint_type   = 'R'			
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= cn.owner

--	------------------------------------------------------------------------

union all
select	'         ' || 'freelists 1   freelist groups 1' || ')',
		' -- ' " ", table_name, constraint_name, 9003 seq
from 		dba_constraints	cn,
		tmp_view		vw
where		table_name 	in (select key_ from tmp_view )
and		cn.constraint_type   = 'R'			
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= cn.owner

--	------------------------------------------------------------------------

union all
select 	';',	
		' -- ' " ", table_name, constraint_name, 9999 seq
from 		dba_constraints	cn,
		tmp_view		vw
where		table_name 	in (select key_ from tmp_view )
and		cn.constraint_type   = 'R'			
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= cn.owner

--	------------------------------------------------------------------------
order by	table_name, constraint_name, seq;
--	------------------------------------------------------------------------


/*
	truncate table	plan_table;
	explain plan	set statement_id = 'test'		for

	select

		' alter table '		|| cn.owner   || '.' || cn.table_name	||		

		' add constraint '	|| cn.constraint_name				" ",

		' foreign key ('	|| ch.column_name || ')'				||	

		' references '	|| cn.r_owner || '.' || pr.table_name || ' (' || pr.column_name || ')'	" ",

		decode ( delete_rule, 'CASCADE', 'ON DELETE CASCADE', ' ' )						" "

	from		dba_constraints	cn,
			dba_cons_columns	ch,
			dba_cons_columns	pr

	where		cn.constraint_type   = 'R'			
	and		cn.constraint_name   = ch.constraint_name			--	child 
	and		cn.r_constraint_name = pr.constraint_name			--	parent

	and		cn.owner 	  = 'GARLAND'
--	and		cn.table_name = 'SANI_COM_FL'

	order by	ch.table_name, ch.constraint_name, ch.position
	;

	@c:\deacutis\scripts\plans\exhibit.sql;
*/
