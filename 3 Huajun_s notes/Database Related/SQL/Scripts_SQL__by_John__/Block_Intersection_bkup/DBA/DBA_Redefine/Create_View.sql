	set echo		off;
	set serveroutput	on		size 999999;

--	=======================================================================
--	extract view definitions for specified tables
--	=======================================================================

declare

	do_compile_only		number	:= 0;

	text				varchar2(100);
	name_constraint		varchar2(40);
	sql_string			varchar2(2000);

begin

	if	do_compile_only > 0		then
		return;
	end if;


for look in	(
		select	all *
		from 		dba_views
		where	(view_name, owner)	 in
			(
			select	name,
					owner	
			from		dba_dependencies,	
					tmp_view
			where		type = 'VIEW'
			and		referenced_owner	= schema_
			and		referenced_name	= key_
			)
		)

loop

		dbms_output.put_line (' ');

		select	'create or replace view	 '	|| 
				look.owner				|| '.' ||				
				look.view_name 			
		into text	from dual; 	

		dbms_output.put_line ( text );

		dbms_output.put_line ( '(' );


for scan  in (
			select 	column_name,  
					column_id	 
			from 		dba_tab_columns
			where		owner		= look.owner
			and		table_name	= look.view_name
			order by	column_id					
		)

loop	

		if	scan.column_id = 01			then
			text := ' ' || scan.column_name;
		else
			text := ',' || scan.column_name;
		end if;

		dbms_output.put_line ( text );

end loop;

		dbms_output.put_line ( ')'  );

		dbms_output.put_line ( 'as' );
	
--	======================================================================
	sql_string := 'select text from all_views where view_name = ''' || look.view_name || 
			  ''' and owner = ''' || look.owner || '''';

	show_long_column (sql_string);
--	======================================================================

begin
		select	constraint_name
		into		name_constraint
		from		dba_constraints

		where		owner 	= look.owner
		and		table_name	= look.view_name	
		and		constraint_type = upper ('v');


		if	name_constraint like 'SYS_C%'		then
			null;
		else
			text	:= 'constraint ' || name_constraint;
			dbms_output.put_line ( text );
		end if;


exception
		when no_data_found	then null;
end;

		dbms_output.put_line ( ';' );

end loop;

end;
