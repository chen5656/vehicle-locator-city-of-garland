
--	test adress formatting routine

	set echo 		off;
	set timing		on;
	set serveroutput	on		size	99999;

--	select rpad (' ',70) " " from dual;

declare

	start_seq		number	:= 011;			--	minimum = 0
	stop_seq		number	:= 011;		

	how_options		varchar2(5)	:= '';		--	1 = test  2 = trace

	seq			number;

	addr_num		number;		
	addr_pfx		varchar2(02);	
	addr_name		varchar2(40);	
	addr_type		varchar2(04);	
	addr_sfx		varchar2(02);	
	addr_code		varchar2(05);	
	addr_unit		varchar2(10);	
	addr_how		varchar2(10);	

	show_how		varchar2(10);	

begin

	seq	:= start_seq - 01;

loop
	seq	:= seq + 01;	
	exit when	seq > stop_seq;

--	=========================================================================================================

	if	seq = 0	then
		goto	re_initialize;


	elsif	seq = 1001	then
		addr_name	:= '1306$ YUKON';
		show_how	:= 'n.....';


	elsif	seq = 1002	then
		addr_name	:= '1200 GARLAND';
		show_how	:= '......';



--	AD HOC

	elsif	seq = 100	then 
		dbms_output.put_line (' ');
		dbms_output.put_line ('***  ad hoc  ***');
		goto	re_initialize;

	elsif	seq = 101	then
		addr_name	:= 'HWY 1050';
		addr_num	:= 0;
		show_how	:= '..t..u';

	elsif	seq = 102	then
		addr_name	:= '#5 KNIGHTSBRIDGE CT';
		addr_num	:= 0;
		show_how	:= '..t.cu';

	elsif	seq = 103	then
		addr_name	:= '1001 E CENTERVILLE #22046';
		show_how	:= 'np..cu';

	elsif	seq = 104	then
		addr_name	:= '1001 EDGEFIELD DR 2081-A';
		show_how	:= 'n.t..u';

	elsif	seq = 105	then
		addr_name	:= '1001 N SHILOH APT1075';
		show_how	:= 'np..cu';

	elsif	seq = 106	then
		addr_name	:= '2929 BURNING TREE T101';
		show_how	:= 'n....u';

	elsif	seq = 107	then
		addr_name	:= '2929 BURNING TREE APT#101';
		show_how	:= 'n...cu';

	elsif	seq = 108	then
		addr_name	:= '2914 W WALNUT #229-A';
		show_how	:= 'np..cu';

	elsif	seq = 109	then
		addr_name	:=  '1005 FOREST CREEK DR 202';                         
		show_how	:= 'n.t..u';

	elsif	seq = 110	then
		addr_name	:=  '1001 apt 123 n shiloh e';                         
		show_how	:= 'np.scu';

	elsif	seq = 111	then
		addr_name	:= '1001 N SHILOH APT 123 A';                         
		show_how	:= 'np..cu';

	elsif	seq = 112	then
		addr_name	:= '1001 N SHILOH #123 A';                         
		show_how	:= 'np..cu';

	elsif	seq = 113	then
		addr_name	:=  '1001 A SHILOH';                         
		show_how	:= 'n....u';

	elsif	seq = 114	then
		addr_name	:=  '1221 CASTLE DR #206 A';                         
		show_how	:= 'n.t.cu';

	elsif	seq = 115	then
		addr_name	:=  '1001E SHILOH  APT E 12';                         
		show_how	:= 'np..cu';

	elsif	seq = 116	then
		addr_name	:=  '1001-SHILOH  APT E12';                         
		show_how	:= 'n...cu';

	elsif	seq = 117	then
		addr_name	:=  '1001SHILOH E12';                         
		show_how	:= 'n....u';

	elsif	seq = 118	then
		addr_name	:=  '4255 #4 ROSEHILL RD';                         
		show_how	:= 'n.t.cu';

	elsif	seq = 119	then
		addr_name	:=  '4255 APT 4 ROSEHILL E';
		show_how	:= 'n..scu';

	elsif	seq = 120	then
		addr_name	:=  ' APT 4';                         
		show_how	:= '....cu';

	elsif	seq = 121	then
		addr_name	:=  '1002MEDIO';                         
		show_how	:= 'n.....';

	elsif	seq = 122	then
		addr_name	:=  '113E EAST AVENUE';                         
		show_how	:= 'npt..u';

	elsif	seq = 123	then
		addr_name	:=  '#25 3347 W Walnut';                         
		show_how	:= 'np..cu';

	elsif	seq = 124	then
		addr_name	:=  'WALLS ADDN #2 1.547A L2'; 
		show_how	:= '......';

	elsif	seq = 125	then
		addr_name	:=  '901 doss  00st'; 
		show_how	:= '......';

	elsif	seq = 126	then
		addr_name	:=  '901 doss (pvt) 00st'; 
		show_how	:= '......';

	elsif	seq = 127	then
		addr_name	:=  'W. CARTER #324'; 
		show_how	:= '......';

	elsif	seq = 198	then
		addr_name	:=  '1001W WALNUT';                         
		show_how	:= 'n....u';

	elsif	seq = 199	then
		addr_name	:=  '1001 A N SHILOH';                         
		show_how	:= 'np...u';

--	elsif	seq = 200	then
--		addr_name	:=  '';                         
--		show_how	:= '......';


--	STREET TYPE

	elsif	seq = 10	then
		dbms_output.put_line (' ');
		dbms_output.put_line ('***  street type  ***');
		goto	re_initialize;

	elsif	seq = 11	then
		addr_name	:= '101 SOUTH COUNTRY CLUB RD E #221b';
		show_how	:= 'npt...';

	elsif	seq = 12	then
		addr_name	:= '101-B No Shiloh Road';
		show_how	:= 'npt..u';

	elsif	seq = 13	then
		addr_name	:= 'n shilo av';
		show_how	:= '.pt...';

	elsif	seq = 14	then
--		addr_name	:= '101 O''HENRY CRT';
		addr_name	:= '4310 O''BANION RD';
		show_how	:= 'n.t...';


--	STREET PREFIX & SUFFIX & NUMBER	

	elsif	seq = 20	then
		dbms_output.put_line (' ');
		dbms_output.put_line ('***  prefix & suffix & number ***');
		goto	re_initialize;

	elsif	seq = 21	then
		addr_name	:= '2 S JUPITER RD E';
		show_how	:= 'npts..';

	elsif	seq = 22	then
		addr_name	:= '22 S JUPTER E RD';
		show_how	:= 'npts..';

	elsif	seq = 23	then
		addr_name	:= '202 S COUNTRY CLUB LA E #A';
		show_how	:= 'nptscu';

	elsif	seq = 24	then
		addr_name	:= '2020 S COUNTY CLUB E LA #A';
		show_how	:= 'nptscu';

	elsif	seq = 25	then
		addr_name	:= '10202 SOUTH JUPITER EAST';
		show_how	:= 'np.s..';

	elsif	seq = 26	then
		addr_name	:= '110202 SO JUPITER EAST APT #A';
		show_how	:= 'np.scu';


--	ADDRESS NAME

	elsif	seq = 30	then
		dbms_output.put_line (' ');
		dbms_output.put_line ('***  street name ***');
		goto	re_initialize;

	elsif	seq = 31	then
		addr_name	:= '1201 3RD';
		show_how	:= 'n.....';

	elsif	seq = 32	then
		addr_name	:= '1201 N 3RD';
		show_how	:= 'np....';

	elsif	seq = 33	then
		addr_name	:= '1306` YUKON';
		show_how	:= 'n.....';


--	ADDRESS UNIT

	elsif	seq = 60	then
		dbms_output.put_line (' ');
		dbms_output.put_line ('***  address unit  ***');
		goto	re_initialize;

	elsif	seq = 61	then
		addr_name	:= '1604A N PLEASANT VALLEY BLVD E';
		show_how	:= 'npts.u';

	elsif	seq = 62	then
		addr_name	:= '160-AB PLEASANT VALLEY E';
		show_how	:= 'n..s.u';

	elsif	seq = 63	then
		addr_name	:= '16PLEASANT VALLEY #ABC';
		show_how	:= 'n...cu';

	elsif	seq = 64	then
		addr_name	:= '1801PLEASANT VALLEY STE G45';
		show_how	:= 'n...cu';

	elsif	seq = 65	then
		addr_name	:= '1604-05 PLEASANT VALLEY';
		show_how	:= 'n....u';

	elsif	seq = 66	then
		addr_name	:= '1604-1610 PLEASANT VALLEY';
		show_how	:= 'n....u';

	elsif	seq = 67	then
		addr_name	:= 'PLEASANT VALLEY 1604-1610';
		show_how	:= 'n....u';

	elsif	seq = 68	then
		addr_name	:= '161 S PLEASANT VALLEY LA  APART A123';
		show_how	:= 'npt.cu';



--	ADDRESS UNIT - DANGLING

	elsif	seq = 70	then
		dbms_output.put_line (' ');
		dbms_output.put_line ('***  dangling unit  ***');
		goto	re_initialize;

	elsif	seq = 71	then
		addr_name	:= '303 S COUNTRY CLUB LA  A123';
		show_how	:= 'npt..u';

	elsif	seq = 72	then
		addr_name	:= '303 S COUNTRY CLUB  E A';
		show_how	:= 'np.s.u';

	elsif	seq = 73	then
		addr_name	:= '303 S COUNTRY CLUB  21';
		show_how	:= 'np...u';

--	AVENUES

	elsif	seq = 80	then
		dbms_output.put_line (' ');
		dbms_output.put_line ('***  avenues  ***');
		goto	re_initialize;

	elsif	seq = 81	then
		addr_name	:= '606 W AVE D';
		show_how	:= 'np....';

	elsif	seq = 82	then
		addr_name	:= '606 E AVE D';
		show_how	:= 'np....';

	elsif	seq = 83	then
		addr_name	:= '606 AVE D';
		show_how	:= 'n.....';

	elsif	seq = 84	then
		addr_name	:= '606 D AVE';
		show_how	:= 'n.....';

	elsif	seq = 85	then
		addr_name	:= '606 D AVENUE';
		show_how	:= 'n.....';

	elsif	seq = 86	then
		addr_name	:= '606 E E AVE';
		show_how	:= 'np....';

	elsif	seq = 87	then
		addr_name	:= '606 E AVE E';
		show_how	:= 'np....';

	elsif	seq = 88	then
		addr_name	:= '606 W AVENUE E';
		show_how	:= 'np....';

	elsif seq = 89	then
		addr_num	:= 606;
		addr_pfx	:= 'E';
		addr_name	:= 'AVENUE E';
		addr_type	:= '';
		addr_sfx	:= ' ';
		addr_unit	:= ' ';
		show_how	:= '......';


--	MISCELLANEOUS

	elsif	seq = 90	then
		dbms_output.put_line (' ');
		dbms_output.put_line ('***  miscellaneous  ***');
		goto	re_initialize;

	elsif	seq = 91	then
		addr_name	:= '5TH AT BUCKINGHAM';
		show_how	:= '......';

	elsif	seq = 92	then
		addr_num	:= 11340;
		addr_name	:= '30';
		show_how	:= '......';


--	PRE-EXISTING ITEMS

	elsif	seq = 200	then
		dbms_output.put_line (' ');
		dbms_output.put_line (' ');
		dbms_output.put_line ('***  pre-existing items ***');
		goto	re_initialize;

	elsif	seq = 201	then
		addr_name	:= '1201 S COUNTRY RD E APT 101';
		addr_num	:= 1234;
		addr_pfx	:= 'N';
		addr_type	:= 'CIR';
		addr_sfx	:= 'W';
		addr_unit	:= 'ABC';
		show_how	:= '....?.';

	elsif	seq = 202	then
		addr_name	:= 'S COUNTRY RD E';
		addr_num	:= 1234;
		addr_pfx	:= 'N';
		addr_type	:= 'CIR';
		addr_sfx	:= 'W';
		addr_unit	:= 'ABC';
		show_how	:= '......';

	elsif	seq = 203	then
		addr_name	:= '1001 COUNTRY E';
		addr_num	:= 1234;
		addr_pfx	:= 'N';
		addr_type	:= 'CIR';
		addr_sfx	:= 'W';
		addr_unit	:= 'ABC';
		show_how	:= '......';

	elsif	seq = 204	then
		addr_name	:= '1201 S COUNTRY RD E APT 101';
		addr_pfx	:= 'N';
		addr_type	:= 'CIR';
		addr_sfx	:= 'W';
		show_how	:= 'n...cu';

	elsif	seq = 205	then
		addr_name	:= 'WALNUT CIR APT 101';
		addr_num	:= 1234;
		addr_type	:= 'ST';
		show_how	:= '....cu';

	elsif	seq = 206	then
		addr_name	:= 'AVENUE A';
		addr_num	:= 1234;
		addr_type	:= ' ';
		addr_unit	:= 'B55';
		show_how	:= '......';

	elsif	seq = 207	then
		addr_name	:= 'E CELESTE DR NW';
		addr_num	:= 1234;
		addr_type	:= ' ';
		addr_unit	:= ' ';
		show_how	:= '......';

	else
		goto	re_initialize;
	end if;

--	=========================================================================================================
--	=========================================================================================================

<<format_address>>

	dbms_output.put_line (' ');

	dbms_output.put_line 
		(	rpad (nvl (ltrim(addr_num,'0'),' ') ,7)
			|| rpad(nvl(addr_pfx, ' '),3) || rpad(nvl(addr_name,' '),30) 
			|| rpad(nvl(addr_type,' '),5) || rpad(nvl(addr_sfx, ' '), 3) 
			|| rpad(nvl(addr_code,' '),6)	|| rpad(nvl(addr_unit,' '), 6) 
			|| '  ('||show_how||')'		|| '		' || seq		
		);

--	----------------------------------------------------------------------------------------------------------
	addr_how	:= how_options;


--	ADR_parse_address ( addr_num, addr_pfx, addr_name, addr_type, addr_sfx, addr_code, addr_unit, addr_how );

	TST_parse_address ( addr_num, addr_pfx, addr_name, addr_type, addr_sfx, addr_code, addr_unit, addr_how );

--	----------------------------------------------------------------------------------------------------------

	dbms_output.put_line 
		(	rpad (nvl (ltrim(addr_num,'0'),' ') ,7)
			|| rpad(nvl(addr_pfx, ' '),3) || rpad(nvl(addr_name,' '),30) 
			|| rpad(nvl(addr_type,' '),5) || rpad(nvl(addr_sfx, ' '), 3) 
			|| rpad(nvl(addr_code,' '),6)	|| rpad(nvl(addr_unit,' '), 6) 
			|| '  ('||addr_how||')'	
		);


--	dbms_output.put_line 
--		( '/'||addr_num ||'/'||addr_pfx ||'/'||addr_name||'/'||addr_type||'/'||addr_sfx
--		||'/'||addr_code||'/'||addr_unit||'/');	


<<re_initialize>>

	addr_num	:= null;
	addr_pfx	:= '';
	addr_name	:= '';
	addr_type	:= '';
	addr_sfx	:= '';
	addr_code	:= '';
	addr_unit	:= '';
	addr_how	:= '';
	show_how	:= '';

end loop;

end;


--	=================================================================================================
/*	display address resolve parse


	select	rpad (a.addr_name,30)	" ",
			'|||',
			v.addr_num, v.addr_pfx, v.addr_name, v.addr_type, v.addr_sfx, v.addr_code, v.addr_unit
	from		gis_app_addr		a,
			gis_verify_addr		v
	where		a.rowid = v.rec_rowid
	and		v.verify_code = 0
	;

--	=================================================================================================
*/