--	=====================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
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
		a.streetnum,
		a.streetprefix,
		a.streetname,
		a.streettype,
		a.streetsuffix,
		null, null,
		a.addressid,
		a.parcelid || '.000',
		b.block_id,
		r.roadid,
		null, null,
		rownum,			
		null, null,
		a.addresstype		
	from
		gis.ADDRESS		A,
		gis.ROAD		R,
		garland.Block	B
	where	a.streetprefix		= b.addr_pfx	(+)
	and	a.streetname		= b.addr_name	(+)
	and	a.streettype		= b.addr_type	(+)
	and	a.streetsuffix		= b.addr_sfx	(+)
	and	trunc(a.streetnum, -2)	= b.addr_block	(+)
	and	b.addr_pfx			= r.streetprefix(+)
	and	b.addr_name			= r.streetname	(+)
	and	b.addr_type			= r.streettype	(+)
	and	b.addr_sfx			= r.streetsuffix(+)
	and	b.addr_block	between trunc(r.rangelo (+),-2)  and trunc(r.rangehi (+), -2)
	and	a.streetnum		 > 0
	and	a.streetnum		 not between 9000 and 9999
	and	rtrim(a.unit)  	is null
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
		null, null, null,	null, null,	null,	null, null, null
	);

	commit;

--	===========================================================================

	analyze table	JDEACUTIS.Common_GIS	compute statistics;

--	===========================================================================

--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;

--	===========================================================================
/*
	update jdeacutis.common_gis
	set	parcel_id = '89' || substr(parcel_id,3)
	where	parcel_id like '4A%';
	commit;
*/
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