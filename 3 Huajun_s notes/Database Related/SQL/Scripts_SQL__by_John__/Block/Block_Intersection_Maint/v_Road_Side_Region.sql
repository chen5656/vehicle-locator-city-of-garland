--	VIEW ROAD SIDE REGION


	set echo	off;
--	===========================================================================

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

	explain plan set statement_id = 'xxx'		into garland.plan_table	for
--	===========================================================================

	create or replace view	garland.temp_view		as

	select all * from
(
	select
		s.road_id,
		s.side,
		00001				region_type,		--  SPECIFY
		s.parity,
		p.POLICE_BEAT		region_id,			--  SPECIFY

		count(*)			Counter

	from	garland.Radial_Side		s,
		garland.Trvehrcl			r,
		garland.Cdreladr			a,
		garland.Cdrelpar			p

	where	s.road_id		= r.mslink
	and	a.parcel_id		= p.parcel_id
	and	a.addr_name		= r.addr_name
	and	a.addr_type		= r.addr_type
	and	a.addr_pfx		= r.addr_pfx
	and	a.addr_sfx		= r.addr_sfx
	and	a.addr_num  between r.addr_lo  and  r.addr_hi

	group by
		s.road_id,
		s.side,
		s.parity,
		p.POLICE_BEAT			--  SPECIFY
)
	order by
		road_id,
		side,
		parity,
		counter desc
		region_id;

--	===========================================================================
	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_analyze;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;

	ROLLBACK;
	commit;
	alter rollback segment rb1 offline;

--	===========================================================================
/*	SQL View Format Verification

	create or replace view   temp_view   as

	select distinct  
		 addr_name, addr_type, 
		 1			id,
		 count(*) 		counter

	from	 adrStreets
	group by addr_name, addr_type
	order by 1, 2, 4 desc;

	select * from temp_view		.where rownum < 11;

------------------------------------------------------------
NOTE

x.	A segment side should occur in only 1 block-block intersection


*/
--	===========================================================================
	set echo on;
