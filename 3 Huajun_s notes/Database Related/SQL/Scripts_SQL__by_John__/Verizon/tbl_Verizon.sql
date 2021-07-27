	set echo off;
--	======================================================

--	drop table  garland.verizon;

	create table  garland.verizon
(
	parcel_id		number(7),
	phone			varchar2(10),
	zip_code		numbe5(5)			-- jan 2006
);

	create index garland.verizon_phone
		on	 garland.verizon(phone)
	tablespace	gis_data
	nologging;

--	======================================================
	set echo on;

