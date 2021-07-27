	set echo	off;

	select 'Define Sanitation Tables  ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi')  " " from dual;

--	=================================================================================
--	DEFINE SANITATION TABLES
--	=================================================================================

	@c:\deacutis\scripts\departments\utility_conversion\sanitation\TBL_UTSANARW.sql;

	@c:\deacutis\scripts\departments\utility_conversion\sanitation\TBL_UTSANCLN.sql;

	@c:\deacutis\scripts\departments\utility_conversion\sanitation\TBL_UTSANLAT.sql;

	@c:\deacutis\scripts\departments\utility_conversion\sanitation\TBL_UTSANLST.sql;

	@c:\deacutis\scripts\departments\utility_conversion\sanitation\TBL_UTSANMH.sql;

	@c:\deacutis\scripts\departments\utility_conversion\sanitation\TBL_UTSANPIP.sql;
	
--	=================================================================================
	set echo	on;
