	set echo off;
--	===================================================================================

	create or replace view	garland.TEMP_VIEW1		as
	select	

	item01		Account,	
	item02		PIDN,		
	item03, item04, item05,

	item06		Owner_Name,
	item07		Owner_Addr1,
	item08		Owner_Addr2,
	item09		Owner_Addr3,
	item10		Owner_Addr4,
	item11		Owner_Zip,
	item12,

	item13		Addr_Num,
	item14		Addr_Name,

	item15,
	item16		Legal1,
	item17		Legal2,
	item18		Legal3,
	item19		Legal4,

	item20		Acct_Type,	
	item21		Acct_Use	

	from	garland.GIS_OBJECTS;

--	===================================================================================
