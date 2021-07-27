	set echo	off;
--	=================================================================
--	Extract Intersection records from Corner table
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
			c.twin_compass
			null					removed
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

	keep_block2			binary_integer;
	keep_street1		binary_integer;
	keep_street2		binary_integer;

	same_street1		binary_integer;
	same_street2		binary_integer;
	same_streets		binary_integer;

	blk1_act			binary_integer;
	blk2_act			binary_integer;
	pfx1_act			binary_integer;
	pfx2_act			binary_integer;
	sfx1_act			binary_integer;
	sfx2_act			binary_integer;

	pfx1_is			binary_integer;
	pfx2_is			binary_integer;
	sfx1_is			binary_integer;
	sfx2_is			binary_integer;

	pfx1_remove			char;
	pfx2_remove			char;
	sfx1_remove			char;
	sfx2_remove			char;
	removed			varchar2(10);

begin

loop

	PREV		:= HERE;

	open	Read_Corner;
	fetch	Read_Corner		into	HERE;
	if	read_app_table%notfound		
	or 	read_app_table%notfound is null		then
		exit;
	end if;
	close	Read_Corner;

--	-----------------------------------------------------------------
--	The following analyses rejects most cases of duplication
--	What duplication sneaks through will be removed by a SQL command
--	-----------------------------------------------------------------

	if	here.esri_node	= prev.esri_node
	and	here.addr1_name	= prev.addr1_name
	and	here.addr1_type	= prev.addr1_type
		same_street1	 := 01;
	else
		same_street1	 := 00;
	end if;

	if	here.esri_node	= prev.esri_node
	and	here.addr2_name	= prev.addr2_name
	and	here.addr2_type	= prev.addr2_type
		same_street2	 := 01;
	else
		same_street2	 := 00;
	end if;


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
--	Possible removal items = street1 block, prefix, and/or suffix    (actions)
--	Possible removal items = street2 block, prefix, and/or suffix    (actions)
--	Consider all possible combination of item removals
--	Consider only  the removal of existing prefix or suffix 
--	Consider only blocks with no removal of  prefix or suffix
--	-----------------------------------------------------------------

	for	blk1_act in 0,1		loop
		for	pfx1_act in 0,1		loop
			for	sfx1_act in 0,1		loop
				for	blk2_act in 0,1		loop
					for	pfx2_act in 0,1		loop
						for	sfx2_act in 0,1		loop

	accept := yes;


--	do block-street only if both prefix & suffix are kept
--	do non-block street  only if not removing a non existent prefix or suffix

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

	if	accept = yes				then



	AND (

	    (	This.addr1_block = Prev1.addr1_block
	or	blk1_act  * blk1_is = 0	)

	and (	This.addr2_block = Prev1.addr2_block
	or	blk2_act  * blk2_is = 0	)

	and (	This.addr1_pfx = Prev1.addr1_pfx
	or	pfx1_act  * pfx1_is = 0	)

	and (	This.addr2_pfx = Prev1.addr2_pfx
	or	pfx2_act  * pfx2_is = 0	)

	and (	This.addr1_sfx = Prev1.addr1_sfx
	or	sfx1_act  * sfx1_is = 0	)

	and (	This.addr2_sfx = Prev1.addr2_sfx
	or	sfx2_act  * sfx2_is = 0	)
	    )	
	
	then	accept := no;


	end if;

--	=======================================================================
--	if intersection removals are acceptable, then erase specified columns
--	=======================================================================

	if	accept = yes				then
	
		write	:= here;

		if	blk1_act = erase		then
			write.addr1_block := 0;
		end if;

		if	pfx1_act = erase		then
			write.addr1_pfx	:= ' ' ;
			pfx1_remove		:= 'P'
		else
			pfx1_remove		:= '.'
		end if;

		if	sfx1_act = erase		then
			write.addr1_sfx 	:= ' ';
			sfx1_remove		:= 'S'
		else
			sfx1_remove		:= '.'
		end if;

		if	blk2_act = erase		then
			write.addr2_block := 0;
		end if;

		if	pfx2_act = erase		then
			write.addr2_pfx	:= ' ';
			pfx2_remove		:= 'P'
		else
			pfx2_remove		:= '.'
		end if;

		if	sfx2_act = erase		then
			write.addr2_sfx 	:= ' ';
			sfx2_remove		:= 'S'
		else
			sfx2_remove		:= '.'
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

	FORMAT := WRITE;

	removed := pfx1_remove || pfx2_remove || sfx1_remove || sfx2_remove;

	call	WRITE_INTERSECTION;

--	-----------------------------------------------------------------

	FORMAT := WRITE;

	removed := pfx2_remove || pfx1_remove || sfx2_remove || sfx1_remove;
	
	format.addr1_block	:= write.addr2_block;
	format.addr1_pfx		:= write.addr2_pfx;
	format.addr1_name		:= write.addr2_name;
	format.addr1_type		:= write.addr2_type;
	format.addr1_sfx		:= write.addr2_sfx;

	format.addr2_block	:= write.addr1_block;
	format.addr2_pfx		:= write.addr1_pfx;
	format.addr2_name		:= write.addr1_name;
	format.addr2_type		:= write.addr1_type;
	format.addr2_sfx		:= write.addr1_sfx;

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
	removals
)
	values
(
	format.addr1_block,
	format.addr1_pfx,
	format.addr1_name,
	format.addr1_type,
	format.addr1_sfx,

	format.addr2_block,
	format.addr2_pfx,
	format.addr2_name,
	format.addr2_type,
	format.addr2_sfx,

	format.corner_compass,
	format.twin_compass,

	format.node_id,
	format.intersection_id,
	removed
);


end	WRITE_INTERSECTION;

