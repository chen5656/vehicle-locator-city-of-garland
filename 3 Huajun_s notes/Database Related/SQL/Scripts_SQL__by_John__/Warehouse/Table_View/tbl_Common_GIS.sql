--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;

--	========================================================================

	drop   table	GARLAND.Common_GIS;

	Create table	GARLAND.Common_GIS
(
	addr_num		number,
	addr_pfx		varchar2(02),
	addr_name		varchar2(20),
	addr_type		varchar2(04),
	addr_sfx		varchar2(02),
	addr_bldg		varchar2(20),
	addr_unit		varchar2(20),

	intersection1	varchar2(40),
	intersection2	varchar2(40),

	address_id		number,
	parent_id		number,

	parcel_id		varchar2(11),
	street_id		number,
	block_id		number,
	road_id		number,
	intersect_id1	varchar2(20),
	intersect_id2	varchar2(20)
)

	tablespace		gis_data
	storage		(initial 100k  next 100k pctincrease 0)
	nologging;

--	========================================================================

	create index	GARLAND.Common_GIS_AID
		on		GARLAND.Common_GIS(Address_ID)
	tablespace		gis_index
	storage		(initial 100k  next 100k pctincrease 0)
	nologging;

--	========================================================================
/*

	create index	GARLAND.Common_GIS_Name_Num
		on		GARLAND.Common_GIS (addr_name, addr_num)
	using index
	tablespace		gis_index
	storage		(initial 100k  next 100k pctincrease 0)
	nologging;

*/
--	========================================================================
