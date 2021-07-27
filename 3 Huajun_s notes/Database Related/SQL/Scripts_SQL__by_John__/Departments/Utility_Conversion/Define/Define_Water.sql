	set echo	off;

	select 'Define Water Tables  ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi')  " " from dual;

--	=================================================================================
--	DEFINE WATER TABLES
--	=================================================================================

	@c:\deacutis\scripts\departments\utility_conversion\water\TBL_UTWATFIT.sql;

	@c:\deacutis\scripts\departments\utility_conversion\water\TBL_UTWATHYD.sql;

	@c:\deacutis\scripts\departments\utility_conversion\water\TBL_UTWATMTR.sql;

	@c:\deacutis\scripts\departments\utility_conversion\water\TBL_UTWATPIP.sql;

	@c:\deacutis\scripts\departments\utility_conversion\water\TBL_UTWATPSTA.sql;

	@c:\deacutis\scripts\departments\utility_conversion\water\TBL_UTWATTNK.sql;

	@c:\deacutis\scripts\departments\utility_conversion\water\TBL_UTWATVLV.sql;

--	=================================================================================
	set echo	on;
