	set echo		off;
--	===========================================================================
	truncate table	garland.plan_table		reuse storage;
--	explain plan set statement_id = 'xxx'		into garland.plan_table	for
--	===========================================================================

	drop table		garland.Common_TAX;

	create table	garland.Common_TAX
(
		tax_address_id		number,

		tax_account			varchar2(25),
		tax_dcad			varchar2(25),

		tax_addr_num		varchar2(06),
		tax_addr_pfx		varchar2(02),
		tax_addr_name		varchar2(20),
		tax_addr_type		varchar2(04),
		tax_addr_sfx		varchar2(02),
		tax_addr_bldg		varchar2(10),
		tax_addr_unit		varchar2(20),

		tax_owner			varchar2(40),		
		tax_addr1			varchar2(40),
		tax_addr2			varchar2(30),
		tax_city			varchar2(15),
		tax_state			varchar2(02),
		tax_zip			varchar2(10),

		tax_prop_type		varchar2(01),
		tax_zoning_code		varchar2(10),
		tax_exempt			varchar2(20),

		tax_collect_mortgage	varchar2(03),
		tax_collect_agent		varchar2(03),
		tax_collect_lender	varchar2(05),

		tax_deed_chng_date	date
)
	tablespace	gis_data
	storage	(initial 1m  next 1m  pctincrease 0)
	nologging;

--	========================================================================

	create index	garland.Common_TAX_AID
		on		garland.Common_TAX (tax_address_id)
	tablespace		gisindx
	storage		(initial 100k  next 100k pctincrease 0)
	nologging;

--	========================================================================
	set echo		on;
