--	========================================================================
--	Apartment/Office Complexes obtained from Access file
--	G:\City\DavidJacobs\Code\MFInterim Database
--	========================================================================

	create table	garland.Address_Complex_Source
(
	complex_id		number,
	trade_name		varchar2(80),
	complex_name	varchar2(80),

	addr_num		number,
	addr_pfx		varchar2(10),
	addr_name		varchar2(30),
	addr_type		varchar2(10),
	addr_sfx		varchar2(10)
)

	tablespace		gis_data
	storage		( initial 50k  next 50k  pctincrease 0 )
	nologging;

