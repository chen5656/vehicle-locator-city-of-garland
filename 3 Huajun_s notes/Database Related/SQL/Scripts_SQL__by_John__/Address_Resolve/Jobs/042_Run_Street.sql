	set echo	off;

	select '*** Street Run ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;
--	=======================================================================================================

	@c:\deacutis\scripts\address_resolve\rules\Rule_Norm_Street.sql;
--	@c:\deacutis\scripts\address_resolve\rules\Rule_Risk_Street.sql;
--	@c:\deacutis\scripts\address_resolve\rules\Rule_Safe_Street.sql;

	@c:\deacutis\scripts\address_resolve\jobs\08_Main_Run.sql;


	@c:\deacutis\scripts\address_resolve\50_Base_Report.sql;

	@c:\deacutis\scripts\address_resolve\reports\quality_control\QC_Street_Sample.sql;

--	=======================================================================================================
--	look for unrecognized valid addresses - in case a mistake was made

	select count(*) from garland.adrResult

--	update	garland.adrResult
--	set		verify_code = 55
	where		verify_code < 55
	and	(	addr_num, nvl(addr_pfx,' '), rtrim(addr_name), nvl(addr_type,' '), nvl(addr_sfx,' ') )  in
(
	select	addr_num, addr_pfx, addr_name, addr_type, addr_sfx	from	garland.cdreladr
)
	and		translate (addr_num, '/1234567890', '/') is null
;

	rollback;

--	=======================================================================================================
	select '*** Finish Street Run ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

	set echo	on;
