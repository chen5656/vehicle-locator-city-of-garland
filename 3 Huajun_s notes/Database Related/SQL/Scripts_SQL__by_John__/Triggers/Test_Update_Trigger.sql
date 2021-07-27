--	===========================================================================
--	an update trigger cannot query its target table for any reason whatever
--	============================================================================

--	drop trigger	test_trigger;

--	============================================================================

	create or replace trigger	test_trigger
	before	update
	on		gis_temp1
	for each row

declare
	cntr		number;

begin
	select count(*) into cntr from gis_temp1;
end;


--	======================================================================
/*

	update gis_temp1	set item30 = 'x'	where rownum < 3;
	rollback;


ORA-04091: table GARLAND.GIS_TEMP1 is mutating, trigger/function may not see it
ORA-06512: at "GARLAND.TEST_TRIGGER", line 6
ORA-04088: error during execution of trigger 'GARLAND.TEST_TRIGGER'

*/
--	======================================================================
