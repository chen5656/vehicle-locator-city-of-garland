
--	update model 
--	when unique index is not available

--	===============================================================
	set echo		on;
	set timing		on;
	set serveroutput	on;
--	===============================================================
/*

	drop table		tmp_john;
	create table	tmp_john

	tablespace	gis_data
	storage ( initial 2m  next 2m  pctincrease 0 )

		as select	distinct

			rpad (inlet_code, 02) || rpad (map_grid, 03) || rpad (map_quad, 01) 		
		
			|| rowid	key
	
		from		utstoinl
	
		where	map_grid is not null				
		nd	map_quad is not null;			


	create index	tmp_john_x_key
		on		tmp_john  ( key )
		tablespace	gisindx
		storage ( initial 2m  next 2m  pctincrease 0 );

*/
--	===============================================================
 
	drop synonym	syn_user_table1;
	create synonym	syn_user_table1		for tmp_john;

	drop synonym	syn_user_table2;
	create synonym	syn_user_table2		for utstoinl;

--	===============================================================

declare

	do_update			number	:= 0;
	do_compile_only		number	:= -80;

	start_id			varchar2(40)	:= ' ';
	stop_id			varchar2(40)	:= 'zzzzzzzzzzzzzzzzzzzzzz';

	start_key			varchar2(40);
	stop_key			varchar2(40);

	prev_id			varchar2(40)	:= start_id;
	this_id			varchar2(40);
	this_rowid			rowid;

	prev_code			varchar2(10);
	prev_grid			varchar2(10);
	prev_quad			varchar2(10);

	this_code			varchar2(10);
	this_grid			varchar2(10);
	this_quad			varchar2(10);
	this_inlet_id		varchar2(40);
	this_seq			number	:= 0;
	
	fetch_count			number	:= 0;
	update_count		number	:= 0;
	show_count			number	:= 0;
	show_limit			number	:= - do_compile_only;
	
begin

	if	do_compile_only > 0		then
		return;
	end if;
	
loop

begin

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for	

	select							
--+	index_asc ( syn_user_table1	TMP_JOHN_X_KEY )			
		key

	into	this_id

	from	syn_user_table1

	where	key > prev_id
	and	rownum  < 02
	;

--	@c:\deacutis\scripts\plans\exhibit.sql


exception
	when others then	exit when sql%notfound;
end;

--	========================================================

	exit when	this_id > stop_id;

	prev_id := this_id;

	stop_key := this_id;
	if	start_key is null			then
		start_key := this_id;
	end if;

	fetch_count := fetch_count + sql%rowcount;

--	========================================================

	this_code	:= rtrim (substr (this_id, 01, 02));
	this_grid	:= rtrim (substr (this_id, 03, 03));
	this_quad	:= rtrim (substr (this_id, 06, 01));
	this_rowid	:= rtrim (substr (this_id, 07, 18));

	if	this_code = prev_code
	and	this_grid = prev_grid
	and	this_quad = prev_quad		then
		this_seq := this_seq + 01;
	else
		this_seq := 01;
	end if;


	this_inlet_id := 'ST' || this_grid || this_quad || '-' || this_seq || 'IN';


	show_count := show_count + 01;
	if	show_count < show_limit		then

		dbms_output.put_line (  'code= ' || this_code || ' grid= ' || this_grid || ' quad= ' || this_quad ||
						' seq= ' || this_seq  || 
						' inlet= ' || this_inlet_id	); 
	end if;	

begin

	if	do_update > 0			then

		update syn_user_table2
		set	inlet_id	= this_inlet_id,
			inlet_num	= this_seq
		where rowid = this_rowid;

		update_count := update_count + sql%rowcount;
		commit;

	end if;

exception
	when others	then		
		dbms_output.put_line ( 'update error ' || this_inlet_id ); 
		exit;
end;

	prev_code	:= this_code;
	prev_grid	:= this_grid;
	prev_quad	:= this_quad;

end loop;

	commit;

	dbms_output.put_line ( 'Update UTSTOINL IDS  ' || to_char (sysdate, 'MON dd yyyy hh24:mi')	); 

	dbms_output.put_line ( 'start= ' || start_id  || '  stop= ' || stop_id	);

	dbms_output.put_line ( 'start= ' || start_key || '  stop= ' || stop_key	);

	dbms_output.put_line ( 'fetch count  '  || fetch_count		);

	dbms_output.put_line ( 'update count= ' || update_count	);

end;
