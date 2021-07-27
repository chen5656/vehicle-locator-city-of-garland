--	=======================================================
--	transfer table records
--	=======================================================
	set echo		off;
	set timing		off;
	set serveroutput	on;

--	=======================================================
--	MODIFY BUILD_ROW_ID_TABLE SCRIPT FOR SYN_FROM_TABLE		<<<<<<===============

--	@c:\deacutis\scripts\models\Build_Row_ID_table.sql;

--	=======================================================

	truncate table	garland.UTWATPIP		reuse storage;	--	syn_to_table
 
	drop synonym	syn_from_table;
	create synonym	syn_from_table		for garland.UTWATPIP_TEMP;	

	drop synonym	syn_to_table;
	create synonym	syn_to_table		for garland.UTWATPIP;	

--	=======================================================
declare

	do_compile_only		number	:= 0;
	do_insert			number	:= 01;
	max_output			number	:= 99999;

	start_id			number	:= 0000000;		
	stop_id			number	:= 9999999;		

--	=======================================================

	fetch_count			number	:= 0;
	insert_count		number	:= 0;
	dupe_count			number	:= 0;

	start_key			varchar2(80);
	stop_key			varchar2(80);

	prev_id			number	:= start_id;
	this_id			number;
	this_rowid			rowid;

--	=======================================================

begin

	if	do_compile_only > 0		then
		return;
	end if;

	dbms_output.put_line (' ');

loop

begin

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'	for	

	select r.row_id,
		 r.row_seq

	into	this_rowid,
		this_id

	from	gis_app_rowid	r
	where	r.row_seq = prev_id + 01;

--	select * from explain_plan;

exception
	when others then	exit when sql%notfound;
end;

--	========================================================

	exit when  this_id > stop_id;

	prev_id := this_id;

	stop_key := this_id;
	if	start_key is null		then
		start_key := this_id;
	end if;

	fetch_count := fetch_count + sql%rowcount;

	if	fetch_count > max_output		then
		dbms_output.put_line ('ERROR - output maximum exceeded');
		exit;
	end if;

--	========================================================

begin

	if	do_insert > 0			then
		insert into	syn_to_table
		select * 
		from	syn_from_table
		where rowid = this_rowid;

		insert_count := insert_count + sql%rowcount;
		commit;
	end if;

exception
	when dup_val_on_index	then	dupe_count := dupe_count + 01;
end;

end loop;

	commit;

	dbms_output.put_line ( 'TRANSFER TABLE ' || to_char (sysdate, 'mon dd yyyy  hh24:mi' ));	--
	dbms_output.put_line ( 'key range:    ' || start_key ||' - '|| stop_key );
	dbms_output.put_line ( 'fetch_count:  ' || fetch_count	);
	dbms_output.put_line ( 'insert count: ' || insert_count	);
	dbms_output.put_line ( 'dupe count:   ' || dupe_count		);

	select count(*) into insert_count from syn_to_table;
	dbms_output.put_line ( 'verify count: ' || insert_count	);

end;

--	===============================================================
/*
	select 	table_name, index_name, column_name	
	from 		user_ind_columns				--	index columns
	where 	table_name = 'UTWATPIP'			--	specify
	order by	table_name, column_position;

	select	table_name, column_name 		--	table columns
	from		cols
	where		table_name = 'UTWATPIP'			--	specify
	order by	column_id;
*/
--	===============================================================
