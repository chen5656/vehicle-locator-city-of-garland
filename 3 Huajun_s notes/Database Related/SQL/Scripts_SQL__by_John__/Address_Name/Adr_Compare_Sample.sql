	set echo off;
	set timing off;
--	===============================================================================================
--	compare mis-spelled street names against adrstreet using adr_compare_name
--	===============================================================================================

--	update gis_objects set item01 = 'best'		where item02 = '$';
--	update gis_objects set item01 = 'all'		where item02 = '$';


	truncate table	garland.gis_objects	reuse storage;							

/*


--	insert into gis_objects (item01,item02) values ( 'all',		'$');


--	keep
	insert into gis_objects (item01,item02) values ( 'bellt-line',	' ');
	insert into gis_objects (item01,item02) values ( 'clove', 		' ');
	insert into gis_objects (item01,item02) values ( 'bellair', 	' ');
	insert into gis_objects (item01,item02) values ( 'lockness',	' ');
	insert into gis_objects (item01,item02) values ( 'randolf',		' ');
	insert into gis_objects (item01,item02) values ( 'wide oak',	' ');
	insert into gis_objects (item01,item02) values ( 'sweetleal',	' ');
	insert into gis_objects (item01,item02) values ( 'fores',	'');
	insert into gis_objects (item01,item02) values ( 'conolel',	'');
	insert into gis_objects (item01,item02) values ( 'coronel',	'');
	insert into gis_objects (item01,item02) values ( 'colnell',	'');
	insert into gis_objects (item01,item02) values ( 'cablier',	'');
	insert into gis_objects (item01,item02) values ( 'waltun',		'');
	insert into gis_objects (item01,item02) values ( 'wanult',		'');
	insert into gis_objects (item01,item02) values ( 'wanlut',		'');
	insert into gis_objects (item01,item02) values ( 'jutiper',	'');
	insert into gis_objects (item01,item02) values ( 'juritep',	'');
	insert into gis_objects (item01,item02) values ( 'aconr green',	'');
	insert into gis_objects (item01,item02) values ( 'arcon green',	'');
	insert into gis_objects (item01,item02) values ( 'fisrt',		'');
	insert into gis_objects (item01,item02) values ( 'firts',		'');
	insert into gis_objects (item01,item02) values ( 'fitst',		'');
	insert into gis_objects (item01,item02) values ( 'fist',		'');
	insert into gis_objects (item01,item02) values ( 'avob',		'');
	insert into gis_objects (item01,item02) values ( 'acon',		'');
	insert into gis_objects (item01,item02) values ( 'mane',		'');
	insert into gis_objects (item01,item02) values ( 'mian',		'');
	insert into gis_objects (item01,item02) values ( 'maim',		'');
	insert into gis_objects (item01,item02) values ( 'miam',		'');
	insert into gis_objects (item01,item02) values ( 'wick',		'');
	insert into gis_objects (item01,item02) values ( 'wicke',		'');
	insert into gis_objects (item01,item02) values ( 'wickes',		'');
	insert into gis_objects (item01,item02) values ( 'syacude',	'');
	insert into gis_objects (item01,item02) values ( 'ridgevue',	'');
	insert into gis_objects (item01,item02) values ( 'bankhand',	'');
	insert into gis_objects (item01,item02) values ( 'trinid',		'');
	insert into gis_objects (item01,item02) values ( 'walnut cir east',	'');
	insert into gis_objects (item01,item02) values ( 'brandon',	'');
	insert into gis_objects (item01,item02) values ( 'lemmon',		'');
	insert into gis_objects (item01,item02) values ( 'miles',		'');


	insert into gis_objects (item01,item02) values ( 'waikki',		'');
	insert into gis_objects (item01,item02) values ( 'rigwood',		'');
	insert into gis_objects (item01,item02) values ( 'suset ',		'');
	insert into gis_objects (item01,item02) values ( 'oats',		'');
	insert into gis_objects (item01,item02) values ( 'wimblton',	'');
	insert into gis_objects (item01,item02) values ( 'windbridge',	'');
	insert into gis_objects (item01,item02) values ( 'teawood',		'');
	insert into gis_objects (item01,item02) values ( 'geenview',	'');
	insert into gis_objects (item01,item02) values ( 'galaxy',		'');
	insert into gis_objects (item01,item02) values ( 'warick',		'');

	insert into gis_objects (item01,item02) values ( '*****',	'');
	insert into gis_objects (item01,item02) values ( 'buckham',	'');
	insert into gis_objects (item01,item02) values ( 'ridgebrook',	'');
	insert into gis_objects (item01,item02) values ( 'cavlere',	'');
	insert into gis_objects (item01,item02) values ( 'shepatd',	'');
	insert into gis_objects (item01,item02) values ( 'crestone',	'');
	insert into gis_objects (item01,item02) values ( 'wunlat',		'');
	insert into gis_objects (item01,item02) values ( 'mikly way',	' ');
	insert into gis_objects (item01,item02) values ( 'cunrty clb',	'');
	insert into gis_objects (item01,item02) values ( 'couny clob',	'');
	insert into gis_objects (item01,item02) values ( 'conty clb',	'');
	insert into gis_objects (item01,item02) values ( 'cuntyr lub',	'');
	insert into gis_objects (item01,item02) values ( 'lake ray hubbard',	'');
	insert into gis_objects (item01,item02) values ( 'marvin love',		'');


*/


--	===============================================================================================

	insert into gis_objects (item01,item02) values ( 'PUTNAM WAY',		'');
	insert into gis_objects (item01,item02) values ( 'STATE HWY 66',		'');
	insert into gis_objects (item01,item02) values ( 'PLATEAU',			'');
	insert into gis_objects (item01,item02) values ( 'MAIMED NAME',		'');
	insert into gis_objects (item01,item02) values ( 'LANE JOLLA',		'');
	insert into gis_objects (item01,item02) values ( 'BELI LINE',		'');
	insert into gis_objects (item01,item02) values ( 'KNIGHTSHAVEN',		'');


--	===============================================================================================

	@c:\deacutis\scripts\address_name\test_compare_names.sql;


	set echo	on;


