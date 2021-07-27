
--	======================================================================================
--	how many Corner nodes have more than 2 regions
--	which Spokes use these nodes

	select	*							--	00
	from		spoke
	where		esri_node	in
(
--	select	esri_node

	select	count(count(*))
	from		gis_app_rowid	g,
			corner		c,
			Block_Region_view	b1,
			Block_Region_view	b2

	where		g.row_id	= c.rowid
	and		b1.rowid	= c.block1_rowid
	and		b2.rowid	= c.block2_rowid

	group by	c.esri_node
--	having	count(distinct b1.region) > 3		--	00
	having	count(distinct b1.region) > 2		--	10
--	having	count(distinct b1.region) > 1		--	347
)	;

--	======================================================================================
--	how many Corner spokes have more than 1 region

(
	select	count(count(*))				--	00
	from		gis_app_rowid	g,
			corner		c,
			Block_Region_view	b1,
			Block_Region_view	b2

	where		g.row_id	= c.rowid
	and		b1.rowid	= c.block1_rowid
	and		b2.rowid	= c.block2_rowid

	group by	c.esri_node,
			b1.addr_name, b1.addr_type, b1.addr_pfx, b1.addr_sfx, b1.addr_block
	having	count(distinct b1.region) > 1	
)	;

--	======================================================================================
--	how many Corner nodes contain at least one empty region

	select	count(count(*))			--	2868
	from		gis_app_rowid	g,
			corner		c,
			Block_Region_view	b1,
			Block_Region_view	b2

	where		g.row_id	= c.rowid
	and		b1.rowid	= c.block1_rowid
	and		b2.rowid	= c.block2_rowid
	and	(	nvl(b1.region,'0') <= '0'
	or		nvl(b2.region,'0') <= '0'	)

	group by	c.esri_node
	having	count(*) > 0;


--	======================================================================================
--	how many Block Sides contain an empty region

	select count(*)					--	6626
	from	 Block_Region_view
	where	 nvl(region,'0') <= '0';

--	======================================================================================
