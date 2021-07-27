--	============================================================
	select * from viewer.me;
--	BEGIN  SERVER USER  SERVER USER  SERVER USER  SERVER USER END;
set	TIMING  ON;
set	sqlblanklines  on;
set	serveroutput   on   size 99999;
set	define         off;
set	linesize  1000;
set	pagesize  50000;
--	execute jdeacutis.show_source         ('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_error          ('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_table_column   ('SEWER_PIPE', 'GIS', '');
--	execute jdeacutis.show_table_column   ('', '', '');
--	execute jdeacutis.show_index_column   ('', '', '');
--	execute jdeacutis.show_view           ('', '', '');

--	execute jdeacutis.show_column_values  ('', '0');
--	execute jdeacutis.make_show_create_table   ('');
--	select * from jdeacutis.show_create_table;
--	select * from jdeacutis.SDE_Schema_Check_Show;

--	select grantee,granted_role from dba_role_privs where grantee not in('SYS')order by 1,2;
--	select role,owner,table_name,privilege from role_tab_privs where owner in('GIS','GARLAND')and length(rtrim(table_name,'1234567890'))>1 order by 1,2,3,4;
--	select owner,table_name,grantee,privilege from dba_tab_privs where owner in('GIS','GARLAND')and grantee<>'PERISQL'and length(rtrim(table_name,'1234567890'))>1 order by 1,2,3,4;
--	============================================================
--	EXECUTE				jdeacutis.TEST_PROC;
--	CREATE or replace procedure	jdeacutis.TEST_PROC  as
--	DECLARE
--	=====================================================================	

--	===================================================================================================================	
--	COMMON CORRECTIONS

--	addr_quals changed from space to null

	select 'alias misc' " " from dual;

	insert into garland.adrAlias_vw values 
		('*',  'SIDE', 'SQ', 'E',	01,999999, 		' ','EAST SIDE OF SQUARE',' ',' ',		'MISC', 009);
	insert into garland.adrAlias_vw values 
		('E',  'SIDE OF', 'SQ', '*', 01,999999,  		' ','EAST SIDE OF SQUARE',' ',' ',		'MISC', 009);

	insert into garland.adrAlias_vw values 
		('*',  'BRIAR OAKS','*', '*',01,999999,		null, 'BRIAROAKS',	null, null,		'MISC', 009);
	insert into garland.adrAlias_vw values 
		('*',  'CALEO',	 '*', '*',	0,999999,		null, 'CALLEJO',  'RD',	null,			'MISC', 009);
	insert into garland.adrAlias_vw values 
		('*',  'CROSS',	 'CT', '*',	0,999999,		null, 'CROSS COURTS',  null, null,		'MISC', 009);
	insert into garland.adrAlias_vw values 
		('*',  'GALAXY',	 '*', '*',	0,999999,		null, 'GALAXIE',  	null, null,		'MISC', 009);
	insert into garland.adrAlias_vw values 
		('*',  'LYNDA', 	 '*', '*',	0,999999,		null, 'LINDA',    	null, null,		'MISC', 009);
	insert into garland.adrAlias_vw values 
		('*',  'OATS', 	 '*', '*',	0,999999,		null, 'OATES',    	null, null,		'MISC', 009);
	insert into garland.adrAlias_vw values 
		('*',  'PLACE 1', '*','*',	0,999999,		null, 'PLACE ONE', 	null, null,		'MISC', 009);
 	insert into garland.adrAlias_vw values 
		('*',  'PRESIDENT GEORGE BUSH', '*','*',	0,999999,	null, 'GEORGE BUSH', null, null,	'MISC', 009);
		
--	insert into garland.adrAlias_vw values
--		('*',  'LAKE RAY HUBBARD', '*','*',0,999999,	null,'LAKE HUBBARD',	null, null,		'MISC', 009);

--	===================================================================================================================	
--	"LIKE" HIGHWAY NUMBER

	select 'alias highway' " " from dual;

	insert into garland.adrAlias_vw values 
		('*', '%30',  '*', '*',	0,999999,	null, 'I30',		  null, null, 'LIKE', 003);

	insert into garland.adrAlias_vw values 
		('*', '%66',  '*', '*',	0,999999,	null, 'STATE HIGHWAY 66', null, null, 'LIKE', 003);

	insert into garland.adrAlias_vw values 
		('*', '%78',  '*', '*',	0,999999,	null, 'LAVON',		  null, null, 'LIKE', 003);

	insert into garland.adrAlias_vw values 
		('*', '%190', '*', '*',	0,999999,	null, 'GEORGE BUSH',	  null, null, 'LIKE', 003);

	insert into garland.adrAlias_vw values 
		('*', '%635', '*', '*',	0,999999,	null, 'LBJ',		  null, null, 'LIKE', 003);

	insert into garland.adrAlias_vw values 
		('*', '%67',  '*', '*',	0,999999,	null, 'STATE HIGHWAY 67', null, null, 'LIKE', 003);

--	===================================================================================================================	
--	"LIKE" OTHER CITY 
/*
	select 'alias city' " " from dual;

	insert into garland.adrAlias_vw values 
		('*', '%DALLAS%',	'*', '*',		0,999999,	null, null, null, null,		'LIKE$', 002);
	insert into garland.adrAlias_vw values 
		('*', '%MESQUITE%',  	'*', '*',	0,999999,	null, null, null, null,		'LIKE$', 002);
	insert into garland.adrAlias_vw values 
		('*', '%RICHARDSON%',	'*', '*',	0,999999,	null, null, null, null,		'LIKE$', 002);
	insert into garland.adrAlias_vw values 
		('*', '%SACHSE%',	'*', '*',		0,999999,	null, null, null, null,		'LIKE$', 002);
	insert into garland.adrAlias_vw values 
		('*', '%SUNNYVALE%',	'*', '*',	0,999999,	null, null, null, null,		'LIKE$', 002);
	insert into garland.adrAlias_vw values 
		('*', '%WYLIE%',		'*', '*',	0,999999,	null, null, null, null,		'LIKE$', 002);

	commit;
*/
--	===================================================================================================================	
--	PREFIX And TYPE And SUFFIX

	select 'alias pull' " " from dual;

	insert into	garland.adrAlias_vw values 
		('N', 'COURT', '*', '*',	0,999999,  ' ', 'NORTH', 'CT', ' ', 		'PULL', 009);

	insert into	garland.adrAlias_vw values 
		('NE', 'PARKWAY', '*', '*',	0,999999,  ' ', 'NORTHEAST', 'PKWY', ' ',		'PULL', 009);

	insert into	garland.adrAlias_vw values 
		('NW', 'HIGHWAY', '*', '*',	0,999999,  ' ', 'NORTHWEST', 'HWY', ' ',		'PULL', 009);

	insert into garland.adrAlias_vw values 
		('*',  'NW', 	'*', '*',	0,999999,		null, 'NORTHWEST',	null, null,		'MISC', 009);

--	-------------------------------------------------------------------------------------------------------------------

	insert into	garland.adrAlias_vw values 
		('*', 'WALNUT', 'CIR', 'E',	0,999999,  ' ', 'WALNUT CIRCLE EAST', ' ', ' ', 'PULL', 009);

	insert into	garland.adrAlias_vw values 
		('*', 'WALNUT', 'CIR', 'W',	0,999999,  ' ', 'WALNUT CIRCLE WEST', ' ', ' ', 'PULL', 009);

	insert into	garland.adrAlias_vw values 
		('E', 'WALNUT', 'CIR', '*',	0,999999,  ' ', 'WALNUT CIRCLE EAST', ' ', ' ', 'PULL', 009);

	insert into	garland.adrAlias_vw values 
		('W', 'WALNUT', 'CIR', '*',	0,999999,  ' ', 'WALNUT CIRCLE WEST', ' ', ' ', 'PULL', 009);

	insert into	garland.adrAlias_vw values 
		('E', 'WALNUT CIRCLE', '*', '*',0,999999,  ' ','WALNUT CIRCLE EAST', ' ', ' ', 'PULL', 009);

	insert into	garland.adrAlias_vw values 
		('W', 'WALNUT CIRCLE', '*', '*',0,999999,  ' ','WALNUT CIRCLE WEST', ' ', ' ', 'PULL', 009);

	insert into garland.adrAlias_vw values 
		('*', 'MILLER', 'PK', 'N',	0,999999,  ' ', 'MILLER PARK NORTH',  ' ', ' ', 'PULL', 009);

	insert into garland.adrAlias_vw values 
		('*', 'MILLER', 'PK', 'S',	0,999999,  ' ', 'MILLER PARK SOUTH',  ' ', ' ', 'PULL', 009);

	insert into	garland.adrAlias_vw values 
		('N', 'MILLER', 'PK', '*',	0,999999,  ' ', 'MILLER PARK NORTH', ' ', ' ', 	'PULL', 009);

	insert into	garland.adrAlias_vw values 
		('S', 'MILLER', 'PK', '*',	0,999999,  ' ', 'MILLER PARK SOUTH', ' ', ' ', 	'PULL', 009);

	insert into	garland.adrAlias_vw values 
		('N', 'MILLER PARK', '*', '*',0,999999,  ' ', 'MILLER PARK NORTH', ' ', ' ', 	'PULL', 009);

	insert into	garland.adrAlias_vw values 
		('S', 'MILLER PARK', '*', '*',0,999999,  ' ', 'MILLER PARK SOUTH', ' ', ' ', 	'PULL', 009);

	commit;

--	===================================================================================================================	
--	NTH STREETS

	select 'alias nth' " " from dual;

	insert into	garland.adrAlias_vw	values	
		('*', 'TWELVE', '*', '*',	0,999999,	null, 'TWELFTH', 	null, ' ',		'NTH', 009);

	insert into	garland.adrAlias_vw	values	
		('*', 'FOURTEENTH', '*', '*',	0,999999,	null, 'FOURTEENTH',	null, ' ',	'NTH$', 009);


	insert into	garland.adrAlias_vw	values	
		('*', '1ST', '*', '*',		0,999999,	null, 'FIRST', 	null, null, 	'NTH', 009);
	insert into	garland.adrAlias_vw	values	
		('*', '2ND', '*', '*',		0,999999,	null, 'SECOND', 	null, null,		'NTH', 009);
	insert into	garland.adrAlias_vw	values	
		('*', '3RD', '*', '*',		0,999999,	null, 'THIRD', 	null, null,		'NTH', 009);
	insert into	garland.adrAlias_vw	values	
		('*', '4TH', '*', '*',		0,999999,	null, 'FOURTH', 	null, null,		'NTH', 009);
	insert into	garland.adrAlias_vw	values	
		('*', '5TH', '*', '*',		0,999999,	null, 'FIFTH', 	null, null,		'NTH', 009);
	insert into	garland.adrAlias_vw	values	
		('*', '6TH', '*', '*',		0,999999,	null, 'SIXTH', 	null, null,		'NTH', 009);
	insert into	garland.adrAlias_vw	values	
		('*', '7TH', '*', '*',		0,999999,	null, 'SEVENTH', 	null, null,		'NTH', 009);
	insert into	garland.adrAlias_vw	values	
		('*', '8TH', '*', '*',		0,999999,	null, 'EIGHTH', 	null, null,		'NTH', 009);
	insert into	garland.adrAlias_vw	values	
		('*', '9TH', '*', '*',		0,999999,	null, 'NINTH', 	null, null,		'NTH', 009);
	insert into	garland.adrAlias_vw	values	
		('*', '10TH', '*', '*',		0,999999,	null, 'TENTH', 	null, null,		'NTH', 009);
	insert into	garland.adrAlias_vw	values	
		('*', '11TH', '*', '*',		0,999999,	null, 'ELEVENTH', null, null,		'NTH', 009);
	insert into	garland.adrAlias_vw	values	
		('*', '12TH', '*', '*',		0,999999,	null, 'TWELFTH', 	null, null,		'NTH', 009);
	insert into	garland.adrAlias_vw	values	
		('*', '13TH', '*', '*',		0,999999,	null, 'THIRTEENTH', null, null,	'NTH', 009);
	insert into	garland.adrAlias_vw	values	
		('*', '15TH', '*', '*',		0,999999,	null, 'FIFTEENTH',  null,  null,	'NTH', 009);
	insert into	garland.adrAlias_vw	values	
		('*', '16TH', '*', '*',		0,999999,	null, 'SIXTEENTH',  null,  null,	'NTH', 009);
	insert into	garland.adrAlias_vw	values	
		('*', '17TH', '*', '*',		0,999999,	null, 'SEVENTEENTH', null, null,	'NTH', 009);

	insert into	garland.adrAlias_vw	values	
		('*', '1', '*', '*',		0,999999,	null, 'FIRST', 	null, null,	'NUM', 002);
	insert into	garland.adrAlias_vw	values	
		('*', '2', '*', '*',		0,999999,	null, 'SECOND', 	null, null,	'NUM', 002);
	insert into	garland.adrAlias_vw	values	
		('*', '3', '*', '*',		0,999999,	null, 'THIRD', 	null, null,	'NUM', 002);
	insert into	garland.adrAlias_vw	values	
		('*', '4', '*', '*',		0,999999,	null, 'FOURTH', 	null, null,	'NUM', 002);
	insert into	garland.adrAlias_vw	values	
		('*', '5', '*', '*',		0,999999,	null, 'FIFTH', 	null, null,	'NUM', 002);
	insert into	garland.adrAlias_vw	values	
		('*', '6', '*', '*',		0,999999,	null, 'SIXTH', 	null, null,	'NUM', 002);
	insert into	garland.adrAlias_vw	values	
		('*', '7', '*', '*',		0,999999,	null, 'SEVENTH', 	null, null,	'NUM', 002);
	insert into	garland.adrAlias_vw	values	
		('*', '8', '*', '*',		0,999999,	null, 'EIGHTH', 	null, null,	'NUM', 002);
	insert into	garland.adrAlias_vw	values	
		('*', '9', '*', '*',		0,999999,	null, 'NINTH', 	null, null,	'NUM', 002);
	insert into	garland.adrAlias_vw	values	
		('*', '10', '*', '*',		0,999999,	null, 'TENTH', 	null, null,	'NUM', 002);
	insert into	garland.adrAlias_vw	values	
		('*', '11', '*', '*',		0,999999,	null, 'ELEVENTH',	null, null,	'NUM', 002);
	insert into	garland.adrAlias_vw	values	
		('*', '12', '*', '*',		0,999999,	null, 'TWELFTH', 	null, null,	  'NUM', 002);
	insert into	garland.adrAlias_vw	values	
		('*', '13', '*', '*',		0,999999,	null, 'THIRTEENTH', null, null, 'NUM', 002);
	insert into	garland.adrAlias_vw	values	
		('*', '15', '*', '*',		0,999999,	null, 'FIFTEENTH',  null,  null,'NUM', 002);
	insert into	garland.adrAlias_vw	values	
		('*', '16', '*', '*',		0,999999,	null, 'SIXTEENTH',  null,  null,'NUM', 002);
	insert into	garland.adrAlias_vw	values	
		('*', '17', '*', '*',		0,999999,	null, 'SEVENTEENTH', null, null,'NUM', 002);

	commit;

--	===================================================================================================================	
--	AVENUE

	select 'alias avenue' " " from dual;

	insert into	garland.adrAlias_vw	values	
	('*', 'AVENUE', '*', 'E',	0,999999,	null, 'AVENUE E', ' ', ' ',	'AVE', 009);

	insert into	garland.adrAlias_vw	values	
		('*', 'A', 'AVE', '*',	0,999999,	null, 'AVENUE A', ' ', null,	'AVE', 009);
	insert into	garland.adrAlias_vw	values	
		('*', 'B', 'AVE', '*',	0,999999,	null, 'AVENUE B', ' ', null,	'AVE', 009);
	insert into	garland.adrAlias_vw	values	
		('*', 'C', 'AVE', '*',	0,999999,	null, 'AVENUE C', ' ', null,	'AVE', 009);
	insert into	garland.adrAlias_vw	values	
		('*', 'D', 'AVE', '*',	0,999999,	null, 'AVENUE D', ' ', null,	'AVE', 009);
	insert into	garland.adrAlias_vw	values	
		('*', 'F', 'AVE', '*',	0,999999,	null, 'AVENUE F', ' ', null,	'AVE', 009);
	insert into	garland.adrAlias_vw	values	
		('*', 'G', 'AVE', '*',	0,999999,	null, 'AVENUE G', ' ', null,	'AVE', 009);

	commit;

--	===================================================================================================================	
--	HISTORICAL PAST

	select 'alias past' " " from dual;

	insert into	garland.adrAlias_vw	values	
		('N', 'STAR', '*', '*',		0,999999,	'N', 'GARLAND',		'AVE', null,	'PAST', 009);

	insert into	garland.adrAlias_vw	values	
		('W', 'GARLAND', '*', '*',	100,1399,	' ', 'MAIN',		'ST', null,		'PAST', 009);

	insert into	garland.adrAlias_vw	values		
		('E', 'GARLAND', '*', '*',	200,699,	'E', 'AVENUE B',		' ', null,		'PAST', 009);

	insert into	garland.adrAlias_vw	values	
		('E', 'GARLAND', '*', '*',	700,1099,	' ', 'STATE HIGHWAY 66','HWY', null,	'PAST', 009);

	insert into	garland.adrAlias_vw	values	
		('E', 'GARLAND', '*', '*',	1100,2399,	' ', 'COMMERCE',		'ST ', null,	'PAST', 009);

	insert into	garland.adrAlias_vw	values	
		('*', 'NORTHEAST', 'PKWY', '*',0,999999,	' ', 'FIREWHEEL',		'PKWY', null,	'PAST', 009);

	commit;

--	===================================================================================================================	
--	PARTIAL CORRECTION

	select 'alias part' " " from dual;

	insert into garland.adrAlias_vw values 
		('*', 'WALNUT', 'CIR', '*',	0,999999,  null, 'WALNUT CIRCLE', ' ', null, 	'PART', 009);

	insert into garland.adrAlias_vw values 
		('*',  'STATE', 	'HWY', '*',	0,999999,	null, 'STATE HIGHWAY', ' ', null,	'PART', 009);

--	===================================================================================================================	
