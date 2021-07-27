	set echo on;
--	===============================================================

--	drop   table garland.CODE_DISTRICT;
	create table garland.CODE_DISTRICT
(
	 parcel_id                          number(7,0)
	,nuisance_district                  number(2,0)
	,nuisance_inspector                 varchar2(20)
	,nuisance_phone                     varchar2(15)
	,rental_district                    number(2,0)
	,rental_inspector                   varchar2(20)
	,rental_phone                       varchar2(15)
	,is_rental                          number(1,0)
	,council_id                         number(1,0)
	,police_beat                        number(3,0)
	,zip_code                           number(5,0)
	,parcel_id_old                      varchar2(11)
	,cdbg						varchar2(1),
	,cdbgid					number(5,0)	
)	tablespace GIS_DATA  nologging;

--	===============================================================

	create index garland.Code_District_Parcel
		on	 garland.Code_District(Parcel_ID)

	tablespace	gis_index
	storage	(initial 1m)
	nologging;

--	===============================================================
	set echo on;
