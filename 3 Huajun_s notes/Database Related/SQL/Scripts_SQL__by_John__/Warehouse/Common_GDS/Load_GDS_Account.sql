	set echo	off;
--	===========================================================================
--	Load GDS_Account table from GIS_Objects
--	===========================================================================

--	define view of GIS_Objects having Loader data

	@c:\deacutis\scripts\warehouse\common_gds\vw_Temp_GDS_Account.sql

--	===========================================================================

	Truncate table	garland.GDS_Account	reuse storage;

--	===========================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id =  'xxx'	into garland.plan_table		for
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

	from	garland.Temp_View1
	;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;

	commit;

--	===========================================================================

 	select * from garland.GDS_Account	where rownum < 11;

--	delete from garland.GDS_Account	where account = 'Account';
--	Rollback;
--	Commit;

--	===========================================================================
	set echo	on;
