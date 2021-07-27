	set echo off;
--	==================================================================
--	Find addresses in which a single street type occurs 
--	very few times in a very small percentage
--	==================================================================

	variable	smallcount		number;
	variable	smallpercent	number;

	execute	:smallcount		:= 02;		-- SPECIFY

	execute	:smallpercent	:= 0.5;		-- SPECIFY

--	==================================================================

	select addr_name, addr_type, addr_pfx, addr_sfx, addr_num
	from	garland.cdreladr
	where	addr_name   in
(
	select addr_name	from

(	
	select t.addr_name, t.addr_type, t.counter, n.counter
	from	
(
	select	addr_name, 			count(addr_type) counter
	from		garland.cdreladr
	group by	addr_name
)			N,

(
	select	addr_name, addr_type,  count(*) counter
	from		garland.cdreladr
	group by	addr_name, addr_type
)			T

	where	n.addr_name	= t.addr_name


	and	t.counter / n.counter	<  :smallpercent	

	and	t.counter 			<= :smallcount

))

	order by 1,2,3,4,5;

--	==================================================================
	set echo on;


