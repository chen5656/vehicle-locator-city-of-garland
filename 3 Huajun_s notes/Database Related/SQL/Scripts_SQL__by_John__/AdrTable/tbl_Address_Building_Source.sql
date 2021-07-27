
--	========================================================================
--	Address Buildings obtained from Access file
--	G:\City\DavidJacobs\Code\MFInterim Database
--	========================================================================

	create table	garland.Address_Building_Source
(
	building_id		number,
	complex_id		number,
	addr_num		number,
	addr_pfx		varchar2(10),
	addr_name		varchar2(30),
	addr_type		varchar2(10),
	addr_sfx		varchar2(10),
	addr_bldg		varchar2(20),
	unit_count		number
)

	tablespace		gis_data
	storage		( initial 50k  next 50k  pctincrease 0 )
	nologging;
