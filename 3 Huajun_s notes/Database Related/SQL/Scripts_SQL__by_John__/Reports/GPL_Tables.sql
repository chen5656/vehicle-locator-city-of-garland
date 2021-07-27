
--	------------------------------------------------------------------------------------------
--	Address List
--	------------------------------------------------------------------------------------------

	select distinct
		addr_name		||','||
		addr_type		||','||
		addr_pfx		||','||
		addr_sfx		||','||
		addr_num		||','||
		x_coord		||','||
		y_coord		||','||
		parcel_id		||','||
		mslink
	from	cdreladr
	where (addr_name, addr_type, addr_pfx, addr_sfx, addr_num, mslink)
	in
(
	select	addr_name, addr_type, addr_pfx, addr_sfx, addr_num, max(mslink)
	from		cdreladr
	where		rtrim(unit_type) is null
	and		rtrim(unit_num)  is null
	group by	addr_name, addr_type, addr_pfx, addr_sfx, addr_num
)
	order by 1;


--	------------------------------------------------------------------------------------------
--	Street List
--	------------------------------------------------------------------------------------------

	select distinct
		addr_name		||','||
		addr_type		||','||
		addr_pfx		||','||
		addr_sfx		||','||
		addr_lo		||','||
		addr_hi		||','||
		addr_left_lo	||','||
		addr_left_hi	||','||
		addr_rght_lo	||','||	
		addr_rght_hi	||','||	
		mslink
	from	trvehrcl;


--	------------------------------------------------------------------------------------------
--	Intersection List
--	------------------------------------------------------------------------------------------

	select distinct
		addr1_name			||','||
		addr1_type			||','||
		addr1_pfx			||','||
		addr1_sfx			||','||
		addr2_name			||','||
		addr2_type			||','||
		addr2_pfx			||','||
		addr2_sfx
	from	intersection
	where	intersect_id like 'AA%';

