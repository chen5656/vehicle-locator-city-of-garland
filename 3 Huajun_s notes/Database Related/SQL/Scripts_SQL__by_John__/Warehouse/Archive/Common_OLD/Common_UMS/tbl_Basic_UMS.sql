	set echo	off;
--	==================================================================================
--	CAUTION !!!  THIS IS A NEW TABLE FORMAT -- SOFTWARE HAS NOT BEEN MODIFIED FOR IT

--	SEE ALTER TABLE AT THE BOTTOM
--	==================================================================================

--	drop   table	garland.BASIC_UMS;

	create table	garland.BASIC_UMS
(
		location_no				number(8,0),
		account_no				number(8,0),
		person_no				number(8,0),
		service_seq				number(4,0),

		effective_date			date,

		last_name				varchar2(40),
		first_name				varchar2(20),
		birth_date				date,
		drivers_license			varchar2(20),
		ssn					varchar2(10),
		sex					varchar2(05),

		addr_num				varchar2(10),
		addr_pfx				varchar2(02),
		addr_name				varchar2(30),
		addr_type				varchar2(04),
		addr_sfx				varchar2(02),
		addr_bldg				varchar2(10),
		addr_unit				varchar2(20),
		address_id				number(8,0)
)
	tablespace	gis_data
	nologging;

--	================================================================

	create index	garland.BASIC_UMS_LOCATION
		on		garland.BASIC_UMS(location_no)
	tablespace	gis_index
	nologging;

--	================================================================

	create index	garland.BASIC_UMS_Address_ID
		on		garland.BASIC_UMS(address_id)
	tablespace	gis_index
	nologging;

--	================================================================
/*
	alter table garland.basic_ums  modify
(
	addr_name varchar2(40),
	addr_pfx varchar2 (40),
	addr_sfx varchar2 (40),
	addr_type varchar2(40),
	addr_bldg varchar2(40),
	addr_unit varchar2(40)
);

*/
--	================================================================
