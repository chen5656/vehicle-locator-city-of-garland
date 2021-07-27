	set echo	off;
--	===========================================================================

	truncate table	garland.GIS_Objects	reuse storage;

--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
--	explain plan set statement_id =  'get'	into garland.plan_table	for

	insert	--+ append
	into		garland.gis_objects  (item01)

--	select	count(*)
	select	location_no

	from sfg.um00100m@umsp.world		L

	where	nvl(l.sec_addr_range,' ') not like ('%SPRINK%')

	and exists
(
	select 'x'
	from	 sfg.um00140t@umsp.world
	where	 location_no  = l.location_no
	and	 service_tp = 'WTR'
)

	and not exists
(
	select 'x'
	from	 sfg.um00140t@umsp.world
	where	 location_no  = l.location_no
	and	 service_tp = 'EL'
)

	and not exists
(
	select 'x'
	from	 sfg.um00140t@umsp.world
	where	 location_no  = l.location_no
	and	 service_tp = 'SPK'
)

	and not exists
(
	select 'x'
	from	 sfg.um00100m@umsp.world	a,
		 sfg.um00140t@umsp.world	b

	where	 a.location_no	<> l.location_no
	and	 a.location_no	=  b.location_no

	and	 a.house_no		= l.house_no
	and	 a.street_nm	= l.street_nm

	and	 nvl(a.street_nm_sfx, ' ')	= nvl(l.street_nm_sfx, ' ')
	and	 nvl(a.street_pfx_dir,' ')	= nvl(l.street_pfx_dir,' ')
	and	 nvl(a.street_sfx_dir,' ')	= nvl(l.street_sfx_dir,' ')

	and	 b.service_tp = 'EL'
)
	;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;

	commit;
	alter rollback segment rb1 offline;

