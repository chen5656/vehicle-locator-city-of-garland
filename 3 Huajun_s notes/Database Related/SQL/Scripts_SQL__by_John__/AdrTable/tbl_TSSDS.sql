
--	drop table		garland.tssds;

	create table	garland.tssds
(
	rec_seq		number,
	rec_type		varchar2(08),

	table_name		varchar2(08),
	field_name		varchar2(20),
	field_type		varchar2(01),
	field_length	number,
	field_domain	varchar2(20),
	field_key		varchar2(20),
	field_describe	varchar2(400)
)

	tablespace	gis_data
	nologging
	storage (initial 200k  next 200k  pctincrease 0);

--	===================================================

	alter table		garland.tssds
	add	constraint	tssds_pkey
	primary key		(table_name)

	using index
	tablespace		gisindx
	storage (initial 200k  next 200k  pctincrease 0);

--	===================================================
