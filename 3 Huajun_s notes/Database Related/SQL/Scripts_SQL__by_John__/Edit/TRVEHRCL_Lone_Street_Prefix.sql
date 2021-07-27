	set echo off;
--	==================================================================
--	Find addresses in which a single street type occurs 
--	a very few times in a very small percentage
--	Optionally: Look for blank prefix (see bottom of query)
--	==================================================================

	variable	smallcount		number;
	variable	smallpercent	number;

	execute	:smallcount		:= 05;
	execute	:smallpercent	:= 0.3;

--	==================================================================

	select addr_pfx, addr_name, addr_type, addr_sfx, addr_lo, addr_hi
	from	garland.TRVEHRCL
	where	addr_name   in
(
	select addr_name	from

(	
	select t.addr_name, t.addr_pfx, t.counter, n.counter
	from	
(
	select	addr_name, addr_type,		count(addr_pfx) counter
	from		garland.TRVEHRCL
	group by	addr_name, addr_type
)			N,

(
	select	addr_name, addr_type, addr_pfx,  count(*) counter
	from		garland.TRVEHRCL
	group by	addr_name, addr_type, addr_pfx
)			T

	where	n.addr_name	= t.addr_name
	and	n.addr_type	= t.addr_type

	and	t.counter / n.counter	<= :smallpercent	

	and	t.counter 			<= :smallcount

	and	t.addr_pfx = ' '		--	OPTIONAL SPECIFICATION

))

	order by 1,2,3,4,5;

--	==================================================================
	set echo on;
