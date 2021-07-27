	set echo		off;
	set serveroutput	on		size 999999;

--	=========================================================================
--	extract trigger definitions for re-org tables
--	=========================================================================

declare

	do_compile_only		number		:= 0;

	scan_count			number		:= 0;
	event_found			number		:= 0;

	text				varchar2(100);
	sql_string			varchar2(2000);

begin

	if	do_compile_only > 0		then
		return;
	end if;

for look in	(
		select *		
		from 	all_triggers,
			tmp_view

		where ( table_name		> ''
		and	'all'			= key_		)

--		and	table_owner		= 'SANI_COM_FL'				--	single owner
--		and	table_name		= 'FRONT_LOAD_CUST'			--	single table

		or  (	table_name		> ' '
		and	trigger_name not like 'TLOG%'
		and	table_owner		= schema_
		and 	table_name		= key_
		and	'table'		= type_		)
		)	
loop

	select	'create or replace trigger '	|| 
			look.table_owner			|| '.' ||				
			look.trigger_name 			
			into text		from dual; 	

	dbms_output.put_line ( text );


	dbms_output.put_line ( replace (look.trigger_type, 'EACH ROW') );

--	=========================================================================	

	if	instr (look.triggering_event, 'INSERT' ) > 0		then
		dbms_output.put_line ( 'INSERT' );
		event_found := 1;
	end if;	

	if	instr (look.triggering_event, 'DELETE' ) > 0		then
		if	event_found  > 0						then
			dbms_output.put_line ('OR');
		end if;
		dbms_output.put_line ( 'DELETE' );
		event_found := 1;
	else
		event_found := 0;
	end if;	

	if	instr (look.triggering_event, 'UPDATE' ) > 0		then
		if	event_found  > 0						then
			dbms_output.put_line ('OR');
		end if;
		dbms_output.put_line ( 'UPDATE' );
	end if;	

--	=========================================================================	

for scan  in (
			select	column_name  
			from 		all_trigger_cols
			where		trigger_owner	= look.table_owner
			and		trigger_name	= look.trigger_name
			and		column_list 	= upper ('yes')
		)
loop	
	scan_count	:= scan_count + 01;
	if	scan_count = 01			then
		text := 'of ' || scan.column_name;
	else
		text := ','	  || scan.column_name;
	end if;

	dbms_output.put_line ( text );

end loop;

--	==========================================================================	

	dbms_output.put_line ( 'on ' || look.table_owner || '.' || look.table_name );

	dbms_output.put_line (look.referencing_names);

	if	instr (look.trigger_type, 'EACH ROW') > 0		then
		dbms_output.put_line ( 'for each row ' );
	end if;

	if	look.when_clause > ' '					then
		dbms_output.put_line ('when ' || '(' || look.when_clause );
		dbms_output.put_line ('     )' );

	end if;


--	====================================================	
	sql_string := 'select trigger_body from all_triggers 
				where trigger_name = ''' || look.trigger_name || '''
				and	owner = ''' || look.table_owner || '''';

	show_long_column (sql_string);
--	====================================================	


end loop;

end;


