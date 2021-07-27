	set echo	off;
--    set linesize	2000;
--	===========================================================================
--	Load GDS_Account table from GIS_Objects
--	===========================================================================
--	ARCHIVE
--	define view of GIS_Objects having Loader data
--	@c:\deacutis\scripts\warehouse\common_gds\vw_Temp_GDS_Account.sql (removed)
--	===========================================================================

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

	null			Mortgage_Co,	
	item20		Acct_Type,	
	item21		Acct_Use	

	from	garland.GIS_OBJECTS;

--	===========================================================================

	Truncate table	garland.GDS_Account	reuse storage;

--	===========================================================================

	insert --+ append
	into	 garland.GDS_Account

	select	

	Account,	
	PIDN,		

	Addr_Num,	
	Addr_Name,	

	Owner_Name,	
	Owner_Addr1,	
	Owner_Addr2,
	Owner_Addr3,	
	Owner_Addr4,	
	Owner_Zip,	

	Legal1,	
	Legal2,	
	Legal3,	
	Legal4,	

	Mortgage_Co,	
	Acct_Type,	
	Acct_Use	

	from	garland.Temp_View1;

--	===========================================================================

	Commit;

--	===========================================================================

 	select * from garland.GDS_Account	where rownum < 11;

	select count(counter) dupekeys	from
(
	select count(*) counter
	from	garland.GDS_Account
	group by account
	having count(*) > 1
);

--	===========================================================================
