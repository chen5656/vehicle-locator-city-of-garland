--	=====================================================================
set echo		off;
set linesize	2000;
set pagesize	9999;
set sqlblanklines	on;
set timing		off;
set serveroutput	on	size 99999;
--	===========================================================================
--	Load GDS_ACCOUNT from EXTERNAL_GDS_ACCOUNT
--	===========================================================================

	Truncate table	garland.GDS_ACCOUNT	reuse storage;

--	===========================================================================

	insert --+ append
	into garland.GDS_ACCOUNT
(
	Account,		
	PIDN,			
	Owner_Name,		
	Owner_Addr1,		
	Owner_Addr2,		
	Owner_Addr3,		
	Owner_Addr4,		
	Owner_Zip,		
	Addr_Num,		
	Addr_Name,		
	Legal1,		
	Legal2,		
	Legal3,		
	Legal4,		
	mortgage_co,			
	Acct_Type,		
	Acct_Use		
)
	select
	ltrim(Account,'0'),
	rtrim(PIDN),			
	rtrim(Owner_Name),		
	rtrim(Owner_Addr1),		
	rtrim(Owner_Addr2),		
	rtrim(Owner_Addr3),		
	rtrim(Owner_Addr4),		
	rtrim(Owner_Zip),		
	rtrim(Addr_Num),		
	rtrim(Addr_Name),		
	rtrim(Legal1),		
	rtrim(Legal2),		
	rtrim(Legal3),		
	rtrim(Legal4),		
	null,			
	rtrim(Acct_Type),		
	rtrim(Acct_Use)		
	from jdeacutis.GDS_ACCOUNT_EXTERNAL;

--	===========================================================================

	Commit;

--	===========================================================================

	select count(*) jdeacutis from jdeacutis.gds_account_external;

 	select * from garland.GDS_Account	where rownum < 11;

	select count(counter) dupekeys	from
(
	select count(*) counter
	from	garland.GDS_Account
	group by account
	having count(*) > 1
);

--	===========================================================================
