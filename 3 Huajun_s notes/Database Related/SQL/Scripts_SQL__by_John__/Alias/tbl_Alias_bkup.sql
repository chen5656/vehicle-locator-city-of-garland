	set echo off;

	create table  garland.Alias
(
	category		varchar2(05),
	
	bef_prefix		varchar2(02),
	bef_name		varchar2(20),
	bef_type		varchar2(04),
	bef_suffix		varchar2(02),
	bef_bldg		varchar2(10),
	bef_unit		varchar2(10),

	aft_prefix		varchar2(02),
	aft_name		varchar2(20),
	aft_type		varchar2(04),
	aft_suffix		varchar2(02),
	aft_bldg		varchar2(10),
	aft_unit		varchar2(10),

	range_lo		number(6,0),
	range_hi		number(6,0),

	match			number(4,0),
	rank			number(4,0)

	tablespace		gis_data
	nologging;

--	==============================================================

	alter table		garland.Alias
	add constraint	Aliaspkey
	primary key		(bef_name, bef_type, bef_prefix, bef_suffix, bef_bldg, bef_unit, range_lo)
	using
	tablespace		gis_index
	nologging;

--	==============================================================
