	set echo off;
--	======================================================================================================
--	Load Sample Input for Find Address routine
--	======================================================================================================

	truncate table	garland.GIS_Objects		reuse storage;

--	======================================================================================================

--	insert into Find_Address_Input values ( '0'
--	'', '', '', '', '', '', '',		'','','',		'','','');

--	======================================================================================================

	insert into Find_Address_Input values ( '01',
	'217', 'N', 'FIFTH', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '03',
	'217', 'N', 'FIhTf', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '04',
	'200', 'S', 'FIhfT', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);


	insert into Find_Address_Input values ( '01',
	'501', '', 'BUTER NUT', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '01',
	'601', '', 'O''PHELLAN', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '04',
	'4105', '', 'Miller', 'Pk', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '04',
	'3801', '', 'Brandon', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '05',
	'3030', '', 'Naman', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '05',
	'1601', '', 'Fores', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '06',
	'301', '', 'Woodaven', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '07',
	'601', '', 'wanlut', 'cr', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '03',
	'1901', '', 'jutiper', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '03',
	'105', '', 'bamcraft', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '09',
	'2110', '', 'glennbrook', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '03',
	'217', '', '10th', '', 's', '', '',			'GIS VERIFY','','',  '1', '2', '3'			);


	insert into Find_Address_Input values ( '03',
	'4001', '', 'walling', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '03',
	'5010', '', 'harth', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

--	insert into Find_Address_Input values ( '03',
--	'2801', '', 'platto', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

--	insert into Find_Address_Input values ( '03',
--	'2910', '', 'bag spring', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '03',
	'1501', '', 'kong', 'rd', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '03',
	'501', '', 'wall', 'st', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '03',
	'901', '', 'lynn', 'dr', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '03',
	'901', '', 'ce ora', 'dr', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '03',
	'301', 'e', 'ih 30', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

--	insert into Find_Address_Input values ( '03',
--	'310', '', 'west ih-30', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

--	insert into Find_Address_Input values ( '03',
--	'1601', '', 'glyncrook', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

--	======================================================================================================
/*

	insert into Find_Address_Input values ( '03',
	'', '', 'x', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

	insert into Find_Address_Input values ( '03',
	'', '', 'x', '', '', '', '',		'GIS VERIFY','','',  '1', '2', '3'			);

*/
--	======================================================================================================

	@c:\deacutis\scripts\address_resolve\address_finder\New_Address\1_Execute_Sample.sql

--	======================================================================================================
	set echo on;


