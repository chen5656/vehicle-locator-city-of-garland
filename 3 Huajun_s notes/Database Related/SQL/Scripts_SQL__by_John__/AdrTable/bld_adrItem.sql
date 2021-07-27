	set echo	off;
--	==============================================================================
--	build adrItem table
--	==============================================================================

	truncate table	adrItem	reuse storage;

--	STREET DIRECTIONALS

	insert into adrItem values ( 'D',	'N',		'N',		'NORTH'	);
	insert into adrItem values ( 'D',	'NO',		'N',		'NORTH'	);
	insert into adrItem values ( 'D',	'S',		'S',		'SOUTH'	);
	insert into adrItem values ( 'D',	'SO',		'S',		'SOUTH'	);
	insert into adrItem values ( 'D',	'E',		'E',		'EAST'	);
	insert into adrItem values ( 'D',	'W',		'W',		'WEST'	);

	insert into adrItem values ( 'D',	'NE',		'NE',		'NORTHEAST'	);
	insert into adrItem values ( 'D',	'NW',		'NW',		'NORTHWEST'	);
	insert into adrItem values ( 'D',	'SE',		'SE',		'SOUTHEAST'	);
	insert into adrItem values ( 'D',	'SW',		'SW',		'SOUTHWEST'	);

	insert into adrItem values ( 'D',	'NORTH',	'N',		'NORTH'	);
	insert into adrItem values ( 'D',	'SOUTH',	'S',		'SOUTH'	);
	insert into adrItem values ( 'D',	'EAST',	'E',		'EAST'	);
	insert into adrItem values ( 'D',	'WEST',	'W',		'WEST'	);


--	STREET TYPES

	insert into adrItem values ( 'T',	'AVE',	'AVE',	'AVENUE'	);
	insert into adrItem values ( 'T',	'AVEN',	'AVE',	'AVENUE'	);
	insert into adrItem values ( 'T',	'AVN',	'AVE',	'AVENUE'	);
	insert into adrItem values ( 'T',	'AV',		'AVE',	'AVENUE'	);
	insert into adrItem values ( 'T',	'BLVD',	'BLVD',	'BOULEVARD'	);
	insert into adrItem values ( 'T',	'BVLD',	'BLVD',	'BOULEVARD'	);
	insert into adrItem values ( 'T',	'BLV',	'BLVD',	'BOULEVARD'	);
	insert into adrItem values ( 'T',	'BVD',	'BLVD',	'BOULEVARD'	);
	insert into adrItem values ( 'T',	'BL',		'BLVD',	'BOULEVARD'	);
	insert into adrItem values ( 'T',	'CIR',	'CIR',	'CIRCLE'	);
	insert into adrItem values ( 'T',	'CIRC',	'CIR',	'CIRCLE'	);
	insert into adrItem values ( 'T',	'CIRCL',	'CIR',	'CIRCLE'	);
	insert into adrItem values ( 'T',	'CRCL',	'CIR',	'CIRCLE'	);
	insert into adrItem values ( 'T',	'CR',		'CIR',	'CIRCLE'	);
	insert into adrItem values ( 'T',	'COVE',	'COVE',	'COVE'	);
	insert into adrItem values ( 'T',	'CV',		'COVE',	'COVE'	);
	insert into adrItem values ( 'T',	'CT',		'CT',		'COURT'	);
	insert into adrItem values ( 'T',	'CRT',	'CT',		'COURT'	);
	insert into adrItem values ( 'T',	'DR',		'DR',		'DRIVE'	);
	insert into adrItem values ( 'T',	'DRV',	'DR',		'DRIVE'	);
	insert into adrItem values ( 'T',	'DRIV',	'DR',		'DRIVE'	);
	insert into adrItem values ( 'T',	'FRWY',	'FRWY',	'FREEWAY'	);
	insert into adrItem values ( 'T',	'FWRY',	'FRWY',	'FREEWAY'	);
	insert into adrItem values ( 'T',	'FRWAY',	'FRWY',	'FREEWAY'	);
	insert into adrItem values ( 'T',	'FWY',	'FRWY',	'FREEWAY'	);
	insert into adrItem values ( 'T',	'FWAY',	'FRWY',	'FREEWAY'	);
	insert into adrItem values ( 'T',	'EXPR',	'FRWY',	'FREEWAY'	);
	insert into adrItem values ( 'T',	'EXPY',	'FRWY',	'FREEWAY'	);
	insert into adrItem values ( 'T',	'EXPW',	'FRWY',	'FREEWAY'	);
	insert into adrItem values ( 'T',	'EXWY',	'FRWY',	'FREEWAY'	);
	insert into adrItem values ( 'T',	'EXWAY',	'FRWY',	'FREEWAY'	);
	insert into adrItem values ( 'T',	'HWY',	'HWY',	'HIGHWAY'	);
	insert into adrItem values ( 'T',	'HWAY',	'HWY',	'HIGHWAY'	);
	insert into adrItem values ( 'T',	'HIWY',	'HWY',	'HIGHWAY'	);
	insert into adrItem values ( 'T',	'HIWAY',	'HWY',	'HIGHWAY'	);
	insert into adrItem values ( 'T',	'LN',		'LN',		'LANE'	);
	insert into adrItem values ( 'T',	'LA',		'LN',		'LANE'	);
	insert into adrItem values ( 'T',	'PK',		'PK',		'PARK'	);
	insert into adrItem values ( 'T',	'PRK',	'PK',		'PARK'	);
	insert into adrItem values ( 'T',	'PKWY',	'PKWY',	'PARKWAY'	);
	insert into adrItem values ( 'T',	'PWKY',	'PKWY',	'PARKWAY'	);
	insert into adrItem values ( 'T',	'PKWAY',	'PKWY',	'PARKWAY'	);
	insert into adrItem values ( 'T',	'PARKWY',	'PKWY',	'PARKWAY'	);
	insert into adrItem values ( 'T',	'PKY',	'PKWY',	'PARKWAY'	);
	insert into adrItem values ( 'T',	'PWY',	'PKWY',	'PARKWAY'	);
	insert into adrItem values ( 'T',	'PW',		'PKWY',	'PARKWAY'	);
	insert into adrItem values ( 'T',	'PL',		'PL',		'PLACE'	);
	insert into adrItem values ( 'T',	'PLC',	'PL',		'PLACE'	);
	insert into adrItem values ( 'T',	'PLZ',	'PLZ',	'PLAZA'	);
	insert into adrItem values ( 'T',	'PLAZ',	'PLZ',	'PLAZA'	);
	insert into adrItem values ( 'T',	'PLZA',	'PLZ',	'PLAZA'	);
	insert into adrItem values ( 'T',	'RD',		'RD',		'ROAD'	);
	insert into adrItem values ( 'T',	'ROW',	'ROW',	'ROW'		);
	insert into adrItem values ( 'T',	'SQ',		'SQ',		'SQUARE'	);
	insert into adrItem values ( 'T',	'SQR',	'SQ',		'SQUARE'	);
	insert into adrItem values ( 'T',	'SQU',	'SQ',		'SQUARE'	);
	insert into adrItem values ( 'T',	'SQRE',	'SQ',		'SQUARE'	);
	insert into adrItem values ( 'T',	'ST',		'ST',		'STREET'	);
	insert into adrItem values ( 'T',	'STR',	'ST',		'STREET'	);
	insert into adrItem values ( 'T',	'STRT',	'ST',		'STREET'	);
	insert into adrItem values ( 'T',	'TRL',	'TRL',	'TRAIL'	);
	insert into adrItem values ( 'T',	'TR',		'TRL',	'TRAIL'	);
	insert into adrItem values ( 'T',	'TL',		'TRL',	'TRAIL'	);
	insert into adrItem values ( 'T',	'WY',		'WY',		'WAY'		);
	insert into adrItem values ( 'T',	'WAY',	'WY',		'WAY'		);

	insert into adrItem values ( 'T',	'AL',		'AL',		'ALLEY'	);
	insert into adrItem values ( 'T',	'BR',		'BR',		'BRANCH'	);
	insert into adrItem values ( 'T',	'UNP',	'UNP',	'UNDERPASS'	);

	insert into adrItem values ( 'T',	'AVENUE',	'AVE',	'AVENUE'	);
	insert into adrItem values ( 'T',	'BOULEVARD','BLVD',	'BOULEVARD'	);
	insert into adrItem values ( 'T',	'CIRCLE',	'CIR',	'CIRCLE'	);
	insert into adrItem values ( 'T',	'COURT',	'CT',		'COURT'	);
	insert into adrItem values ( 'T',	'DRIVE',	'DR',		'DRIVE'	);
	insert into adrItem values ( 'T',	'FREEWAY',	'FRWY',	'FREEWAY'	);
	insert into adrItem values ( 'T',	'HIGHWAY',	'HWY',	'HIGHWAY'	);
	insert into adrItem values ( 'T',	'LANE',	'LN',		'LANE'	);
	insert into adrItem values ( 'T',	'PARK',	'PK',		'PARK'	);
	insert into adrItem values ( 'T',	'PARKWAY',	'PKWY',	'PARKWAY'	);
	insert into adrItem values ( 'T',	'PLACE',	'PL',		'PLACE'	);
	insert into adrItem values ( 'T',	'PLAZA',	'PLZ',	'PLAZA'	);
	insert into adrItem values ( 'T',	'ROAD',	'RD',		'ROAD'	);
	insert into adrItem values ( 'T',	'ROW',	'ROW',	'ROW'		);
	insert into adrItem values ( 'T',	'SQUARE',	'SQ',		'SQUARE'	);
	insert into adrItem values ( 'T',	'STREET',	'ST',		'STREET'	);
	insert into adrItem values ( 'T',	'TRAIL',	'TRL',	'TRAIL'	);

	insert into adrItem values ( 'T',	'ALLEY',	'AL',		'ALLEY'	);
	insert into adrItem values ( 'T',	'BRANCH',	'BR',		'BRANCH'	);
	insert into adrItem values ( 'T',	'UNDERPASS','UNP',	'UNDERPASS'	);

--	insert into adrItem values ( 'T',	'ON',		'ON',		'ON'		);
--	insert into adrItem values ( 'T',	'OFF',	'OFF',	'OFF'		);	--	OFFICE


--	UNIT CODES

	insert into adrItem values ( 'C',	'APT',	'APT',	'APARTMENT'	);
	insert into adrItem values ( 'C',	'APART',	'APT',	'APARTMENT'	);
	insert into adrItem values ( 'C',	'AP',		'APT',	'APARTMENT'	);
	insert into adrItem values ( 'C',	'STE',	'STE',	'SUITE'	);
	insert into adrItem values ( 'C',	'BLDG',	'BLDG',	'BUILDING'	);
	insert into adrItem values ( 'C',	'BDG',	'BLDG',	'BUILDING'	);
	insert into adrItem values ( 'C',	'BLD',	'BLDG',	'BUILDING'	);
	insert into adrItem values ( 'C',	'FLR',	'FLR',	'FLOOR'	);
	insert into adrItem values ( 'C',	'FL',		'FLR',	'FLOOR'	);
	insert into adrItem values ( 'C',	'LOT',	'LOT',	'LOT'		);
	insert into adrItem values ( 'C',	'LT',		'LOT',	'LOT'		);
	insert into adrItem values ( 'C',	'SUIT',	'STE',	'SUITE'	);
	insert into adrItem values ( 'C',	'OFC',	'STE',	'SUITE'	);
	insert into adrItem values ( 'C',	'OFFICE',	'STE',	'SUITE'	);
	insert into adrItem values ( 'C',	'OFFI',	'STE',	'SUITE'	);
	insert into adrItem values ( 'C',	'RM',		'RM',		'ROOM'	);
	insert into adrItem values ( 'C',	'TP',		'TEMP',	'TEMP'	);
	insert into adrItem values ( 'B',	'TEMP',	'TEMP ',	'TEMP');
	insert into adrItem values ( 'C',	'UNIT',	'UNIT',	'UNIT'	);
	insert into adrItem values ( 'C',	'UNT',	'UNIT',	'UNIT'	);
	insert into adrItem values ( 'C',	'UN',		'UNIT',	'UNIT'	);
--	insert into adrItem values ( 'C',	'NO',		'#',		'#'		);

	insert into adrItem values ( 'C',	'APARTMENT','APT',	'APARTMENT'	);
	insert into adrItem values ( 'C',	'SUITE',	'STE',	'SUITE'	);
	insert into adrItem values ( 'C',	'OFFICE',	'STE',	'SUITE'	);
	insert into adrItem values ( 'C',	'FLOOR',	'FLR',	'FLOOR'	);
	insert into adrItem values ( 'C',	'ROOM',	'RM',		'ROOM'	);
	insert into adrItem values ( 'C',	'BUILDING',	'BLDG',	'BUILDING'	);


--	HIGHWAY Garland

	insert into adrItem values ( 'H',	'30',		'30',		'I30'				);
	insert into adrItem values ( 'H',	'66',		'66',		'STATE HIGHWAY 66'	);
	insert into adrItem values ( 'H',	'78',		'78',		'LAVON'			);
	insert into adrItem values ( 'H',	'190',	'190',	'GEORGE BUSH'		);
	insert into adrItem values ( 'H',	'635',	'635',	'LBJ'				);

--	HIGHWAY Non-Garland

	insert into adrItem values ( 'H',	'I',		'',		'I'				);
	insert into adrItem values ( 'H',	'IH',		'',		'I'				);
	insert into adrItem values ( 'H',	'INTERSTATE','',		'I'				);
	insert into adrItem values ( 'H',	'HIGHWAY',	'',		'I'				);
	insert into adrItem values ( 'H',	'35',		'',		'I35'				);
	insert into adrItem values ( 'H',	'45',		'',		'I45'				);
	insert into adrItem values ( 'H',	'67',		'',		'HIGHWAY 67'		);
	insert into adrItem values ( 'H',	'75',		'',		'75'				);


--	BUSINESS TERMS
--	OBJECT  TERMS 

	insert into adrItem values ( 'B',	'ADDN',		' ',		' ');
	insert into adrItem values ( 'B',	'ADDITION',		' ',		' ');
	insert into adrItem values ( 'B',	'ANNEX',		' ',		' ');
	insert into adrItem values ( 'B',	'BILLBOARD',	' ',		' ');
	insert into adrItem values ( 'B',	'BILLBOARDS',	' ',		' ');
	insert into adrItem values ( 'B',	'BUS',		' ',		' ');
	insert into adrItem values ( 'B',	'CABLE',		' ',		' ');
	insert into adrItem values ( 'B',	'CO',			' ',		' ');
	insert into adrItem values ( 'B',	'COMMUNICATIONS',	' ',		' ');
	insert into adrItem values ( 'B',	'CTS',		' ',		' ');
	insert into adrItem values ( 'B',	'DIST',		' ',		' ');
	insert into adrItem values ( 'B',	'EST',		' ',		' ');
	insert into adrItem values ( 'B',	'GAS',		' ',		' ');
	insert into adrItem values ( 'B',	'HYDRANT',		' ',		' ');
	insert into adrItem values ( 'B',	'LEASE',		' ',		' ');
	insert into adrItem values ( 'B',	'LEASED',		' ',		' ');
	insert into adrItem values ( 'B',	'METER',		' ',		' ');
	insert into adrItem values ( 'B',	'PHONE',		' ',		' ');
	insert into adrItem values ( 'B',	'INDL',		' ',		' ');
	insert into adrItem values ( 'B',	'BOX',		' ',		' ');
	insert into adrItem values ( 'B',	'PO',			' ',		' ');
	insert into adrItem values ( 'B',	'RETAIL',		' ',		' ');
	insert into adrItem values ( 'B',	'ROUTE',		' ',		' ');
	insert into adrItem values ( 'B',	'RT',			' ',		' ');
	insert into adrItem values ( 'B',	'RR',			' ',		' ');
	insert into adrItem values ( 'B',	'RAIL',		' ',		' ');
	insert into adrItem values ( 'B',	'RAILROAD',		' ',		' ');
	insert into adrItem values ( 'B',	'BALLFIELD',	' ',		' ');
	insert into adrItem values ( 'B',	'CONCESSION',	' ',		' ');
	insert into adrItem values ( 'B',	'CONCESS',		' ',		' ');
	insert into adrItem values ( 'B',	'FLOODWAY',		' ',		' ');
	insert into adrItem values ( 'B',	'FOOTBALL',		' ',		' ');
	insert into adrItem values ( 'B',	'PLAYGROUND',	' ',		' ');
	insert into adrItem values ( 'B',	'POOL',		' ',		' ');
	insert into adrItem values ( 'B',	'PRIVATE',		' ',		' ');
	insert into adrItem values ( 'B',	'RAIL',		' ',		' ');
	insert into adrItem values ( 'B',	'OPERATIONS',	' ',		' ');
	insert into adrItem values ( 'B',	'REC',		' ',		' ');
	insert into adrItem values ( 'B',	'SOCCER',		' ',		' ');
	insert into adrItem values ( 'B',	'TENNIS',		' ',		' ');
	insert into adrItem values ( 'B',	'SERVICE',		' ',		' ');
	insert into adrItem values ( 'B',	'STND',		' ',		' ');
	insert into adrItem values ( 'B',	'SUBDIV',		' ',		' ');
	insert into adrItem values ( 'B',	'SUBDIVISION',	' ',		' ');
	insert into adrItem values ( 'B',	'TRANSMISSION',	' ',		' ');
	insert into adrItem values ( 'B',	'UNKNOWN',		' ',		' ');
	insert into adrItem values ( 'B',	'NEXT',		' ',		' ');
	insert into adrItem values ( 'B',	'XING',		' ',		' ');
	insert into adrItem values ( 'B',	'FLOATING',		' ',		' ');		-- UMS
	insert into adrItem values ( 'B',	'%',			' ',		' ');	


--	KEY WORDS

	insert into adrItem values ( 'K',	'OF',		'OF',		'OF'		);
	insert into adrItem values ( 'K',	'ON',		'ON',		'ON'		);
	insert into adrItem values ( 'K',	'AT',		'AT',		'AT'		);
	insert into adrItem values ( 'K',	'FROM',	'FROM',	'FROM'	);
	insert into adrItem values ( 'K',	'NEAR',	'NEAR',	'NEAR'	);
	insert into adrItem values ( 'K',	'BLK',	'BLOCK',	'BLOCK'	);
	insert into adrItem values ( 'K',	'BLK OF',	'BLOCK',	'BLOCK'	);
	insert into adrItem values ( 'K',	'BLOCK',	'BLOCK',	'BLOCK'	);
	insert into adrItem values ( 'K',	'BLOCK OF',	'BLOCK',	'BLOCK'	);
	insert into adrItem values ( 'K',	'NB',		'NB',		'NORTHBOUND');
	insert into adrItem values ( 'K',	'SB',		'SB',		'SOUTHBOUND');
	insert into adrItem values ( 'K',	'EB',		'EB',		'EASTBOUND'	);
	insert into adrItem values ( 'K',	'WB',		'WB',		'WESTBOUND'	);

	commit;

--	==============================================================================

	select count(*) "total" from garland.adrItem;

--	==============================================================================

