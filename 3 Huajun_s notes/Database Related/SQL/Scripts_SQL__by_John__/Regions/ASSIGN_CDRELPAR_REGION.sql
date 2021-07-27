	set echo	off;
	set timing	off;
--	==============================================================
--	update cdrelpar region
--	==============================================================

	alter table		garland.cdrelpar		disable all triggers;		-- CAUTION  !!!!

--	==============================================================

	drop synonym	garland.temp_syn;
	create synonym	garland.temp_syn		for garland.GIS_OBJECTS;	-- VERIFY

--	analyze table	garland.GIS_OBJECTS	compute statistics;		-- VERIFY

--	==============================================================

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment	rb1			online;
	set transaction 	use rollback segment	rb1;

--	explain plan	set statement_id = 'region'		for

	update  --+ all_rows
	garland.cdrelpar					P

--	set	p.COUNCIL_ID			=	
--	set	p.POLICE_BEAT			=	
--	set	p.ZIP_CODE			=	
--	set	p.CODE_INSPECT_AREA		=	
--	set	p.FIRE_DISTRICT		=	
--	set	p.LANDUSE			=	

	set	p.LANDUSE			=						--  CHANGE
	(

--		select	    g.item02						--  CHANGE
		select	nvl(g.item02, pp.LANDUSE)				--  CHANGE

		from		garland.cdrelpar		pp,
		 		garland.temp_syn		G

		where		pp.rowid		= p.rowid 
		and		pp.parcel_id	= g.item01 (+)			--  VERIFY

		and	item02 =
		(
			select	max(item02)
			from		garland.temp_syn
			where		item01 = rtrim(pP.parcel_id)			--  VERIFY
		)
	);


--	select * from explain_plan;

--	rollback;
	commit;
	alter rollback segment	rb1	offline;

--	==============================================================

	select *		from garland.cdrelpar	where rownum < 22;

	select chain_cnt  from tabs where table_name = 'CDRELPAR';

--	==============================================================

	alter table		garland.cdrelpar		enable all triggers;	-- CAUTION !!!!

--	==============================================================


/*
--	==============================================================
--	correction to parcel_id format

--	select *
	select count(*)
	from	tmp_parcel_region
	where	length (parcel_id) < 11;

	update tmp_parcel_region
	set	parcel_id = lpad (parcel_id, 07, '0') || '.000'
	where	length (parcel_id) < 11;

	rollback;
	commit;

--	==============================================================

--	how many duplicate parcel ids in extract

--	select 	parcel_id	
	select 	count(*)
	from	 	tmp_parcel_region
	group by 	parcel_id
	having 	count(*) > 1;


--	which parcel ids have conflicting region id assignments

	select	distinct
			parcel_id,
			region_id
	from 		tmp_parcel_region
	where		parcel_id	in
(
	select 	parcel_id
	from	 	tmp_parcel_region
	group by 	parcel_id
	having 	count(distinct region_id) > 1
);

--	==============================================================
--	expand cdrelpar_copy definition to match cdrelpar

--	desc			cdrelpar;
--	desc			cdrelpar_copy;

	alter table		cdrelpar_copy	
	add	(
			ARCVIEW_X			NUMBER
			ARCVIEW_Y			NUMBER
			ZIP_CODE			VARCHAR2(05)
			CODE_INSPECT_AREA		VARCHAR2(02)
			FIRE_DISTRICT		VARCHAR2(01)
		);

--	==============================================================
--	refresh cdrelpar_copy

	truncate table	cdrelpar_copy;

	alter rollback segment	rb1			online;
	set transaction 	use rollback segment	rb1;

	insert into		cdrelpar_copy
	select * from	cdrelpar;

	alter rollback segment	rb1			offline;

--	==============================================================
*/

--	==============================================================
	set echo	on;

