--	==========================================
--	test adr_process_atreet_alias  function
--	==========================================

	set	echo			off;
	set 	serveroutput	on;

declare 

	start_seq		number	:= 332;
	stop_seq		number	:= 332;

	seq			number;

	mail			varchar2(10)	:= 'alias';
	addr_num		number;
	addr_pfx		varchar2(20);
	addr_name		varchar2(40);
	addr_type		varchar2(20);
	addr_sfx		varchar2(20);
	addr_code		varchar2(20);
	addr_unit		varchar2(20);

	right_class		varchar2(10);
	match_class		varchar2(10);

	reduced_name	varchar2(20);
	compact_name	varchar2(20);
	
	second_name		varchar2(20);
	also_names		varchar$v		:= varchar$v ('','','','');

	alias_weight	varchar2(10);	-- june 2005
	alias_match		varchar2(10);	-- june 2005


begin

	seq	:= start_seq - 01;

loop
	seq	:= seq + 01;	
	exit when	seq > stop_seq;

--	=========================================================================================================

--	AD HOC

	if	seq = 00	then 
		dbms_output.put_line (' ');
		dbms_output.put_line ('***  ad hoc  ***');
	end if;

	if	seq is null	then null;

	elsif	seq = 0	then 
		addr_num	:= 901;
		addr_pfx	:= '';
		addr_name	:= '';
		addr_type	:= '';
		addr_sfx	:= '';
		right_class	:= ' ';
		goto	re_initialize;

	elsif	seq = 01	then 						--	tpush
		addr_num	:= 1234;
		addr_name	:= 'MILKY WAY';
		right_class	:= 'tpush';

	elsif	seq = 02	then 						--	ppush
		addr_num	:= 1234;
		addr_name	:= 'EAST VISTA';
		right_class	:= 'ppush';

	elsif	seq = 03	then 						--	spush
		addr_num	:= 1234;
		addr_name	:= 'COUNTRY CLUB EAST';
		right_class	:= 'spush';

	elsif	seq = 04	then 						--	tpull
		addr_num	:= 1234;
		addr_name	:= 'MOLLER';
		addr_type	:= 'PK';
		addr_sfx	:= 'N';
		right_class	:= 'tpull';

	elsif	seq = 05	then						--	ppull
		addr_num	:= 1234;
		addr_pfx	:= 'N';
		addr_name	:= 'SHORE';
		right_class	:= 'ppull';

	elsif	seq = 06	then 						--	spull
		addr_num	:= 1234;
		addr_pfx	:= '';
		addr_name	:= 'KEY';
		addr_type	:= '';
		addr_sfx	:= 'W';
		right_class	:= 'spull';

	elsif	seq = 07	then						--	pull
		addr_num	:= 1234;
		addr_pfx	:= 'E';
		addr_name	:= ' ';
		addr_type	:= 'PK';
		addr_sfx	:= '';
		right_class	:= 'pull';

	elsif	seq = 08	then						--	pull
		addr_num	:= 1234;
		addr_pfx	:= '';
		addr_type	:= 'PK';
		addr_sfx	:= 'E';
		right_class	:= 'pull';

	elsif	seq = 09	then						--	pull

		addr_num	:= 1234;
		addr_type	:= 'PKWY';
		right_class	:= 'pull';

	elsif	seq = 10	then						--	part/

		addr_num	:= 1234;
		addr_name	:= 'NAAMAN';
		addr_sfx	:= 'E';
		right_class	:= 'part*';

	elsif	seq = 11	then 						--	more1
		addr_num	:= 1234;
		addr_name	:= 'BRIDGE';
		right_class	:= 'more';

	elsif	seq = 12	then 						--	more2
		addr_num	:= 1234;
		addr_name	:= 'BRANDON';
		right_class	:= 'more';

	elsif	seq = 13	then 						--	pcut
		addr_num	:= 1234;
		addr_name	:= 'NSHILOH';
		right_class	:= 'pcut';

	elsif	seq = 14	then						--	LIKE

		addr_num	:= 1234;
		addr_name	:= '  INTERSTATE IH 30';
		addr_type	:= 'CIR';
		addr_sfx	:= 'E';
		right_class	:= 'LIKE';


--	========================================================================
--	codeaddr

	elsif	seq = 20	then				

		addr_num	:= 806;
		addr_pfx	:= ' ';
		addr_name	:= 'WALNUT PKWY';
		addr_type	:= ' ';
		addr_sfx	:= ' ';
		right_class	:= 'tpush';
		mail		:= 'alias';

	elsif	seq = 21	then				

		addr_num	:= 1214;
		addr_name	:= 'PARKWAY';
		addr_type	:= '';
		addr_sfx	:= '';
		right_class	:= 'X';

	elsif	seq = 22	then				

		addr_num	:= 901;
		addr_name	:= 'FORTEENTH';
		addr_type	:= '';
		addr_sfx	:= '';
		right_class	:= '';

	elsif	seq = 23	then				

		addr_num	:= 901;
		addr_pfx	:= 'E';
		addr_name	:= 'AVENVE D';
		addr_type	:= '';
		addr_sfx	:= '';
		right_class	:= 'AVE';


	elsif	seq = 24	then				

		addr_num	:= 901;
		addr_pfx	:= '';
		addr_name	:= 'I-30';
		addr_type	:= '';
		addr_sfx	:= '';
		right_class	:= 'LIKE';

	elsif	seq = 25	then				

		addr_num	:= 901;
		addr_pfx	:= '';
		addr_name	:= 'SIDE';
		addr_type	:= 'SQ';
		addr_sfx	:= 'E';
		right_class	:= '';

	elsif	seq = 26	then				

		addr_num	:= 901;
		addr_pfx	:= '';
		addr_name	:= 'MAIN 3 07';
		addr_type	:= '';
		addr_sfx	:= '';
		right_class	:= 'none';

--	========================================================================

	elsif	seq = 51	then						--	tpush

		addr_num	:= 1234;
		addr_name	:= 'KINGSROW';
		right_class	:= 'tpush';

	elsif	seq = 52	then						--	tpush

		addr_num	:= 1234;
		addr_name	:= 'KING ROW';
		right_class	:= 'tpush';

	elsif	seq = 53	then						--	tpush

		addr_num	:= 1234;
		addr_name	:= 'KINGROW';
		right_class	:= 'tpush';

	elsif	seq = 54	then						--	pull

		addr_num	:= 1234;
		addr_name	:= 'WALNUT';
		addr_type	:= 'CIR';
		addr_sfx	:= 'E';
		right_class	:= 'pull';

	elsif	seq = 55	then						--	PART/		lower case

		addr_num	:= 1234;
		addr_name	:= 'WALNUT';
		addr_type	:= 'CIR';
		right_class	:= 'part*';

--	========================================================================

	elsif	seq = 91	then

		addr_num	:= 1234;
		addr_pfx	:= 'W';
		addr_name	:= 'APOLLO';
		addr_type	:= 'RD';
		right_class	:= 'none';

	elsif	seq = 92	then

		addr_num	:= 1234;
		addr_pfx	:= '';
		addr_name	:= 'NAST';
		addr_type	:= 'ST';
		right_class	:= 'none';

--	========================================================================

	elsif	seq = 101	then

		addr_num	:= 901;
		addr_pfx	:= '';
		addr_name	:= '';
		addr_type	:= 'AVE';
		addr_sfx	:= 'E';
		right_class	:= '   ';

	elsif	seq = 102	then

		addr_num	:= 1234;
		addr_pfx	:= 'N';
		addr_name	:= '';
		addr_type	:= 'CT';
		right_class	:= '   ';

	elsif	seq = 103	then

		addr_num	:= '901';
		addr_pfx	:= 'E';
		addr_name	:= 'I 30';
		addr_type	:= '';
		right_class	:= '   ';

	elsif	seq = 104	then

		addr_num	:= 901;
		addr_pfx	:= '';
		addr_name	:= 'CADDY';
		addr_type	:= '';
		addr_sfx	:= 'S';
		right_class	:= 'pulls';


	elsif	seq = 105	then

		addr_num	:= 814;
		addr_pfx	:= '';
		addr_name	:= 'WALNUT';
		addr_type	:= 'ST';
		addr_sfx	:= 'E';
		right_class	:= '=';

	elsif	seq = 106	then

		addr_num	:= 901;
		addr_pfx	:= 'N';
		addr_name	:= ' ';
		addr_type	:= 'CT';
		right_class	:= '   ';

	elsif	seq = 107	then

		addr_num	:= 901;
		addr_pfx	:= '';
		addr_name	:= 'WYKES ';
		addr_type	:= '';
		right_class	:= '   ';

	elsif	seq = 108	then

		addr_num	:= 901;
		addr_pfx	:= '';
		addr_name	:= 'WYKE ';
		addr_type	:= '';
		right_class	:= '   ';

--	=========================================================================================================
--	alien calls

	elsif	seq = 222	then

		MAIL		:= 'alien';

		addr_num	:= '101';
		addr_pfx	:= '';
		addr_NAME	:= 'LOVING #791 0.660 AC ';
		addr_type	:= '';
		right_class	:= '   ';


--	=========================================================================================================
--	test cases

	elsif	seq = 301	then
		MAIL		:= 'alias';

		addr_num	:= '901';
		addr_pfx	:= '';
		addr_NAME	:= 'side';
		addr_type	:= 'sq';
		addr_sfx	:= 'e';
		right_class	:= '   ';

	elsif	seq = 302	then
		MAIL		:= 'alias';

		addr_num	:= '901';
		addr_pfx	:= '';
		addr_NAME	:= 'state hwy 66';
		addr_type	:= '';
		addr_sfx	:= '';
		right_class	:= '   ';

	elsif	seq = 303	then
		MAIL		:= 'alias';

		addr_num	:= '901';
		addr_pfx	:= 'n';
		addr_NAME	:= 'sh 190';
		addr_type	:= 'hwy';
		addr_sfx	:= '';
		right_class	:= '   ';


	elsif	seq = 331	then
		MAIL		:= 'alias';

		addr_num	:= '521';
		addr_pfx	:= '';
		addr_NAME	:= 'bois d''arc';
		addr_type	:= '';
		addr_sfx	:= '';
		right_class	:= '   ';

	elsif	seq = 332	then
		MAIL		:= 'alias';

		addr_num	:= '521';
		addr_pfx	:= '';
		addr_NAME	:= 'sholoh';
		addr_type	:= '';
		addr_sfx	:= '';
		right_class	:= '   ';

	elsif	seq = 333	then
		MAIL		:= 'alias';

		addr_num	:= '521';
		addr_pfx	:= '';
		addr_NAME	:= 'PARK';
		addr_type	:= 'DR';
		addr_sfx	:= 'E';
		right_class	:= '   ';


--	=========================================================================================================

	else
		goto	re_initialize;

	end if;

--	=========================================================================================================

	dbms_output.put_line ( ' ' );
	dbms_output.put_line (  rpad (right_class, 05) || '   ' 
					||'/'|| rpad(addr_num,05)
					||'/'|| rpad(nvl(addr_pfx,' '),02)	||'/'|| rpad(addr_name,25) 
					||'/'|| rpad(addr_type,06)		||'/'|| rpad(addr_sfx, 02)	
					||'/');

--	=========================================================================================================
--	reduced_name := adr_compress_name ( addr_name, '2');
--	compact_name := adr_compress_name ( addr_name, '4');
--	TST_alias_match (mail, addr_num, addr_pfx, addr_name, addr_type, addr_sfx, reduced_name, compact_name);
--	ADR_alias_match (mail, addr_num, addr_pfx, addr_name, addr_type, addr_sfx, reduced_name, compact_name);
--	=========================================================================================================

	garland.ADR_FIND.FIND_ALIAS
--	garland.ADR_FIND_01.FIND_ALIAS
	( 
		addr_num,		
		addr_pfx,		
		addr_name,		
		addr_type,		
		addr_sfx,		

		second_name,
		also_names,
		mail,
		alias_weight,
		alias_match
	);

--	=========================================================================================================

	match_class := nvl (rtrim(mail), 'none');

	dbms_output.put_line	( rpad (
						  rpad(match_class, 08)
					||'/'|| rpad(nvl(addr_num,0),05)
					||'/'|| rpad(nvl(addr_pfx, ' '),02)	||'/'|| rpad(nvl(addr_name,' '),25) 
					||'/'|| rpad(nvl(addr_type,' '),06)	||'/'|| rpad(nvl(addr_sfx, ' '),02)	
					||'/    <'|| seq ||'> '
					, 70) 
					|| alias_match ||','|| alias_weight 
					);

--	=========================================================================================================

<<re_initialize>>

	mail		:= 'alias';
	addr_num	:= null;
	addr_pfx	:= '';
	addr_name	:= '';
	addr_type	:= '';
	addr_sfx	:= '';
	addr_code	:= '';
	addr_unit	:= '';
	match_class := ' ';
	right_class	:= ' ';

end loop;

end;


