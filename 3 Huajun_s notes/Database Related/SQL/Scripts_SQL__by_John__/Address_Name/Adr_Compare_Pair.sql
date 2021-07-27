	set echo off;
--	==============================================================================================
--	compare specific pair of names: invalid / valid 
--	==============================================================================================

	truncate table	garland.gis_objects	reuse storage;

--	==============================================================================================

	insert into gis_objects (item01,item02) values ( '=cablier/cavalier',		' ');


/*
--	==============================================================================================


--	double orphan
	insert into gis_objects (item01,item02) values ( 'xyzAAxyz/xyzxyz',		' ');
	insert into gis_objects (item01,item02) values ( 'xyzxyzAA/xyzxyz',		' ');


--	==============================================================================================

	insert into gis_objects (item01,item02) values ( '=arcon green/acorn green',	' ');

	insert into gis_objects (item01,item02) values ( '=fores/forest',		' ');
	insert into gis_objects (item01,item02) values ( '=fores/flores',		' ');
	insert into gis_objects (item01,item02) values ( '=fores/forbes',		' ');
	insert into gis_objects (item01,item02) values ( '=fores/fern',			' ');

	insert into gis_objects (item01,item02) values ( '=cablier/cavalier',		' ');
	insert into gis_objects (item01,item02) values ( '=cablier/chablis',		' ');

	insert into gis_objects (item01,item02) values ( 'coronel/cornell',		' ');
	insert into gis_objects (item01,item02) values ( 'coronel/colonel',		' ');
	insert into gis_objects (item01,item02) values ( '=colnell/colonel',		' ');
	insert into gis_objects (item01,item02) values ( '=colnell/cornell',		' ');
	insert into gis_objects (item01,item02) values ( '=collonel/colonel',		' ');

	insert into gis_objects (item01,item02) values ( 'county clob/country club',	' ');
	insert into gis_objects (item01,item02) values ( 'county clb/country club',	' ');
	insert into gis_objects (item01,item02) values ( 'counrty clb/country club',	' ');

	insert into gis_objects (item01,item02) values ( '=abon/avalon',			' ');

	insert into gis_objects (item01,item02) values ( 'wunlat/walnut',		' ');
	insert into gis_objects (item01,item02) values ( 'wunlat/wanda',		' ');


--	==============================================================================================
*/



--	@c:\deacutis\scripts\address_name\adr_compare_test.sql;
