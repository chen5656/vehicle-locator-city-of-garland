
	set echo		off;
	set serveroutput	on;

	spool	c:\deacutis\scripts\ora_create\Script_Revoke.sql;

--	spool	d:\scripts\ora_create\Script_Revoke.sql;

--	====================================================================================

declare

	do_compile_only		number		:= 0;

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

		where	((	owner		= schema_
		and		table_name	= key_
		and		'table'	= type_	)

		or		'all'		= type_	)

		and		rownum < 11

		order by	table_name
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

	command :=	'revoke ' || look.privilege;
	dbms_output.put_line ( command );


	command :=	'on '	|| look.owner ||'.'|| look.table_name;
	dbms_output.put_line ( command );

	command :=	'from ' || look.grantee;
	dbms_output.put_line ( command );

	dbms_output.put_line ( ';' );

end loop;

end;
