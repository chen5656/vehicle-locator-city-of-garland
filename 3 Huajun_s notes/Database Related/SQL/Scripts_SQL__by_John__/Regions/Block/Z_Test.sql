	set echo		off;
	set timing		on;
	set serveroutput	on	size	999999;
--	===================================================================================
--	Populate adrBlock_Side regions using "Linear" method
--	Populate empty regions on the same side between blocks with the same region id
--	===================================================================================

--	========>>>>>>>	is_empty = '0'	<<<<<<=============
--		is the "empty" value <= all region ids ?
--	===================================================================================

declare

	do_compile		number		:= 0;
	do_update		number		:= 0;
	do_dangle		number		:= 03;	--	update if dangling blocks <= do_dangle
	do_print		number		:= 02;	--	01 = filled;  02 = filled & vacant

	max_loops		number		:= 020;	--	total records to be processed
--	do_test		number		:= 0;		--	don't test
	do_test		number		:= 001;	--	start test at this record sequence

	test_parity1	number		:= 0;
	test_parity2	number		:= 01;
	test_name		varchar2(30)	:= '';
	test_type		varchar2(04)	:= ' ';
	test_pfx		varchar2(02)	:= ' ';
	test_sfx		varchar2(02)	:= ' ';
	test_block1		number		:= 3000;
	test_block2		number		:= 4800;
	test			varchar2(400);
	test_data		varchar2(400);

	is_empty		char		:='0';	--	what is an "empty" region
	is_eof		number	:= 0;
	is_equal		number	:= 0;
	is_update		number	:= 0;
	is_dangle		number	:= 0;
	at_dangle		number	:= 0;

	total_update	number	:= 0;
	count_gaps		number	:= 0;
	count_filled	number	:= 0;
	count_append	number	:= 0;
	count_vacant	number	:= 0;
	count_dangle	number	:= 0;
	total_gaps		number	:= 0;
	total_filled	number	:= 0;
	total_append	number	:= 0;
	total_vacant	number	:= 0;
	total_dangle	number	:= 0;
	most_dangle		number	:= 0;

	this_seq		number	:= 0;
	this_parity		number	:= 0;

	this_blk		number;
	this_id		varchar2(80);
	this_range		varchar2(100);

	this			o$temp1;		--	street object
	side			o$temp2;		--	side   objects
	even			o$temp2;
	odd			o$temp2;

--	=================================================================================================
cursor	read_block_side		is	

	select	b.addr_name, b.addr_type, b.addr_pfx, b.addr_sfx, b.addr_block,
			r.addr_parity,  r.region, r.kind,
			g.*
	from		adrBlock_Side	b,
			temp_view1		r,	--	block side parity & region id
			gis_app_rowid	g
	where		g.row_seq	= this_seq
	and		g.row_id	= b.rowid
	and		g.row_id	= r.rowid;

	BLOCK		read_block_side%rowtype;

--	====================================================================
begin
	
	if	do_compile > 0		then
		return;
	end if;

	if	do_test > 0			then
		this_seq	:= do_test - 01;
		do_test	:= 01;
	end if;

	do_dangle := (do_dangle - 1) * 2;

--	initially the logic will fall through to read_block_side

	this	:= o$temp1 (' ',  ' ', ' ', ' ');
	side	:= o$temp2 (this, ' ',  0, 0, 0, 0, 0);	
	odd	:= side;
	even	:= side;

loop

	is_dangle	:= 0;
	at_dangle	:= 0;

--	====================================================================
--	BBB	Process New Street

	select count(*) into is_equal from dual
	where	 side.str = this;
   test := test || ' sel ' || is_equal;

	if	is_equal = 0			then
   test := test || ' neq';

		if	side.lo_seq > 0		then
   test := test || ' dan';

			at_dangle	 := 2;
			is_dangle	 := side.hi_seq - side.lo_seq;

			if	do_print > 0		then					--	RANGE
				this_range	:= 
				lpad(side.lo_seq,5)		||'-'|| rpad(side.hi_seq,5)		||
				'  [' || this_parity || ']'	||
				lpad(side.lo_blk,6) 		||'-'|| rpad(side.hi_blk,6)	      || 
				rpad(side.str.addr_pfx, 2)	||	  rpad(side.str.addr_name,30) ||
				rpad(side.str.addr_type,4)	||' '|| rpad(side.str.addr_sfx, 05)	||
				block.kind				||' '|| rpad(side.last_id,6)		;
				dbms_output.put_line ( 'dangle ' || this_range);
			end if;
		end if;
	
		goto	update_gap;
	end if; 

--	====================================================================
--	DDD	Track Empty Regions

	if	this_id <= is_empty 		then
   test := test || ' emp';
		side.hi_seq := this_seq; 
		side.hi_blk := this_blk;
		side.blocks	:= side.blocks + 01;
		total_gaps	:= total_gaps + 01;

		if	side.lo_seq = 0		then	
   test := test || ' beg';
			side.lo_seq := this_seq;
			side.lo_blk := this_blk;
			count_gaps	:= count_gaps + 01;
		end if;

	end if;

--	====================================================================
--	HHH	Print "Vacant" Range

	if	this_id  > is_empty	
	and	this_id <> side.last_id 
	and	side.lo_seq > 0			then
   test := test || ' vac';

		if	side.last_id = is_empty		then
   test := test || ' din';
			at_dangle	 := 1;
			is_dangle	 := side.hi_seq - side.lo_seq;
		else
			count_vacant := count_vacant + 01;
			total_vacant := total_vacant + side.blocks;
		end if;

		if	do_print > 0			then					--	RANGE
			this_range	:= 
			lpad(side.lo_seq,5)		||'-'|| rpad(side.hi_seq,5)		||
			'  [' || this_parity || ']'	||
			lpad(side.lo_blk,6) 		||'-'|| rpad(side.hi_blk,6)	      || 
			rpad(side.str.addr_pfx, 2)	||	  rpad(side.str.addr_name,30) ||
			rpad(side.str.addr_type,4)	||' '|| rpad(side.str.addr_sfx, 05)	||
			block.kind				||' '|| rpad(side.last_id,6)		;

			if	at_dangle = 1		then					--	VACANT /
				dbms_output.put_line ( 'dingle ' || this_range);
			else
				dbms_output.put_line ( 'vacant ' || this_range);
			end if;
		end if;
	end if;

--	====================================================================
--	LLL	Fill Empty Regions & Print "Filled" Range

<<update_gap>>

	if	at_dangle > 0
	and	do_dangle >= is_dangle		then
		is_update	 := 01;
		count_append := count_append + 01;
		total_append := total_append + side.blocks;

	elsif this_id > is_empty 
	and	this_id = side.last_id 
	and	side.lo_seq  > 0			then
		is_update	 := 01;
		count_filled := count_filled + 01;
		total_filled := total_filled + side.blocks;
	else
		is_update	:= 0;
	end if;

   test := test || ' upd';

	if	is_update > 0			then

		if	do_update > 0		then
	
--		truncate table	plan_table;
--		explain plan	set statement_id = 'update'		for

			update temp_view1
			set	region	= side.last_id
			where	addr_parity = this_parity
			and	rowid		in
		(
			select row_id
			from	 gis_app_rowid
			where  row_seq	between side.lo_seq and side.hi_seq
		);
			total_update := total_update + sql%rowcount;
		end if;

		if	do_print > 0		then						--	RANGE
			this_range	:= 
			lpad(side.lo_seq,5)		||'-'|| rpad(side.hi_seq,5)		||
			'  [' || this_parity || ']'	||
			lpad(side.lo_blk,6) 		||'-'|| rpad(side.hi_blk,6)	      || 
			rpad(side.str.addr_pfx, 2)	||	  rpad(side.str.addr_name,30) ||
			rpad(side.str.addr_type,4)	||' '|| rpad(side.str.addr_sfx, 05)	||
			block.kind				||' '|| rpad(side.last_id,6)		;

			if	at_dangle > 0	then
				dbms_output.put_line ( 'append ' || this_range );
			else
				dbms_output.put_line ( 'filled ' || this_range );
			end if;
		end if;

	elsif	at_dangle > 0			then
		count_dangle := count_dangle + 01;
		total_dangle := total_dangle + side.blocks;
	end if;

	if	most_dangle  < is_dangle	then
		most_dangle := is_dangle;
	end if;

--	====================================================================
--	MMM	Reset Side controls

	if	is_equal = 0		
	or	this_id > is_empty		then
   test := test || ' zer';
		side.lo_seq  := 0;
		side.hi_seq  := 0;
		side.lo_blk	 := 0;
		side.hi_blk	 := 0;
		side.blocks	 := 0;
	end if;

	if	is_equal = 0			then
   test := test || ' str';
		side.str	 := this;
	end if;

	if	this_id > is_empty		then
   test := test || ' last';
		side.last_id := this_id;
	else
		side.last_id := is_empty;
	end if;

--	====================================================================
--	end of side processing

	if	is_equal = 0			then
		commit;
	end if;

	if	this_parity = 0			then
		even	:= side;
	else
		odd	:= side;
	end if;

	if	do_test = 99		then							--	FLOW / SIDE /
		dbms_output.put_line (	
			'**** side /'	||
			rpad(	side.lo_seq	||','|| side.hi_seq ||'/',12)	||
			' blk/'		||
			rpad(	side.lo_blk	||','|| side.hi_blk ||'/',12)	||
			' str/'		||
			rpad(	side.str.addr_pfx ||'/'|| side.str.addr_name ||'/'|| side.str.addr_type ||'/'||
				side.str.addr_sfx	||'/',30)	||
			' par/'		|| this_parity	||'/'	||
			' this/'		|| this_id		||'/'	||
			' last/'		|| side.last_id	||'/'	||
			' '		);
	end if;	

--	====================================================================
--	PPP	Read Next Block Side
--		update even/odd side and obtain next side

	this_seq := this_seq + 01;

	open	read_block_side;
	fetch	read_block_side		into block;
	
	if	read_block_side%notfound
	or	read_block_side%notfound is null	then
		is_eof		:= 01;
		this.addr_name	:= null;
		block.addr_name	:= null;
	end if;
	close	read_block_side;

   test := test || ' inp';

	this_id		:= nvl(rtrim(block.region), is_empty);
	this.addr_name	:= block.addr_name;
	this.addr_type	:= block.addr_type;
	this.addr_pfx	:= block.addr_pfx;
	this.addr_sfx	:= block.addr_sfx;
	this_blk		:= block.addr_block;
	this_parity 	:= block.addr_parity;

	if	this_parity = 0		then
		side := even;
	else
		side := odd;
	end if;


	if	do_test = 99
	and	test_data is not null	then
		dbms_output.put_line ( '**** data/ ' || test_data );	
	end if;
	if	do_test = 99		then
		dbms_output.put_line ( '**** flow ' || upper(rpad(test,100)) );	
	end if;
	test		:= null;
	test_data	:= null;

	if	do_test > 0										--	RECD /
	and	block.addr_name	like test_name || '%'
	and	block.addr_parity	between test_parity1 and test_parity2
--	and	block.addr_block	between test_block1  and test_block2
	and	test_pfx  in (block.addr_pfx,  ' ')
	and	test_type in (block.addr_type, ' ')
	then
		do_test := 99;	
	elsif	do_test > 0			then
		do_test := 01;
	end if;

	if	do_test = 99		then
		dbms_output.put_line (' ');	
		dbms_output.put_line (	
			'**** recd /'
			|| 		   rpad( this_seq ||'/', 12)		
			||' blk/'	|| rpad(block.addr_block ||'/',12) 
			||' str/'	|| rpad(block.addr_pfx	 ||'/'|| block.addr_name ||'/'
					|| block.addr_type	 ||'/'|| block.addr_sfx	 ||'/', 30)  
			||' par/'	|| block.addr_parity	 ||'/'
			||' tpar/'	|| this_parity		 ||'/'
			||' this/'	|| this_id ||'/'	 
			||' '		);
	end if;


	exit when	is_eof > 0;

	max_loops := max_loops - 01;
	if	max_loops < 0		then
		dbms_output.put_line ('ERROR - looping');
		return;
	end if;

end loop;

	commit;

	dbms_output.put_line (' ');
	dbms_output.put_line ('"Linear" Region Update    ' || to_char (sysdate, 'Mon dd,yyyy, hh24:mi'));
	dbms_output.put_line (' ');
	dbms_output.put_line ('total gaps     ' || lpad(count_gaps,	  05));
	dbms_output.put_line ('total blocks   ' || lpad(total_gaps,	  05));
	dbms_output.put_line (' ');
	dbms_output.put_line ('filled gaps    ' || lpad(count_filled, 05));
	dbms_output.put_line ('filled blocks  ' || lpad(total_filled, 05));
	dbms_output.put_line (' ');
	dbms_output.put_line ('append gaps    ' || lpad(count_append, 05));
	dbms_output.put_line ('append blocks  ' || lpad(total_append, 05));
	dbms_output.put_line (' ');
	dbms_output.put_line ('vacant gaps    ' || lpad(count_vacant, 05));
	dbms_output.put_line ('vacant blocks  ' || lpad(total_vacant, 05));
	dbms_output.put_line (' ');
	dbms_output.put_line ('dangle gaps    ' || lpad(count_dangle, 05));
	dbms_output.put_line ('dangle blocks  ' || lpad(total_dangle, 05));
	dbms_output.put_line (' ');
	dbms_output.put_line ('worst dangle   ' || lpad(most_dangle,  05));
	dbms_output.put_line (' ');
	dbms_output.put_line ('total updates  ' || lpad(total_update, 05));
	dbms_output.put_line (' ');

end;

--	======================================================================
--	select * from explain_plan;
--	select * from explain_analyze;
--	select * from explain_indexed;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_cost;
--	======================================================================

