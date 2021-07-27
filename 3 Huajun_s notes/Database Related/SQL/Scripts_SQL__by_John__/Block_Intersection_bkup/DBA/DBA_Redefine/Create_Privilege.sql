
--	=========================================================================	
--	create system privileges
--	=========================================================================	

	set echo		off;
	set serveroutput	on;
	set charwidth	100;

	spool	c:\deacutis\scripts\ora_create\Script_Privilege.sql;
--	spool	d:\scripts\ora_create\Script_Privilege.sql;

--	=========================================================================	

declare

	do_compile_only		number		:= 0;

	text				varchar2(100);
	clause			varchar2(100);

begin

	if	do_compile_only > 0		then
		return;
	end if;


for look in	
	(
		select 	all *
		from 		dba_sys_privs

		where		grantee		like '%'
		and		privilege		like '%'
		and		admin_option	like 'YES'

		and		rownum < 22					

		order by	grantee, admin_option, privilege
	)
loop

	text	:= 	'grant ' || look.privilege;
	dbms_output.put_line ( text );

	text	:= 	'to    ' || look.grantee;
	dbms_output.put_line ( text );

	select	decode (look.admin_option, 'YES', 'with  admin option', null)
	into		text
	from		dual;

	if	text is not null		then
		dbms_output.put_line ( text );
	end if;

	text	:= 	';';	
	dbms_output.put_line ( text );

--	=========================================================================	

end loop;

end;



