
	set echo		off;
	set serveroutput	on;

	spool	off;
	spool	c:\deacutis\scripts\ora_create\Script_Grant.sql;
--	spool	d:\scripts\ora_create\Script_Grant.sql;

--	====================================================================================

declare

	do_compile_only		number		:= 0;
	do_many			varchar2(01)	:= ' ';		--	do table names in john_specs 
	do_one			varchar2(01)	:= '';		--	do table specified below

	spec_table			varchar2(40)	:= 'TST_JOHN';
	spec_owner			varchar2(40)	:= 'GARLAND';

	seq				number;
	command			varchar2(80);

	this_table_name		varchar2(80);
	this_owner			varchar2(80);
	this_privilege		varchar2(80);

--	====================================================================================

cursor	read_tab_privs		is

		select	*
		from		dba_tab_privs,
				tmp_view

		where	( (	owner		> do_many
		and		owner		= schema_
		and		table_name	= key_
		and		'table'	= type_	)

		or	  (	owner		> do_one
		and		owner		= spec_owner
		and		table_name	= spec_table
		and		'all'		= key_	)	)

		order by	table_name
		;

cursor	read_col_privs		is

		select	*
		from		dba_col_privs,
				tmp_view
		where		table_name	= this_table_name
		and		owner		= this_owner
		and		privilege	= this_privilege
		and		key_		= table_name
		and		schema_	= owner
		;

--	====================================================================================

begin

	if	do_compile_only > 0			then
		return;
	end if;


for	look in	read_tab_privs			loop

	this_table_name	:= look.table_name;
	this_owner		:= look.owner;
	this_privilege	:= look.privilege;

	command :=	'grant ' || look.privilege;
	dbms_output.put_line ( command );

	seq 	:= 0;

for	scan in	read_col_privs			loop

	seq	:= seq + 01;	
	if	seq = 01			then
		dbms_output.put_line ('(');
		command :=	' ' || scan.column_name;
	else
		command := ', ' || scan.column_name;
	end if;

	dbms_output.put_line ( command );

end loop;

	dbms_output.put_line ( ')' );

	command :=	'on '	|| look.owner ||'.'|| look.table_name;
	dbms_output.put_line ( command );

	command :=	'to ' || look.grantee;
	dbms_output.put_line ( command );


	if	look.grantable = 'YES'			then
		command := 'with grant option';
		dbms_output.put_line ( command );
	end if;

	dbms_output.put_line ( ';' );

end loop;

end;



