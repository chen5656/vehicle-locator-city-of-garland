	set echo		off;
	set timing		off;
	set serveroutput	on;	

--	===================================================================================
--	batch insert using hash_rowid table
--	===================================================================================

	drop synonym	syn_in_table;
	create synonym	syn_in_table		for GARLAND.CDRELADR;

	drop synonym	syn_out_table;
	create synonym	syn_out_table		for GARLAND.CDRELADR_COPY;

	set timing		on;
--	===================================================================================

	truncate table	GARLAND.CDRELADR_COPY;
	
--	===================================================================================

declare

	do_compile_only		number	:= 0;
	do_insert			number	:= 01;
	do_update			number	:= 0;
	do_delete			number	:= 0;

	start_id			number	:= 01;
	stop_id			number	:= 00;
	max_id			number	:= 00;
	loop_max			number	:= 99999;

	job_title			varchar2(80) := 'COPY CDRELADR TO CDRELADR_COPY';

--	======================================================================

	this_id			number	:= start_id;
	this_rowid			rowid;

	start_key			number;
	stop_key			number;

	fetch_count			number	:= 00;
	lost_count			number	:= 00;

	insert_count		number	:= 00;
	update_count		number	:= 00;
	delete_count		number	:= 00;

	match_count			number	:= 00;
	orphan_count		number	:= 00;

	this_seq			number	:= 00;
	seq1				number	:= 00;
	seq2				number	:= 00;
	seq3				number	:= 00;
	seq4				number	:= 00;
	seq5				number	:= 00;


--	======================================================================
--	======================================================================

begin

	if	do_compile_only > 0		then
		return;
	end if;

	if	max_id = 0				then
		select max (seq)
		into	 max_id
		from	 hash_rowid;
	end if;

	if	max_id is null			then
		dbms_output.put_line ('** error **  hash_rowid table is empty');
		return;
	end if;

	if	stop_id  = 0	
	or	stop_id  > max_id			then
		stop_id := max_id;
	end if;

--	======================================================================

loop

	this_seq	:= this_seq + 01;
/*
	seq1		:= this_seq;
	this_seq	:= this_seq + 01;
	seq2		:= this_seq;
	this_seq	:= this_seq + 01;
	seq3		:= this_seq;
	this_seq	:= this_seq + 01;
	seq4		:= this_seq;
	this_seq	:= this_seq + 01;
	seq5		:= this_seq;
*/

	if	do_insert > 0				then

begin

--	========================================================================

--	truncate table 	plan_table;
--	explain plan	set statement_id = 'test '		for

		insert into	syn_out_table
		select	all i.*
		from		syn_in_table	i,
				hash_rowid		h							
		where		h.seq		= this_seq
		and		i.rowid	= h.row_id;

--	@c:\deacutis\scripts\models\exhibit.sql;

--	========================================================================
/*
--	truncate table 	plan_table;
--	explain plan	set statement_id = 'test '		for

		insert into	syn_out_table
		select	all *
		from		syn_in_table		
		where		rowid 	in
		(		select	row_id
				from		hash_rowid
				where		seq in	( seq1, seq2, seq3, seq4, seq5 )		
		);

--	@c:\deacutis\scripts\models\exhibit.sql;
*/
--	========================================================================

		insert_count := insert_count + sql%rowcount;
		commit;

exception
		when others then
			dbms_output.put_line ( 'insert error at seq ' || this_id ||' '|| this_rowid);
			raise;
end;
	end if;

--	======================================================================

<<end_loop>>

	exit when this_seq > stop_id;

	loop_max := loop_max - 01;
	exit when	loop_max < 01;		

end loop;	

	commit;

	dbms_output.put_line (' ');
	dbms_output.put_line ( job_title	   || '   '		 || to_char (sysdate, 'mon dd hh24:mi')	);

	dbms_output.put_line ( 'start id =  '  || start_id     || '   stop id =  '  || stop_id 		);
	dbms_output.put_line ( 'start key = '  || start_key    || '   stop key = '  || stop_key 		);

	dbms_output.put_line ( 'fetched = '    || fetch_count	 || '   lost =    '   || lost_count 	);
	dbms_output.put_line ( 'inserts = '    || insert_count );
	dbms_output.put_line ( 'matched = '    || match_count  || '   orphans = '   || orphan_count 	);

end;


--	===================================================================================
--	debug queries

--	select * from cdreladr	where rowid in
--	(select row_id from hash_rowid where seq = 	1	);

--	select * from user_constraints where table_name =	'CDRELADR_COPY';
--	===================================================================================

