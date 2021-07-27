	set echo	on;
--	===================================================================================
	create or replace	package body	Update_Radial_Region		as
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

	junc_side		char(2);
	first_side		char(2)	:= 'FL';

--	===================================================================================
cursor	Read_Radial_Side	is		--	acquire one Radial side at one seq

	select
		g.row_seq 	 g.row_id,
		r.addr_name, r.addr_type, r.addr_pfx, r.addr_sfx, r.addr_lo,
		s.parity,	 s.road_id,   s.row_id,	  s.side,	  s.junction,
		s.region_type,	s.region_id,
 		'0000'  empty_id

	from	gis_app_rowid		g,
		garland.Radial_Side	s,
		garland.trvehRCL		r

	where	g.row_seq	= read_seq
	and	s.rowid	= g.row_id	
	and	s.road_id	= r.mslink;

	INIT_Radial		read_Radial_side%rowtype;
	THIS_Radial		read_Radial_side%rowtype;
	PREV_Radial		read_Radial_side%rowtype;

--	===================================================================================
	type  Side_Control is record
(
	last_id		varchar2(80),		--	last non_empty region

	lo_seq		binary_integer,		--	where is first empty region
	hi_seq		binary_integer,		-- 	where is last  empty region

	lo_side		binary_integer,		--	first empty hundred Radial
	hi_side		binary_integer,		--	last  empty hundred Radial

	Radials		binary_integer		--	how many Radial are empty
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

--	Populate Radial_Side regions using "Linear" method
--	Populate empty regions on same street side between Radials with the same region id
--	===================================================================================
--	===================================================================================
begin

	dbms_output.put_line (' ');
	dbms_output.put_line 
	(	rpad('Gap',16)	|| rpad('Seq',10)		|| rpad('E/O',06)		|| rpad('Radials',09) ||
		'Pf ' 		|| rpad('Street',26)	|| 'Type  Sf   '		||
					'Region     Before After Count'	);   
	dbms_output.put_line (rpad('_',110,'_'));
	dbms_output.put_line (' ');


	init.last_id	:= null;
	init.lo_seq		:= 0;
	init.hi_seq		:= 0;
	init.lo_side	:= 0;
	init.hi_side	:= 0;
	init.Radials	:= 0;

	this			:= init;
	prev			:= init;

	init_Radial			:= null;
	init_Radial.region_id	:= empty_region_id;
	this_Radial			:= init_Radial;
	prev_Radial			:= init_Radial;
	
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
--	read next Radial side
--	is it a new street 
--	is it end of file (also a "new street")

	read_seq	:= read_seq + 01;

	open	read_Radial_side;
	fetch read_Radial_side		into This_Radial;

	if	read_Radial_side%notfound
	or	read_Radial_side%notfound is null	then
		is_eof 		:= 1;
		this_Radial		:= init_Radial;
	end if;
	close	read_Radial_side;

	junc_side	:= this_Radial.junction || this_Radial.side;

	if	read_seq = 1				then
		region_type			:= this_Radial.region_type;
		empty_region_id		:= this_Radial.empty_id;
		init.last_id		:= empty_region_id;
		this.last_id		:= empty_region_id;
		prev.last_id		:= empty_region_id;
		prev_Radial.region_id	:= empty_region_id;
	end if;

	this_Radial.region_id := nvl(rtrim(this_Radial.region_id), empty_region_id);

	if	this_Radial.addr_name	= prev_Radial.addr_name
	and	this_Radial.addr_type	= prev_Radial.addr_type
	and	this_Radial.addr_pfx	= prev_Radial.addr_pfx
	and	this_Radial.addr_sfx	= prev_Radial.addr_sfx		then
		is_new_street	:= 0;
	else
		is_new_street	:= 1;
		commit;
	end if;

--	=======================================================================
--	prep the current side control

	if	is_new_street = 1
	or (	this_Radial.region_id > empty_region_id	
	and	junc_side = first_side	)			then
		this			:= init;
		this.last_id	:= this_Radial.region_id;	
	end if;

--	=======================================================================
--	show the "back" gap  (at back end of street)

	if	is_new_street = 1			then

		if	prev.lo_seq > 0		then
			count_back	:= count_back + 01;
			total_back	:= total_back + prev.Radials;
			gap_label	:= 'back';
			Show_Gap_Range;
		end if;

		prev		:= init;
		prev_Radial	:= init_Radial;
	end if;

	exit when is_eof = 1;

	total_input := total_input + 01;	
	if	this_Radial.region_id > empty_region_id		then
		total_exist	:= total_exist + 01;
	end if;

--	========================================================================
--	Track Empty Gaps

	if	this_Radial.region_id <= empty_region_id		then
		this.hi_seq  := read_seq;	
		this.hi_side := this_Radial.addr_Radial;
		this.Radials := this.Radials + 01;
		total_gaps	 := total_gaps  + 01;

		if	this.lo_seq = 0	
		and	junc_side = first_side				then
			this.lo_seq	:= read_seq;	
			this.lo_side:= this_Radial.addr_Radial;
			count_gaps	:= count_gaps + 01;
		end if;

--		dbms_output.put_line ( '***************************  [gap] cnt side ttl ' 
--			|| count_gaps ||' '|| prev.Radials ||' '|| total_gaps );

	end if;

--	========================================================================
--	Show the Gap
--	Fill the Gap

	if	prev.lo_seq > 0
	and	junc_side = first_side	
	and	this_Radial.region_id > empty_region_id
	and	this_Radial.region_id = prev.last_id			then
		count_filled := count_filled + 01;
		total_filled := total_filled + prev.Radials;
		gap_label	 := 'filled';
		Show_Gap_Range;

		Assign_Gap_Regions;
	end if;

--	========================================================================
--	Show the "Front"  Gap	(at front end  of the street)
--	Show the "Middle" Gap	(in the middle of the street)

	if	prev.lo_seq > 0
	and	junc_side = first_side
	and	this_Radial.region_id  > empty_region_id
	and	this_Radial.region_id <> prev.last_id		then

		if	prev.last_id = empty_region_id				then
			count_front	:= count_front + 01;
			total_front	:= total_front + prev.Radials;
			gap_label	:= 'front';
			Show_Gap_Range;
		else
			count_middle := count_middle + 01;
			total_middle := total_middle + prev.Radials;
			gap_label	 := 'middle';

--			dbms_output.put_line ( '***************************  [mid] cnt side ttl ' 
--				|| count_middle ||' '|| prev.Radials ||' '|| total_middle );

			Show_Gap_Range;
		end if;
	end if;

--	=======================================================================
--	current info becomes previous info

	prev		:= this;
	prev_Radial	:= this_Radial;

--	========================================================================

end loop;

--	=======================================================================
--	display summary statistics

	commit;

	dbms_output.put_line (' ');
	dbms_output.put_line ('"Linear" Region Update    ' || to_char (sysdate, 'Mon dd,yyyy, hh24:mi'));
	dbms_output.put_line (' ');
	dbms_output.put_line ('Region Type    ' || region_type);


	dbms_output.put_line (' ');
	dbms_output.put_line ('total input    ' || lpad(total_input,  05));
	dbms_output.put_line ('total exist    ' || lpad(total_exist,  05));
	dbms_output.put_line ('total updates  ' || lpad(total_update, 05));
	dbms_output.put_line (' ');
	dbms_output.put_line ('total gaps     ' || lpad(count_gaps,	  05));
	dbms_output.put_line ('total Radials  ' || lpad(total_gaps,	  05));
	dbms_output.put_line (' ');
	dbms_output.put_line ('filled gaps    ' || lpad(count_filled, 05));
	dbms_output.put_line ('filled Radials ' || lpad(total_filled, 05));
	dbms_output.put_line (' ');
	dbms_output.put_line ('front gaps     ' || lpad(count_front,  05));
	dbms_output.put_line ('front Radials  ' || lpad(total_front,  05));
	dbms_output.put_line (' ');
	dbms_output.put_line ('back gaps      ' || lpad(count_back,   05));
	dbms_output.put_line ('back Radials   ' || lpad(total_back,   05));
	dbms_output.put_line (' ');
	dbms_output.put_line ('middle gaps    ' || lpad(count_middle, 05));
	dbms_output.put_line ('middle Radials ' || lpad(total_middle, 05));
	dbms_output.put_line (' ');

end	Linear_Update;


--	===================================================================================
	procedure	Assign_Gap_Regions		is
--	===================================================================================

begin

	if	do_update > 0			then

		update Radial_Side
		set	region_id	= prev.last_id
		where	addr_parity = prev_Radial.addr_parity
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
		gap_next_id	:= rpad(empty_region_id, 6);
	else
		gap_next_id := rpad(this_Radial.region_id, 6);
	end if;

	gap_range	:= 

	lpad(prev.lo_seq,05)			||'-'|| rpad(prev.hi_seq,05)			||' '||
							'  [' || prev_Radial.addr_parity || ']'	||' '||
	lpad(prev.lo_side,05) 			||'-'|| rpad(prev.hi_side,05)	      	||' '||  
	rpad(prev_Radial.addr_pfx, 02)	||	  rpad(prev_Radial.addr_name,25)	||' '||
	rpad(prev_Radial.addr_type,05)	||' '|| rpad(prev_Radial.addr_sfx, 04)	||' '||
	rpad(prev_Radial.region_type,10)								||' '|| 
	rpad(prev.last_id,06)			||' '|| gap_next_id				||' '||
	
	lpad(prev.Radials,03)										||' '||	
	' ';

	dbms_output.put_line (rpad(gap_label,12) || gap_range);

end	Show_Gap_Range;

--	===================================================================================

end	Update_Radial_Region;

--	===================================================================================
