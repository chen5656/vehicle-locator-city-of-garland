	set echo		off;
	set timing		off;

--	==========================================================================================================
--	test input for test_adr_parse
--	==========================================================================================================

	@c:\deacutis\scripts\sequences\adr_work_seq.sql;

	truncate table	garland.gis_objects;

--	==========================================================================================================
/*	

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'', '',	'',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'',
'',	''	);                                                         

*/

/*
--	===================================================================================================
                                                                                                          
insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'901', 'S',	'COUNTRY CLUB',   				 'RD',	'E',	   'BLDG','A',	'APT','32',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2   un2   
'901    S    COUNTRY CLUB                               RD        E         BLDG   A       APT    32',
'',	'.........'	);                                                         

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'901 S COUNTRY CLUB RD E BLDG A APT 32',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901    S    COUNTRY CLUB                               RD        E         BLDG   A       APT    32',
'',	'npMtscukv'	);                                                         

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'901 - 903 W CIR ST',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'       W    CIRCLE                                     ST                  DPLX   901            903',
'',	'.pMt..u.v'	);                                                         

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'W AVENUE E AVE 901 - 903',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'       W    AVENUE E                                   AVE                 DPLX   901            903',
'',	'.pMt..u.v'	);                                                         

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'901 N W 3RD S E ST 11 - 12',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901    NW   3RD                                        ST        SE               11-12', 	
'',	'npMts.u.v'	);                                                           

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'901 1/2 NO. I-30 S.E.FWY G-3',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901    N    I-30                                       Frwy      Se               1/2            g-3',
'',	'npMts.u.v'	);                                                         

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'901A  NO.ST.JAMES S E E',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901    N    ST JAMES                                             SE               A              E',
'',	'npM.s.u.v'	);                                                         

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'901 E N AVE E S E',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901    N    AVENUE E                                             SE               E',
'',	'npM.s.u..'	);                                                         

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	 '',	'901 APT 12B WALNUT CIR E DR',			 'DR',	'',	   '','',		'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901         WALNUT CIRCLE EAST                         DR                  APT    12B',
'',	'n.Mt.cu..'	);                                                         

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'901 E NORTH CRT A 10 ',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901    E    NORTH                                      CT                         A              10     ',
'',	'npMt..u.v'	);                                                         

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'901 N NORTH CRT DR #A 10 BLDG 5',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901    N    NORTH COURT                                DR                  #      A 10    BLDG   5',
'',	'npMt.cukv'	);                                                         

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'901.E N SHANNON''S 13',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901    N    SHANNON''S                                                             E              13',
'',	'npM...u.v'	);                                                         

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'901.E N SHILOH 35',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901    N    SHILOH 35                                                             E              ',
'',	'npM...u..'	);                                                         

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'',	'',	'11901 N HWY 35 5',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'11901  N    HIGHWAY 35                                                            5   ',
'',	'npM...u..'	);                                                         


insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'901','',	'state highway 66 h/mtr#5',				'hwy', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901         STATE HIGHWAY 66                           HWY                        H/MTR   #      5   ',
'',	'.........'	);                                                         


insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'901', 'e',	'interstate 30 e-4', 				'frwy', 	'',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901    E    INTERSTATE 30                              FRWY                       E-4',
'',	'.........'	);                                                         

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'901e', '',	'bois-d''arc #a4',				 's', 	'av',	   '','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901         BOIS-D''ARC                                 AVE       S                E       #      A4',
'',	'.........'	);                                                         

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'901','',	'n shiloh #b @ forest',				'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'901    N    SHILOH                                                         #      B   ',
'',	''	);                                                         

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'', '',	'n shiloh #b @ forest',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'            N SHILOH #B @ FOREST',
'',	''	);                                                         

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'', '',	'3258 garland ave n.',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'3258        GARLAND                                    AVE       N',
'',	''	);                                                         


insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'', '',	'718 broadway commons. #722',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
'718         BROADWAY. COMMONS                                                #     722',
'',	''	);                                                         

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'', '',	'114 square east side',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
' ',
'',	''	);        

--	-------------------------------------------------------------------------------------------------------

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'', '',	'1234 c avenue',		'ave', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
' ',
'',	''	);        

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'', '',	'1234 ave c ave',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
' ',
'',	''	);        

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'', '',	'1234 d ave west',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
' ',
'',	''	);        

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'0', '',	'evelyn dr 310-312',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
' ',
'',	''	);        

--	-------------------------------------------------------------------------------------------------------

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'', '',	'state 66',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
' ',
'',	''	);        

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'', '',	'state hwy 66',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
' ',
'',	''	);        

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'', '',	'state 666',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
' ',
'',	''	);        

--	-------------------------------------------------------------------------------------------------------

*/
--	==========================================================================================================


--	TEST ADDRESS

insert into garland.adr_parse_test_vw values (	lpad(adr_work_seq.nextval,2,0),		

'', '',	'1234 state 66 ',		'', '',		'','',	'','',
--      pp   mmmm                                       tttt      ss        cd1    un1     cd2    un2   
' ',
'',	''	);        



--	==========================================================================================================
	commit;
	set echo on;
--	==========================================================================================================

	@c:\deacutis\scripts\address_parse\test_adr_parse.sql;

--	==========================================================================================================

