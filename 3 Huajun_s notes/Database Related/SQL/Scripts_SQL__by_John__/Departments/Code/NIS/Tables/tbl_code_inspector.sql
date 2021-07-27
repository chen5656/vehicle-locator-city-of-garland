

--	==================================================================================

	drop table		code_inspector;

	create table	code_inspector
	(
		inspect_area	varchar2(02),
		inspector		varchar2(20),
		inspector_id	varchar2(03)
	)
	tablespace		gis_data
	storage		( initial 32k  next 32k  pctincrease 0 );


--	==================================================================================

	truncate table	code_inspector	reuse storage;

	insert into	code_inspector	values ( '1', 	'EMMA RODGERS',		'ERO' );
	insert into	code_inspector	values ( '2', 	'PAULA MCSWAIN',		'PMC' );
	insert into	code_inspector	values ( '3', 	'DENNIS PICKETT',		'DP'	);
	insert into	code_inspector	values ( '4',	'JIM AVERRE',		'JA'	);
	insert into	code_inspector	values ( '4A', 	'TOMMY COBB',		'TC'	);
	insert into	code_inspector	values ( '5', 	'CHERYL RENO',		'CRE'	);
	insert into	code_inspector	values ( '6', 	'SHANNON GRIFFIN', 	'SG'	);
	insert into	code_inspector	values ( '7', 	'STEPHEN BOBCOCK', 	'STB'	);
	insert into	code_inspector	values ( '8', 	'SHARON BROWN', 		'SB'	);
	insert into	code_inspector	values ( '9', 	'TYRONE WALLS', 		'TW'	);
	insert into	code_inspector	values ( '10', 	'BILL COFFINDAFFER', 	'BC'	);

	commit;

--	==================================================================================
/*

per Dan Hearne	05/23/2001

Name                            Null?    Type
 ------------------------------- -------- ----
 INSPECT_AREA                             VARCHAR2(2)
 INSPECTOR                                VARCHAR2(20)
 INSPECTOR_ID                             VARCHAR2(3)  - New Column


IN INSPECTOR                   INSPECTOR_ID
-- --------------------	   --------------------
1  EMMA RODGERS                ERO
2  PAULA MCSWAIN               PMC
3  MARLON BRADFORD             MB
4  TOMMY COBB                  TC
4A TOMMY COBB                  TC
5  CHERYL RENO                 CRE
6  SHANNON GRIFFIN             SG
7  STEPHEN BOBOCK              STB       
8  SHARON BROWN                SB
9  TYRONE WALLS                TW
10 BILL COFFINDAFFER           BC

*/
--	==================================================================================
