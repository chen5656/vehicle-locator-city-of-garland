--	===========================================================================
--	copy scrubbed UMS address from adrResult_Output to adrResult_UMS_Location
--	===========================================================================

	truncate table	garland.adrResult_UMS_Location		reuse storage;

	comment on table	garland.adrResult_UMS_Location		is 'UM00100M addresses';

--	===========================================================================

	alter rollback segment rb1	online;
	commit;
	set transaction use rollback segment rb1;

	insert --+  append
	into		garland.adrResult_UMS_Location

	select	all *
	from		garland.adrResult_Output;

	commit;
	alter rollback segment rb1	offline;

--	=============================================================

	analyze table	garland.adrResult_UMS_Location		compute statistics;

--	=============================================================
