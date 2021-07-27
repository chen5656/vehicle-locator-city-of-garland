	set echo	off;	
	set timing	off;
--	=======================================================================================
--	obtain GIS info for Code Inspection records
--	=======================================================================================

	alter rollback segment rb_large	online;
	commit;
	set transaction use rollback segment rb_large;

--	=======================================================================================
--	update code_inspection with code_citation info
--	=======================================================================================

--	truncate table	plan_table		reuse storage;
--	explain plan	set statement_id = 'gis'	for

	update 	garland.syn_gis_table		i
	set	( 	parcel_id, inspect_area, council_id, subdiv_id, zip_code )	=
(
	select	parcel_id, code_inspect_area, council_id, subdiv_id, zip_code
	from		garland.cdrelpar
	where		parcel_id	= i.parcel_id
);

--	=======================================================================================

--	select * from explain_plan;

--	Rollback;
	commit;
	alter rollback segment rb_large	offline;

--	analyze table	garland.NSA_CODE_INSPECT	compute statistics;

--	=======================================================================================
	set echo	on;	
	set timing	off;
