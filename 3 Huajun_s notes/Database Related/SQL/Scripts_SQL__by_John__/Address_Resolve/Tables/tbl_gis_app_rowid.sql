
--	=======================================================================================

	drop table		garland.gis_app_rowid;

	create table	garland.gis_app_rowid
	(
		row_seq	number,
		row_id	rowid,

		constraint	gis_app_rowid_pkey
		primary key	(row_seq)
	)
		organization index
		tablespace	 gisindx
		storage	( initial 5m  next 1m  pctincrease 0 );	

--	=======================================================================================

