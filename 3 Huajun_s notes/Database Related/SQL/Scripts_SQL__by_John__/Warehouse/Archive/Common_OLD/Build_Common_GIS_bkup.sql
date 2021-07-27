	set echo	off;
    set linesize	2000;
--	===========================================================================
--	Build Common GIS
--	without Intersection IDs
--	without Unit info
--	===========================================================================

	Truncate table	JDEACUTIS.Common_GIS	reuse storage;

--	===========================================================================

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
--	explain plan set statement_id = 'query'	into garland.plan_table	for

	insert	--+ append
	into		JDEACUTIS.Common_GIS

	select --+ use_hash(x)

		a.addr_num,
		a.addr_pfx,
		a.addr_name,
		a.addr_type,
		a.addr_sfx,
		null, null,

		a.mslink,
		a.parcel_id,
		b.block_id,
		r.mslink,
		null, null,
		null,
		null, null
		a.address_type
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
	alter rollback segment rb1 offline;

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

		null, null, null,	null, null,	null,	null, null
	);

	commit;

--	===========================================================================
--	remove duplicate address id
--	due to multiple Road ID
--	due to overlapping Centerline segments

--	@c:\deacutis\scripts\warehouse\Common\Remove_Dupe_GIS.sql;

--	===========================================================================

--	analyze table	JDEACUTIS.Common_GIS	compute statistics;

--	===========================================================================

--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;

--	===========================================================================
	set echo	on;


