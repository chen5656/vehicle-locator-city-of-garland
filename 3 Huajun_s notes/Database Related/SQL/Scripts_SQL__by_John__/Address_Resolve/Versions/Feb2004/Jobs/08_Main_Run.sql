	set echo	off;
	set timing	off;

	select '*** Main Address Run ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;
--	------------------------------------------------------------------------------------------

	@c:\deacutis\scripts\address_resolve\31_AdrAlter.sql;
	
--	------------------------------------------------------------------------------------------
	select '*** Batch Resolve Address ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

	set timing	on;

--	execute	garland.resolve_address.batch_driver ();

	@c:\deacutis\scripts\address_resolve\package\Batch_Address_Resolve.sql;

	set timing	off;

	select '*** Finish Batch Resolve Address ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

--	------------------------------------------------------------------------------------------

	@c:\deacutis\scripts\address_resolve\Fix_adrResult_Show.sql;	--	TEMPORARY FIX	--
	@c:\deacutis\scripts\address_resolve\Fix_adrResult.sql;		--	TEMPORARY FIX	--

--	------------------------------------------------------------------------------------------

	analyze table	garland.gis_verify_addr		compute statistics;

--	------------------------------------------------------------------------------------------
	set echo on;
