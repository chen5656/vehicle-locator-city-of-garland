	set echo	off;
	set timing	off;
--	========================================================================
--	assign cdrelpar region value to application table containing parcel_id
--	========================================================================

--	alter table	garland.CDRELADR		disable all triggers;

--	========================================================================
--	GIS SOURCE = CDRELPAR

	create or replace view	garland.temp_view1 (parcel_id, region_id)	 
	as select	
		parcel_id,

		POLICE_BEAT	

--		COUNCIL_ID			
--		ZIP_CODE
--		CODE_INSPECT_AREA
--		POLICE_BEAT	
	
	from	garland.cdrelpar;

--	====================================================================
--	USER TARGET

	create or replace view	garland.temp_view2 (parcel_id, region_id, empty_region)	 
	as select	

		PARCEL_ID,

		POLICE_BEAT				,'0'	

--		COUNCIL_ID				,'0'			
--		ZIP_CODE,				,'0'
--		CODE_INSPECT_AREA			,'0'
--		POLICE_BEAT				,'0'	

	from 
		garland.NSA_CRIME;	

--		garland.CDRELADR
--		garland.NSA_CODE_INSPECT	
--		garland.NSA_CRIME			
--		jdeacutis.NSA_CODE_VIOLATION	
--		jdeacutis.NSA_CODEADDR		

--	====================================================================

	alter rollback segment	RB1	 		online;
	commit;
	set transaction use 	rollback segment	RB1;

--	====================================================================

--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = 'REGION UPDATE'		for

	update	garland.temp_view2	u
	set		u.region_id		=
(
	select	max (nvl(p.region_id, v.region_id))

	from		garland.temp_view1	p,
			garland.temp_view2	v

	where		v.rowid		= u.rowid
	and		v.parcel_id		= p.parcel_id (+)

--	and		v.empty_region	< p.region_id (+)		--  optional
);


--	select * from explain_plan;

--	========================================================================

--	Rollback;
	commit;
	alter rollback segment	RB1		offline;

--	========================================================================

--	alter table garland.CDRELADR		enable all triggers;

--	========================================================================

