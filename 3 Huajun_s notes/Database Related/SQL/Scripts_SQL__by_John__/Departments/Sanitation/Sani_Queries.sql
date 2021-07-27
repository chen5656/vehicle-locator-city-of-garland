
--	SANITATION COMMERCIAL & ASSET

--	======================================================================

	select count(*)	from sani_commercial;			--	5478

	select count(*)	from sani_asset;				--	1698

	select count(*)	from gis_objects;				--	1381

	select count(*)	from gis_objects				--	1060
	where item02 > '0';

--	======================================================================
--	how many complete		match/differ				43

	select count(*)	from adrResult	
	where	 (addr_name, addr_num, addr_type, addr_pfx, addr_unit)		in
(
	select addr_name, rtrim(addr_num), addr_type, addr_pfx, addr_unit
	from	adrResult

	intersect

	select addr_name, addr_num, addr_type, addr_pfx, addr_unit
	from	sani_asset
);

--	======================================================================
--	how many name, number, unit	match/differ			88 

	select count(*)	from adrResult	
	where	 (addr_name, addr_num, addr_unit)		in
(
	select addr_name, rtrim(addr_num), addr_unit
	from	adrResult

	intersect

	select addr_name, addr_num, addr_unit
	from	sani_asset
);

--	======================================================================
--	what sani_commercial results are not unique			259

	select *	from adrResult
	where		(addr_name, addr_type, addr_pfx, addr_num, addr_unit)		in 

(
	select	addr_name, addr_type, addr_pfx, addr_num, addr_unit 
--		 	,count(*)

	from	adrResult

	group by	addr_name, addr_type, addr_pfx, addr_num, addr_unit
	having count(*) > 1
);

--	======================================================================
--	what sani_commercial results & addresses are not unique	259

	select --+ rule 

		''	" "
		,lpad(r.rec_key,06) ||' / '|| rpad(r.rec_seq,06)  "   key / seq" 
		,r.addr_num "     num", r.addr_pfx "pf", rpad(r.addr_name,20) "name", r.addr_type "type" 
		,rpad(r.addr_unit,5) "unit"
--		,a.*

	from	adrResult		r,
		gis_app_addr	a

	where	a.rowid = r.rec_rowid

	and	(r.addr_name, r.addr_type, r.addr_pfx, r.addr_num, r.addr_unit)	in 
(
	select	addr_name, addr_type, addr_pfx, addr_num, addr_unit 
	from		adrResult
	group by	addr_name, addr_type, addr_pfx, addr_num, addr_unit
	having 	count(*) > 1
);

--	======================================================================
--	how many unique asset name & number					1815

	select addr_name, addr_num, count(*)
	from	 sani_asset
	group by	addr_name, addr_num
	having	count(*) = 1;

--	======================================================================
--	how many unique asset name & number	& unit			268

	select addr_name, addr_num, addr_unit, count(*)
	from	 sani_asset
	where	 	addr_unit > ' '
	group by	addr_name, addr_num, addr_unit
	having	count(*) = 1;

--	======================================================================
--	how many name & number matches					1815

	select count(*)	from adrResult	
	where	 (addr_name, addr_num)			in
(
	select addr_name, rtrim(addr_num)
	from adrResult

	intersect

	select addr_name, addr_num
	from sani_asset
);

--	======================================================================
--	how many name/num matches for non-matched assets

	select count(*)							--	22

	from	adrResult	r,
		cdreladr	a

	where	r.addr_name	= a.addr_name
	and	r.addr_num	= a.addr_num

	and	(r.addr_name, rtrim(r.addr_num), r.addr_type, r.addr_pfx, r.addr_unit)	in


--	select count(*)	from adrResult	
--	where	 (addr_name, addr_num, addr_type, addr_pfx, addr_unit)		in


--	unique address differences						--	66
(
	select addr_name, rtrim(addr_num), addr_type, addr_pfx, addr_unit
	from	adrResult

	minus

	select addr_name, addr_num, addr_type, addr_pfx, addr_unit
	from	sani_asset
);

--	======================================================================
