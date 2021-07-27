
	create table garland.Engr_AsBuilt
(
	project_num			varchar2(11),
	subdivision			varchar2(25),
	project_name		varchar2(40),			
	classify			varchar2(10),
	parcel_num			number,
	asbuilt_date		varchar2(10),
	inspector			varchar2(20),
	contractor			varchar2(20)
)
	tablespace			gis_data
	storage			(initial 50K  next 50K  pctincrease 0);

