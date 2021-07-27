
--	===================================================================================================================	
--	VERIFY ONLY (without correcting)

--	===================================================================================================================	
--	COMMON CORRECTIONS

--	addr_quals changed from space to null			-- may 2003

	select 'alias misc' " " from dual;

	insert into garland.adrAlias_vw values 
		('E',  'SIDE OF', 'SQ', '*', 01,999999,  		'','EAST SIDE OF SQUARE','','',	'MISC');

	insert into garland.adrAlias_vw values 
		('*',  'BRIAR OAKS','*', '*',01,999999,		'', 'BRIAROAKS',	'', '',		'MISC');
	insert into garland.adrAlias_vw values 
		('*',  'CROSS',	 'CT', '*',	0,999999,		'', 'CROSS COURTS',  '', '',		'MISC');
	insert into garland.adrAlias_vw values 
		('*',  'GALAXY',	 '*', '*',	0,999999,		'', 'GALAXIE',  	'', '',		'MISC');
	insert into garland.adrAlias_vw values
		('*',  'LAKE RAY HUBBARD', '*','*',0,999999,	'','LAKE HUBBARD','', '',		'MISC');
	insert into garland.adrAlias_vw values 
		('*',  'LYNDA', 	 '*', '*',	0,999999,		'', 'LINDA',    	'', '',		'MISC');
	insert into garland.adrAlias_vw values 
		('*',  'NW', 	'*', '*',	0,999999,		'', 'NORTHWEST',	'', '',		'MISC');
	insert into garland.adrAlias_vw values 
		('*',  'OATS', 	 '*', '*',	0,999999,		'', 'OATES',    	'', '',		'MISC');
	insert into garland.adrAlias_vw values 
		('*',  'PLACE 1', '*','*',	0,999999,		'', 'PLACE ONE', 	'', '',		'MISC');
 	insert into garland.adrAlias_vw values 
		('*',  'PRESIDENT GEORGE BUSH', '*','*',	0,999999,	'', 'GEORGE BUSH', '', '',	'MISC');
		

--	===================================================================================================================	
--	"LIKE" HIGHWAY NUMBER

	select 'alias highway' " " from dual;

	insert into garland.adrAlias_vw values 
		('*', '%30',  '*', '*',	0,999999,	'', 'I30',			'FRWY', '', 'LIKE');

	insert into garland.adrAlias_vw values 
		('*', '%66',  '*', '*',	0,999999,	' ', 'STATE HIGHWAY 66','HWY', '', 'LIKE');

	insert into garland.adrAlias_vw values 
		('*', '%78',  '*', '*',	0,999999,	' ', 'LAVON',		'DR', '', 	'LIKE');

	insert into garland.adrAlias_vw values 
		('*', '%190', '*', '*',	0,999999,	' ', 'GEORGE BUSH',	'HWY', '', 'LIKE');

	insert into garland.adrAlias_vw values 
		('*', '%635', '*', '*',	0,999999,	' ', 'LBJ',			'FRWY', '', 'LIKE');

	insert into garland.adrAlias_vw values 
		('*', '%67',  '*', '*',	0,999999,	'', 'STATE HIGHWAY 67',	'HWY', '',	'LIKE');

--	===================================================================================================================	
--	"LIKE" OTHER CITY 

	select 'alias city' " " from dual;

	insert into garland.adrAlias_vw values 
		('*', '%DALLAS%',	'*', '*',		0,999999,	'', '', '', '',		'LIKE$');
	insert into garland.adrAlias_vw values 
		('*', '%MESQUITE%',  	'*', '*',	0,999999,	'', '', '', '',		'LIKE$');
	insert into garland.adrAlias_vw values 
		('*', '%RICHARDSON%',	'*', '*',	0,999999,	'', '', '', '',		'LIKE$');
	insert into garland.adrAlias_vw values 
		('*', '%SACHSE%',	'*', '*',		0,999999,	'', '', '', '',		'LIKE$');
	insert into garland.adrAlias_vw values 
		('*', '%SUNNYVALE%',	'*', '*',	0,999999,	'', '', '', '',		'LIKE$');
	insert into garland.adrAlias_vw values 
		('*', '%WYLIE%',		'*', '*',	0,999999,	'', '', '', '',		'LIKE$');

	insert into garland.adrAlias_vw values ('*', '% BOX %', 	'*', '*',		0,999999,	'', '', '', '', 		'LIKE$');
--	insert into garland.adrAlias_vw values ('*', '%PO %', 	  	'*', '*',		0,999999,	'', '', '', '', 		'LIKE$');
--	insert into garland.adrAlias_vw values ('*', '%RT %', 	  	'*', '*',		0,999999,	'', '', '', '', 		'LIKE$');

	commit;

--	===================================================================================================================	
--	PARTIAL CORRECTION

	select 'alias part' " " from dual;

	insert into garland.adrAlias_vw values 
		('*', 'WALNUT', 'CIR', '*',	0,999999,  '', 'WALNUT CIRCLE', ' ', '', 	'PART*');

	insert into garland.adrAlias_vw values 
		('*',  'STATE', 	'HWY', '*',	0,999999,	'', 'STATE HIGHWAY', '', '',	'PART*');

--	===================================================================================================================	
--	PREFIX & TYPE & SUFFIX

	select 'alias pull' " " from dual;

	insert into	adrAlias_vw values 
		('N', 'COURT', '*', '*',	0,999999,  ' ', 'NORTH', 'CT', ' ', 		'PULL');

	insert into	adrAlias_vw values 
		('*', 'WALNUT', 'CIR', 'E',	0,999999,  ' ', 'WALNUT CIRCLE EAST', ' ', ' ', 'PULL');

	insert into	adrAlias_vw values 
		('*', 'WALNUT', 'CIR', 'W',	0,999999,  ' ', 'WALNUT CIRCLE WEST', ' ', ' ', 'PULL');

	insert into	adrAlias_vw values 
		('E', 'WALNUT', 'CIR', '*',	0,999999,  ' ', 'WALNUT CIRCLE EAST', ' ', ' ', 'PULL');

	insert into	adrAlias_vw values 
		('W', 'WALNUT', 'CIR', '*',	0,999999,  ' ', 'WALNUT CIRCLE WEST', ' ', ' ', 'PULL');

	insert into	adrAlias_vw values 
		('E', 'WALNUT CIRCLE', '*', '*',0,999999,  ' ','WALNUT CIRCLE EAST', ' ', ' ', 'PULL');

	insert into	adrAlias_vw values 
		('W', 'WALNUT CIRCLE', '*', '*',0,999999,  ' ','WALNUT CIRCLE WEST', ' ', ' ', 'PULL');

	insert into garland.adrAlias_vw values 
		('*', 'MILLER', 'PK', 'N',	0,999999,  ' ', 'MILLER PARK NORTH',  ' ', ' ', 'PULL');

	insert into garland.adrAlias_vw values 
		('*', 'MILLER', 'PK', 'S',	0,999999,  ' ', 'MILLER PARK SOUTH',  ' ', ' ', 'PULL');

	insert into	adrAlias_vw values 
		('N', 'MILLER', 'PK', '*',	0,999999,  ' ', 'MILLER PARK NORTH', ' ', ' ', 	'PULL');

	insert into	adrAlias_vw values 
		('S', 'MILLER', 'PK', '*',	0,999999,  ' ', 'MILLER PARK SOUTH', ' ', ' ', 	'PULL');

	insert into	adrAlias_vw values 
		('N', 'MILLER PARK', '*', '*',0,999999,  ' ', 'MILLER PARK NORTH', ' ', ' ', 	'PULL');

	insert into	adrAlias_vw values 
		('S', 'MILLER PARK', '*', '*',0,999999,  ' ', 'MILLER PARK SOUTH', ' ', ' ', 	'PULL');

	commit;

--	===================================================================================================================	
--	NTH STREETS

	select 'alias nth' " " from dual;

	insert into	adrAlias_vw	values	
		('*', '1ST', '*', '*',		0,999999,	'', 'FIRST', 	'', ' ', 	'NTH');
	insert into	adrAlias_vw	values	
		('*', '2ND', '*', '*',		0,999999,	'', 'SECOND', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '3RD', '*', '*',		0,999999,	'', 'THIRD', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '4TH', '*', '*',		0,999999,	'', 'FOURTH', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '5TH', '*', '*',		0,999999,	'', 'FIFTH', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '6TH', '*', '*',		0,999999,	'', 'SIXTH', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '7TH', '*', '*',		0,999999,	'', 'SEVENTH', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '8TH', '*', '*',		0,999999,	'', 'EIGHTH', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '9TH', '*', '*',		0,999999,	'', 'NINTH', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '10TH', '*', '*',		0,999999,	'', 'TENTH', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '11TH', '*', '*',		0,999999,	'', 'ELEVENTH', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '12TH', '*', '*',		0,999999,	'', 'TWELFTH', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '13TH', '*', '*',		0,999999,	'', 'THIRTEENTH', '', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '15TH', '*', '*',		0,999999,	'', 'FIFTEENTH',  '',  ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '16TH', '*', '*',		0,999999,	'', 'SIXTEENTH',  '',  ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '17TH', '*', '*',		0,999999,	'', 'SEVENTEENTH', '', ' ',	'NTH');

	insert into	adrAlias_vw	values	
		('*', '1', '*', '*',		0,999999,	'', 'FIRST', 	'', ' ', 	'NTH');
	insert into	adrAlias_vw	values	
		('*', '2', '*', '*',		0,999999,	'', 'SECOND', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '3', '*', '*',		0,999999,	'', 'THIRD', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '4', '*', '*',		0,999999,	'', 'FOURTH', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '5', '*', '*',		0,999999,	'', 'FIFTH', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '6', '*', '*',		0,999999,	'', 'SIXTH', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '7', '*', '*',		0,999999,	'', 'SEVENTH', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '8', '*', '*',		0,999999,	'', 'EIGHTH', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '9', '*', '*',		0,999999,	'', 'NINTH', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '10', '*', '*',		0,999999,	'', 'TENTH', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '11', '*', '*',		0,999999,	'', 'ELEVENTH', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '12', '*', '*',		0,999999,	'', 'TWELFTH', 	'', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '13', '*', '*',		0,999999,	'', 'THIRTEENTH', '', ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '15', '*', '*',		0,999999,	'', 'FIFTEENTH',  '',  ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '16', '*', '*',		0,999999,	'', 'SIXTEENTH',  '',  ' ',	'NTH');
	insert into	adrAlias_vw	values	
		('*', '17', '*', '*',		0,999999,	'', 'SEVENTEENTH', '', ' ',	'NTH');

	insert into	adrAlias_vw	values	
		('*', 'TWELVE', '*', '*',	0,999999,	'', 'TWELFTH', 	'', ' ',	'NTH');

	insert into	adrAlias_vw	values	
		('*', 'FOURTEENTH', '*', '*',	0,999999,	'', 'FOURTEENTH',	'', ' ',	'NTH$');

	commit;

--	===================================================================================================================	
--	AVENUE

	select 'alias avenue' " " from dual;

	insert into	adrAlias_vw	values	
		('*', 'AVENUE S', '*', '*',	0,999999,	'', 'AVENUE S', ' ', ' ',	'KEEP');

	insert into	adrAlias_vw	values	
	('*', 'AVE E', '*', '*',		0,999999,	'', 'AVENUE E', ' ', ' ',	'AVE');

	insert into	adrAlias_vw	values	
	('*', ' ', 'AVE', 'E',			0,999999,	'', 'AVENUE E', ' ', ' ',	'AVE');

	insert into	adrAlias_vw	values	
		('*', 'E', 'AVE', 'E',		0,999999,	'E', 'AVENUE E', ' ', ' ',	'AVE');


	insert into	adrAlias_vw	values	
		('*', 'AVE A', '*', '*',	0,999999,	'', 'AVENUE A', ' ', ' ',	'AVE');
	insert into	adrAlias_vw	values	
		('*', 'A AVE', '*', '*',	0,999999,	'', 'AVENUE A', ' ', ' ',	'AVE');

	insert into	adrAlias_vw	values	
		('*', 'AVE B', '*', '*',	0,999999,	'', 'AVENUE B', ' ', ' ',	'AVE');
	insert into	adrAlias_vw	values	
		('*', 'B AVE', '*', '*',	0,999999,	'', 'AVENUE B', ' ', ' ',	'AVE');

	insert into	adrAlias_vw	values	
		('*', 'AVE C', '*', '*',	0,999999,	'', 'AVENUE C', ' ', ' ',	'AVE');
	insert into	adrAlias_vw	values	
		('*', 'C AVE', '*', '*',	0,999999,	'', 'AVENUE C', ' ', ' ',	'AVE');

	insert into	adrAlias_vw	values	
		('*', 'AVE D', '*', '*',	0,999999,	'', 'AVENUE D', ' ', ' ',	'AVE');
	insert into	adrAlias_vw	values	
		('*', 'D AVE', '*', '*',	0,999999,	'', 'AVENUE D', ' ', ' ',	'AVE');

	insert into	adrAlias_vw	values	
		('*', 'AVE F', '*', '*',	0,999999,	'', 'AVENUE F', ' ', ' ',	'AVE');
	insert into	adrAlias_vw	values	
		('*', 'F AVE', '*', '*',	0,999999,	'', 'AVENUE F', ' ', ' ',	'AVE');

	insert into	adrAlias_vw	values	
		('*', 'AVE G', '*', '*',	0,999999,	'', 'AVENUE G', ' ', ' ',	'AVE');
	insert into	adrAlias_vw	values	
		('*', 'G AVE', '*', '*',	0,999999,	'', 'AVENUE G', ' ', ' ',	'AVE');

	commit;

--	===================================================================================================================	
--	HISTORICAL PAST

	select 'alias past' " " from dual;

	insert into	adrAlias_vw	values	
		('N', 'STAR', '*', '*',		0,999999,	'N', 'GARLAND',		'AVE', ' ',	'PAST');

	insert into	adrAlias_vw	values	
		('W', 'GARLAND', '*', '*',	100,1399,	' ', 'MAIN',		'ST', ' ',	'PAST');

	insert into	adrAlias_vw	values		
		('E', 'GARLAND', '*', '*',	200,699,	'E', 'AVENUE B',		' ', ' ',	'PAST');

	insert into	adrAlias_vw	values	
		('E', 'GARLAND', '*', '*',	700,1099,	' ', 'STATE HIGHWAY 66','HWY', '',	'PAST');

	insert into	adrAlias_vw	values	
		('E', 'GARLAND', '*', '*',	1100,2399,	' ', 'COMMERCE',		'ST ', ' ',	'PAST');

	commit;

--	===================================================================================================================	
--	OTHER CITY

	select 'alias other' " " from dual;

	insert into garland.adrAlias_vw values 
		('*',  'CLUB GLEN',	'*', '*',	0,999999,	'', 'CLUB GLEN', '', '',	'NAME$');
	insert into garland.adrAlias_vw values 
		('*',  'LYONS CREST',	'*', '*',	0,999999,	'', 'LYONS CREST', '', '',	'NAME$');
	insert into garland.adrAlias_vw values 
		('*',  'MACGREGOR',  	'*', '*',	0,999999,	'', 'MACGREGOR', '', '',  	'NAME$');
	insert into garland.adrAlias_vw values 
		('*',  'SAVAGE', 	'*', '*',	0,999999,	'', 'SAVAGE', '',	'',		'NAME$');

	commit;

--	===================================================================================================================	
--	APPLICATION CORRECTIONS

	insert into garland.adrAlias_vw values 
		('*',  'CALEO',	 '*', '*',	0,999999,		'', 'CALLEJO',  'RD', '',		'APPL');

	insert into garland.adrAlias_vw values 
		('*',  'TRINID',	 '*', '*',	0,999999,		'', 'TRINIDAD',  'RD', '',		'CODE@');

	insert into garland.adrAlias_vw values 
		('*',  'SIDE', 'SQ', 'E',	01,999999, 		' ','EAST SIDE OF SQUARE',' ',' ',	'WATR@');

	commit;

--	===================================================================================================================	

	@c:\deacutis\scripts\address_resolve\tables\adrAlias\bld_adrAlias_compress.sql;


