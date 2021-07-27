
--	mass insert / update template

--	enhancements
--		open / update range of ids / commit / close

--	===================================================================================
/*
--	survey table indexes
	select *	from dba_ind_columns	
	where 	table_name 	= 'ADRSTREET'			
	and		table_owner	= 'GARLAND'
	order by	table_name, index_name, column_position;

--	obtain table column list
	select	column_name || ','
	from		dba_tab_columns
	where		table_name 	= 'ADRSTREET'			
	and		owner 	= 'GARLAND'
	order by	column_id;
*/
--	===================================================================================

	set echo		off;
	set timing		on;
	set serveroutput	on;	

	drop synonym	syn_user_table;
	create synonym	syn_user_table		for GARLAND.ADRSTREET;

--	===================================================================================

declare

	do_compile_only		number	:= 0;
	do_insert			number	:= 0;
	do_update			number	:= 0;
	do_delete			number	:= 0;

	loop_limit			number	:= 11111;

	fetch_count			number	:= 00;
	insert_count		number	:= 00;
	update_count		number	:= 00;
	delete_count		number	:= 00;
	found_count			number	:= 00;
	unfound_count		number	:= 00;
	loops				number	:= 00;

--	======================================================================

	start_id			number	:= 0000000;
	stop_id			number	:= 9999999;

	prev_id			number	:= start_id;
	this_id			number;
	this_rowid			rowid;

	start_key			number;
	stop_key			number;

--	======================================================================

cursor	READ_USER_TABLE		is

--	truncate table 	plan_table;
--	explain plan	set statement_id = 'test '		for

	select
--+	index_asc ( syn_user_table	ADRSTREET_PKEY )
		ADDR_NAME,
		rowid	

	from	SYN_USER_TABLE

	where	ADDR_NAME > prev_id
	and	rownum < 2

	and	nvl (ADDR_SFX, ' ') = ' ' 
	;

--	@c:\deacutis\scripts\models\exhibit.sql;

--	======================================================================

begin

	if	do_compile_only > 0		then
		return;
	end if;

--	======================================================================

loop

	loops	:= loops + 01;
	exit when	loops > loop_limit;

begin

	open	READ_USER_TABLE;

	fetch	READ_USER_TABLE
	into	this_id,
		this_rowid;	

	exit when	READ_USER_TABLE%notfound;

--	======================================================================

	exit when this_id > stop_id;

	prev_id := this_id;

	stop_key := this_id;
	if	start_key is null		then
		start_key := this_id;
	end if;

	fetch_count := fetch_count + sql%rowcount;

--	======================================================================

	if	do_update > 0				then
		update	SYN_USER_TABLE
		set		ADDR_SFX = ' '
		where		rowid = this_rowid;

		update_count := update_count + sql%rowcount;
		commit;
	end if;

--	======================================================================

	close	READ_USER_TABLE;

exception
	when no_data_found	then	exit when sql%notfound;
end;

--	dbms_output.put_line (this_id);				--	test

end loop;	

	commit;

	dbms_output.put_line ( 'DESCRIBE' );

	dbms_output.put_line ( 'start id =  '   || start_id     || '   stop id =  '  || stop_id 		);
	dbms_output.put_line ( 'start key = '   || start_key    || '   stop key = '  || stop_key 		);

	dbms_output.put_line ( 'fetched = '     || fetch_count 	);
	dbms_output.put_line ( 'updated = '     || update_count 	);
	dbms_output.put_line ( 'found =   '     || found_count  || '   unfound = '   || unfound_count 	);

end;
