
--	=======================================================================

	create table   garland.PARCEL_SANITATION
(
	parcel_id		varchar2(11),
	trash_pickup	varchar2(12),
	brush_pickup	varchar2(12),
	recycle_pickup	varchar2(12)
)
	nologging
	tablespace		gis_data
	storage		( initial 2m  next 100k  pctincrease 0 );

--	=======================================================================

	alter table  garland.PARCEL_SANITATION

	add	constraint	PARCEL_SANITATION_PKEY
		primary key (parcel_id)

	using index
		nologging
		tablespace		gis_data
		storage		( initial 100k  next 100k  pctincrease 0 );

--	===========================================================================
/*

	truncate table  parcel_sanitation  reuse storage;

--	alter rollback segment rb1 online;
--	commit;
--	set transaction use rollback segment rb1;

	insert into parcel_sanitation
	select distinct item01, item02, item03, item04, item06
	from	 gis_objects
	where	item01 <> '5400724.000'
	;

--	ROLLBACK;
	commit;
--	alter rollback segment rb1 offline;

/*
--	===========================================================================
