
--	mslinks < 50000 of cdrelpar that have duplicate parcel ids that should be deleted

	truncate table	gis_objects	reuse storage;


--		01
insert into gis_objects (item01) values ( '4120' );
insert into gis_objects (item01) values ( '4121' );
insert into gis_objects (item01) values ( '4261' );
--		28
insert into gis_objects (item01) values ( '32053' );
insert into gis_objects (item01) values ( '32307' );
insert into gis_objects (item01) values ( '32316' );
insert into gis_objects (item01) values ( '32334' );
insert into gis_objects (item01) values ( '32335' );
insert into gis_objects (item01) values ( '32337' );
insert into gis_objects (item01) values ( '32338' );
--		29
insert into gis_objects (item01) values ( '35216' );
insert into gis_objects (item01) values ( '35766' );
insert into gis_objects (item01) values ( '37667' );
insert into gis_objects (item01) values ( '37670' );
insert into gis_objects (item01) values ( '37916' );
insert into gis_objects (item01) values ( '38736' );
insert into gis_objects (item01) values ( '39332' );
--		30
insert into gis_objects (item01) values ( '39333' );
insert into gis_objects (item01) values ( '42147' );
insert into gis_objects (item01) values ( '43181' );
insert into gis_objects (item01) values ( '43465' );
insert into gis_objects (item01) values ( '00860' );





