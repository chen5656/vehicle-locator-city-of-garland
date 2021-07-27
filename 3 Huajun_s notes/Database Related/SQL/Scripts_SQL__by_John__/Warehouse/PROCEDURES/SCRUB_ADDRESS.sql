--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
--	=====================================================================
--	Update Address info in Basic UMS with scrubbed address info
--	=====================================================================

--	execute	garland.SCRUB_ADDRESS;

	create or replace procedure garland.SCRUB_ADDRESS	as

--	DECLARE

--	=====================================================================

	compile_only	integer	:= 0;

BEGIN
	if	compile_only > 0		then
		return;
	end if;

--	===============================================================================

	garland.SCRUB_ADDRESS_Prep_Input;

	garland.SCRUB_ADDRESS_Resolve;

	garland.SCRUB_ADDRESS_Fix_AdrResult;

--	===============================================================================

END;

