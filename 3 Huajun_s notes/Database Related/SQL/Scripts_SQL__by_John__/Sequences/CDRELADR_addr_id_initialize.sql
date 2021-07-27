	set echo			off;
	set serveroutput		on;
--	=========================================================================
--	Batch update/insert of Oracle table using gis_app_rowid as driver
--	=========================================================================
	set echo		off;
	set timing		off;

--	=========================================================================================================
--	build app Rowid reference table (for mass update processing)
	select '*** build App RowID ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;
--	=========================================================================================================

	truncate table	garland.gis_app_rowid	reuse storage;
	alter rollback segment	rb1			online;
	set transaction	use rollback segment	rb1;
	insert into		garland.gis_app_rowid
	(	select	rownum, rec_rowid
		from	(	select
--	-------------------------------------------------------------------------------------
				addr_name,
				addr_type,
				addr_pfx,
				addr_sfx,
				addr_num,
--	-------------------------------------------------------------------------------------
				rowid		rec_rowid
				from		garland.CDRELADR
--	-------------------------------------------------------------------------------------
				order by	1,2,3,4,5
--	-------------------------------------------------------------------------------------
			)
	);
	commit;
	alter rollback segment	rb1			offline;

--	======================================================================
	select count(*) from garland.gis_app_rowid;

	select rpad(segment_name,30) segment_name, segment_type, bytes, extents, tablespace_name 
	from dba_segments
	where	segment_name in
	(	select	index_name
		from		all_indexes
		where		table_name = 'GIS_APP_ROWID'	);

	analyze table	garland.gis_app_rowid	compute statistics;
--	======================================================================

	select 'Large Update    ' || to_char (sysdate, 'Mon dd,yyyy  hh24:mi') " " from dual;

	drop synonym	temp_syn;
	create synonym	temp_syn for	garland.CDRELADR		;

--	=========================================================================

declare

		do_compile		number	:= 0;
		do_update		number	:= 01;
		do_insert		number	:= 0;

		this_seq		number	:= 0;
		size_table		number	:= 0;
		total_recs		number	:= 0;
		total_update	number	:= 0;
		total_insert	number	:= 0;


cursor	read_app_table		is

		select t.*, r.*
		from	temp_syn		t,
			gis_app_rowid	r
		where	r.row_seq	= this_seq
		and	r.row_id	= t.rowid;

		APP	read_app_table%rowtype;

begin

	if	do_compile > 0		then
		return;
	end if;

	select count(*)
	into	 size_table
	from	 temp_syn;

loop

	this_seq := this_seq + 01;

	open read_app_table;

	fetch read_app_table	into APP;
	exit when	read_app_table%notfound
		or	read_app_table%notfound is null;

	if	this_seq > size_table	then
		dbms_output.put_line ('ERROR - record seq exceeds limit ' || size_table);
		return;
	end if;

	total_recs := total_recs + 01;

--	-----------------------------------------------------------------------


	if	do_update > 0		then
		update temp_syn
		set	addr_id	= app.row_seq
		where	rowid		= app.row_id;	

		total_update	:= total_update + 01;
	end if;



--	-----------------------------------------------------------------------
/*


	if	do_insert > 0		then
		insert into temp_syn	t	(	)


		total_insert := total_insert + 01;
	end if;


*/
--	-----------------------------------------------------------------------

--	Rollback;
	
	commit;
	close	read_app_table;

end loop;

	dbms_output.put_line (' ');
	dbms_output.put_line ('total records Fetched  ' || total_recs);
	dbms_output.put_line ('total records Updated  ' || total_update);
	dbms_output.put_line ('total records Inserted ' || total_insert);

end;

