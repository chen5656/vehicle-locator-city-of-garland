	set echo	off;
--	===========================================================================
--	For each Address ID obtain GIS keys & Application keys
--	Applications:  TAX  UMS 
--	===========================================================================

	truncate table	garland.plan_table	reuse storage;

--	===========================================================================
	truncate table	garland.GIS_Objects	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
--	explain plan set statement_id = 'ref1'	into garland.plan_table	for

	insert --+ append
	into	 garland.GIS_Objects (item01, item02, item03)

	select segment_id, 'TAX', min(rec_key)	from adrResult_TAX_Account	group by segment_id	-- mslink

	union all
	select segment_id, 'UMS', min(rec_key)	from adrResult_UMS_Location	group by segment_id	-- mslink
	;

--	===========================================================================
	commit;

--	===========================================================================
	truncate table	garland.Common_GIS	reuse storage;

	set transaction use rollback segment rb1;

--	===========================================================================

--	truncate table	plan_table		reuse storage;
--	explain plan set statement_id = 'ref2'	into garland.plan_table	for

	insert	--+ append
	into		garland.Common_GIS

	select --+ use_hash(x)

		a.mslink,
		a.addr_id,
		a.parcel_id,
		b.block_id,
		s.street_id,
		x.intersect_id,
		null,				--	intersect_id2
		t.item03,			--    TAX
		u.item03			--	UMS

	from
		garland.cdrelADR		A,
		garland.cdrelPAR		P,
		garland.block		B,
		garland.adrStreets	S,
		garland.GIS_Objects	T,
		garland.GIS_Objects	U,

(
		select addr1_name, addr1_type, addr1_pfx, addr1_sfx, addr1_block,
			 min (intersect_id)	intersect_id
		from	garland.Intersection

		where	intersect_id like 'BB%'
		and	(addr1_name	<> addr2_name
		or	 addr1_type	<> addr2_type )

		group by addr1_name, addr1_type, addr1_pfx, addr1_sfx, addr1_block
)						X

	where	a.mslink			= to_number(u.item01)
	and	a.parcel_id			= p.parcel_id

	and	a.addr_pfx			= s.addr_pfx
	and	a.addr_name			= s.addr_name
	and	a.addr_type			= s.addr_type
	and	a.addr_sfx			= s.addr_sfx

	and	a.addr_pfx			= b.addr_pfx
	and	a.addr_name			= b.addr_name
	and	a.addr_type			= b.addr_type
	and	a.addr_sfx			= b.addr_sfx
	and	trunc(a.addr_num, -2)	= b.addr_block

	and	x.addr1_name   (+)	= b.addr_name
	and	x.addr1_type   (+)	= b.addr_type
	and	x.addr1_pfx	   (+)	= b.addr_pfx
	and	x.addr1_sfx	   (+)	= b.addr_sfx
	and	x.addr1_block  (+) 	= b.addr_block

	and	a.addr_num		 > 0
	and	a.addr_num		<> 9999
	and	rtrim(a.unit_num) is null

	and	t.item02	= 'TAX'
	and	u.item02	= 'UMS'
	and	u.item01	= t.item01		-- matching address id
	;

--	===========================================================================

	commit;
	alter rollback segment rb1 offline;

	analyze table	garland.Common_GIS	compute statistics;

--	===========================================================================

	select * from garland.explain_plan;
--	select * from garland.explain_indexed;

--	===========================================================================
	set echo	on;
