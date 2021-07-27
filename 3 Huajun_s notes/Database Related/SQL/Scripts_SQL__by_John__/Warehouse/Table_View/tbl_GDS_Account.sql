	set echo	off;
--	===========================================================================

	drop   table	garland.GDS_Account;

	create table	garland.GDS_Account
(
	Account			varchar2(100),
	PIDN			varchar2(100),
	Addr_Num		varchar2(100),
	Addr_Name		varchar2(100),
	Owner_Name		varchar2(100),
	Owner_Addr1		varchar2(100),
	Owner_Addr2		varchar2(100),
	Owner_Addr3		varchar2(100),
	Owner_Addr4		varchar2(100),
	Owner_Zip		varchar2(100),
	Legal1			varchar2(100),
	Legal2			varchar2(100),
	Legal3			varchar2(100),
	Legal4			varchar2(100),
	Mortgage_Co		varchar2(100),
	Acct_Type		varchar2(100),
	Acct_Use		varchar2(100)
--	Acct_Status		varchar2(100),
--	Status_Info		varchar2(100),
--	Mail_Status		varchar2(100),
--	Acres			number
)
	tablespace		gis_data
	nologging;

--	===========================================================================
/*
	alter table	garland.GDS_Account
	add	Constraint	GDS_Account_Pkey
		Primary Key	(Account)

	using index
	tablespace	gis_indx
	nologging;
*/
--	===========================================================================

	create index garland.GDS_Account_IDX
		on	garland.GDS_Account(Account)
	tablespace	gis_index
	nologging;

--	===========================================================================
