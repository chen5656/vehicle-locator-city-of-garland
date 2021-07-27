
--	============================================================================
--	extract foreign keys for re-org tables
--	============================================================================

	set echo		off;
	set serveroutput	on;
	set charwidth	100;

	spool off;
	spool	c:\deacutis\scripts\ora_create\Script_Foreign.sql;
--	spool	d:\scripts\ora_create\Script_Foreign.sql;
--	============================================================================

declare

	do_compile_only		number		:= 0;

	spec_table_name		varchar2(40)	:= 'TEST_JOHN';
	spec_owner			varchar2(40)	:= 'GARLAND';

	scan_count			number		:= 0;
	text				varchar2(80);

begin

	if	do_compile_only > 0		then
		return;
	end if;



for look in	
	(

	select 	owner,
			constraint_name,
			table_name,
			delete_rule,
			r_owner,
			r_constraint_name

	from		dba_constraints		con,
			tmp_view

	where		con.constraint_type = 'R'
	and		owner		= spec_owner
	and		table_name	= spec_table_name
	and		key_		= 'all'

	union

	select 	con.owner,
			con.constraint_name,
			con.table_name,
			con.delete_rule,
			r_owner,
			r_constraint_name

	from		dba_constraints		con,
			dba_cons_columns		col

	where		con.constraint_type	= 'R'	
	and		con.r_constraint_name	= col.constraint_name
	and		col.position		= 01

	and		col.owner			= spec_owner
	and		col.table_name		= spec_table_name

	)

loop

	text	:=	'select ''' || look.constraint_name || '''	" "   from dual;';
	dbms_output.put_line ( text );


	text	:=	'alter table    ' || look.owner || '.' || look.table_name;		
	dbms_output.put_line ( text );

	text	:=	'add constraint ' || look.constraint_name || '    foreign key ';	
	dbms_output.put_line ( text );

	text	:=	'(';
	dbms_output.put_line ( text );


--	=========================================================================	

	scan_count	:= 0;

for child	in 
	(
		select	column_name	
		from		dba_cons_columns	
		where		constraint_name	= look.constraint_name 
		order by	position
	)

loop	

	scan_count	:= scan_count + 01;
	if	scan_count = 01			then
		text	:= ' ' || child.column_name;
	else
		text	:= ',' || child.column_name;
	end if;

	dbms_output.put_line ( text );

end loop;

	text	:=	')';
	dbms_output.put_line ( text );

--	=========================================================================	

	scan_count	:= 0;

for parent	in 
	(
		select	*
		from		dba_cons_columns		
		where		constraint_name	= look.r_constraint_name
		order by	position
	)

loop	

	scan_count	:= scan_count + 01;

	if	scan_count = 01			then
		text := 'references     ' || parent.owner || '.' || parent.table_name;
		dbms_output.put_line ( text );
		dbms_output.put_line ( '('  );
	end if;

	if	scan_count = 01			then
		text	:=	' ' || parent.column_name;
	else
		text	:=	',' || parent.column_name;
	end if;
	dbms_output.put_line ( text );

end loop;

	text	:=	')';
	dbms_output.put_line ( text );

--	=========================================================================	

	if	look.delete_rule = 'CASCADE'		then
		text	:=	'ON DELETE CASCADE';
		dbms_output.put_line ( text );
	end if;

	text	:=	';';	
	dbms_output.put_line ( text );

end loop;

end;



