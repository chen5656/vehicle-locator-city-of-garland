	set echo	off;
    set linesize	2000;
--	===========================================================================
--	Build Common GIS
--	without Intersection IDs
--	without Unit info
--	===========================================================================

	Truncate table	JDEACUTIS.Common_GIS	reuse storage;

--	===========================================================================
	insert --+ append
	into	 JDEACUTIS.Common_GIS
	select --+ use_hash(x)
		a.addr_num,
		a.addr_pfx,
		a.addr_name,
		a.addr_type,
		a.addr_sfx,
		null, null,
		a.mslink,
		a.parcel_id,
--		substr(a.parcel_id, 1, instr(a.parcel_id,'.') - 1),
		b.block_id,
		r.mslink,
		null, null,
		rownum,			-- parent_id   APR 2005
		null, null,
		a.address_type		--  aug 2006
	from
		garland.cdrelADR		A,
		garland.cdrelPAR		P,
		garland.Block		B,
		garland.trvehRCL		R
	where	a.parcel_id			= p.parcel_id 	(+)
	and	a.addr_pfx			= b.addr_pfx	(+)
	and	a.addr_name			= b.addr_name	(+)
	and	a.addr_type			= b.addr_type	(+)
	and	a.addr_sfx			= b.addr_sfx	(+)
	and	trunc(a.addr_num, -2)	= b.addr_block	(+)
	and	b.addr_pfx			= r.addr_pfx	(+)
	and	b.addr_name			= r.addr_name	(+)
	and	b.addr_type			= r.addr_type	(+)
	and	b.addr_sfx			= r.addr_sfx	(+)
	and	b.addr_block	between trunc(r.addr_lo (+),-2)  and trunc(r.addr_hi (+), -2)
	and	a.addr_num		 > 0
	and	a.addr_num		 not between 9000 and 9999
	and	rtrim(a.unit_num)  is null
	and	rtrim(a.unit_type) is null
--	AND	ROWNUM < 11
	;


--	===========================================================================

	commit;

--	===========================================================================

	insert into	JDEACUTIS.Common_GIS
	values
	(
		9999,
		' ',
		'DIRECTIONS ONLY',
		' ',
		' ',
		null, null,
		999999,
		null, null, null,	null, null,	null,	null, null,
		null
	);

	commit;

--	===========================================================================

	update jdeacutis.common_gis
	set	parcel_id = '89' || substr(parcel_id,3)
	where	parcel_id like '4A%';

	commit;

--	===========================================================================

	analyze table	JDEACUTIS.Common_GIS	compute statistics;

--	===========================================================================
