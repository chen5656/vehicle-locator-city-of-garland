	set echo	off;
--	===========================================================================

	drop   table	garland.GDS_Exemption;

	create table	garland.GDS_Exemption
(
	Account		varchar2(10),
	Tax_Year		number  (04),
	Tax_Entity		varchar2(04),
	Exempt_Code		varchar2(02)
)
	tablespace		gis_data
	storage		(initial 1m  next 1m  pctincrease 0)
	nologging;

--	===========================================================================

	create index	garland.GIS_Exemption_Account
		on		garland.GDS_Exemption(Account)

	tablespace	gis_index
	nologging;


--	===========================================================================

