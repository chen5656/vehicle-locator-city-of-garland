	set echo	off;
	set timing	off;
--	==========================================================================
--	copy adrResult_Input into adrResult
--	==========================================================================

	select '*** Put Input into Output ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

	truncate table	garland.gis_verify_addr		reuse storage;		-- adrResult

---	alter rollback segment rb1	online;
---	commit;
---	set transaction use rollback segment rb1;

	insert /*+ append */	into garland.adrResult
	select *			from garland.adrResult_Input;

	commit;
---	alter rollback segment rb1	offline;

	analyze table	garland.gis_verify_addr		compute statistics;

--	==========================================================================
	set echo on;

