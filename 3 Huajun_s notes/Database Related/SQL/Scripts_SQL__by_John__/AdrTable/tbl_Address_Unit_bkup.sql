
	drop table		garland.Address_Unit;

	create table	garland.Address_Unit
(
	addr_num			number,
	addr_pfx			varchar2(02),
	addr_name			varchar2(20),
	addr_type			varchar2(04),
	addr_sfx			varchar2(02),
	addr_bldg			varchar2(10),
	addr_unit			varchar2(10),

	address_id			number,
	parent_id			number,
	parcel_id			varchar2(11),

	unit_type			varchar2(05),
	source			varchar2(05),
	source_key			varchar2(10),

	x_coord			number,
	y_coord			number
)
	tablespace	gis_data
	storage ( initial 1m  next 1m  pctincrease 0 )
	;

--	===============================================================================================
 
alter table	Address_Unit
add
(
	constraint	Address_Unit_pkey	
	primary key	(	addr_name,  addr_type,  addr_pfx,   addr_sfx,   addr_num, 
				addr_bldg1, addr_unit1, addr_bldg2, addr_unit2		)
	using		index
	tablespace	gisindx
	storage 	(initial 1m next 1m  pctincrease 0)
);


--	===============================================================================================
/*

create index	Address_Unit_Parcel_ID
	 on 		Address_Unit
			(parcel_id)
	tablespace	gisindx
	storage ( initial 1m  next 1m  pctincrease 0 );

*/
--	===============================================================================================


