	set echo	off;
--	===========================================================================

--	drop   table	garland.GDS_Account;

	create table	garland.GDS_Account
(
	Account		varchar2(10),
	PIDN			varchar2(25),

	Addr_Num		varchar2(10),
	Addr_Name		varchar2(30),

	Owner_Name		varchar2(35),
	Owner_Addr1		varchar2(35),
	Owner_Addr2		varchar2(35),
	Owner_Addr3		varchar2(35),
	Owner_Addr4		varchar2(35),
	Owner_Zip		varchar2(09),

	Legal1		varchar2(30),
	Legal2		varchar2(30),
	Legal3		varchar2(30),
	Legal4		varchar2(30),

	Mortgage_Co		varchar2(15),
	Acct_Type		varchar2(30),
	Acct_Use		varchar2(03)

--	Acct_Status		varchar2(03),
--	Status_Info		varchar2(40),
--	Mail_Status		varchar2(02),
--	Acres			number
)

	tablespace		gis_data
	storage		(initial 1m  next 1m  pctincrease 0)
	nologging;

--	===========================================================================
/*
	alter table	garland.GDS_Account
	add	Constraint	GDS_Account_Pkey
		Primary Key	(Account)

	using index
	tablespace	gis_indx
	storage	(initial 1m  next 1m  pctincrease 0)
	nologging;
*/
--	===========================================================================

	create index garland.GDS_Account_IDX
		on	 garland.GDS_Account(Account)
	tablespace	gis_indx
	nologging;

--	===========================================================================

