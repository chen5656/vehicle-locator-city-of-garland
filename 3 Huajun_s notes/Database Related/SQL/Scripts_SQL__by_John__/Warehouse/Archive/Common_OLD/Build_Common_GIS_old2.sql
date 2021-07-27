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

--	===========================================================================
--	explain plan set statement_id = 'query'	into garland.plan_table	for

	insert --+ append
	into	 JDEACUTIS.Common_GIS
	select --+ use_hash(x)
		a.streetnum,
		a.streetprefix,
		a.streetname,
		a.streettype,
		a.streetsuffix,
		null, null,
		a.addressid,
		p.parcel_id,
		b.block_id,
		r.mslink,
		null, null,
		rownum,			-- parent_id   APR 2005
		null, null
	from
		gis.ADDRESS			A,
		garland.cdrelPAR		P,
		garland.Block		B,
		garland.trvehRCL		R
	where	a.parcelid||'.000'		= p.parcel_id 	(+)
	and	a.streetprefix			= b.addr_pfx	(+)
	and	a.streetname			= b.addr_name	(+)
	and	a.streettype			= b.addr_type	(+)
	and	a.streetsuffix			= b.addr_sfx	(+)
	and	trunc(a.streetnum, -2)	= b.addr_block	(+)
	and	b.addr_pfx			= r.addr_pfx	(+)
	and	b.addr_name			= r.addr_name	(+)
	and	b.addr_type			= r.addr_type	(+)
	and	b.addr_sfx			= r.addr_sfx	(+)
	and	b.addr_block	between trunc(r.addr_lo (+),-2)  and trunc(r.addr_hi (+), -2)
	and	a.streetnum		 > 0
	and	a.streetnum		 not between 9000 and 9999
	and	rtrim(a.unit)  is null
	and	rtrim(a.building) is null
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
		null, null, null,	null, null,	null,	null, null
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

--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;

--	===========================================================================
/*	find duplicate addresses

--	select count(*) from
	
	select * from
(	
	select * from jdeacutis.common_gis
 	where  (addr_name,addr_type, addr_pfx, addr_sfx, addr_num)	IN
(
 	   select addr_name,addr_type, addr_pfx, addr_sfx, addr_num  
	   from	  jdeacutis.common_gis 		    
 	   group by addr_name,addr_type, addr_pfx, addr_sfx, addr_num
	   having count(*) > 1
)
 	   order by addr_name,addr_type, addr_pfx, addr_sfx, addr_num
)
 	   where rownum < 111;
*/
--	===========================================================================