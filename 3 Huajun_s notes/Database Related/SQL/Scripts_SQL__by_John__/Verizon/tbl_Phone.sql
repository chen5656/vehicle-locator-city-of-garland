	set echo off;
--	======================================================

--	drop table  garland.PHONE;

	create table  garland.PHONE
(
	parcel_id		number(7),
	phone			varchar2(10),
	zip_code		number(5),
	source		varchar2(01)	-- V = Verizon  A = AT&T
)
	nologging;

--	======================================================

	create index garland.Phone_PARCEL
		on	 garland.Phone(PARCEL_ID)
	nologging;

--	======================================================

	create index garland.Phone_PHONE
		on	 garland.Phone(PHONE)
	nologging;

--	======================================================
	set echo on;

