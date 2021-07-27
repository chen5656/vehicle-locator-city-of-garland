
--	make constraint definitions 

--	====================================================================
	set echo		off;
	set timing		on;
	set serveroutput	on;
--	====================================================================

	select	'alter table    ' ||  rpad (table_name, 30)		" ",
			' -- ' " ", table_name, constraint_name, 01 seq
	from		dba_constraints	cn,
			tmp_view		vw
	where		constraint_type in ( 'P', 'U' )
	and		vw.key_	= 'TABLE SPECS'
	and		vw.schema_	= owner
	and		cn.table_name 	in (select key_ from tmp_view )

--	------------------------------------------------------------------------

	union
	select	'add constraint ' || rpad (constraint_name, 30)	|| ' ' || 
			decode (constraint_type,
					'P',	'primary key',
					'U',	'unique',
						constraint_type	),
			' -- ' " ", table_name, constraint_name, 02 seq
	from		dba_constraints	cn,
			tmp_view		vw
	where		constraint_type in ( 'P', 'U' )
	and		vw.key_	= 'TABLE SPECS'
	and		vw.schema_	= owner
	and		cn.table_name 	in (select key_ from tmp_view )

--	------------------------------------------------------------------------

	union
	select	'(',
			' -- ' " ", table_name, constraint_name, 03 seq
	from		dba_constraints	cn,
			tmp_view		vw
	where		constraint_type in ( 'P', 'U' )
	and		vw.key_	= 'TABLE SPECS'
	and		vw.schema_	= owner
	and		cn.table_name 	in (select key_ from tmp_view )

--	------------------------------------------------------------------------

	union
	select	rpad 	( nvl (rpad ( ',', sign (position - 1) ), ' ') || rpad (cc.column_name, 25), 50),
			' -- ' " ", cn.table_name, cn.constraint_name, cc.position + 100 seq
	from		dba_constraints	cn,
			dba_cons_columns	cc,
			tmp_view		vw
	where		cn.constraint_name = cc.constraint_name
	and		cn.constraint_type in ( 'P', 'U' )
	and		vw.key_	= 'TABLE SPECS'
	and		vw.schema_	= cn.owner
	and		cn.table_name 	in (select key_ from tmp_view )

--	------------------------------------------------------------------------

	union
	select	')',
			' -- ' " ", table_name, constraint_name, 999 seq
	from		dba_constraints	cn,
			tmp_view		vw
	where		constraint_type in ( 'P', 'U' )
	and		vw.key_	= 'TABLE SPECS'
	and		vw.schema_	= owner
	and		cn.table_name 	in (select key_ from tmp_view )

--	------------------------------------------------------------------------

	union
	select	'using index',
			' -- ' " ", table_name, constraint_name, 9000 seq
	from		dba_constraints	cn,
			tmp_view		vw
	where		constraint_type in ( 'P', 'U' )
	and		vw.key_	= 'TABLE SPECS'
	and		vw.schema_	= owner
	and		cn.table_name 	in (select key_ from tmp_view )

--	------------------------------------------------------------------------

union all
select 	'tablespace ' || tablespace_ || '   pctfree ' || pctfree_ || '  pctused ' || pctused_ || '      initrans 1    maxtrans ' || maxtrans_,
		' -- ' " ", table_name, constraint_name, 9001 seq
from		dba_constraints	cn,
		tmp_view		vw
where		constraint_type in ( 'P', 'U' )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner
and		cn.table_name 	in (select key_ from tmp_view )

--	------------------------------------------------------------------------

union all
select	'storage (initial ' || initial_ || '  next ' || next_ || '  pctincrease 0   minextents 1  maxextents ' || maxextents_ || ')',
		' -- ' " ", table_name, constraint_name, 9002 seq
from		dba_constraints	cn,
		tmp_view		vw
where		constraint_type in ( 'P', 'U' )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner
and		cn.table_name 	in (select key_ from tmp_view )
		
--	------------------------------------------------------------------------

union all
select	'         ' || 'freelists 1   freelist groups 1' || ')',
		' -- ' " ", table_name, constraint_name, 9003 seq
from		dba_constraints	cn,
		tmp_view		vw
where		constraint_type in ( 'P', 'U' )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner
and		cn.table_name 	in (select key_ from tmp_view )

--	------------------------------------------------------------------------

	union
	select	';',
			' -- ' " ", table_name, constraint_name, 9999 seq
	from		dba_constraints	cn,
			tmp_view		vw
	where		constraint_type in ( 'P', 'U' )
	and		vw.key_	= 'TABLE SPECS'
	and		vw.schema_	= owner
	and		cn.table_name 	in (select key_ from tmp_view )

--	------------------------------------------------------------------------

	order by	table_name, constraint_name, seq;		

--	====================================================================
	set echo	on;
--	====================================================================
