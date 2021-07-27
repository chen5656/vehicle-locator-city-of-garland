	set echo		off;
	set timing		on;
	set serveroutput	on	size 99999;
--	=====================================================
--	update intersection regions using block side table
--	see documentation at the bottom
--	=====================================================

declare

	do_compile			number 	:= 0;
	do_update			number	:= 0;
	do_default			number 	:= 0;
	do_array			number 	:= 0;

	input_limit			number	:= 999999;
	test_start			number	:= null;
--	test_start			number	:= 011;
	test_stop			number	:= 022;

	empty_region		char(01)	:= '0';
	any_value			char(01)	:= chr(01);		

	commit_size			number	:= 100;
	commit_count		number	:= 0;

	read_total			number	:= 0;
	full_total			number	:= 0;
	half_total			number	:= 0;
	quarter_total		number	:= 0;
	multiple_total		number	:= 0;
	default_total		number	:= 0;
	dupe_total			number	:= 0;

	is_eof			number	:= null;
	this_seq			number	:= 0;

	ndx				number;
	idx				number;
	idx11				number;
	idx12				number;
	idx21				number;
	idx22				number;

	region1_exists		number;
	region2_exists		number;
	primary_differs		number;
	secondary_differs		number;

	street_count		number;	--	block/pfx/sfx
	street1_count		number;	--	100 N/S Shiloh Rd
	street2_count		number;	--	200 N/S Shiloh Rd

	this_esri_node		number;
	this_node_id		varchar2(20);
	this_name1			varchar2(30);
	this_type1			varchar2(10);
	this_name2			varchar2(30);
	this_type2			varchar2(10);

	this_region			varchar2(20);
	this_pfx			varchar2(10);
	this_sfx			varchar2(10);
	this_block			number;

	that_region			varchar2(20);
	that_pfx			varchar2(10);
	that_sfx			varchar2(10);
	that_block			number;

	msg				varchar2(250);
	msg1				varchar2(250);
	msg2				varchar2(250);
	msg3				varchar2(250);
	msg4				varchar2(250);

	error_id			number;
	node_exception		exception;

	default_region		varchar2(20);
	REGION$			varchar$v;

	type corner_record	is record 
(
	esri_node			number,
	node_id			varchar2(20),
	addr1_name			varchar2(40),
	addr1_type			varchar2(10),
	addr2_name			varchar2(40),
	addr2_type			varchar2(10),
	addr1_pfx			varchar2(10),
	addr1_sfx			varchar2(10),
	addr1_block			number,
	addr2_pfx			varchar2(10),
	addr2_sfx			varchar2(10),
	addr2_block			number,
	region			varchar2(20)
);

	CORNER		corner_record;
	CORNER_		corner_record;
	CORNER11		corner_record;
	CORNER12		corner_record;
	CORNER21		corner_record;
	CORNER22		corner_record;

	type	corner_table is table of corner_record
		index by	binary_integer;
	CORNERS	corner_table;

--	type	corner_table is varray (4) of corner_record	??


cursor read_corner	is

	select	c.esri_node,
			c.node_id,
			b1.addr_name		addr1_name,
			b1.addr_type		addr1_type,
			b2.addr_name		addr2_name,
			b2.addr_type		addr2_type,

			b1.addr_pfx			addr1_pfx,
			b1.addr_sfx			addr1_sfx,
			b1.addr_block		addr1_block,

			b2.addr_pfx			addr2_pfx,
			b2.addr_sfx			addr2_sfx,
			b2.addr_block		addr2_block,

			nvl(b1.region, empty_region)	region

	from		gis_app_rowid	g,
			corner		c,
			Block_Region_view	b1,
			Block_Region_view	b2

	where		g.row_seq	= this_seq
	and		g.row_id	= c.rowid
	and		b1.rowid	= c.block1_rowid
	and		b2.rowid	= c.block2_rowid
	
	and	(	test_start	is null
	or		g.row_seq	between test_start and test_stop	)
	;

	CORNER$	read_corner%rowtype;	--	current  corner


cursor read_empty_intersection	is

	select	addr1_block,  addr1_pfx,  addr1_sfx,
			addr2_block,  addr2_pfx,  addr2_sfx,
			rowid		 row_id
	from		Intersection_Region_view

	where		node_id	= this_node_id
	and		addr1_name	= this_name1
	and		addr1_type	= this_type1
	and		addr2_name	= this_name2
	and		addr2_type	= this_type2
	and		region	<= empty_region;

	EMPTY		read_empty_intersection%rowtype;

--	=====================================================

begin

	if	do_compile > 0		then
		return;
	end if;

	select empty 
	into	 empty_region
	from	 intersection_region_view
	where	 rownum < 2;

	if	test_start > 0		then
		this_seq := test_start - 1;
	else
		this_seq := 0;
	end if;

	region$ := varchar$v( '','','','');

	this_seq := 01;
	open	read_corner;
	fetch	read_corner				into corner$;
	if	read_corner%notfound
	or	read_corner%notfound is null	then
		dbms_output.put_line ('ERROR = empty input table');
		close read_corner;
		return;
	end if;
	close read_corner;
	read_total := 01;

	corner.node_id		:= corner$.node_id;
	corner.esri_node		:= corner$.esri_node;
	corner.addr1_name		:= corner$.addr1_name;
	corner.addr1_type		:= corner$.addr1_type;
	corner.addr1_pfx		:= corner$.addr1_pfx;
	corner.addr1_sfx		:= corner$.addr1_sfx;
	corner.addr1_block	:= corner$.addr1_block;
	corner.addr2_name		:= corner$.addr2_name;
	corner.addr2_type		:= corner$.addr2_type;
	corner.addr2_pfx		:= corner$.addr2_pfx;
	corner.addr2_sfx		:= corner$.addr2_sfx;
	corner.addr2_block	:= corner$.addr2_block;
	corner.region		:= corner$.region;

<<Driver>>
loop

	if	this_seq between test_start and test_stop		then
		dbms_output.put_line (msg);

		if	msg1 is not null					then
			dbms_output.put_line (msg1);
		end if;
		if	msg2 is not null					then
			dbms_output.put_line (msg2);
		end if;
		if	msg3 is not null					then
			dbms_output.put_line (msg3);
		end if;
		if	msg4 is not null					then
			dbms_output.put_line (msg4);
		end if;
	end if;
	msg := null;
	msg1 := null;	msg2 := null;	msg3 := null;	msg4 := null;

   msg := msg || 'loop ';

begin

	idx			:= 0;
	street_count	:= 0;
	street1_count	:= 0;
	street2_count	:= 0;
	error_id		:= 0;

	default_region	:= null;
	this_pfx		:= null;
	this_sfx		:= null;
	this_block		:= null;

	this_node_id	:= corner.node_id;
	this_esri_node	:= corner.esri_node;
	this_name1		:= corner.addr1_name;
	this_type1		:= corner.addr1_type;
	this_name2		:= corner.addr2_name;
	this_type2		:= corner.addr2_type;

--	obtain all corners for intersection & count streets 
--	(differing in pfx/sfx/block)

while	this_esri_node	= corner.esri_node				
and	this_name1		= corner.addr1_name	
and	this_type1		= corner.addr1_type
and	this_name2		= corner.addr2_name	
and	this_type2		= corner.addr2_type			loop

   msg  := msg || 'while ';

	if	this_seq between test_start and test_stop		then
		msg1 :=  rpad (
	   		this_seq		 ||'='|| corner.node_id    ||'   '||	
	   		corner.addr1_name  ||' '|| corner.addr1_type ||' / '|| 
			corner.addr2_name  ||' '|| corner.addr2_type,  50);
		msg1 :=  msg1 ||'    '||
			rpad (
	   		corner.addr1_block ||' '|| corner.addr1_pfx ||' '|| corner.addr1_sfx ||'/'|| 
			corner.addr2_block ||' '|| corner.addr2_pfx ||' '|| corner.addr2_sfx,  30) 
			|| ' || '		 || corner.region;

		dbms_output.put_line (msg1);
	end if;

	if	this_pfx	= corner.addr1_pfx
	and	this_sfx	= corner.addr1_sfx
	and	this_block	= corner.addr1_block		then
		null;
	else
		street_count := street_count + 01;
		this_pfx	 := corner.addr1_pfx;
		this_sfx	 := corner.addr1_sfx;
		this_block	 := corner.addr1_block;
	end if;

	if	street_count = 01					then
		street1_count := street1_count + 01;
	elsif	street_count = 02					then
		street2_count := street2_count + 01;
	else
		dbms_output.put_line ('ERROR = node has 3 streets');
		error_id := -3;
	end if;

	if	idx < 4						then
		idx			:= idx + 01;
		corners (idx)	:= corner;
	else
		dbms_output.put_line ('ERROR = node has 5 corners');
		error_id := -5;
	end if;

	if	corner.region > empty_region			then
		default_region := corner.region;
	end if;

<<read_next_corner>>

	corner_  := corner;
	this_seq := this_seq + 01;

	open	read_corner;
	fetch	read_corner				into corner$;
	if	read_corner%notfound
	or	read_corner%notfound is null	then
		is_eof := 01;
		close read_corner;
		exit;
	end if;
	close read_corner;

	read_total			:= read_total + 01;
	corner.node_id		:= corner$.node_id;
	corner.esri_node		:= corner$.esri_node;
	corner.addr1_name		:= corner$.addr1_name;
	corner.addr1_type		:= corner$.addr1_type;
	corner.addr1_pfx		:= corner$.addr1_pfx;
	corner.addr1_sfx		:= corner$.addr1_sfx;
	corner.addr1_block	:= corner$.addr1_block;
	corner.addr2_name		:= corner$.addr2_name;
	corner.addr2_type		:= corner$.addr2_type;
	corner.addr2_pfx		:= corner$.addr2_pfx;
	corner.addr2_sfx		:= corner$.addr2_sfx;
	corner.addr2_block	:= corner$.addr2_block;
	corner.region		:= corner$.region;

	if	corner.addr1_block = corner_.addr1_block			--	?????
	and	corner.addr2_block = corner_.addr2_block	
	and	corner.addr1_name	 = corner_.addr1_name
	and	corner.addr2_name	 = corner_.addr2_name
	and	corner.addr1_type	 = corner_.addr1_type
	and	corner.addr2_type	 = corner_.addr2_type
	and	corner.addr1_pfx	 = corner_.addr1_pfx
	and	corner.addr2_pfx	 = corner_.addr2_pfx
	and	corner.addr1_sfx	 = corner_.addr1_sfx
	and	corner.addr2_sfx	 = corner_.addr2_sfx				then
		
		if	this_seq between test_start and test_stop			then
			dbms_output.put_line ('duplicate ignored');
		end if;
			
		dupe_total := dupe_total + 01;
		goto	read_next_corner;
	end if;

	if	this_seq > input_limit		then
		dbms_output.put_line ('ERROR = input maximum exceeded');
		exit driver;
	end if;

end loop;

	if	street1_count > 2
	or	street2_count > 2			then
		dbms_output.put_line ('ERROR = street has 3 spokes');
		error_id := 3;
	end if;

	if	error_id <> 0			then
		raise node_exception;
	end if;

	idx11	:= 01;
	if	street1_count = 1			then
		idx12	:= idx11;
	else
		idx12	:= 02;
	end if;

	if	street2_count > 0			then
		idx21	:= street1_count + 01;
		if	street2_count = 1		then
			idx22 := idx21;
		else
			idx22 := idx;
		end if;
	else
		idx21	:= 01;
		idx22	:= 01;
	end if;

--	=====================================================
--	process primary spokes on both opposite ends of node

for n in 1..street_count			loop

   msg := msg || 'oppos ';

	if	n = 1					then
		corner11	:= corners(idx11);
		corner12	:= corners(idx12);
		corner21	:= corners(idx21);
		corner22	:= corners(idx22);
	else
		corner11	:= corners(idx21);
		corner12	:= corners(idx22);
		corner21	:= corners(idx11);
		corner22	:= corners(idx12);
	end if;

--	do regions exist on both sides of spokes

	if	corner11.region > empty_region
	and	corner12.region > empty_region	then
		region1_exists	:= 1;
	else
		region1_exists	:= 0;
	end if;

	if	street2_count > 0
	and	corner21.region > empty_region
	and	corner22.region > empty_region	then
		region2_exists	:= 1;
	else
		region2_exists	:= 0;
	end if;

--	=====================================================
--	Does Name/Type intersection contain only 1 region?

	if	region1_exists = 1	
	and	corner11.region = corner12.region	

	and (	street_count = 1
	or  (	corner11.region = corner21.region
	and	corner11.region = corner22.region	))	then

   msg  := msg || 'full ';
   msg3 := msg3 || ' full ' || corner11.region;

		if	do_update > 0				then
			update intersection_region_view
			set	region = corner11.region
	
			where	this_node_id	= node_id
			and	this_name1		= addr1_name
			and	this_type1		= addr1_type
			and	this_name2		= addr2_name
			and	this_type2		= addr2_type
	
			and	region		<= empty_region;
		end if;

		full_total	 := full_total   + sql%rowcount;
		commit_count := commit_count + sql%rowcount;
		street_count := 0;
	end if;

--	=====================================================
--	how do 2 spokes of primary street differ

--	Example:
--				   First | St
--	W Walnut St	(region=A)     |  E Walnut St (region=?)
--	---------------------------|------------------------
--	W Walnut St	(region=A)     |  E Walnut St (region=?)
--				   First | St
--	======================================================

	primary_differs	:= 0;
	this_block		:= 0;
	this_pfx		:= any_value;
	this_sfx		:= any_value;

	if	corner11.addr1_block <> corner21.addr1_block	then
		this_block		:= corner11.addr1_block;
		primary_differs	:= 1;
	end if;

	if	corner11.addr1_pfx <> corner21.addr1_pfx		then
		this_pfx		:= corner11.addr1_pfx;
		primary_differs	:= 1;
	end if;

	if	corner11.addr1_sfx <> corner21.addr1_sfx		then
		this_sfx		:= corner11.addr1_sfx;
		primary_differs	:= 1;
	end if;

--	=====================================================

	if	street_count  = 2	
	and	region1_exists = 1
	and	corner11.region = corner12.region	
	and	primary_differs > 0				then

		this_region	:= corner11.region;

   msg  := msg || 'half ';
   msg3 := msg3 || ' half ' || this_region;

		if	do_update > 0				then
			update intersection_region_view
			set region = this_region

			where	this_node_id	= node_id
			and	this_name1		= addr1_name
			and	this_type1		= addr1_type
			and	this_name2		= addr2_name
			and	this_type2		= addr2_type
	
			and ( this_pfx		in (any_value, addr1_pfx)
			or	this_sfx		in (any_value, addr1_sfx)
			or	this_block		in ( 0,	   addr1_block))
	
			and	region		<= empty_region;
		end if;
	
		half_total	 := half_total   + sql%rowcount;
		commit_count := commit_count + sql%rowcount;
	end if;

--	=====================================================
--	how do 2 spokes of secondary street differ

--	Example:
--			  100 First | St
--	W Walnut St	(region=A)  |  E Walnut St (region=?)
--	------------------------|-------------------------
--	W Walnut St	(region=B)	|  E Walnut St (region=?)
--			  200 First	| St
--	=====================================================


for m in 1..2			loop

	secondary_differs	:= 0;
	that_block		:= 0;
	that_pfx		:= any_value;
	that_sfx		:= any_value;

	if	corner11.addr2_block <> corner12.addr2_block	then
		secondary_differs := 1;
		if	m = 1							then
			that_block	:= corner11.addr2_block;
		else
			that_block	:= corner12.addr2_block;
		end if;
	end if;

	if	corner11.addr2_pfx <> corner12.addr2_pfx		then
		secondary_differs := 1;
		if	m = 1							then
			that_pfx	:= corner11.addr2_pfx;
		else
			that_pfx	:= corner12.addr2_pfx;
		end if;
	end if;

	if	corner11.addr2_sfx <> corner12.addr2_sfx		then
		secondary_differs := 1;
		if	m = 1							then
			that_sfx	:= corner11.addr2_sfx;
		else
			that_sfx	:= corner12.addr2_sfx;
		end if;
	end if;

--	=====================================================

	if	street_count  = 2					
	and	region1_exists = 1
	and	corner11.region <> corner12.region
	and	primary_differs   > 0
	and	secondary_differs > 0				then

		if	m = 1						then
			this_region	:= corner11.region;
		else
			this_region	:= corner12.region;
		end if;

   msg  := msg || 'quart ';
   msg3 := msg3 || ' quart ' || this_region;

		if	do_update > 0				then
			update intersection_region_view
			set region = this_region
	
			where	this_node_id	= node_id
			and	this_name1		= addr1_name
			and	this_type1		= addr1_type
			and	this_name2		= addr2_name
			and	this_type2		= addr2_type
	
			and (	this_pfx		in (any_value, addr1_pfx)
			or	this_sfx		in (any_value, addr1_sfx)
			or	this_block		in ( 0,	   addr1_block))
	
			and (	that_pfx		in (any_value, addr2_pfx)
			or	that_sfx		in (any_value, addr2_sfx)
			or	that_block		in ( 0,	   addr2_block))
	
			and	region		<= empty_region;
		end if;

		quarter_total := quarter_total + sql%rowcount;
		commit_count  := commit_count  + sql%rowcount;

	else
		exit;
	end if;

end loop;
	
--	=====================================================

	if	do_default	 > 0
	and 	street_count > 0
	and	default_region > empty_region			then

   msg  := msg || 'dflt ';
   msg3 := msg3 || ' dflt ' || default_region;

		if	do_update > 0				then
			update intersection_region_view
			set	 region = default_region
	
			where	this_node_id	= node_id
			and	this_name1		= addr1_name
			and	this_type1		= addr1_type
			and	this_name2		= addr2_name
			and	this_type2		= addr2_type
	
			and	region 		<= empty_region;
		end if;

		commit_count  := commit_count  + sql%rowcount;
		default_total := default_total + sql%rowcount;
	end if;
	
--	=====================================================
--	if intersection with empty region "matches" a corner
--	then make array with distinct corner region id

	if	do_array	 > 0
	and 	street_count > 0			then
		null;
	else
		goto	end_driver;
	end if;

	open	read_empty_intersection;

loop

   msg := msg || 'multi ';

	fetch	read_empty_intersection		into	empty;
	exit when	read_empty_intersection%notfound
		or	read_empty_intersection%notfound is null;

	ndx		:= 0;
	region$(1)	:= null;
	region$(2)	:= null;
	region$(3)	:= null;
	region$(4)	:= null;

for	x in 1..4			loop

	corner11 := corners(x);

	if	corner11.region <= empty_region
	or	corner11.region in (region$(1), region$(2), region$(3), region$(4)) then
		null;

	elsif	empty.addr1_block	in ( 0,  corner11.addr1_block)
	and	empty.addr2_block	in ( 0,  corner11.addr2_block)
	and	empty.addr1_pfx	in (' ', corner11.addr1_pfx)
	and	empty.addr2_pfx	in (' ', corner11.addr2_pfx)
	and	empty.addr1_sfx	in (' ', corner11.addr1_sfx)
	and	empty.addr2_sfx	in (' ', corner11.addr2_sfx)			then
		ndx		 := ndx + 01;
		region$(ndx) := corner11.region;

   msg := msg || 'array ';
	end if;

end loop;


   msg4 := msg4 ||' array '||region$(1)||' '||region$(2)||' '||region$(3)||' '||region$(4);


/*
	if	ndx > 0
	and	do_update > 0			then
		update	intersection_region_view
		set		region (1)	= region$(1),
				region (2)	= region$(2),
				region (3)	= region$(3),
				region (4)	= region$(4)
		where		rowid = empty.row_id;
	end if;

	multiple_total := multiple_total + 01;
*/
	
end loop;

	close	read_empty_intersection;
	commit;

--	=====================================================

<<end_driver>>
	null;

end loop;

--	=====================================================

	if	commit_count > commit_size	then
		commit;
		commit_count := 0;
	end if;

	exit when	is_eof > 0;

exception
	when	node_exception		then	
	dbms_output.put_line (	
		this_seq				||'='|| rpad(corner_.node_id,    09) ||'   '  ||
		rpad(corner_.addr1_name, 20)	||' '|| rpad(corner_.addr1_type, 04) ||' / '  ||
		rpad(corner_.addr2_name, 20)	||' '|| rpad(corner_.addr2_type, 04) ||' ||  '||
		lpad(corner_.addr2_block,05)	||' '|| rpad(corner_.addr2_block,05) ||' ; '  ||
		rpad(corner_.addr1_pfx,  02)	||' '|| rpad(corner_.addr1_pfx,  02) ||' ; '  ||
		rpad(corner_.addr1_sfx,  02)	||' '|| rpad(corner_.addr1_sfx,  02)
		);
	
	error_id := 0;
--	return;
end;

end loop;

	commit;

	dbms_output.put_line (' ');
	dbms_output.put_line ('Intersection Region Assignment    ' || to_char (sysdate, 'Mon dd,yyyy, hh24:mi'));
	dbms_output.put_line (' ');
	dbms_output.put_line ('input    total    ' || read_total);
	dbms_output.put_line ('full     total    ' || full_total);
	dbms_output.put_line ('half     total    ' || half_total);
	dbms_output.put_line ('quarter  total    ' || quarter_total);
	dbms_output.put_line ('multiple total    ' || multiple_total);
	dbms_output.put_line ('default  total    ' || default_total);
	dbms_output.put_line (' ');
	dbms_output.put_line ('duplicate total  ' || dupe_total);

end;

--	=============================================================================================
--	All block-block (type BB) intersections were populated by Update_Corner_Region
--	Example:	400 N First St / 100 E Walnut St

--	Only BB type intersections are used as input
--	Non-BB type intersection regions are updated

--	Intersection_Region_View looks at only 1 type of region (Beat, Fire, Council, etc)
--	This view is re-defined for each execution so that different regions are processed

--	Street/Type combinations are processed as a group
--	Example:	First St / Walnut St	(primary=First, secondary=Walnut)

--	A given intersection node may connect to one or more streets
--	The individual streets may have different prefix or suffix or hundred block
--	Differences in prefix/suffix/block may permit unique region assignment
--	Example:	N First St   / E Walnut St
--	Example:	N First St   / W Walnut St
--	Example:	400 First St / E Walnut St

--	RECALL that there are different ways of identifying an intersection (A - N)
--	Different identification schemes may or may not contain prefix/suffix/block
--	A unique region id is assigned whenever possible
--	=============================================================================================

--	=============================================================================================
--	gis_app_rowid	points to intersection records in the proper sequence
--	Corner view		points to relevant records associated w/ an intersection corner
--	Block  view		describes the sides of a 100 block of a given intersection spoke
--				Example:   400 N First St even side / 400 N First St odd side
--	=============================================================================================

--	=======================================================================
--	5 point intersection
--	Kingsley/Broadway    is processed separately from Broadway/Kingsley
--	Kingsley/Broadway    is processed separately from Kingsley/Centerville
--	Kingsley has 1 spoke  at the intersection	(street count = 1)
--	Broadway has 2 spokes at the intersection	(street count = 2)
--	Each spoke will usually have 2 sides	(street1 count = 2)
--	=======================================================================

--	=======================================================================
--	Full total		Intersection falls entirely within 1 region
--				so the full intersection is updated at 1 time

--	Half total		Intersection falls on a region boundary
--				and each half might be uniquely identified
	
--	Quarter total	Corners of an intersection half have different regions
--				and each corner (quarter) might be uniquely identified

--	Default total	Default region is randomly chosen
--				Default region fills in whatever is left empty
--				Default is not necessary if Full exists
--	=======================================================================
