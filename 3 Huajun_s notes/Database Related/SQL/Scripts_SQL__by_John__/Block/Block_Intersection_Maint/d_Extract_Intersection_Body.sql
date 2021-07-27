	set echo	off;
--	=================================================================
--	Extract Intersection records from Corner & Centerline tables
--	=================================================================

create or replace package body  garland.EXTRACT_INTERSECTION	as


cursor	Read_Corner			is

	select	c.esri_node,			--  temporary node id
			c.node_id,				--  permanent node id
			c.intersection_id,

			trunc(c.street1_num, -2)	addr1_block,
			r1.addr_pfx				addr1_pfx,
			r1.addr_name			addr1_name,
			r1.addr_type			addr1_type,
			r1.addr_sfx				addr1_sfx,

			trunc(c.street2_num, -2)	addr2_block,
			r2.addr_pfx				addr2_pfx,
			r2.addr_name			addr2_name,
			r2.addr_type			addr2_type,
			r2.addr_sfx				addr2_sfx,

			c.corner_compass,
			c.twin_compass,

			c.addr1_pfx_count,
			c.addr1_sfx_count,
			c.addr2_pfx_count,
			c.addr2_sfx_count
	" "
	from		garland.Corner		c,	
			garland.trvehRCL		r1,
			garland.trvehRCL		r2,
			garland.GIS_App_Rowid	g

	where		g.row_seq	= this_seq
	and		g.row_id	= c.rowid
	and		c.road1_id	= r1.mslink
	and		c.road2_id	= r2.mslink
	;

	HERE		read_Corner%rowtype;
	PREV1		read_Corner%rowtype;
	PREV2		read_Corner%rowtype;

	WRITE		read_Corner%rowtype;
	FORMAT	read_Corner%rowtype;

--	=================================================================
	procedure	WRITE_INTERSECTION_PAIR;

	procedure	WRITE_INTERSECTION;
--	=================================================================

--	=================================================================
	procedure  DRIVER				is
--	=================================================================

	yes				binary_integer	:= 1;
	no				binary_integer	:= 0;
	keep				binary_integer	:= 1;
	erase				binary_integer	:= 0;

	accept			binary_integer;

	blk1_idx			binary_integer;	-- Loop indexes
	blk2_idx			binary_integer;
	pfx1_idx			binary_integer;
	pfx2_idx			binary_integer;
	sfx1_idx			binary_integer;
	sfx2_idx			binary_integer;

	blk1_act			binary_integer;	-- Actions
	blk2_act			binary_integer;
	pfx1_act			binary_integer;
	pfx2_act			binary_integer;
	sfx1_act			binary_integer;
	sfx2_act			binary_integer;

	pfx1_is			binary_integer;	-- Non_Blank prefix/suffix
	pfx2_is			binary_integer;
	sfx1_is			binary_integer;
	sfx2_is			binary_integer;

	pfx1_erased			char;			-- Audit of erasures
	pfx2_erased			char;
	sfx1_erased			char;
	sfx2_erased			char;
	erased			varchar2(10);

	classify1			char;
	classify2			char;

begin

loop

	PREV2	:= PREV1;
	PREV1	:= THIS;

	open	Read_Corner;
	fetch	Read_Corner					into	THIS;
	if	read_app_table%notfound		
	or 	read_app_table%notfound is null		then
		exit;
	end if;
	close	Read_Corner;


	if	this.esri_node	= prev1.esri_node
	and	this.addr1_name	= prev1.addr1_name
	and	this.addr1_type	= prev1.addr1_type
	and	this.addr2_name	= prev1.addr2_name
	and	this.addr2_type	= prev1.addr2_type	then
		same_intersection_group : = yes;
	else
		same_intersection_group : = no;
	end if;
		
--	-----------------------------------------------------------------
--	The following analyses causes most duplicates to be rejected
--	What duplication sneaks through will be removed by the next job
--	-----------------------------------------------------------------

	if	here1.addr1_pfx > '0'		then
		pfx1_is := 1;
	else
		pfx1_is := 0;
	end if;

	if	here1.addr2_pfx > '0'		then
		pfx2_is := 1;
	else
		pfx2_is := 0;
	end if;

	if	here1.addr1_sfx > '0'		then
		sfx1_is := 1;
	else
		sfx1_is := 0;
	end if;

	if	here1.addr2_sfx > '0'		then
		sfx2_is := 1;
	else
		sfx2_is := 0;
	end if;

--	-----------------------------------------------------------------
--	Block, Prefix, or Suffix can be erased from Corner streets
--	Action = Erase or Keep
--	Consider all possible combinations of actions
--	Accept those combinations that do not yield duplicate output
--	-----------------------------------------------------------------

	blk1_idx	:= 0;
	blk2_idx	:= 0;

	if	c.addr1_pfx_count = 1		then
		pfx1_idx	:= 1;
	else
		pfx1_idx	:= 0;
	end if;

	if	c.addr1_sfx_count = 1		then
		sfx1_idx	:= 1;
	else
		sfx1_idx	:= 0;
	end if;

	if	c.addr2_pfx_count = 1		then
		pfx2_idx	:= 1;
	else
		pfx2_idx	:= 0;
	end if;

	if	c.addr2_sfx_count = 1		then
		sfx1_idx	:= 1;
	else
		sfx2_idx	:= 0;
	end if;


	for	blk1_act in  blk1_idx, 01		loop
		for	pfx1_act in  pfx1_idx, 01		loop
			for	sfx1_act in  sfx1_idx, 01		loop
				for	blk2_act in  blk2_idx, 01		loop
					for	pfx2_act in  pfx2_idx, 01		loop
						for	sfx2_act in  sfx2_idx, 01		loop

	accept := yes;

	if	same_intersection_group = no		then
		PREV1	:= THIS;
		PREV2	:= THIS;
		goto	Prepare_Intersection;
	end if;

--	accept block-street	only if both prefix & suffix are kept
--	accept non-block street only if not removing a blank prefix or suffix

	if	blk1_act = keep				then
		if	pfx1_act + sfx1_act < 2		then
			accept := no;
		end if;
	else
		if	(pfx1_act + pfx1_is) *  (sfx1_act + sfx1_is) = 0	then
			accept := no;
		end if;
	end if;

	if	blk2_act = keep				then
		if	pfx2_act + sfx2_act < 2		then
			accept := no;
		end if;
	else
		if	(pfx2_act + pfx2_is) *  (sfx2_act + sfx2_is) = 0	then
			accept := no;
		end if;
	end if;

--	THIS intersection will be a duplicate of a PREVIOUS intersection
--		if the qualifiers are the same 
--		or the current qualifier is empty
--		or the current qualifier is to be erased
--	Duplicate Intersections are suppressed (accept = no)

	if	accept = yes				then

		AND ((
		    (	This.addr1_block	 = Prev1.addr1_block
		or	blk1_act * blk1_is = 0	)

		and (	This.addr2_block	 = Prev1.addr2_block
		or	blk2_act * blk2_is = 0	)

		and (	This.addr1_pfx	 = Prev1.addr1_pfx
		or	pfx1_act * pfx1_is = 0	)

		and (	This.addr2_pfx	 = Prev1.addr2_pfx
		or	pfx2_act * pfx2_is = 0	)

		and (	This.addr1_sfx	 = Prev1.addr1_sfx
		or	sfx1_act * sfx1_is = 0	)

		and (	This.addr2_sfx	 = Prev1.addr2_sfx
		or	sfx2_act * sfx2_is = 0	)
		    )

		OR  (
		    (	This.addr1_block	 = Prev2.addr1_block
		or	blk1_act * blk1_is = 0	)

		and (	This.addr2_block	 = Prev2.addr2_block
		or	blk2_act * blk2_is = 0	)

		and (	This.addr1_pfx	 = Prev2.addr1_pfx
		or	pfx1_act * pfx1_is = 0	)

		and (	This.addr2_pfx	 = Prev2.addr2_pfx
		or	pfx2_act * pfx2_is = 0	)

		and (	This.addr1_sfx	 = Prev2.addr1_sfx
		or	sfx1_act * sfx1_is = 0	)

		and (	This.addr2_sfx	 = Prev2.addr2_sfx
		or	sfx2_act * sfx2_is = 0	)
		    ))

	then	
		accept := no;
	end if;

--	=======================================================================
--	if intersection is acceptable, then erase specified columns
--	=======================================================================

<<Prepare_Intersection>>

	if	accept = yes			then
	
		format := here;

		if	blk1_act = erase		then
			format.addr1_block := 0;
		end if;

		if	pfx1_act = erase		then
			format.addr1_pfx	:= ' ' ;
			pfx1_erased		:= 'P'
		else
			pfx1_erased		:= '.'
		end if;

		if	sfx1_act = erase		then
			format.addr1_sfx 	:= ' ';
			sfx1_erased		:= 'S'
		else
			sfx1_erased		:= '.'
		end if;

		if	blk2_act = erase		then
			format.addr2_block := 0;
		end if;

		if	pfx2_act = erase		then
			format.addr2_pfx	:= ' ';
			pfx2_erased		:= 'P'
		else
			pfx2_erased		:= '.'
		end if;

		if	sfx2_act = erase		then
			format.addr2_sfx 	:= ' ';
			sfx2_erased		:= 'S'
		else
			sfx2_erased		:= '.'
		end if;


		if	format.addr1_block > 0		then
			classify1	:= 'B'
		elsif	pfx1_erased	= '.'
		and	sfx1_erased = '.'			then
			classify1	:= 'S'
			if	format.addr1_pfx	= ' '
			and	format.addr1_sfx	= ' '
				classify1	:= 'N'
			end if;
		end if;

		if	format.addr2_block > 0		then
			classify2	:= 'B'
		elsif	pfx2_erased	= '.'
		and	sfx2_erased = '.'			then
			classify2	:= 'S'
			if	format.addr2_pfx	= ' '
			and	format.addr2_sfx	= ' '
				classify2	:= 'N'
			end if;
		end if;

		Call	WRITE_INTERSECTION_PAIR;
	end if;

end loop
end loop
end loop
end loop
end loop
end loop

end	DRIVER;

--	=================================================================
	procedure	WRITE_INTERSECTION_PAIR			is
--	=================================================================

begin;

	WRITE := FORMAT;

	erased 	:= pfx1_erased || pfx2_erased || sfx1_erased || sfx2_erased;
	classify	:= classify1 || classify2;

	call	WRITE_INTERSECTION;

--	-----------------------------------------------------------------
	
	write.addr1_block		:= format.addr2_block;
	write.addr1_pfx		:= format.addr2_pfx;
	write.addr1_name		:= format.addr2_name;
	write.addr1_type		:= format.addr2_type;
	write.addr1_sfx		:= format.addr2_sfx;

	write.addr2_block		:= format.addr1_block;
	write.addr2_pfx		:= format.addr1_pfx;
	write.addr2_name		:= format.addr1_name;
	write.addr2_type		:= format.addr1_type;
	write.addr2_sfx		:= format.addr1_sfx;

	erased	:= pfx2_erased || pfx1_erased || sfx2_erased || sfx1_erased;
	classify	:= classify2 || classify1;

	call	WRITE_INTERSECTION;

	commit;

end	WRITE_INTERSECTION_PAIR;


--	=================================================================
	procedure	WRITE_INTERSECTION			is
--	=================================================================

begin

	insert into	garland.INTERSECTION_EXTRACT
(
	addr1_block,
	addr1_pfx,
	addr1_name,
	addr1_type,
	addr1_sfx,

	addr2_block,
	addr2_pfx,
	addr2_name,
	addr2_type,
	addr2_sfx,

	corner_compass,
	twin_compass.
	node_id,
	intersection_id,
	removals,
	classify
)
	values
(
	write.addr1_block,
	write.addr1_pfx,
	write.addr1_name,
	write.addr1_type,
	write.addr1_sfx,

	write.addr2_block,
	write.addr2_pfx,
	write.addr2_name,
	write.addr2_type,
	write.addr2_sfx,

	write.corner_compass,
	write.twin_compass,

	write.node_id,
	write.intersection_id,
	erased,
	classify
);

end	WRITE_INTERSECTION;

