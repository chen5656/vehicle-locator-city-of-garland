	Set 	echo 		off;
	set	charwidth	125;
--	************************************************************************************

	select rpad (' ', 070) " " from dual;
	select rpad (' ',125)  " " from dual;

--	=====================================================
--	display duplicate addresses 	in cdreladr
--	display orphan parcel ids 	in cdreladr & cdrelpar
--	=====================================================
		
	select
--+	all_rows
		rpad (a.mslink,06)				"MSLINK",
		rpad (a.parcel_id,15)				"PARCEL ID",
		rpad (
		rpad (addr_num,5)		|| ' ' ||
		rpad (addr_pfx,1)		|| ' ' ||	
		rpad (addr_name,17)		|| ' ' ||	
		rpad (addr_type,4)		|| ' ' ||
		rpad (addr_sfx,1)		|| ' ' ||
		addr_bldg			|| ' ' ||
		unit_type			|| ' ' ||
		unit_num			||' '||
		' '
		,40)							"ADDRESS",
		x_coord, y_coord,
		p.mslink						"PARCEL MSLINK"

--		,rpad(addr_status,1)				" "
--		,lpad (map_grid, 02)				" "

	from	cdreladr		a,
		cdrelpar		p

	where	a.parcel_id	= p.parcel_id (+)
	and	nvl (lower (rtrim (addr_status)), ' ') <> 'd'

	and	addr_num <> 9999				--  FILTER

	and	
	(
		addr_num,
		addr_pfx,
		addr_name,
		addr_type,
		addr_sfx		
	)
	in	
	(	
	select
		addr_num,
		addr_pfx,		
		addr_name,
		addr_type,
		addr_sfx		
	from	cdreladr
	where	nvl (lower (rtrim (addr_status)), ' ') <> 'd'

	group by
		addr_name,
		addr_type,
		addr_pfx,
		addr_sfx,
		addr_num
	having	count(*) > 1
	)

	order by	addr_name,
			addr_type,
			addr_pfx,
			addr_sfx,
			addr_num
	;

--	===========================================================
/*	display parcel orphans
--	===========================================================

--	select	all *				from cdrelpar
	select	count(*)	"ADR-PAR"	from cdrelpar		--	00
	where		parcel_id	in
(
	select	parcel_id		from cdreladr
	minus
	select	parcel_id		from cdrelpar
);


--	select	all *				from cdrelpar
	select	count(*)	"PAR-ADR"	from cdrelpar		--	2396
	where		parcel_id	in
(
	select	parcel_id		from cdrelpar
	minus
	select	parcel_id		from cdreladr
);
		
*/

--	************************************************************************************
Set	echo on;
