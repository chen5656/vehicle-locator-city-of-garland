	set echo off;
--	=========================================================================================
--	generate "twin compass" intersection records

--	Some street intersections consist of 2 junctions (nodes)
--	The "twin_compass" column indicates the relative direction of each
--	In the example below one junction lies to the north (N) and the other to the south (S)
--	=========================================================================================

/*
					|
		ASH			|
	------------------------o
					|
					|ELM
					|			ASH
					o-------------------------------
					|
					|

--	---------------------------------------------------------------------------------
--	formula for assigning compass direction

	decode (sign((n.y1 - n.y2) - (sign(n.y1 - n.y2) * :min_diff)),
			+1,		'N',
			-1,		'S',
			null)

	if the difference between two y coordinates > + min_diff, then twin compass = 'N'
	if the difference between two y coordinates < - min_diff, then twin compass = 'S'
	note:	 a > b  means  a - b > 0  (sign = +1)
	note:	 a < b  means  a - b < 0  (sign = -1)
*/
--	=================================================================================

	variable	 min_diff		number;
	execute	:min_diff		:= 10;	-- specify minimum coordinate difference

--	======================================================================

	truncate table	garland.plan_table;

	alter rollback segment	rb1		online;
	commit;

--	======================================================================

	truncate table	garland.gis_temp4	reuse storage;	--	twin_compass_view	
	comment on table	garland.gis_temp4		is 'twin compass table';

	set transaction	use rollback segment	rb1;

	explain plan	set statement_id = '111'	into garland.plan_table		for
	
	insert into	twin_compass_view
(
	select	distinct
			node_1,	node_2,
			n.x, 		n.y,	
			m.x,		m.y	

	from		node				N,
			node				M,
(
	select	c1.esri_node		esri_1,
			c2.esri_node		esri_2,
			c1.node_id			node_1,
			c2.node_id			node_2

	from		corner			C1,
			corner			C2

	where		 c1.node_id	= c2.node_id
	and		(c1.rowid,	c2.rowid)		in
(
	select	min(c.rowid),	max(c.rowid)	

	from		corner			C,
			Block_Region_view		B1,
			Block_Region_view		B2

	where		b1.rowid = c.block1_rowid
	and		b2.rowid = c.block2_rowid

	group by	b1.addr_name, b1.addr_type, b1.addr_pfx, b1.addr_sfx, b1.addr_block,
			b2.addr_name, b2.addr_type, b2.addr_pfx, b2.addr_sfx, b2.addr_block
	having	count(*) = 2
))	

	where		n.esri_node	= esri_1
	and		m.esri_node	= esri_2
);

	commit;

	analyze table	gis_temp4		compute statistics;

--	======================================================================
--	insert twin compass intersections for first node

	set transaction	use rollback segment	rb1;

	explain plan	set statement_id = '222'	into garland.plan_table		for

	insert into	intersection
	(	
		addr1_name,
		addr1_type,                    
		addr1_pfx,                     
		addr1_sfx,                     
		addr1_block,                   

		addr2_name,                    
		addr2_type,                    
		addr2_pfx,                     
		addr2_sfx,                     
		addr2_block,                   

		corner_compass,
		twin_compass,
		node_id,                       
		intersect_id 	
	)                 
	select	
		addr1_name,
		addr1_type,                    
		addr1_pfx,                     
		addr1_sfx,                     
		addr1_block,                   

		addr2_name,                    
		addr2_type,                    
		addr2_pfx,                     
		addr2_sfx,                     
		addr2_block,                   

		corner_compass,

		decode (sign((n.y1 - n.y2) - (sign(n.y1 - n.y2) * :min_diff)),
			+1,		'N',
			-1,		'S',
			null)
		||
		decode  (sign((n.x1 - n.x2) - (sign(n.x1 - n.x2) * :min_diff)),
			+1,		'E',
			-1,		'W',
			null),
			
		node_id,                       
		intersect_id

	from	intersection		X,
		twin_compass_view		T
	where	x.node_id = t.node1_id;

	commit;

--	======================================================================
--	insert twin compass intersections for second node

	set transaction	use rollback segment	rb1;

	explain plan	set statement_id = '333'	into garland.plan_table		for

	insert into	intersection
	(	
		addr1_name,
		addr1_type,                    
		addr1_pfx,                     
		addr1_sfx,                     
		addr1_block,                   

		addr2_name,                    
		addr2_type,                    
		addr2_pfx,                     
		addr2_sfx,                     
		addr2_block,                   

		corner_compass,
		twin_compass,
		node_id,                       
		intersect_id 	
	)                 
	select	
		addr1_name,
		addr1_type,                    
		addr1_pfx,                     
		addr1_sfx,                     
		addr1_block,                   

		addr2_name,                    
		addr2_type,                    
		addr2_pfx,                     
		addr2_sfx,                     
		addr2_block,                   

		corner_compass,

		decode (sign((n.y2 - n.y1) - (sign(n.y2 - n.y1) * :min_diff)),
			+1,		'N',
			-1,		'S',
			null)
		||
		decode  (sign((n.x2 - n.x1) - (sign(n.x2 - n.x1) * :min_diff)),
			+1,		'E',
			-1,		'W',
			null),
			
		node_id,                       
		intersect_id

	from	intersection		X,
		twin_compass_view		T

	where	x.node_id = t.node2_id;

	commit;

--	======================================================================

	set transaction	use rollback segment	rb1;

	explain plan	set statement_id = '444'	into garland.plan_table		for

	update	intersection
	set		intersect_id = intersect_id || twin_compass
	where		twin_compass > 'A';

	commit;

--	======================================================================

	alter rollback segment	rb1		offline;

--	======================================================================
	select * from garland.explain_plan;
--	select * from garland.explain_analyze;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_cost;
--	select * from garland.explain_remote;
--	======================================================================

	set echo on;

--	desc corner;
--	desc intersection;

