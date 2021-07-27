
--	transfer contents of any table to any other table

--	===============================================================================
	set echo 	on;
	set timing	on;	
--	===============================================================================	

	drop synonym	syn_from_table;
	create synonym	syn_from_table		for ADRNAME;

	drop synonym	syn_to_table;
	create synonym	syn_to_table		for ADRNAME_COPY;

--	===============================================================================	

	drop cluster	tmp_rowid_cluster		including tables;

	create cluster	tmp_rowid_cluster	( key    number (8,0)	)
				hash is 		  key
				size		256
				HASHKEYS	300			(adrname = 2000 rows, keys = 256 / (02 + 18) > 10 )

		storage	( initial 1m  next 1m  pctincrease 0 );

--	===============================================================================	
/*

	drop table		tmp_rowid;

	create table 	tmp_rowid
		(	
			seq		number(8,0),
			row_id	rowid		
		)
		cluster	tmp_rowid_cluster	( seq );

*/
--	===============================================================================	
/*

	drop table		tmp_rowid;

	create table 	tmp_rowid

		cluster	tmp_rowid_cluster	( seq )

		as select
--+		index_asc ( syn_from_table	ADRNAME_PKEY )
				rownum		seq,
				rowid			row_id
		from		syn_from_table;

*/
--	===============================================================================	
/*
	create unique index	tmp_rowid_u_seq
			on		tmp_rowid  (seq)
		storage  ( initial 3m  next 3m  pctincrease 0 );
*/
--	===============================================================================	
/*	p.8-44 admin guide

	block header = 57 + 23 + 5

*/
--	===============================================================================	

--	truncate table	UTWATPIP	reuse storage;		<<===	C A R E F U L

--	===============================================================================	

declare

	do_compile_only		number	:= 01;
	do_insert			number	:= 0;

	fetch_count			number	:= 0;
	insert_count		number	:= 0;
	dupe_count			number	:= 0;

--	=======================================================
/*
	start_id			varchar2(80)	:= ' ';		
	stop_id			varchar2(80)	:= 'zzzzzzzzzzzzzzzzzzzz';		

	start_key			varchar2(80);
	stop_key			varchar2(80);

	prev_id			varchar2(80)	:= start_id;
	this_id			varchar2(80);
	this_rowid			rowid;
*/
--	==============================================================================

	start_id			number	:= 0000000;		
	stop_id			number	:= 9999999;		

	start_key			number;
	stop_key			number;

	prev_id			number	:= start_id;
	this_id			number;
	this_rowid			rowid;

--	=======================================================

begin

	if	do_compile_only > 0		then
		return;
	end if;


loop

begin

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for	

	select								--	specs
--+	index_asc ( tmp_rowid	tmp_rowid_x_seq )			
		seq,	
		row_id

	into	this_id,
		this_rowid

	from	tmp_rowid

	where	seq > prev_id
	and	rownum < 02;

--	@c:\deacutis\scripts\plans\models\exhibit.sql


exception
	when others then		exit when sql%notfound;
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

begin

	if	do_insert > 0			then
		insert into	syn_to_table
		select * 
		from		syn_from_table
		where rowid = this_rowid;

		insert_count := insert_count + sql%rowcount;
		commit;
	end if;

exception
	when dup_val_on_index	then	dupe_count := dupe_count + 01;
end;


end loop;

	commit;

	dbms_output.put_line ( 'TRANSFER   ' || to_char (sysdate, 'MON dd yyyy  hh24:mi' ));

	dbms_output.put_line ( 'fetch count:  ' || fetch_count  );

	dbms_output.put_line ( 'insert count: ' || insert_count );

	dbms_output.put_line ( 'dupe count:   ' || dupe_count );

end;
