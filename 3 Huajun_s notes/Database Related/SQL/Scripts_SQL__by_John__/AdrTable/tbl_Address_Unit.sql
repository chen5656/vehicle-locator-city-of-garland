--	=====================================================================================
--	Address Unit, Building, & Complex  table


--	Sources:  Code survey, Tax table, UMS table

--	=====================================================================================
--	ADDRESS UNITS

--	index			parent address
--	index			parent complex
--	unique		unit aid
--	primary		address

--	parent 		basic   address id
--	parent 		complex address id
--	complex		additional info

--	unit_type		plx, bldg, unit, apt, ste			
--	=====================================================================================

--	drop table		garland.Address_Unit;

	create table	garland.Address_Unit
(
	addr_num			number,
	addr_pfx			varchar2(02),
	addr_name			varchar2(20),
	addr_type			varchar2(04),
	addr_sfx			varchar2(02),
	addr_bldg			varchar2(20),
	addr_unit			varchar2(20),

	address_id			number,		--  address id of unit  address
	parent_id			number,		--  address id of basic address (CDRELADR)
	parcel_id			varchar2(11),	--  parcel  id of basic address

	unit_type			varchar2(05),
	source			varchar2(05),
	source_key			varchar2(20),

	x_coord			number,
	y_coord			number
)

	tablespace	gis_data
	storage ( initial 100k  next 100k  pctincrease 0 )
	nologging;


--	===============================================================================================

alter table	Address_Unit
add
(
	constraint	Address_Unit_AID
	unique	(address_id)
	using		index
	tablespace	gisindx
	storage 	(initial 100K next 100k  pctincrease 0)
);

--	===============================================================================================

create index	Address_Unit_Parcel_ID
	 on 		Address_Unit(parcel_id)

	tablespace	gisindx
	storage ( initial 100K  next 100K  pctincrease 0 );


--	===============================================================================================

create index	Address_Unit_Parent_ID
	 on 		Address_Unit(parent_id)

	tablespace	gisindx
	storage ( initial 100K  next 100K  pctincrease 0 );

--	===============================================================================================


