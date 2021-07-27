	set echo	off;
--	==========================================================================================================
--	Update the Coordinates in the Address table (CDRELADR)
--	==========================================================================================================

--	==========================================================================================================
--	"Mslink","Parcel_id","Addr_num","Addr_pfx","Addr_name","Addr_type","Addr_sfx","X-coord","Y-coord"
--	==========================================================================================================

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
--	explain plan set statement_id =  'xxx'	into garland.plan_table	for

--	select count(*)	from					--  FOR PRELIMINARY CHECK ONLY

	update garland.CDRELADR			A

	set (X_coord, Y_coord)  =

(
	select ITEM08, ITEM09					

	from	garland.GIS_OBJECTS

--		,garland.cdrelADR			A		--  FOR PRELIMINARY CHECK ONLY

	where	item01	= rtrim(a.mslink)
	and	item02	= a.parcel_id
	and	item03	= rtrim(a.addr_num)
	and	item04	= nvl(rtrim(a.addr_pfx),  ' ')
	and	item05	= rtrim(a.addr_name)
	and	item06	= nvl(rtrim(a.addr_type), ' ')
	and	item07	= nvl(rtrim(a.addr_sfx),  ' ')
)
	where exists
(
	select 'x'
	from	garland.GIS_OBJECTS

--		,garland.cdrelADR			A		--  FOR PRELIMINARY CHECK ONLY

	where	item01	= rtrim(a.mslink)
	and	item02	= a.parcel_id
	and	item03	= rtrim(a.addr_num)
	and	item04	= nvl(rtrim(a.addr_pfx),  ' ')
	and	item05	= rtrim(a.addr_name)
	and	item06	= nvl(rtrim(a.addr_type), ' ')
	and	item07	= nvl(rtrim(a.addr_sfx),  ' ')

	and	ITEM08	is not null
	and	ITEM09	is not null
);

--	===========================================================================
--	VERIFY RESULTS

	select mslink, parcel_id, x_coord, y_coord, 
		 addr_num, addr_pfx, addr_name, addr_type, addr_sfx

	from	 garland.cdreladr			A,
		 garland.GIS_Objects		G

	where	g.item01	= rtrim(a.mslink);

--	===========================================================================
--	insert into garland.plan_table(object_owner, object_name)values('GARLAND', '');

--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_index;
--	select * from garland.explain_table;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;

	savepoint	xxx;	

--	ROLLBACK;		

	Commit;
	alter rollback segment rb1 offline;

--	===========================================================================

--	select ITEM08, ITEM09	from garland.GIS_OBJECTS	where rownum < 22;

	select count(*)	"Input"
	from garland.GIS_Objects;

	select count(*)	"No X,Y"	
	from garland.GIS_Objects
	where				ITEM08 is null	or ITEM09 is null;

--	===========================================================================
	set echo	on;
