--	===================================================================================
--	Corner_View was built during the rebuild of the Intersection table
--	It contains info about intersection corners (eg. 200 N Fifth St / 500 Austin St)
--	For any corner intersection, determine whether the odd or even side of a block is involved

--	Also, assign corner compass to each corner intersection (block-block)
--	===================================================================================

declare

	do_compile			number	:= 01;

	empty_id			char(01)	:= '.';

	min_differ			number	:= 10;

	commit_size			number	:= 100;
	commit_count		number;

	total_update		number	:= 0;
	this_node_id		varchar2(20) := ' ';

	find_road_id		number;
	find_block			number;
	find_parity			number;
	find_rowid			rowid;

	cross_product		number;
	this_factor1		number;
	this_factor2		number;
	this_parity1		number;
	this_parity2		number;
	this_side1			char;
	this_side2			char;

	compass			char;
	compass1			char;
	compass2			char;
	abs1				number;
	abs2				number;
	abs_diff			number;

--	-----------------------------------------------------------------------------------

cursor read_corner	is

	select	node_id,
			block1_rowid,
			block2_rowid,
			spoke1_rowid,
			spoke2_rowid,
			road1_rowid,
			road2_rowid,
			intersect_rowid,
			corner_compass,
			rowid			row_id
	from		corner
	where		node_id > this_node_id
	and		rownum  < 2;

	CORNER	read_corner%rowtype;


cursor read_spoke		is

	select	all *
	from		spoke
	where		rowid	= find_rowid;

	SPOKE1	read_spoke%rowtype;
	SPOKE2	read_spoke%rowtype;


cursor read_road		is

	select	addr_name,
			addr_type,
			addr_pfx,
			addr_sfx,
			trunc	(addr_lo, -2)		addr_low,
			trunc	(addr_hi, -2)		addr_high,
			mod	(addr_left_from, 2)	parity_left, 
			mod	(addr_rght_from, 2)	parity_rght
	from		trvehrcl
	where		rowid = find_rowid;

	ROAD		read_road%rowtype;
	ROAD1		read_road%rowtype;
	ROAD2		read_road%rowtype;


cursor	read_block		is

	select	rowid			row_id
	from		block_region_view	
	where		addr_name		= road.addr_name
	and		addr_type		= road.addr_type
	and		addr_pfx		= road.addr_pfx
	and		addr_sfx		= road.addr_sfx
	and		addr_block		= find_block
	and		addr_parity		= find_parity;

	BLOCK1	read_block%rowtype;
	BLOCK2	read_block%rowtype;

--	-----------------------------------------------------------------------------------------------

begin

	if	do_compile > 0		then
		return;
	end if;

	total_update	:= 0;
	commit_count	:= 0;

loop

	open	read_corner;
	fetch	read_corner		into corner;
	exit when	read_corner%notfound
		or	read_corner%notfound is null;
	close	read_corner;

	this_node_id	:= corner.node_id;

--	===================================================================================
--	obtain intersecting spokes

	find_rowid		:= corner.spoke1_rowid;
	open	read_spoke;
	fetch	read_spoke		into spoke1;
	close read_spoke;

	find_rowid		:= corner.spoke2_rowid;
	open	read_spoke;
	fetch	read_spoke		into spoke2;
	close read_spoke;

--	===================================================================================
--	obtain intersecting road segments

	find_rowid		:= corner.road1_rowid;
	open	read_road;
	fetch	read_road		into road1;
	close	read_road;

	find_rowid		:= corner.road2_rowid;
	open	read_road;
	fetch	read_road		into road2;
	close	read_road;

--	===================================================================================
--	If spoke is attached to node at the "TO" end, then flip the vector direction to point outwards
--	If cross product is positive, then vector2  is counter-clockwise	to vector1
--						so use left side of vector1  & right side of vector2
--	If cross product is negative, then vector2  is clock-wise to vector1
--						so use right side of vector1 & left side of vector2
--						so flip the factors to indicate opposite sides of vectors

	if	spoke1.terminal = 'T'		then
		this_factor1   := -1;
	else
		this_factor1   := +1;
	end if;

	if	spoke2.terminal = 'T'		then
		this_factor2   := -1;
	else
		this_factor2   := +1;
	end if;

	spoke1.vector_x := spoke1.vector_x * this_factor1;
	spoke1.vector_y := spoke1.vector_y * this_factor1;
	spoke2.vector_x := spoke2.vector_x * this_factor2;
	spoke2.vector_y := spoke2.vector_y * this_factor2;

	cross_product := 
		(spoke1.vector_x * spoke2.vector_y) - (spoke2.vector_x * spoke1.vector_y);

	if	cross_product < 0			then
		this_factor1 := this_factor1 * -1;
		this_factor2 := this_factor2 * -1;
	end if;

	if	this_factor1  >  0			then
		this_side1	 := 'L';
		this_parity1 := road1.parity_left;
	else
		this_side1	 := 'R';
		this_parity1 := road1.parity_rght;
	end if;

	if	this_factor2  >  0			then
		this_side2	 := 'R';
		this_parity2 := road2.parity_rght;
	else
		this_side2	 := 'L';
		this_parity2 := road2.parity_left;
	end if;

--	===================================================================================
--	obtain intersecting block sides

	road			:= road1;
	find_parity		:= this_parity1;
	if	spoke1.terminal = 'F'		then
		find_block	:= road1.addr_low;
	else
		find_block	:= road1.addr_high;
	end if;

	open	read_block;
	fetch	read_block		into block1;
	close read_block;


	road			:= road2;
	find_parity		:= this_parity2;
	if	spoke2.terminal = 'F'		then
		find_block	:= road2.addr_low;
	else
		find_block	:= road2.addr_high;
	end if;

	open	read_block;
	fetch	read_block		into block2;
	close read_block;

--	===================================================================================
--	determine compass orientation of intersection corner

	compass	:= null;
	compass1	:= null;
	compass2	:= null;

	if	corner.corner_compass > empty_id	then
		goto	end_compass;
	end if;

	if	spoke1.vector_y > 0
	and	spoke2.vector_y > 0		then
		compass1	:= 'N';
	elsif	spoke1.vector_y < 0
	and	spoke2.vector_y < 0		then
		compass1	:= 'S';
	end if;

	if	spoke1.vector_x > 0
	and	spoke2.vector_x > 0		then
		compass2	:= 'E';
	elsif	spoke1.vector_x < 0
	and	spoke2.vector_x < 0		then
		compass2	:= 'W';
	end if;

--	if	the vectors do not have the same sign (ie. do not point in the same axial direction)
--		if	the vectors have at least a minimum difference along their axis
--			if	one vector points in positive direction & is bigger than the other vector
--			then	set compass = positive direction
--			else	set compass = negative direction

	if	compass1 is null							then
		abs1		:= abs (spoke1.vector_y);
		abs2		:= abs (spoke2.vector_y);
		abs_diff	:= abs (spoke1.vector_y - spoke2.vector_y);
		if	abs_diff > min_differ					then
			if  (	spoke1.vector_y > 0  and  abs1 > abs2 )
			or  (	spoke2.vector_y > 0  and  abs2 > abs1 )	then
				compass2	:= 'N';
			else
				compass2	:= 'S';
			end if;
		end if;
	end if;

	if	compass2 is null							then
		abs1		:= abs (spoke1.vector_x);
		abs2		:= abs (spoke2.vector_x);
		abs_diff	:= abs (spoke1.vector_x - spoke2.vector_x);
		if	abs_diff > min_differ					then
			if  (	spoke1.vector_x > 0  and  abs1 > abs2 )
			or  (	spoke2.vector_x > 0  and  abs2 > abs1 )	then
				compass2	:= 'E';
			else
				compass2	:= 'W';
			end if;
		end if;
	end if;

	compass := compass1 || compass2;

<<end_compass>>
	null;

--	===================================================================================
--	update corner block-side pointers
--	update corner compass

	if	compass is null				then
		compass	:= corner.corner_compass;
	end if;

	if	compass is not null
	and	corner.corner_compass is null		then
		update intersection
		set	corner_compass = compass
		where rowid = corner.intersect_rowid;
	end if;

	update	corner
	set		block1_rowid   = block1.row_id,
			block2_rowid   = block2.row_id,
			corner_compass = compass
	where		rowid	= corner.row_id;

	total_update := total_update + 01;
	commit_count := commit_count + 01;
	if	commit_count > commit_size 		then
		commit;
		commit_count := 0;
	end if;

--	===================================================================================

end	loop;

	close	read_corner;
	commit;

	dbms_output.put_line (' ');
	dbms_output.put_line ('"Corner" Block Assignment    ' || to_char (sysdate, 'Mon dd,yyyy, hh24:mi'));
	dbms_output.put_line (' ');
	dbms_output.put_line ('total updates  ' || lpad(total_update, 05));
	dbms_output.put_line (' ');

end	Assign_Corner_Blocks;

--	==================================================================================================

--	======================================================================
--	select * from explain_plan;
--	select * from explain_analyze;
--	select * from explain_indexed;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_cost;
--	======================================================================

--	==================================================================================================
--	Corner Display
--	400 N Shiloh Rd / 2100 W Walnut St / BB1234.5678 / F1234 T5678 / L0 R1 / beat = 21
--	primary		secondary		 xid		   term.mslink   side.parity	  region
--	==================================================================================================

