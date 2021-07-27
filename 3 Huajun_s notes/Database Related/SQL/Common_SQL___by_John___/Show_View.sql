--	=====================================================================
	select * from viewer.me;
	BEGIN  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  END;
set	TIMING		OFF;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	linesize		1000;
set	pagesize		0000;
--	execute jdeacutis.show_table_column	('', '', '');
--	execute jdeacutis.show_source		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_error		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_view		('', '', '');
--	execute jdeacutis.show_index_column	('', '', '');
--	SELECT  to_char(sysdate,'Mon dd,yyyy hh24:mi')||'  ***  ' " "  from dual;
--	EXECUTE jdeacutis.TEST_PROC;
--	CREATE or replace procedure jdeacutis.TEST_PROC  as
--	DECLARE
--	=====================================================================	

--	extract specific view definitions 

	set echo			off;
	set serveroutput		on;
	set charwidth		100;


declare

	do_compile_only		number		:= 0;

	spec_schema			varchar2(40)	:= 'GARLAND';
	spec_view			varchar2(40)	:= 'CCS_ADDRESSES_PREVIEW';

	text				varchar2(100);
	sql_string			varchar2(2000);
	name_constraint		varchar2(40);

begin

	if	do_compile_only > 0		then
		return;
	end if;


for look in	(
		select object_name, owner 	

--		from 	ALL_objects
		from 	DBA_objects

		where	object_type	=	upper ('view')
		and	owner 	= 	spec_schema
		and	object_name = 	spec_view 
		)	
loop

		dbms_output.put_line (' ');

		select	'create or replace view	 '	|| 
				spec_schema				|| '.' ||				
				look.object_name 			
				into text		from dual; 	

		dbms_output.put_line ( text );

		dbms_output.put_line ( '(' );


for scan  in (
			select 	column_name,  
					column_id	 
			from 		all_tab_columns
			where		owner		= spec_schema
			and		table_name	= look.object_name
			order by	column_id					
		)

loop	

		if	scan.column_id = 01			then
			text := scan.column_name;
		else
			text := ',' || scan.column_name;
		end if;

		dbms_output.put_line ( text );

end loop;

		dbms_output.put_line ( ')   as  ' );
	
--	======================================================================
	sql_string :=	'select text from all_views 
				where view_name = ''' || look.object_name || 
			  	''' and owner = ''' || look.owner || '''';

	show_long_column (sql_string);
--	======================================================================


begin
		select	constraint_name
		into		name_constraint
		from		all_constraints
		where		owner 	= spec_schema
		and		table_name	= spec_view	
		and		constraint_type = upper ('v');

		text	:= 'with check option constraint ' || name_constraint;
		dbms_output.put_line ( text );

exception
		when others	then null;
end;

		dbms_output.put_line ( ';' );

end loop;

end;


