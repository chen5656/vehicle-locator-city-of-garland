	set echo	off;
	set timing	off;
--	==============================================================================================
--	compare specific pair of names: invalid / valid 
--	==============================================================================================

	truncate table	garland.gis_objects	reuse storage;

--	==============================================================================================

	insert into gis_objects (item01,item02) values ( 'wide oak/wild oak',		' ');

--	insert into gis_objects (item01,item02) values ( 'randolf/randolph',			' ');
--	insert into gis_objects (item01,item02) values ( 'randolf/redell',			' ');

--	insert into gis_objects (item01,item02) values ( '=x/x',		' ');


--	==============================================================================================
/*

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

	insert into gis_objects (item01,item02) values ( 'wunlat/walnut',			' ');
	insert into gis_objects (item01,item02) values ( 'wunlat/wanda',			' ');

	insert into gis_objects (item01,item02) values ( 'waikki/waikiki',		' ');
	insert into gis_objects (item01,item02) values ( '=suset/sussex',		' ');
	insert into gis_objects (item01,item02) values ( '=randolf/randolph',		' ');


*/
--	==============================================================================================


	@c:\deacutis\scripts\address_name\fuzzy_match\A2_compare_name_pairs.sql;


--	==============================================================================================
	set echo	on;
