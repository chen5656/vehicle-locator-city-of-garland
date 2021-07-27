	set echo 	off;
	set timing	off;

	truncate table	plan_table;

	alter rollback segment rb1	online;
	commit;

--	=======================================================
--	remove invalid spoke records

	set transaction use rollback segment rb1;

	delete from spoke
	where	lower (road_id) = 'mslink'
	or	translate (road_id,	'/0123456789', '/') is not null
	or	translate (esri_node,	'/0123456789', '/') is not null
	;

	commit;

--	=======================================================
--	update spoke lo & hi nodes  (from & to)

	set transaction use rollback segment rb1;

	update	spoke
	set		from_node	= esri_node
	where		terminal	= 'F';

	commit;

	set transaction use rollback segment rb1;

	update	spoke
	set		to_node	= esri_node
	where		terminal	= 'T';

	commit;

--	=======================================================
--	update spoke coordinates


	set transaction use rollback segment rb1;

	explain plan	set statement_id = 'F'		for

	update 	spoke		S
	set		(coord_x, coord_y)	= 
(
	select	x, y
	from		node		N
	where		s.from_node	= n.esri_node
)
	where	s.terminal	= 'F';

	commit;

--	----------------------------------------------------------
	set transaction use rollback segment rb1;

	explain plan	set statement_id = 'T'		for

	update 	spoke		S
	set		(coord_x, coord_y)	= 
(
	select	x, y
	from		node		N
	where		s.to_node	= n.esri_node
)
	where	s.terminal	= 'T';

	commit;


--	=======================================================
--	update spoke vectors

	set transaction use rollback segment rb1;

	explain plan	set statement_id = 'V'		for

	update spoke			S
	set	(vector_x,	vector_y)	= 
(
	select	(t.x - f.x), 
			(t.y - f.y)

	from
	(select * from node)		F,
	(select * from node)		T

	where	s.from_node	= f.esri_node
	and	s.to_node	= t.esri_node
);

	commit;

--	=======================================================
--	update spoke street id

	set transaction use rollback segment rb1;

--	explain plan	set statement_id = 'sid'	for

	update	spoke			sp
	set		street_id =
(
	select	street_id
	from		adrStreets		st,
			trvehrcl		rd

	where		rd.mslink		= to_number(sp.road_id)	
	and		rd.addr_name	= st.addr_name
	and		rd.addr_type	= st.addr_type
	and		rd.addr_pfx		= st.addr_pfx
	and		rd.addr_sfx		= st.addr_sfx
);

	commit;	

--	=======================================================
--	update "FROM SPOKE" block id 

	set transaction use rollback segment rb1;

--	explain plan	set statement_id = 'bid-F'		for

	update	spoke			s
	set		block_id =
(
	select	min(b.block_id)
	from		adrBlock		b,
			trvehrcl		r
	where		s.road_id		= r.mslink
	and		b.addr_name		= r.addr_name
	and		b.addr_type		= r.addr_type
	and		b.addr_pfx		= r.addr_pfx
	and		b.addr_sfx		= r.addr_sfx
	and		b.addr_block	= trunc(r.addr_lo, -2)
)
	where		s.terminal		= 'F';

	commit;

--	-----------------------------------------------------------
--	update "TO SPOKE" block id 

	set transaction use rollback segment rb1;

--	explain plan	set statement_id = 'bid-T'		for

	update	spoke			s
	set		block_id =
(
	select	min(b.block_id)
	from		adrBlock		b,
			trvehrcl		r
	where		s.road_id		= r.mslink
	and		b.addr_name		= r.addr_name
	and		b.addr_type		= r.addr_type
	and		b.addr_pfx		= r.addr_pfx
	and		b.addr_sfx		= r.addr_sfx
	and		b.addr_block	= trunc(r.addr_hi, -2)
)
	where		s.terminal		= 'T';

	commit;

--	=======================================================

	alter rollback segment rb1	offline;

--	=======================================================
--	select * from explain_plan;
--	select * from explain_indexed;
--	select * from explain_analyze;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_cost;
--	select * from explain_remote;
--	=======================================================
	set echo on;

