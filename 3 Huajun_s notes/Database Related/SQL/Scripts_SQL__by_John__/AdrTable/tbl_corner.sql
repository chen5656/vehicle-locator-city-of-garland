
/*

	drop table		corner;

	create table	corner
(
	record_id			number,
	corner_id			number,
	node_id			number,

	side1_id			number,
	side2_id			number,

	block1			number,
	block2			number,

	compass			char(2)
);


*/


--	===============================================================================
/*

	select	x.*,			--	intersecting streets
			c.*,			--	intersecting hundred blocks
			b.*			--	geographic regions

	from		Intersection	x,
			Corner		c,
			adrBlock_Side	b

	where		x.record_id		= c.record_id
	and		b.side_id		= c.side1_id

--	possible types of filters (or some combination)
	
	and		x.addr1_name	= 'FIFTH'
	and		x.addr2_name	= 'AUSTIN'
	
	and		x.addr1_type	= 'ST'
	and		x.addr2_type	= 'ST'
	
	and		x.addr1_pfx		= 'N'
	and		x.addr2_pfx		= ' '
	
	and		x.addr1_sfx		= ' '
	and		x.addr2_sfx		= ' '

	and		c.block1		= 200
	and		c.block2		= 500

	and		c.compass		like '%E'

	and		b.police_beat	= '21'

*/
--	===============================================================================
