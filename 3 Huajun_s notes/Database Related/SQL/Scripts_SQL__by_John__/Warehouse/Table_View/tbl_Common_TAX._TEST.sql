	set echo		off;
--	===========================================================================
--	TEST COMMON TAX - so excessive lengths can be found
--	===========================================================================

	drop table		JDEACUTIS.Common_TAX;

	create table	JDEACUTIS.Common_TAX
(
	TAX_ADDRESS_ID                          number,

	TAX_ACCOUNT                             VARCHAR2(50),
	TAX_DCAD                                VARCHAR2(50),

	TAX_ADDR_NUM                            NUMBER,
	TAX_ADDR_PFX                            VARCHAR2(10),
	TAX_ADDR_NAME                           VARCHAR2(50),
	TAX_ADDR_TYPE                           VARCHAR2(10),
	TAX_ADDR_SFX                            VARCHAR2(10),
	TAX_ADDR_BLDG                           VARCHAR2(40),
	TAX_ADDR_UNIT                           VARCHAR2(40),

	TAX_ADDR_ZIP                            VARCHAR2(40),
	TAX_OWNER                               VARCHAR2(50),
	TAX_ADDR1                               VARCHAR2(50),
	TAX_ADDR2                               VARCHAR2(50),
	TAX_CITY                                VARCHAR2(50),
	TAX_STATE                               VARCHAR2(10),
	TAX_ZIP                                 VARCHAR2(20),
	TAX_PROP_TYPE                           VARCHAR2(10),
	TAX_ZONING_CODE                         VARCHAR2(20),
	TAX_EXEMPT                              VARCHAR2(20),
	TAX_COLLECT_MORTGAGE                    VARCHAR2(10),
	TAX_COLLECT_AGENT                       VARCHAR2(10),
	TAX_COLLECT_LENDER                      VARCHAR2(10),
	TAX_DEED_CHNG_DATE                      VARCHAR2(20),
	LEGAL_DESC                              VARCHAR2(400),
	OCCUPIED                                VARCHAR2(1),

	PARENT_ID                               number
)

	tablespace	gis_data
	storage	(initial 128K  next 128K  pctincrease 0)
	nologging;

--	========================================================================
/*
	alter table		JDEACUTIS.Common_TAX
	add constraint	Common_TAX_account
		unique	(tax_account)

	using index		
	tablespace		gis_index
	storage		(initial 128k  next 128k pctincrease 0)
	nologging;
*/

--	========================================================================

	create index	JDEACUTIS.Common_TAX_Account
		on		JDEACUTIS.Common_TAX (tax_account)
	tablespace		gis_index
	storage		(initial 128k  next 100k pctincrease 0)
	nologging;

--	========================================================================

	create index	JDEACUTIS.Common_TAX_AID
		on		JDEACUTIS.Common_TAX (tax_address_id)
	tablespace		gis_index
	storage		(initial 128k  next 128k pctincrease 0)
	nologging;

--	========================================================================
