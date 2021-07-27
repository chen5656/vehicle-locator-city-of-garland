--	===========================================================================================
	A - B		1 SQL insert into gis_objects  table
	C - F 	1 SQL delete from intersection table
--	===========================================================================================

--	===========================================================================================
A.	what are the duplicated intersections 	 				"dupe names"

	select	addr1_name, addr1_type, addr1_pfx, addr1_sfx, addr1_block, 
			addr2_name, addr2_type, addr2_pfx, addr2_sfx, addr2_block
	from		intersection
	group by	addr1_name, addr1_type, addr1_pfx, addr1_sfx, addr1_block, 
			addr2_name, addr2_type, addr2_pfx, addr2_sfx, addr2_block
	having	count(*) > 1;

	
--	===========================================================================================
[B]	what records contain these "dupe names"

	insert into	duplicate_intersect (gis_objects view)

	select	[x.intersect_id], 
			x.addr1_name, x.addr1_type, x.addr1_pfx, x.addr1_sfx, x.addr1_block, 
			x.addr2_name, x.addr2_type, x.addr2_pfx, x.addr2_sfx, x.addr2_block,
			x.rowid		row_id
	from		intersection	x,
			A

	where		[x.addr1_name]	= A.addr1_name 
	and		x.addr1_type	= A.addr1_type
	and		x.addr1_pfx 	= A.addr1_pfx
	and		x.addr1_sfx 	= A.addr1_sfx
	and		x.addr1_block	= A.addr1_block
	and		x.addr2_name 	= A.addr2_name
	and		x.addr2_type 	= A.addr2_type
	and		x.addr2_pfx 	= A.addr2_pfx
	and		x.addr2_sfx 	= A.addr2_sfx
	and		x.addr2_block	= A.addr2_block


--	===========================================================================================
--	===========================================================================================
C	what is the smallest intersection id of each "dupe name"		"minimum id"

	select	min (intersect_id)	min_id,
			addr1_name, addr1_type, addr1_pfx, addr1_sfx, addr1_block, 
			addr2_name, addr2_type, addr2_pfx, addr2_sfx, addr2_block,
	from 		B
	group by	addr1_name, addr1_type, addr1_pfx, addr1_sfx, addr1_block, 
			addr2_name, addr2_type, addr2_pfx, addr2_sfx, addr2_block

	
--	===========================================================================================
D	which records have "minimum ids"						"minimum family"

	select	B.intersect_id,
			B.row_id
	from		B, C
	where		[B.intersect_id]	= C.min_id

	
--	===========================================================================================
E	what is the smallest rowid of each "minimum family"			"select group"

	select	D.intersect_id,
			min(D.row_id)	row_id
	from		D
	group by	D.intersect_id

	
--	===========================================================================================
F	delete all duplicate intersections except for the "select group"

	delete from intersection
	where	rowid in
(
	select	row_id	from B
	minus
	select	row_id	from E
)

--	===========================================================================================
