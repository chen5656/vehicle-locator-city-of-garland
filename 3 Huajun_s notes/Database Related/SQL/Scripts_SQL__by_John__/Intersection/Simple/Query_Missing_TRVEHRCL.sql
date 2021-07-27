	set echo off;
--	===============================================================================
--	What Centerline streets are missing from the Intersection table

--	Most of these are dead end streets
--	===============================================================================

--	select count(*)	primary

	select	
		lpad(addr_block,	05)		block, 
		rpad(addr_pfx,	03) 		pre,
		rpad(addr_name,	20) 		name,
		rpad(addr_type,	04) 		type,
		rpad(addr_sfx,	03) 		suf
	from

(
	select	
		trunc(addr_lo,-2)||''		addr_block, 
		addr_name,
		addr_type,
		addr_pfx,
		addr_sfx

	from	trvehrcl
	where	addr_name > '0'
	and	addr_lo  <> 0
	and	addr_lo  <> 9999

--	and	rownum < 111

	minus

	select	strblok1, strname1, strtype1, strpre1, strsuf1 
	from		temp_view4
	where		intersect_type = 'BB'
)

	order by	3,4,2,5,1;

--	===============================================================================

--	select count(*)	secondary

	select	
		lpad(addr_block,	05)		block, 
		rpad(addr_pfx,	03) 		pre,
		rpad(addr_name,	20) 		name,
		rpad(addr_type,	04) 		type,
		rpad(addr_sfx,	03) 		suf
	from

(
	select 
		trunc(addr_lo,-2)||''	addr_block, 
		addr_name, addr_type, addr_pfx, addr_sfx
	from	trvehrcl
	where	addr_name > '0'
	and	addr_lo  <> 0
	and	addr_lo  <> 9999

	minus

	select	strblok2, strname2, strtype2, strpre2, strsuf2 
	from		temp_view4
	where		intersect_type = 'BB'
);

--	===============================================================================
	set echo on;
