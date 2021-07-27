	set echo off;
	select '*** First Name Run ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;
--	=======================================================================================================

	@c:\deacutis\scripts\address_resolve\jobs\06_Output_into_Input.sql;

	@c:\deacutis\scripts\address_resolve\rules\Rule_Norm_Name.sql;
--  	@c:\deacutis\scripts\address_resolve\rules\Rule_Risk_Name.sql;
--	@c:\deacutis\scripts\address_resolve\rules\Rule_Safe_Name.sql;

	@c:\deacutis\scripts\address_resolve\jobs\08_Main_Run.sql;


	@c:\deacutis\scripts\address_resolve\51_Name_Report.sql;


	select distinct r.addr_name 	"MISTAKEN ALIAS INVALID NAMES"
	from	garland.adrResult	r,
		garland.adrStreets	s
	where	r.addr_name = s.addr_name
	and	r.verify_code < 10;

--	=======================================================================================================
	select '*** Finish First Name Run ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;
	set echo on;
