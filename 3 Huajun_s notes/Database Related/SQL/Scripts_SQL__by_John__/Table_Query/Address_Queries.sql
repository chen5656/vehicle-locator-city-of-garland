	set echo	off;

--	=====================================================================================================
--	Total Addresses

	select count(*) "Address"
	from	garland.cdreladr;

--	=====================================================================================================
--	Total Prefixes		(count = 5806)

	select	count(*) "Prefix"
	from		garland.cdreladr
	where		addr_pfx > ' ';

--	=====================================================================================================
--	Total Suffixes		(count = 5)

	select	count(*) "Suffix"
	from		garland.cdreladr
	where		addr_sfx > ' ';

--	=====================================================================================================
--	Total Blank Types		(count = 1000)

	select	count(*) "Blank Type"
	from		garland.cdreladr
	where		addr_type = ' ';

--	=====================================================================================================
--	Total Units

	select count(*) "Units"
	from	garland.cdreladr
	where	unit_type > ' '
	or	unit_num  > ' ';

--	=====================================================================================================
--	How many Street Types per Street Name

	select	counter "Type/Name  ", count(*) "    total"
	from
(
	select	addr_name,	count(distinct addr_type) counter
	from		garland.cdreladr
	group by	addr_name
)
	group by	counter;	

--	=====================================================================================================
--	How many Street Prefixes per Street Name

	select	counter "Pref/Name", count(*) "    total"
	from
(
	select	addr_name,	count(distinct addr_pfx) counter
	from		garland.cdreladr
	group by	addr_name
)
	group by	counter;	

--	=====================================================================================================
--	How many Street Suffixes per Street Name

	select	counter "Suff/Name", count(*) "    total"
	from
(
	select	addr_name,	count(distinct addr_sfx) counter
	from		garland.cdreladr
	group by	addr_name
)
	group by	counter;	

--	=====================================================================================================
--	Lone Prefixes		(count = 4962)

	select	count(*) "Lone Pref"
--	select	'Lone Prefix  ' " ", addr_num " ", addr_pfx " ", addr_name " ", addr_type " ", addr_sfx " "
	from		garland.cdreladr

	where	   (	addr_num, addr_name, addr_type, addr_sfx )	in
(
	select	addr_num, addr_name, addr_type, addr_sfx
	from		garland.cdreladr
	where		addr_pfx > ' '
	group by	addr_name, addr_type, addr_sfx, addr_num
	having	count(distinct addr_pfx) = 1
)
	order by	addr_name, addr_type, addr_pfx, addr_sfx, addr_num;

--	=====================================================================================================
--	Odd Prefixes

	select	count(*) "Odd Prefix"
--	select	distinct 'Odd Prefix  ' " ", addr_pfx " ", addr_name " ", addr_type " ", addr_sfx " "

	from		garland.cdreladr
	where	(	addr_name, addr_type, addr_sfx)	in
(
	select	addr_name, addr_type, addr_sfx
	from		garland.cdreladr
	group by	addr_name, addr_type, addr_sfx 
	having	variance (decode (addr_pfx, ' ',0,	'N',1, 'S',1, 'E',2, 'W',2 )) > 0
)
	order by	addr_name, addr_type, addr_pfx, addr_sfx;

--	=====================================================================================================
--	Odd Prefix Pairs		(count = 60)

	select count(*) "Odd Prefix"
--	select	'Odd Prefix  ' " ",
--			addr_num, addr_pfx " ", addr_name " ", addr_type " ", addr_sfx " "

	from		garland.cdreladr
	where	   (	addr_num, addr_name, addr_type  )	in
(
	select	addr_num, addr_name, addr_type
	from		garland.cdreladr
	group by	addr_name, addr_type, addr_num
	having	variance (decode (addr_pfx, ' ',0,	'N',1, 'S',1, 'E',2, 'W',2 )) > 0
)
	order by	addr_name, addr_type, addr_num, addr_pfx, addr_sfx;

--	=====================================================================================================
--	Odd Suffix Pairs		(count = 0)

	select count(*) "Odd Suffix"
--	select	'Odd Suffix  ' " ",
--			addr_num " ", addr_sfx " ", addr_name " ", addr_type " ", addr_pfx " "

	from		garland.cdreladr
	where	   (	addr_num, addr_name, addr_type, addr_pfx )	in
(
	select	addr_num, addr_name, addr_type, addr_pfx
	from		garland.cdreladr
	group by	addr_name, addr_type, addr_pfx, addr_num
	having	variance (decode (addr_sfx, ' ',0,	'N',1, 'S',1, 'E',2, 'W',2 )) > 0
)
	order by	addr_name, addr_type, addr_num, addr_pfx, addr_pfx;

--	=====================================================================================================
--	Total Blocks 						(count = 8692)

	select	count(*) "Blocks"
	from		adrBlock;

--	=====================================================================================================
--	Blocks with Addresses on only One Side		(count = 1933)

	select	count(count(*)) "1 Side Blk"
--	select	'1 Side Blk  ' " ", block " ", addr_pfx " ", addr_name " ", addr_type " ", addr_sfx " ",
--			decode(max(parity), 0,'even', 1,'odd') " "

	from		
(
	select	distinct	addr_name, addr_type, addr_pfx, addr_sfx, trunc(addr_num, -2) block, 
					mod(addr_num,2) parity
	from		garland.cdreladr
)
	group by	addr_name, addr_type, addr_pfx, addr_sfx, block
	having	count(distinct parity) = 1

	order by	addr_name, addr_type, addr_pfx, addr_pfx, block;

--	=====================================================================================================

	set echo	on;
