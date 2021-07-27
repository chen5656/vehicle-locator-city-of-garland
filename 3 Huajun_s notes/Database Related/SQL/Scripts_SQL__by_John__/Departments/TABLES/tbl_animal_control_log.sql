
	drop table		animal_control_log;

	create table	animal_control_log
	(
		Rec_Key		number,
		Addr_Num		number,
		Addr_Pfx		varchar2(02),
		Addr_Name		varchar2(80),
		Addr_Type		varchar2(04),
		Addr_Sfx		varchar2(02),
		Addr_Unit		varchar2(10),
		Parcel_ID		varchar2(11)
	)

	tablespace	gis_data
	storage	(initial 320k  next 320k  pctincrease 0);
