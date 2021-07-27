--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
--	========================================================================

	drop   table	garland.BASIC_UMS;

	create table	garland.BASIC_UMS
(
		location_no				number(8,0),
		account_no				number(8,0),
		service_seq				number(4,0),
		person_no				number(8,0),
		address_id				number(8,0),

		effective_date			date,
		last_name				varchar2(40),
		first_name				varchar2(20),
		birth_date				date,
		drivers_license			varchar2(20),
		ssn					varchar2(10),
		sex					varchar2(05),

		addr_num				varchar2(10),
		addr_pfx				varchar2(40),
		addr_name				varchar2(40),
		addr_type				varchar2(40),
		addr_sfx				varchar2(40),
		addr_bldg				varchar2(40),
		addr_unit				varchar2(40)
)
	tablespace	gis_data
	nologging;

--	================================================================

	create index	garland.BASIC_UMS_LOCATION
		on		garland.BASIC_UMS(location_no)

	tablespace	gis_index
	nologging;

--	================================================================

