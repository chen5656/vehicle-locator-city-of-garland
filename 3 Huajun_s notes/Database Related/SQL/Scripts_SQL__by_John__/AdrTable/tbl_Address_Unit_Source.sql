
--	========================================================================
--	Address Units obtained from Access file
--	G:\City\DavidJacobs\Code\MFInterim Database
--	========================================================================

	create table	garland.Address_Unit_Source
(
	unit_id		number,
	complex_id		number,
	building_id		number,
	addr_bldg		varchar2(20),
	addr_unit		varchar2(20)
)

	tablespace		gis_data
	storage		(initial 50k  next 50k  pctincrease 0)
	nologging;

--	========================================================================

	create index	garland.Address_Unit_Source_bldg
		on		garland.Address_Unit_Source(building_id)

	tablespace		gisindx
	storage		(initial 50k  next 50k  pctincrease 0)
	nologging;

--	========================================================================

