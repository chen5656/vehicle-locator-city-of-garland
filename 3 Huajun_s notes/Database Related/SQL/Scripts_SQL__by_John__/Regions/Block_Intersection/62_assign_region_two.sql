	set echo on;
--	===========================================================
--	update block side region where two distinct regions are possible and one is known
--	===========================================================

declare
	do_compile		number	:= 01;

	this_seq		binary_integer	:= 0;

	pair_rowid		rowid;
	even_rowid		rowid;
	odd_rowid		rowid;

	this_region		varchar2(20);
	this_name		varchar2(20);
	this_type		varchar2(04);
	this_pfx			varchar2(02);
	this_sfx			varchar2(02);
	this_block		binary_integer;

--	===========================================================
cursor	read_block_side		is

--	explain plan set statement_id = 'row'	for

	select	b.*
	from	block_region_view	b,
		gis_app_rowid		r
	where	r.row_seq	= this_seq
	and	r.row_id		= b.rowid
	;

--	select * from explain_plan;

	BLOCK		read_block_side%rowtype;
	EVEN		read_block_side%rowtype;
	ODD		read_block_side%rowtype;

	PAIR		block_region2_view%rowtype;

--	===========================================================

begin

	if	do_compile > 0		then
		return;
	end if;

loop
	this_seq := this_seq + 01;	
	open	read_block_side;
	fetch	read_block_side		into block;
	if	block.addr_parity = 0			then	
		even_rowid	:= block.row_id;
		even.region	:= block.region;
		this_name	:= block.addr_name;
		this_type	:= block.addr_type;
		this_pfx		:= block.addr_pfx;
		this_sfx		:= block.addr_sfx;
		this_block	:= block.addr_block;
	end if;
	close	read_block_side;

	this_seq := this_seq + 01;	
	open	read_block_side;
	fetch	read_block_side		into block;
	if	block.addr_parity = 1			then	
		odd_rowid	:= block.row_id;
		odd.region	:= block.region;
	end if;
	close	read_block_side;

	select	max(rowid)
	into	pair_rowid
	from	block_region2_view
	where	addr_name	= this_name
	and	addr_type	= this_type
	and	addr_pfx	= this_pfx
	and	addr_sfx	= this_sfx
	and	addr_block	= this_block;

	if	pair_rowid is not null			then
		select	all *
		into	pair
		from	block_region2_view
		where	rowid = pair_rowid;
	end if;
	
	if	even.region is null
	and	odd.region  is not null			then

		if	odd.region   = pair.region1	then
			this_region := pair.region2;
		elsif	odd.region   = pair.region2	then
			this_region := pair.region1;
		else
			this_region := null;
		end if;

		if	this_region is not null		then
			update	block_region_view
			set	region = this_region
			where	rowid  = even_rowid;
		end if;
	end if;
	
	if	even.region is not null
	and	odd.region  is null			then

		if	even.region   = pair.region1	then
			this_region := pair.region2;
		elsif	even.region   = pair.region2	then
			this_region := pair.region1;
		else
			this_region := null;
		end if;

		if	this_region is not null		then
			update	block_region_view
			set	region = this_region
			where	rowid  = odd_rowid;
		end if;
	end if;

end loop;

end;