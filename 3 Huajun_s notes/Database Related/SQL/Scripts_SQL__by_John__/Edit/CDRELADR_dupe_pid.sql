	Set echo off;
	select rpad(' ',70) " " from dual;

--	=====================================================
--	display duplicate parcel id's in cdreladr
--	=====================================================
		
	select
--+	all_rows

--		count(*)	"dupe pid"


		rpad (parcel_id,	12)		"parcel",
		rpad (mslink,	06)		"mslink",
Rpad		(
		rpad (addr_num, 05)	|| ' ' ||
		rpad (addr_pfx, 01)	|| ' ' ||	
		rpad (addr_name,19)	|| ' ' ||	
		rpad (addr_type,04)	|| ' ' ||
		rpad (addr_sfx, 01)	|| ' ' ||
		addr_bldg			|| ' ' ||
		unit_type			|| ' ' ||
		unit_num,
		45	)				"address"

		,addr_status			"sta"
--		,unit_aux,
--		,rpad(map_grid,2)			"grid"


	from	cdreladr
	where	nvl (lower (rtrim (addr_status)), ' ') <> 'd' 

	and	parcel_id	
	in
		(		
		select	parcel_id
		from		cdreladr
		group by	parcel_id
		having	count(*) > 1
		)

	order by	parcel_id,
			addr_name,
			addr_type,
			addr_pfx,
			addr_sfx,
			addr_num
	;


Set echo on;
