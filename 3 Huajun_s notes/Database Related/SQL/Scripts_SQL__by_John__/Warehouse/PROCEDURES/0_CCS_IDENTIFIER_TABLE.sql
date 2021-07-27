--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
--	========================================================================

--	// scripts / warehouse / procedures / 0_CCS_IDENTIFIER

--	========================================================================

	drop sequence	Garland.CCS_IDENTIFIER_SEQ;

	create sequence	Garland.CCS_IDENTIFIER_SEQ
	start with		01
	increment by	01
	minvalue		01
	maxvalue		999999999
	nocache		-- buffer size
	nocycle		-- not wrap from max to min
	noorder		-- not 1st come 1st serve
	;

--	========================================================================

--	drop table		garland.CCS_IDENTIFIER;
	drop table		garland.CCS_IDENTIFIER_NEW;

--	create table	garland.CCS_IDENTIFIER
	create table	garland.CCS_IDENTIFIER_NEW
(
--	------------------------------------------------------------------------
--	Permanent Unique ID corresponds to CCS ADDRESS Keys below

	CCS_ID			NUMBER(10,0),
	CCS_PARENT			NUMBER(10,0),

--	------------------------------------------------------------------------
--	Uniqueness of the ID is determined by the following Keys in CCS ADDRESS
--	An address can have many blk/lots (Legal Descriptions)
--	A property can have many owners (TAX) or occupants (UMS)

	ADDR_NUMBER			NUMBER (8,0),
	ADDR_PREFIX			VARCHAR2(02),
	ADDR_NAME			VARCHAR2(30),
	ADDR_TYPE			VARCHAR2(04),
	ADDR_SUFFIX			VARCHAR2(02),

	TAX_LEGAL			VARCHAR2(140),
	TAX_OWNER			VARCHAR2(70),
	UMS_LAST_NAME		VARCHAR2(50),
	UMS_FIRST_NAME		VARCHAR2(30),

--	------------------------------------------------------------------------
--	Source Record IDs of CCS ADDRESS when record became Active
--	One Source <-> Many Keys
--	UMS ID = Account number (with one or more Occupants)

	GIS_ID			NUMBER(10,0),
	TAX_ID			NUMBER(10,0),
	UMS_ID			NUMBER(10,0),

--	------------------------------------------------------------------------
--	Active   = date when Keys first appear in CCS ADDRESS
--	Inactive = date when Keys disappear from CCS ADDRESS

	ACTIVE			VARCHAR2(10),
	INACTIVE			VARCHAR2(10)

--	------------------------------------------------------------------------
)
	tablespace	gis_data
	nologging;

--	========================================================================

	create Unique index	garland.CCS_IDENTIFIER_ID
		on			garland.CCS_IDENTIFIER(CCS_ID)
	tablespace	gis_index
	nologging;

	create index	garland.CCS_IDENTIFIER_Address
		on		garland.CCS_IDENTIFIER(Addr_Name, Addr_Number)
	tablespace	gis_index
	nologging;

--	========================================================================
