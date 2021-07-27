--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
-- set pagesize	74;
-- set pagesize	57;
-- alter session set nls_date_format = 'yyyymmdd hh24:mi:ss';  
--	========================================================================

	drop   table	garland.Common_UMS;

	Create table	garland.Common_UMS
(
	address_id			number,

	addr_num			number,
	addr_pfx			varchar2(02),
	addr_name			varchar2(30),
	addr_type			varchar2(04),
	addr_sfx			varchar2(02),
	addr_bldg			varchar2(10),
	addr_unit			varchar2(20),

	location_no			number,
	account_no			number,
	person_no			number,

	last_name			varchar2(40),
	first_name			varchar2(40),
	drivers_license		varchar2(20),
	birth_date			date,

	parent_id			number
)

	tablespace		gis_data
	nologging;

--	========================================================================

	create index	garland.Common_UMS_AID
		on		garland.Common_UMS (address_id)
	tablespace		gis_index
	nologging;

--	========================================================================

	create index	garland.Common_UMS_Location
		on		garland.Common_UMS (location_no)
	tablespace		gis_index
	nologging;

--	========================================================================

	create index	garland.Common_UMS_Address
		on		garland.Common_UMS (addr_name, addr_num)
	tablespace		gis_index
	nologging;

--	========================================================================
