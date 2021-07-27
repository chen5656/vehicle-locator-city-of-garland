	set echo off;
--	===============================================================
--	Show Code_District record corresponding to address
--	Show CCS_ADDRESSES record corresponding to address
--	===============================================================

	variable strname		varchar2(40);
	variable strnum		number;
	execute  :strnum  :=	1501;
	execute  :strname := 	'FIRST';

--	===============================================================
--	Show Code District

	select *
	from garland.Code_District_new	C
	where parcel_id || '.000'
	in
(
	select parcel_id
	from garland.cdreladr
	where	addr_name = :strname
	and	addr_num  = :strnum
);

--	===============================================================
--	Show CCS_Addresses

	select 'CCS' "CCS", lpad(inspector_dist,04) dist,
				parcel_id, 		 
				lpad(addr_number, 06)	num, 
				rpad(addr_prefix, 03)	pfx, 
				rpad(addr_name,	20)	name, 
				rpad(addr_type,	04)	type,
				rpad(addr_suffix,	03)	sfx
	from garland.ccs_addresses		C
	where parcel_id in
(
	select parcel_id
	from garland.cdreladr
	where	addr_name = :strname
	and	addr_num  = :strnum
);

--	===============================================================
--	Show GIS Address

	select 'GIS' "GIS", parcel_id, 		 
				lpad(addr_num, 06) num, 
				rpad(addr_pfx, 03) pfx, 
				rpad(addr_name,20) name, 
				rpad(addr_type,04) type,
				rpad(addr_sfx, 03) sfx
	from garland.CDRELADR		A
	where addr_name	= :strname
	and	addr_num	= :strnum;

--	===============================================================
--	Show TAX Address

	select 'TAX' "TAX", parcel_id, 		 
				lpad(addr_num, 06) num, 
				rpad(addr_pfx, 03) pfx, 
				rpad(addr_name,20) name, 
				rpad(addr_type,04) type,
				rpad(addr_sfx, 03) sfx
	from garland.adrResult_Tax_GDS	A
	where addr_name	= :strname
	and	addr_num	= :strnum;


--	===============================================================
--	Show UMS Address

	select 'UMS' "UMS", parcel_id, addr_num, addr_pfx, addr_name, addr_type, addr_sfx
	from garland.adrResult_UMS_Location		A
	where addr_name	= :strname
	and	addr_num	= :strnum;

--	===============================================================
