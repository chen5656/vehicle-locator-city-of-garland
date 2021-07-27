 	set echo	off;
	set timing	off;
--	========================================================================================================
--	************	INSURE gis_objects is in proper format	**************
--	========================================================================================================
--	analyze  table	garland.		compute statistics;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	explain plan set statement_id = 'gis maint'  into garland.plan_table	for
--	====================================================================================

	update 	
	garland.cdreladr		a

--	set	(x_coord, y_coord,  parcel_id) =	
	set	(x_coord, y_coord) =	
(
--	select item08, item09, item10
	select item04, item05

	from	garland.gis_objects

	where	item01		= rtrim(a.mslink)

	and   nvl(item02,' ') 	in (a.parcel_id,' ')

--	and	nvl(item03,' ')	= rtrim(a.addr_num)
--	and	nvl(item04,' ')	= a.addr_pfx
--	and	nvl(item05,' ')	= a.addr_name
--	and	nvl(item06,' ')	= a.addr_type
--	and	nvl(item07,' ')	= a.addr_sfx

--	and	item10 is  null	
--	and	translate (item10, '123456789AB','00000000000') = '0000000.000'		-- new parcel id

)
	where exists
(
	select 'x'
	from	garland.gis_objects

	where	item01		= rtrim(a.mslink)
	and   nvl(item02,' ') 	in (a.parcel_id, ' ')

--	and	nvl(item03, 0 )	= rtrim(a.addr_num)
--	and	nvl(item04,' ')	= a.addr_pfx
--	and	nvl(item05,' ')	= a.addr_name
--	and	nvl(item06,' ')	= a.addr_type
--	and	nvl(item07,' ')	= a.addr_sfx

--	and	item10 is  null	
--	and	translate (item10, '123456789AB','00000000000') = '0000000.000'		-- new parcel id

);

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;
--	===========================================================================

--	===========================================================================
/*	display gis_objects

	select rpad(item01,12) mslink, rpad(item02,10) parcel 
		,rpad(item03,06) num  ,rpad(item04,02) pfx  ,rpad(item05,20) name 
		,rpad(item06,04) type ,rpad(item07,05) sfx
		,rpad(item08,10) x ,rpad(item09,10) y ,rpad(item10,12) parcel
	from	garland.gis_objects	g
	;

--	===========================================================================

	verify that gis_objects has valid parcel_id formats

	select item01 from gis_objects
	where	translate (item01, '/0123456789AB.', '/') is not null
	and	rownum < 11;

--	===========================================================================
--	Display cdreladr / gis_objects  match

--	select count(*)	
	select mslink, parcel_id, addr_num, addr_pfx, addr_name, addr_type, addr_sfx

--	select rpad(item01,12) mslink, rpad(item02,10) parcel 
--		,rpad(item03,06) num  ,rpad(item04,02) pfx  ,rpad(item05,20) name 
--		,rpad(item06,04) type ,rpad(item07,05) sfx
--		,rpad(item08,10) x ,rpad(item09,10) y ,rpad(item10,12) parcel

	from	garland.gis_objects	g,
		garland.cdreladr		a

	where	item01		= rtrim(a.mslink)
	and   nvl(item02,' ') 	= a.parcel_id

	and	nvl(item03,' ')	= rtrim(a.addr_num)
	and	nvl(item04,' ')	= a.addr_pfx
	and	nvl(item05,' ')	= a.addr_name
	and	nvl(item06,' ')	= a.addr_type
--	and	nvl(item07,' ')	= a.addr_sfx

	order by	a.addr_name, a.addr_type, a.addr_pfx, a.addr_num;
--	order by	rpad(item05,20), rpad(item06,04), rpad(item04,02), rpad(item03,06);


--	-------------------------------------------------------------------------------------
--	Display gis_objects minus cdreladr

	select

--			rpad(item01,		12)		"mslink", 
			rpad(item02,		12)		"parcel", 

--			rpad(rtrim(item03),	10)		"num", 
--			rpad(nvl(item04,' '),	10)		"pfx", 
--			rpad(nvl(item05,' '),	20)		"name",
--			rpad(nvl(item06,' '),	10)		"type"
--			rpad(nvl(item07,' '),	10)		"sfx",
			' '						" "
	from
(
	select	

--		item01,
		item02,

--		rtrim(nvl(item03,0))	item03,
--		nvl(item04,' ')		item04,
--		nvl(item05,' ')		item05,
--		nvl(item06,' ')		item06,
--		nvl(item07,' ')		item07,

		' '

	from	 garland.gis_objects

	minus

	select 

--		rtrim(nvl(mslink,0)),	
		nvl(parcel_id,' '), 

--		rtrim(nvl(addr_num,0)), 
--		nvl(addr_pfx, ' '), 
--		nvl(addr_name,' '), 
--		nvl(addr_type,' '),
--		nvl(addr_sfx, ' '),

		' '

	from	 garland.cdreladr
);

--	-------------------------------------------------------------------------------------
--	Display duplicate mslink/parcel in cdreladr

	select	mslink, parcel_id, addr_num, addr_pfx, addr_name, addr_type, addr_sfx
	from		garland.cdreladr
	where	(	mslink, parcel_id	)	in
(
	select	mslink, parcel_id
	from 		garland.cdreladr
	group by	mslink, parcel_id
	having	count(*) > 1
);

--	-------------------------------------------------------------------------------------
--	Display duplicate mslink/parcel in gis_objects


	select item01, item02
	from	garland.gis_objects
	group by 	item01, item02
	having 	count(*) > 1;

*/
--	===========================================================================

--	ROLLBACK;
	commit;
	alter rollback segment rb1 offline;

--	===========================================================================

	select count(*) "GIS_Objects"		from garland.gis_objects;

--	===========================================================================


