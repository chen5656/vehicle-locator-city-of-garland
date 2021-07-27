
	select '*** Prep Tables ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

--	======================================================================================================

	@c:\deacutis\scripts\address_resolve\21_GIS_Prep.sql;		--	CDRELADR & TRVEHRCL

	@c:\deacutis\scripts\address_resolve\22_adrStreet.sql;	--	Rebuild Street & Alias

--	======================================================================================================

	select '*** Finish Prep Tables ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

	set echo	on;;


