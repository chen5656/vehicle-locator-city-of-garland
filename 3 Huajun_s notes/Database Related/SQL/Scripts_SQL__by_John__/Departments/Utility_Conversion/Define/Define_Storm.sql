	set echo	off;

	select 'Define Storm Tables  ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi')  " " from dual;

--	=================================================================================
--	DEFINE STORM TABLES
--	=================================================================================

	@c:\deacutis\scripts\departments\utility_conversion\storm\TBL_UTSTOHDWL.sql;

	@c:\deacutis\scripts\departments\utility_conversion\storm\TBL_UTSTOINL.sql;

	@c:\deacutis\scripts\departments\utility_conversion\storm\TBL_UTSTOJUN.sql;

	@c:\deacutis\scripts\departments\utility_conversion\storm\TBL_UTSTOMH.sql;

	@c:\deacutis\scripts\departments\utility_conversion\storm\TBL_UTSTOCHN.sql;

	@c:\deacutis\scripts\departments\utility_conversion\storm\TBL_UTSTOOUT.sql;

	@c:\deacutis\scripts\departments\utility_conversion\storm\TBL_UTSTOPIP.sql;

	@c:\deacutis\scripts\departments\utility_conversion\storm\TBL_UTSTOPON.sql;

--	=================================================================================
	set echo	on;
