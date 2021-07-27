	set echo	off;
--	========================================================================

--	drop   table	garland.TAX_NAME;

	Create table	garland.TAX_NAME
(
	acct_owner		varchar2(25),
	geoacct		varchar2(25),

	tax_payer		varchar2(40),

	addr1			varchar2(40),
	addr2			varchar2(30),
	city			varchar2(15),
	state			varchar2(02),
	zip_code		varchar2(10)
)
	tablespace		gis_data
	storage		(initial 1M  next 1M  pctincrease 0)
	nologging;

--	========================================================================

	create index	garland.TAX_NAME_ACCT
		on		garland.TAX_NAME (acct_owner)
	tablespace		gisindx
	storage		(initial 100K  next 100K  pctincrease 0)
	nologging;

--	========================================================================
	set echo	on;
