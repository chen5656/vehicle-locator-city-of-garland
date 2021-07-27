	set echo	off;
--	=======================================================================================================
--	update intersection regions using block side table

--	case 1:	do intersecting streets   lie in a single region?
--	case 2:	do sides of pfx/sfx/block lie in different regions?
--	update other intersection regions accordingly
--	=======================================================================================================

declare

	do_compile			number 	:= 01;

	empty_id			char(01)	:= chr(64);		-- 'A' = 65
	is_many			char(01)	:= chr(01);

	commit_size			number	:= 100;
	commit_count		number	:= 0;

	is_eof			number	:= 0;
	this_seq			number	:= 0;

	idx				number;
	first				number;		--	first corner for name/type at node
	last				number;		--	last  corner for name/type at node 
	street_count		number;		--	street differs when pfx or sfx differs
	street1_count		number;		--	N Shiloh Rd
	street2_count		number;		--	S Shiloh Rd
	street2_first		number;

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

	street_region1		varchar2(20);
	street_region2		varchar2(20);
	street_pfx			varchar2(10);
	street_sfx			varchar2(10);
	street_block		number;

	street1_region1		varchar2(20);
	street1_region2		varchar2(20);
	street1_pfx			varchar2(10);
	street1_sfx			varchar2(10);
	street1_block		number;

	street2_region1		varchar2(20);
	street2_region2		varchar2(20);
	street2_pfx			varchar2(10);
	street2_sfx			varchar2(10);
	street2_block		number;


cursor read_corner		is

	select	c.node_id,
			b1.addr_name		addr1_name,
			b1.addr_type		addr1_type,
			b2.addr_name		addr2_name,
			b2.addr_type		addr2_type,

			b1.addr_pfx			addr1_pfx,
			b1.addr_sfx			addr1_sfx,
			b1.addr_block		addr1_block,
			nvl(b1.region,' ')	region1,

			b2.addr_pfx			addr2_pfx,
			b2.addr_sfx			addr2_sfx,
			b2.addr_block		addr2_block,
			nvl(b2.region,' ')	region2

	from		gis_app_rowid	g,
			Corner_view		c,
			Block_view		b1,
			Block_view		b2

	where		g.row_seq	= this_seq
	and		g.row_id	= c.rowid
	and		b1.rowid	= c.block1_rowid
	and		b2.rowid	= c.block2_rowid;

	CORNER	read_corner%rowtype;
	CORNER1	read_corner%rowtype;
	CORNER2	read_corner%rowtype;


	type	corner_table is table of read_corner%rowtype;
	corners	corner_table;

--	=======================================================================================================

begin

	if	do_compile > 0		then
		return;
	end if;

	this_seq := 01;
	open	read_corner;
	fetch	read_corner				into corner;
	if	read_corner%notfound
	or	read_corner%notfound is null		then
		close read_corner;
		return;
	end if;

loop

	idx			:= 0;
	street_count	:= 0;
	street1_count	:= 0;
	street2_count	:= 0;

	this_pfx		:= null;
	this_sfx		:= null;
	this_block		:= null;

	this_node_id	:= corner.node_id;
	this_name1		:= corner.addr1_name;
	this_type1		:= corner.addr1_type;
	this_name2		:= corner.addr2_name;
	this_type2		:= corner.addr2_type;

while	this_node_id	 = corner.node_id				
and	this_name1		 = corner.addr1_name	
and	this_type1		 = corner.addr1_type
and	this_name2		 = corner.addr2_name	
and	this_type2		 = corner.addr2_type		loop

	if	idx < 4						then
		idx			:= idx + 01;
		corners (idx)	:= corner;
	else
		dbms_output.put_line ('ERROR = more than 4 corners');
		return;
	end if;

	if	this_pfx	  = corner.addr1_pfx
	and	this_sfx	  = corner.addr1_sfx
	and	this_block	  = corner.addr1_block		then
		null;
	else
		this_pfx	 := corner.addr1_pfx;
		this_sfx	 := corner.addr1_sfx;
		this_block	 := corner.addr1_block;
		street_count := street_count + 01;
	end if;

	if	street_count = 01					then
		street1_count := street1_count + 01;
	elsif	street_count = 02					then
		street2_count := street2_count + 01;
	else
		dbms_output.put_line ('ERROR = more than 2 streets');
	end if;

	this_seq := this_seq + 01;

	open	read_corner;
	fetch	read_corner		into corner;
	if	read_corner%notfound
	or	read_corner%notfound is null	then
		is_eof := 01;
	end if;
	close read_corner;

end loop;

--	=======================================================================================================
	
	if	street1_count > 2
	or	street2_count > 2			then
		dbms_output.put_line ('ERROR = street has 3 corners');
		return;
	end if;


<<street_loop>>
for s in 1..2					loop

	if	s = 1					then
		first	:= 01;
		last	:= street1_count;
	elsif	street2_count > 0			then
		first	:= street1_count + 01;
		last	:= street1_count + street2_count;
	else
		exit;
	end if;

for ndx in first..last			loop

	if	corners(ndx).region1 <= empty_id		then
		street_count  := 0;
		exit street_loop;
	end if;

	if	ndx = first						then
		street_region1 := corners(ndx).region1;
	else
		street_region2 := corners(ndx).region1;
	end if;

	if	ndx = first						then
		street_pfx   := corners(ndx).addr1_pfx;
		street_sfx   := corners(ndx).addr1_sfx;
		street_block := corners(ndx).addr1_block;
	end if;

end loop;	

	if	s = 01					then
		street1_region1	:= street_region1;	
		street1_region2	:= street_region2;	
		street1_pfx		:= street_pfx;	
		street1_sfx		:= street_sfx;	
		street1_block	:= street_block;	
	else
		street2_region1	:= street_region1;	
		street2_region2	:= street_region2;	
		street2_pfx		:= street_pfx;	
		street2_sfx		:= street_sfx;	
		street2_block	:= street_block;	
	end if;

end loop;

--	=======================================================================================================
--	Does Name/Type intersection contain only 1 region ?

	if	street1_region1 = street1_region2		then

	if	street_count = 1
	or  (	street1_region1 = street2_region1
	and	street1_region1 = street2_region2	)	then

		update intersection_region_view
		set	region		= street1_region1
		where	this_node_id	= node_id
		and	this_name1		= addr1_name
		and	this_type1		= addr1_type
		and	this_name2		= addr2_name
		and	this_type2		= addr2_type
		and	intersect_id	not like 'BB%';

		commit_count := commit_count + sql%rowcount;
		street_count := 0;
	end if;
	end if;

--	=======================================================================================================

	if	street1_pfx <> street2_pfx		then
		this_pfx	:= street1_pfx;
	else
		this_pfx	:= empty_id;
	end if;

	if	street1_sfx <> street2_sfx		then
		this_sfx	:= street1_sfx;
	else
		this_sfx	:= empty_id;
	end if;

	if	street1_block <> street2_block	then
		this_block	:= street1_block;
	else
		this_block	:= 0;
	end if;

--	=======================================================================================================
--	Example:
--
--						First | St
--	W Walnut St	(region = A)		|	E Walnut St (region = B)
--	------------------------------------|----------------------------------------
--	W Walnut St	(region = A)		|	E Walnut St (region = C)
--						First	| St

--	=======================================================================================================

	if	street_count = 2					
	and	street1_region1 = street1_region2		
	and	street1_region1 not in (street2_region1, street2_region2)		then
		this_region	:= street1_region1;
	else
		this_region	:= null;
	end if;

	if	this_region is not null				then
		update intersection_region_view
		set region			= this_region

		where	this_node_id	= node_id
		and	this_name1		= addr1_name
		and	this_type1		= addr1_type
		and	this_name2		= addr2_name
		and	this_type2		= addr2_type

		and 	this_pfx		in (empty_id, addr1_pfx)
		and	this_sfx		in (empty_id, addr1_sfx)
		and	this_block		in ( 0,	  addr1_block)
		and	intersect_id	not like 'BB%';

		commit_count := commit_count + sql%rowcount;
	end if;


--	=======================================================================================================

	corner1	:= corners(1);
	corner2	:= corners(street1_count + 01);

	if	corner1.addr2_pfx <> corner2.addr2_pfx		then
		that_pfx	:= corner1.addr2_pfx;
	else
		that_pfx	:= empty_id;
	end if;

	if	corner1.addr2_sfx <> corner2.addr2_sfx		then
		that_sfx	:= corner1.addr2_sfx;
	else
		that_sfx	:= empty_id;
	end if;

	if	corner1.addr2_block <> corner2.addr2_block	then
		that_block	:= corner1.addr2_block;
	else
		that_block	:= 0;
	end if;

--	=======================================================================================================
--	Example:
--						
--					  100 First | St
--	W Walnut St	(region = A)		|	E Walnut St (region = C)
--	------------------------------------|----------------------------------------
--	W Walnut St	(region = B)		|	E Walnut St (region = C)
--					  200 First	| St

--	=======================================================================================================

	if	street_count = 2					
	and	street1_region1 <> street1_region2		then
		this_region	:= street1_region1;
	else
		this_region	:= null;
	end if;

	if	this_region is not null	
	and (	that_pfx	> empty_id
	or	that_sfx	> empty_id
	or	that_block  > 0			)		then

		update intersection_region_view
		set region			= this_region

		where	this_node_id	= node_id
		and	this_name1		= addr1_name
		and	this_type1		= addr1_type
		and	this_name2		= addr2_name
		and	this_type2		= addr2_type

		and 	this_pfx		in (empty_id, addr1_pfx)
		and	this_sfx		in (empty_id, addr1_sfx)
		and	this_block		in ( 0,	  addr1_block)

		and 	that_pfx		in (empty_id, addr2_pfx)
		and	that_sfx		in (empty_id, addr2_sfx)
		and	that_block		in ( 0,	  addr2_block)

		and	intersect_id	not like 'BB%';

		commit_count := commit_count + sql%rowcount;
	end if;
	
--	=======================================================================================================

	if	that_pfx  > empty_id		then
		that_pfx := corner2.addr2_pfx;
	end if;

	if	that_sfx  > empty_id		then
		that_sfx := corner2.addr2_sfx;
	end if;
	
	if	that_block  > 0			then
		that_block := corner2.addr2_block;
	end if;

--	=======================================================================================================

--	street2

--	=======================================================================================================

	if	commit_count > commit_size	then
		commit;
		commit_count := 0;
	end if;

	exit when	is_eof > 0;

end loop;

	commit;

end;

--	=======================================================================================================
/*

	street1_region1	:= null;
	street1_region2	:= null;
	street1_pfx		:= null;
	street1_sfx		:= null;
	street1_block	:= null;

*/
--	=======================================================================================================

