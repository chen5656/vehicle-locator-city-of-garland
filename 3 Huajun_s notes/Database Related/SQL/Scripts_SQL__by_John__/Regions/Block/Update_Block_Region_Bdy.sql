	set echo	on;
--	===================================================================================
	create or replace	package body	Update_Block_Region		as
--	===================================================================================

	total_input		binary_integer;
	total_exist		binary_integer;
	total_update	binary_integer;

	total_gaps		binary_integer;
	total_filled	binary_integer;
	total_front		binary_integer;
	total_middle	binary_integer;
	total_back		binary_integer;

	count_gaps		binary_integer;
	count_filled	binary_integer;
	count_front		binary_integer;
	count_middle	binary_integer;
	count_back		binary_integer;

	is_eof		binary_integer;
	is_new_street	binary_integer;
	read_seq		binary_integer;

	gap_label		varchar2(20);
	empty_region_id	varchar2(10);
	region_type		varchar2(10);

--	===================================================================================
cursor	read_block_side	is		--	acquire one block side at one seq

	select	b.*,	
			g.row_seq, 
			g.row_id 	g_row_id

	from		block_region_view		b,
			gis_app_rowid		g

	where		g.row_seq	= read_seq
	and		g.row_id	= b.row_id;	

	INIT_BLOCK		read_block_side%rowtype;
	THIS_BLOCK		read_block_side%rowtype;
	PREV_BLOCK		read_block_side%rowtype;

--	===================================================================================
	type  Side_Control is record
(
	last_id		varchar2(80),		--	last non_empty region

	lo_seq		binary_integer,		--	where is first empty region
	hi_seq		binary_integer,		-- 	where is last  empty region

	lo_blk		binary_integer,		--	first empty hundred block
	hi_blk		binary_integer,		--	last  empty hundred block

	blocks		binary_integer		--	how many block are empty
);

	INIT			side_control;		--	initialized side control
	THIS			side_control;		--	current  side control
	PREV			side_control;		--	previous side control

--	===================================================================================
	procedure	Update_Driver  (	job_update	binary_integer, 
						job_print	binary_integer, 
						job_test	binary_integer	)
	is
--	===================================================================================

	do_update		binary_integer;
	do_print		binary_integer;
	do_test		binary_integer;

--	===================================================================================
begin

	do_update	:= job_update;
	do_print	:= job_print;
	do_test	:= job_test;

	Linear_Update;

end	Update_Driver;



--	===================================================================================

	procedure	Assign_Gap_Regions;

	procedure	Show_Gap_Range;

--	===================================================================================
	procedure	Linear_Update		is
--	===================================================================================

--	Populate Block_Side regions using "Linear" method
--	Populate empty regions on same street side between blocks with the same region id
--	===================================================================================
--	===================================================================================
begin

	dbms_output.put_line (' ');
	dbms_output.put_line 
	(	rpad('Gap',16)	|| rpad('Seq',10)		|| rpad('E/O',06)		|| rpad('Blocks',09) ||
		'Pf ' 		|| rpad('Street',26)	|| 'Type  Sf   '		||
					'Region     Before After Count'	);   
	dbms_output.put_line (rpad('_',110,'_'));
	dbms_output.put_line (' ');


	init.last_id	:= null;
	init.lo_seq		:= 0;
	init.hi_seq		:= 0;
	init.lo_blk		:= 0;
	init.hi_blk		:= 0;
	init.blocks		:= 0;

	this			:= init;
	prev			:= init;

	init_block			:= null;
	init_block.region_id	:= empty_region_id;
	this_block			:= init_block;
	prev_block			:= init_block;
	
	read_seq		:= - 1;
	is_eof		:= 0;
	is_new_street	:= 0;

	total_input		:= 0;
	total_exist		:= 0;
	total_update	:= 0;

	total_gaps		:= 0;
	total_filled	:= 0;
	total_front		:= 0;
	total_middle	:= 0;
	total_back		:= 0;
	count_gaps		:= 0;
	count_filled	:= 0;
	count_front		:= 0;
	count_middle	:= 0;
	count_back		:= 0;

Loop

--	=======================================================================
--	read next block side
--	is it a new street 
--	is it end of file (also a "new street")

	read_seq	:= read_seq + 01;

	open	read_block_side;
	fetch read_block_side		into This_Block;

	if	read_block_side%notfound
	or	read_block_side%notfound is null	then
		is_eof 		:= 1;
		this_block		:= init_block;
	end if;
	close	read_block_side;

	if	read_seq = 1				then
		region_type			:= this_block.region_type;
		empty_region_id		:= this_block.empty_id;
		init.last_id		:= empty_region_id;
		this.last_id		:= empty_region_id;
		prev.last_id		:= empty_region_id;
		prev_block.region_id	:= empty_region_id;
	end if;

	this_block.region_id := nvl(rtrim(this_block.region_id), empty_region_id);

	if	this_block.addr_name	= prev_block.addr_name
	and	this_block.addr_type	= prev_block.addr_type
	and	this_block.addr_pfx	= prev_block.addr_pfx
	and	this_block.addr_sfx	= prev_block.addr_sfx		then
		is_new_street	:= 0;
	else
		is_new_street	:= 1;
		commit;
	end if;

--	=======================================================================
--	prep the current side control

	if	is_new_street = 1
	or	this_block.region_id > empty_region_id	then
		this			:= init;
		this.last_id	:= this_block.region_id;	
	end if;

--	=======================================================================
--	show the "back" gap  (at back end of street)

	if	is_new_street = 1			then

		if	prev.lo_seq > 0		then
			count_back	:= count_back + 01;
			total_back	:= total_back + prev.blocks;
			gap_label	:= 'back';
			Show_Gap_Range;
		end if;

		prev		:= init;
		prev_block	:= init_block;
	end if;

	exit when is_eof = 1;

	total_input := total_input + 01;	
	if	this_block.region_id > empty_region_id		then
		total_exist	:= total_exist + 01;
	end if;

--	========================================================================
--	Track Empty Gaps

	if	this_block.region_id <= empty_region_id		then
		this.hi_seq := read_seq;	
		this.hi_blk := this_block.addr_block;
		this.blocks := this.blocks + 01;
		total_gaps	:= total_gaps  + 01;

		if	this.lo_seq = 0					then
			this.lo_seq	:= read_seq;	
			this.lo_blk	:= this_block.addr_block;
			count_gaps	:= count_gaps + 01;
		end if;

--		dbms_output.put_line ( '***************************  [gap] cnt blk ttl ' 
--			|| count_gaps ||' '|| prev.blocks ||' '|| total_gaps );

	end if;


--	========================================================================
--	Show the Gap
--	Fill the Gap

	if	prev.lo_seq > 0
	and	this_block.region_id > empty_region_id
	and	this_block.region_id = prev.last_id			then
		count_filled := count_filled + 01;
		total_filled := total_filled + prev.blocks;
		gap_label	:= 'filled';
		Show_Gap_Range;

		Assign_Gap_Regions;
	end if;

--	========================================================================
--	Show the "Front"  Gap	(at front end  of the street)
--	Show the "Middle" Gap	(in the middle of the street)

	if	prev.lo_seq > 0
	and	this_block.region_id  > empty_region_id
	and	this_block.region_id <> prev.last_id		then

		if	prev.last_id = empty_region_id				then
			count_front	:= count_front + 01;
			total_front	:= total_front + prev.blocks;
			gap_label	:= 'front';
			Show_Gap_Range;
		else
			count_middle := count_middle + 01;
			total_middle := total_middle + prev.blocks;
			gap_label	 := 'middle';

--			dbms_output.put_line ( '***************************  [mid] cnt blk ttl ' 
--				|| count_middle ||' '|| prev.blocks ||' '|| total_middle );

			Show_Gap_Range;
		end if;
	end if;


--	=======================================================================
--	current info becomes previous info

	prev		:= this;
	prev_block	:= this_block;

--	========================================================================

end loop;

--	=======================================================================
--	display summary statistics

	commit;

	dbms_output.put_line (' ');
	dbms_output.put_line ('"Linear" Region Update    ' || 
					to_char (sysdate, 'Mon dd,yyyy, hh24:mi'));
	dbms_output.put_line (' ');
	dbms_output.put_line ('Region Type    ' || region_type);


	dbms_output.put_line (' ');
	dbms_output.put_line ('total input    ' || lpad(total_input,  05));
	dbms_output.put_line ('total exist    ' || lpad(total_exist,  05));
	dbms_output.put_line ('total updates  ' || lpad(total_update, 05));
	dbms_output.put_line (' ');
	dbms_output.put_line ('total gaps     ' || lpad(count_gaps,	  05));
	dbms_output.put_line ('total blocks   ' || lpad(total_gaps,	  05));
	dbms_output.put_line (' ');
	dbms_output.put_line ('filled gaps    ' || lpad(count_filled, 05));
	dbms_output.put_line ('filled blocks  ' || lpad(total_filled, 05));
	dbms_output.put_line (' ');
	dbms_output.put_line ('front gaps     ' || lpad(count_front,  05));
	dbms_output.put_line ('front blocks   ' || lpad(total_front,  05));
	dbms_output.put_line (' ');
	dbms_output.put_line ('back gaps      ' || lpad(count_back,   05));
	dbms_output.put_line ('back blocks    ' || lpad(total_back,   05));
	dbms_output.put_line (' ');
	dbms_output.put_line ('middle gaps    ' || lpad(count_middle, 05));
	dbms_output.put_line ('middle blocks  ' || lpad(total_middle, 05));
	dbms_output.put_line (' ');

end	Linear_Update;


--	===================================================================================
	procedure	Assign_Gap_Regions		is
--	===================================================================================

begin

	if	do_update > 0			then

		update block_region_view
		set	region_id	= prev.last_id
		where	addr_parity = prev_block.addr_parity
		and	rowid		in
	(
		select row_id
		from	 gis_app_rowid
		where  row_seq	between prev.lo_seq and prev.hi_seq
	);

		total_update := total_update + sql%rowcount;

	end if;

end	Assign_Gap_Regions;	

--	===================================================================================
	procedure	Show_Gap_Range		is
--	===================================================================================

	gap_range		varchar2(100);
	gap_next_id		varchar2(10);

begin

	if	is_new_street = 1			then
		gap_next_id	:= rpad(empty_region_id,6);
	else
		gap_next_id := rpad(this_block.region_id,6);
	end if;

	gap_range	:= 

	lpad(prev.lo_seq,05)		||'-'|| rpad(prev.hi_seq,05)			||' '||
	'  [' || prev_block.addr_parity || ']'						||' '||
	lpad(prev.lo_blk,05) 		||'-'|| rpad(prev.hi_blk,05)	      	||' '||  
	rpad(prev_block.addr_pfx, 02)	||	  rpad(prev_block.addr_name,25)	||' '||
	rpad(prev_block.addr_type,05)	||' '|| rpad(prev_block.addr_sfx, 04)	||' '||
	rpad(prev_block.region_type,10)							||' '|| 
	rpad(prev.last_id,06)		||' '|| gap_next_id				||' '||
	
	lpad(prev.blocks,03)									||' '||	
	' ';

	dbms_output.put_line (rpad(gap_label,12) || gap_range);

end	Show_Gap_Range;

--	===================================================================================

end	Update_Block_Region;

--	===================================================================================


