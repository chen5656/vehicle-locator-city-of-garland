
--	drop table		garland.council_member;

	create table	garland.council_member
(
	council_district		varchar2(01),
	last_name			varchar2(20),
	first_name			varchar2(20),
	home_phone			varchar2(12)

)
	tablespace	gis_data
	storage	( initial 50k  next 50k  pctincrease 0);
