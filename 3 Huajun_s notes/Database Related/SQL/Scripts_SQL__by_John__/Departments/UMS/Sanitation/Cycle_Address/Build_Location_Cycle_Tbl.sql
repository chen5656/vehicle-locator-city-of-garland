	set echo	off;
	set timing	off;
--	==============================================================
--	build location <=> cycle correspondence table
--	==============================================================

--	==============================================================

--	alter table	garland.gis_objects	pctfree 10  pctused 90;

	truncate table	garland.gis_objects	reuse storage;	

--	==============================================================

	alter rollback segment rb1	online;
	commit;
	set transaction use rollback segment rb1;

--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for

	insert 	--+ append
	into		garland.gis_objects (item01, item02)
	select	distinct
			location_no, 
			cycle_cd
	from 		sfg.um00163t@umsp.world;
--	from 		sfg.um00830t@umsp.world;

--	======================================================================
--	select * from explain_plan;
--	select * from explain_analyze;
--	select * from explain_indexed;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_cost;
--	======================================================================

	commit;
	alter rollback segment rb1	offline;


--	==============================================================
--	how many locations have multiple cycles

	select	count(count(*))			--	1429
	from		garland.gis_objects
	group by	item01
	having	count(distinct item02) > 1;

--	==============================================================
--	how many UMS parcel ids match DCAD Residential parcel ids

	select count(*) 
	from 	adrResult_Extract		a,
		nsa_dcad_res		t
	where	a.parcel_id = t.parcel_id;

--	==============================================================


	set echo on;
