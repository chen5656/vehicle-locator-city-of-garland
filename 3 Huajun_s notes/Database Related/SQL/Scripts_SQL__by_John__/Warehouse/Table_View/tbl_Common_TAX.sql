--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
--	===========================================================================

--	feb2007	tax_addr_name	varchar2(30)
--	===========================================================================

	drop table		GARLAND.Common_TAX;

	create table	GARLAND.Common_TAX
(
	TAX_ADDRESS_ID		NUMBER(20,0),

	TAX_ACCOUNT			VARCHAR2(25),
	TAX_DCAD			VARCHAR2(25),

	TAX_ADDR_NUM		NUMBER(10,0),
	TAX_ADDR_PFX		VARCHAR2(2),
	TAX_ADDR_NAME		VARCHAR2(30),
	TAX_ADDR_TYPE		VARCHAR2(4),
	TAX_ADDR_SFX		VARCHAR2(2),
	TAX_ADDR_BLDG		VARCHAR2(10),
	TAX_ADDR_UNIT		VARCHAR2(20),

	TAX_ADDR_ZIP		VARCHAR2(10),
	TAX_OWNER			VARCHAR2(40),
	TAX_ADDR1			VARCHAR2(40),
	TAX_ADDR2			VARCHAR2(50),
	TAX_CITY			VARCHAR2(30),
	TAX_STATE			VARCHAR2(2),
	TAX_ZIP			VARCHAR2(10),
	TAX_PROP_TYPE		VARCHAR2(1),
	TAX_ZONING_CODE		VARCHAR2(10),
	TAX_EXEMPT			VARCHAR2(20),
	TAX_COLLECT_MORTGAGE	VARCHAR2(3),
	TAX_COLLECT_AGENT		VARCHAR2(3),
	TAX_COLLECT_LENDER	VARCHAR2(5),
	TAX_DEED_CHNG_DATE	VARCHAR2(10),
	LEGAL_DESC			VARCHAR2(200),
	OCCUPIED			VARCHAR2(1),
	PARENT_ID			NUMBER(10,0),

	BLK				VARCHAR2(10),
	LOT				VARCHAR2(10),
	SUBDIVISION			VARCHAR2(30)
)
	tablespace	gis_data
	nologging;

--	========================================================================

	create index	GARLAND.Common_TAX_Account
		on		GARLAND.Common_TAX (tax_account)
	tablespace		gis_index
	storage		(initial 128k  next 100k pctincrease 0)
	nologging;

--	========================================================================

	create index	GARLAND.Common_TAX_AID
		on		GARLAND.Common_TAX (tax_address_id)
	tablespace		gis_index
	storage		(initial 128k  next 128k pctincrease 0)
	nologging;

--	========================================================================
/*

--	what is maximum length of subdivision

	select max(length(substr(legal2,1,instr(legal2,' BLK'))))		-- 27
	from	garland.gds_account 
	where	acct_type = 'R';

*/
--	========================================================================
