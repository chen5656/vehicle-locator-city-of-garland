	set echo		off;
	set timing		off;

--	==========================================================================================================
--	test input for test_adr_parse
--	==========================================================================================================

	@c:\deacutis\scripts\sequences\adr_work_seq.sql;

	truncate table	gis_objects;

--	==========================================================================================================
/*	

insert into adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'',
'',	''	);                                                         

*/
--	===================================================================================================
                                                                                                          
insert into adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'901', 'S',	'COUNTRY CLUB',   				 'RD',	'E',	   'BLDG','A',	'APT','32',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2   un2   
'901    S    COUNTRY CLUB                               RD        E         BLDG   A       APT    32',
'',	'.........'	);                                                         

insert into adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'901 S COUNTRY CLUB RD E BLDG A APT 32',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901    S    COUNTRY CLUB                               RD        E         BLDG   A       APT    32',
'',	'npMtscukv'	);                                                         

insert into adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'901 - 903 W CIR ST',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'       W    CIRCLE                                     ST                  DPLX   901            903',
'',	'.pMt..u.v'	);                                                         

insert into adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'W AVENUE E AVE 901 - 903',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'       W    AVENUE E                                   AVE                 DPLX   901            903',
'',	'.pMt..u.v'	);                                                         

insert into adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'901 N W 3RD S E ST 11 - 12',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901    NW   3RD                                        ST        SE               11-12', 	
'',	'npMts.u.v'	);                                                           

insert into adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'901 1/2 NO. I-30 S.E.FWY G-3',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901    N    I-30                                       Frwy      Se               1/2            g-3',
'',	'npMts.u.v'	);                                                         

insert into adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'901A  NO.ST.JAMES S E E',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901    N    ST JAMES                                             SE               A              E',
'',	'npM.s.u.v'	);                                                         

insert into adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'901 E N AVE E S E',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901    N    AVENUE E                                             SE               E',
'',	'npM.s.u..'	);                                                         

insert into adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	 '',	'901 APT 12B WALNUT CIR E DR',			 'DR',	'',	   '','',		'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901         WALNUT CIRCLE EAST                         DR                  APT    12B',
'',	'n.Mt.cu..'	);                                                         

insert into adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'901 E NORTH CRT A 10 ',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901    E    NORTH                                      CT                         A              10     ',
'',	'npMt..u.v'	);                                                         

insert into adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'901 N NORTH CRT DR #A 10 BLDG 5',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901    N    NORTH COURT                                DR                  #      A10     BLDG   5',
'',	'npMt.cukv'	);                                                         

insert into adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'901.E N SHILOH 35',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901    N    SHILOH 35                                                             E              ',
'',	'npM...u..'	);                                                         

insert into adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'11901 N HWY 35 5',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'11901  N    HIGHWAY 35                                                            5   ',
'',	'npM...u..'	);                                                         

--	==========================================================================================================
	commit;
	set echo on;
--	==========================================================================================================

	@c:\deacutis\scripts\address_parse\parse\test_adr_parse.sql;

--	==========================================================================================================

