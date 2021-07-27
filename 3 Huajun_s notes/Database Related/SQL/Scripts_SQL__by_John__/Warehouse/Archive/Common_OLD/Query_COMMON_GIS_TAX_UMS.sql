	set echo off;
    set linesize	2000;
--	======================================================================================================
--	Show	CCS  GIS  TAX  UMS  KEY  SEQ  CODE records for a specified address
--	======================================================================================================

	variable	strname	varchar2(40);
	variable	strnum	number;

	execute	:strname :=	upper('WHITEOAK');	--	S P E C I F Y
	execute	:strnum :=	1602;				--	S P E C I F Y 

--	execute	:strname :=	upper('SHILOH');		--	S P E C I F Y
--	execute	:strnum :=	102;				--	S P E C I F Y 

--	======================================================================================================

	select * from garland.CCS_Addresses
	where	addr_name	= :strname
	and	addr_number = :strnum
	and	1 = 0;

--	======================================================================================================

	select 'CCS' CCS, address_id, 
				addr_number, addr_prefix, addr_name, addr_type, addr_suffix, 
				rpad(tax_owner,20) owner, rpad(ums_last_name,20) tenant,
				rpad(inspector_dist,04)	dist,	lpad(record_seq,06) seq 
--				,chr(10)||'      ' " "  ,tax_id ,ums_id ,tax_dcad
	from	garland.CCS_Addresses
	where addr_name   = :strname
	and	addr_number = :strnum;

--	======================================================================================================

	select 'GIS' GIS, address_id, parcel_id,
				addr_num, addr_pfx, addr_name, addr_type, addr_sfx, s.sequence
	from	garland.Common_GIS		G,
		garland.Common_Record_Seq	S
	where	g.addr_num  = :strnum
	and	g.addr_name = :strname
	and	g.address_id = s.gis_key;

/*
	select 'gis' "gis", address_id, parcel_id,
				addr_num, addr_pfx, addr_name, addr_type, addr_sfx
	from	garland.Common_GIS		G
	where	g.addr_num  = :strnum
	and	g.addr_name = :strname;
*/
--	======================================================================================================

	select 'TAX' TAX, lpad(tax_account,10) Account, tax_address_id,  
		tax_addr_num, tax_addr_pfx, tax_addr_name, tax_addr_type, tax_addr_sfx, 
		rpad(tax_owner,20) owner, s.sequence
	from	garland.Common_TAX		T,
		garland.Common_Record_Seq	S
	where	t.tax_addr_num  = :strnum
	and	t.tax_addr_name = :strname
	and	t.tax_address_id = s.gis_key;

/*
	select 'tax' "tax", lpad(tax_account,10) Account, tax_address_id,
		tax_addr_num, tax_addr_pfx, tax_addr_name, tax_addr_type, tax_addr_sfx, rpad(tax_owner,20) owner
	from	garland.Common_TAX		T
	where	t.tax_addr_num  = :strnum
	and	t.tax_addr_name = :strname;
*/
--	======================================================================================================

	select 'UMS' UMS, location_no, address_id,  
		addr_num, addr_pfx, rpad(addr_name,20) addr_name, addr_type, addr_sfx, 
		rpad(last_name,20) tenant,	s.sequence
	from	garland.Common_UMS		U,
		garland.Common_Record_Seq	S
	where	u.addr_num  = :strnum
	and	u.addr_name = :strname
	and	u.address_id = s.gis_key;

/*
	select 'ums' "ums", location_no, address_id,
		addr_num, addr_pfx, rpad(addr_name,20) addr_name, addr_type, addr_sfx, 
		rpad(last_name,20) tenant
	from	garland.Common_UMS		U
	where	u.addr_num  = :strnum
	and	u.addr_name = :strname;
*/
--	======================================================================================================

	select
		'EXT' EXT,
		lpad(nvl(gis_key,	   0), 06)		gis,
		lpad(nvl(tax_key,	   0), 06)		tax,
		lpad(nvl(ums_key,	   0), 06)		ums,
		rpad(nvl(parcel_id,' '), 11)		parcel, 
		lpad(nvl(addr_num,   0), 05)		num, 
		rpad(nvl(addr_pfx, ' '), 02)		pf, 
		rpad(nvl(addr_name,' '), 20)		name,
		rpad(nvl(addr_type,' '), 04)		type,	 
		rpad(nvl(addr_sfx, ' '), 02)		sf,
		lpad(sequence,		 08)		sequence
	from	garland.extract1_address_keys
	where addr_name	= :strname
	and	addr_num	= :strnum;

--	======================================================================================================

	select 'KEY' KEY,
		lpad(gis_key, 10)				"GIS",
		lpad(tax_key, 10)				"TAX",
		lpad(ums_key, 10)				"UMS",
		lpad(nvl(addr_num,   0), 05)		num, 
		rpad(nvl(addr_pfx, ' '), 02)		pf, 
		rpad(nvl(addr_name,' '), 20)		name,
		rpad(nvl(addr_type,' '), 04)		type,	 
		rpad(nvl(addr_sfx, ' '), 02)		sf,
		sequence					sequence

	from garland.common_address_keys	K
	where	addr_name = :strname	
	and	addr_num  = :strnum;

--	======================================================================================================

	select 'SEQ' SEQ, S.*
	from	garland.Common_GIS		U,
		garland.Common_Record_Seq	S
	where	u.addr_num  = :strnum
	and	u.addr_name = :strname
	and	u.address_id = s.gis_key;

--	======================================================================================================

	select 'Code' CODE, address_id, g.parcel_id,
				addr_num, addr_pfx, addr_name, addr_type, addr_sfx, 
				nuisance_district, rental_district, is_rental
	from	garland.Common_GIS		G,
		garland.Code_District		C
	where	g.addr_num  = :strnum
	and	g.addr_name = :strname
	and	c.parcel_id	= to_number(substr(g.parcel_id,1,7));

--	======================================================================================================

--	desc garland.CCS_Addresses;
--	desc garland.Common_GIS;
--	desc garland.Common_TAX;
--	desc garland.Common_UMS;
--	desc garland.Common_Address_Keys;
--	desc garland.Common_Record_Seq;

--	======================================================================================================

