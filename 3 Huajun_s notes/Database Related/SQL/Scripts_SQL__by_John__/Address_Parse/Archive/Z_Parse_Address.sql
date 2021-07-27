 	set echo		on;
--	aug 8 17:00

--	===================================================================================
--	parse address into standard address format
--	===================================================================================

--	===================================================================================
--	enhance
--		ignore all info after "ending" delimiter ?
--		'ste'	may be part of street name

--		Complex Format	examples:  wb  on  block  near  at  &
--		Intersection	calling program
--	===================================================================================

--	create or replace	procedure	ADR_parse_address

	create or replace	procedure	TST_parse_address

	(
		addr_num	in out	number,		
		addr_pfx	in out	varchar2,
		addr_name	in out	varchar2,
		addr_type	in out	varchar2,
		addr_sfx	in out	varchar2,
		addr_code	in out	varchar2,
		addr_unit	in out	varchar2,
		addr_parse	in out	varchar2
	)
as

	do_trace		number	:= 0;
	do_test		number	:= 0;

	min_name_size	number	:= 03;					--	new
	code_size		number	:= 05;
	unit_size		number	:= 06;

--	======================================================================

	form_addr_num		number;
	form_addr_pfx		varchar2(02);
	form_addr_name		varchar2(100);
	form_addr_type		varchar2(04);
	form_addr_sfx		varchar2(02);
	form_addr_code		varchar2(10);
	form_addr_unit		varchar2(10);
	form_parse			varchar2(10);

	how_parse			varchar2(10);
	parse_default		varchar2(10) := '......';
	parse_pfx			char		 := '.';
	parse_type			char		 := '.';
	parse_sfx			char		 := '.';
	parse_code			char		 := '.';
	parse_unit			char		 := '.';
	parse_num			char		 := '.';

--	======================================================================

	this_num			number;
	this_pfx			varchar2(05);
	this_name			varchar2(100);
	this_type			varchar2(20);
	this_sfx			varchar2(05);
	this_code			varchar2(05);
	this_unit			varchar2(40);

	this_word			varchar2(100);
	that_word			varchar2(100);
	that_name			varchar2(100);

	this_posn			number;
	lo_posn			number	:= 01;
	hi_posn			number	:= 99;
	end_posn			number;

	name_leng			number;
	word_leng			number;
	space_posn			number;
	dash_posn			number;
	alpha_posn			number;
	alpha_leng			number;

	retry_suffix		boolean	:= true;
	retry_ending		boolean	:= true;

	this_pattern		varchar2(100);
	that_pattern		varchar2(100);
	pattern#			varchar2(100);
	pattern			varchar2(100);

	lower_case			varchar2(40) := 'abcdefghijklmnopqrstuvwxyz';
	from_pattern		varchar2(40) := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
	to_pattern			varchar2(40) := 'XXXXXXXXXXXXXXXXXXXXXXXXXX0000000000';

	symbols			varchar2(40) := '`~!?$%^*_+=|\()[]{}<>;:,."''';
	markers			varchar2(10) := '#-@&/';
	digits			varchar2(10) := '123456789';
	letters			varchar2(30) := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	spaces			char(80)	 := ' ';

--	endings			varchar2(10) := '([{;:,';
--	enders			varchar2(10) := rpad (chr(128), 10, chr(128));

--	======================================================================

begin

	addr_name		:= ltrim (rtrim (upper (addr_name)));

	addr_pfx		:= ltrim (rtrim (addr_pfx));
	addr_type		:= ltrim (rtrim (addr_type));
	addr_sfx		:= ltrim (rtrim (addr_sfx));
	addr_unit		:= ltrim (rtrim (addr_unit));

	form_addr_num	:= addr_num;
	form_addr_pfx	:= translate (addr_pfx,  lower_case, from_pattern);
	form_addr_name	:= translate (addr_name, lower_case, from_pattern);
	form_addr_type	:= translate (addr_type, lower_case, from_pattern);
	form_addr_sfx	:= translate (addr_sfx,  lower_case, from_pattern);
	form_addr_unit	:= translate (addr_unit, lower_case, from_pattern);

	that_name		:= form_addr_name;
	this_name		:= form_addr_name;
	name_leng 		:= length(this_name);
	this_pattern 	:= translate (this_name, from_pattern, to_pattern);	

	if	instr(addr_parse, '1') > 0	then
		do_test	:= 01;
	end if;

	if	instr(addr_parse, '2') > 0	then
		do_trace	:= 01;
	end if;

--	=======================================================================================================

<<parse_unit_num>>

--	positions:		where t = this, l= lo, h = hi
--	(_posn)		_code_unit_
--				 t    l   h			

if	do_trace > 0 			then
	dbms_output.put_line ( 'unit code  ' );
end if;

	this_name	 := ' '|| this_name ||' ';
	name_leng	 := length (this_name);
	that_pattern := translate (this_name, symbols || markers || digits, spaces);
	this_code	 := null;
	this_unit	 := null;

if	do_test > 0999 			then
	dbms_output.put_line ( 'unit code1  /' || this_name ||'/'|| that_pattern ||'\');
end if;


for	item in (select /*+ cache */ all * from adrItem where class = 'C')	loop

	this_code 	:= null;

	this_posn := instr (that_pattern, ' '|| item.possible ||' ', -1);
	if	this_posn > 0									then
		this_code := item.standard;
		word_leng := length(item.possible);

	elsif item.possible = item.standard							then
		this_posn := instr (that_pattern, ' '|| item.name ||' ', -1); 
		if	this_posn > 0								then
			this_code := item.standard;
			word_leng := length(item.name);
		end if;
	end if;			

	exit when	this_code is not null;

end loop;

	if	this_code is not null					then
		this_posn	:= this_posn + 01;							--	begin of code			
	else
		this_posn := instr (this_name, '#');						--	begin of code
		if	this_posn > 0					then
			this_code	:= '#';
			word_leng	:= 1;
		end if;
	end if;	

	if	this_code is null						then
		goto	parse_unit_num_end;
	end if;

if	do_test > 0999 			then
	dbms_output.put_line ( 'unit code2  /' || this_code ||'/'|| this_posn ||'/'|| word_leng ||'\');
end if;

	lo_posn := this_posn + word_leng;								--	begin of unit
	if	substr (this_name, lo_posn, 01) < '0'			then
		lo_posn	:= lo_posn + 01;
	end if;


if	do_test > 0 			then
	dbms_output.put_line ( 'unit posn  /' || this_name ||'/'|| this_posn ||'/'|| this_pattern ||'\');
end if;

--	if	this_posn <= 05							
--	or	this_pattern like '0%'						then			
		hi_posn	:= instr (this_name, ' ', lo_posn);					--	end of unit + 01
--	else	
--		hi_posn	:= name_leng + 01;							--	end of unit + 01
--	end if;

	if	name_leng - hi_posn <= 3					then
		hi_posn	:= name_leng + 01;
	end if; 


	alpha_leng		:= hi_posn - lo_posn;							--	unit leng
	if	alpha_leng <= unit_size						then			
		this_unit	:= substr (this_name, lo_posn, alpha_leng);
	end if;

if	do_test > 0 			then
	dbms_output.put_line ( 'unit code3   /' || this_posn ||'/'|| lo_posn ||'/'|| hi_posn ||'/'|| alpha_leng ||'\');
end if;

	if	nvl (this_unit, ' ') = ' '					then
		goto	parse_unit_num_end;
	end if;

	if	parse_unit = 'u'							then	
		if	parse_pfx = '.'
		and	form_addr_unit in ( 'N', 'S', 'E', 'W' )		then
			form_addr_pfx	:= form_addr_unit;
			parse_pfx		:= 'p';
		else
			goto	parse_unit_num_end;
		end if;
	end if;

	parse_unit	   := 'u';
	form_addr_unit := ltrim (rtrim (this_unit), ' #');						

	if	this_code is not null					then
		parse_code	:= 'c';
		form_addr_code := ltrim (rtrim (this_code));
	end if;

	this_name	:= substr (this_name, 01, this_posn - 01) || substr (this_name, hi_posn);

if	do_test > 0999 			then
dbms_output.put_line ('unit codez  /' || this_num ||'/'|| this_code ||'/'|| this_unit ||'\' );
dbms_output.put_line ('unit codez  /' || form_addr_num ||'/'|| form_addr_pfx ||'/'|| form_addr_code ||'/'|| form_addr_unit ||'\');
end if;

<<parse_unit_num_end>>

	this_name	 := ltrim(rtrim(this_name));
	name_leng	 := length(this_name);
	this_pattern := translate (this_name, from_pattern, to_pattern);	

--	=======================================================================================================

--	======================================================================
--	obtain number & adjacent unit
--	======================================================================
<<parse_number>>

	if	form_addr_num > 0			then
		goto	parse_number_end;
	end if;

--	======================================================================
--	parse duplex

	this_posn := instr (this_pattern, '0-0');							

	if	this_posn > 0										then
		dash_posn   := this_posn + 01;
		end_posn	:= instr (this_pattern||' ', ' ', dash_posn) - 01;
		this_posn 	:= instr (rpad (this_pattern, end_posn), ' ', -1) + 01;	--	duplex 1
		word_leng 	:= dash_posn - this_posn;

		this_word := substr (this_pattern, this_posn, word_leng);
		if	word_leng <= 5
		and	word_leng = end_posn - dash_posn						--	duplex 2
		and	this_word = rpad ('0', word_leng, '0')					then
			form_addr_num  := substr (this_name, this_posn,	word_leng);
			form_addr_unit := substr (this_name, dash_posn + 01, end_posn - dash_posn);
			form_addr_code := 'DPLX';
			this_name := replace (this_name, substr (this_name, this_posn, (2 * word_leng) + 1));
			this_name := ltrim (rtrim (this_name));
			name_leng := length(this_name);
			parse_num := 'n';									
			parse_unit:= 'u';
			goto	parse_number_end;
		end if;
	end if;

--	======================================================================
--	parse solitary number

if do_trace > 0			then
dbms_output.put_line ( '$solitary num' );
end if;


	this_num	:= 0;
	end_posn	:= instr (this_name, ' ') - 01;

	if	end_posn < 01						then					--	new	
		end_posn	:= name_leng;
	end if;

	if	this_pattern not like '0%'				then
		goto	parse_number_end;
	end if;	


	this_word 	 := substr (this_name,	 01, end_posn);
	that_pattern := substr (this_pattern,01, end_posn);

	if	translate (that_pattern, '/0', '/') is null	then
		this_num	:= this_word;
		parse_num	:= 'n';						
		goto	parse_number_unit;
	end if;

--	======================================================================
--	find end of number  (examples:  1201A  1201-ABC  1201-5 1201/25)

	that_pattern := translate (that_pattern, symbols||markers, spaces);
	space_posn	 := instr (that_pattern, ' ');
	alpha_posn	 := instr (that_pattern, 'X');

	if	space_posn = 0								
	or (	space_posn > alpha_posn						
	and	alpha_posn > 0	)			then
		hi_posn := alpha_posn;
	else
		hi_posn := space_posn;
	end if;

--	obtain unit number

	that_word := ltrim (substr (this_word, hi_posn), ' '||symbols||markers);			
	alpha_leng	:= length (that_word);										--	new

--	=======================================================================================================
--	process delimited number & unit

	if	hi_posn = space_posn						then					--	new	
		this_num	:= substr (this_word, 01, hi_posn - 01);
		parse_num	:= 'n';									
		if	alpha_leng < 3						then
			this_unit	:= that_word;
			parse_unit	:= 'u';
		else
			hi_posn	:= -1;
			end_posn	:= alpha_posn - 01;
		end if;
	end if;

--	=======================================================================================================
--	process contiguous number & unit (eg. 1201A, 3RD, 1001DOSS)


if do_test > 0999			then
dbms_output.put_line ( ' ' );
dbms_output.put_line ('contig1:  ' || this_word ||'/'|| that_word ||'/'|| alpha_posn  ||'/'|| alpha_posn );
dbms_output.put_line ('contig1:  ' || this_num  ||'/'|| this_unit ||'/'|| space_posn  ||'/'|| hi_posn ||'/'|| '' );
end if;

	if	hi_posn = alpha_posn						then

--		process a unit letter adjacent to the number
		if	alpha_leng = 01						then
			this_num  := rpad (this_word, hi_posn - 01);
			this_unit := that_word;				
			parse_num := 'n';									--	new 
			parse_unit:= 'u';

--		process a conjoined number & street name (eg. 606BAY ST)		
		elsif	alpha_leng > 02						then
			end_posn := alpha_posn - 01;							--	new
			this_num := rpad (this_word, end_posn);
			parse_num := 'n';							 

		end if;
	end if;


if do_test > 0999			then
dbms_output.put_line ( ' ' );
dbms_output.put_line ('numun1 ' || this_num  ||'/'|| this_unit  ||'/'|| this_word ||'/'|| that_word ||'/'|| '' );
dbms_output.put_line ('numun3 ' || hi_posn   ||'/'|| end_posn   ||'/'|| alpha_posn ||'/'|| alpha_leng || '' );
dbms_output.put_line ('numun2 ' || parse_num ||'/'|| parse_unit ||'/'|| '' ||'/'|| '' ||'/'|| '' );
end if;
--	=======================================================================================================
<<parse_number_unit>>

--	example:  1119 1/2 Avenue A											--	new

	if	instr (this_name, ' 1/2 ') between 04 and 07		then		
		this_unit	:= '1/2';
		this_name	:= replace (this_name, ' 1/2');
	end if;

--	use final number/unit results

	if	this_num > 0				then
		form_addr_num	:= this_num;
		form_addr_unit	:= ltrim (this_unit);
		form_addr_name	:= ltrim (substr (this_name, end_posn + 01));
		parse_num		:= 'n';
		if	form_addr_unit is not null	then
			parse_unit	:= 'u';
		end if;
	end if;

	this_name := form_addr_name;
	name_leng := length(this_name);

--if	do_test > 0999 			then
--dbms_output.put_line ('999XXc:  ' || this_num ||'/'|| this_unit ||'/'|| space_posn ||'/'|| hi_posn ||'/'|| '' );
--end if;

<<parse_number_end>>
	null;

--	=======================================================================================================
<<parse_prefix>>

	if	parse_pfx > '.'		then
		goto	parse_prefix_end;
	end if;

	space_posn := instr (this_name, ' ');
	if	space_posn - 01 <= 05							then
		this_word	:= substr (this_name, 01, space_posn - 01);
		this_pfx	:= adr_verify_street_prefix (this_word);
	end if;


		if	this_pfx is not null						then
			form_addr_pfx	:= this_pfx;
			parse_pfx		:= 'p';

			this_name		:= ltrim (substr (this_name, space_posn + 01));
			name_leng		:= length (this_name);

		elsif	 form_addr_code is null
		and	 form_addr_unit in ( 'N', 'S', 'E', 'W')			then
			form_addr_pfx	:= form_addr_unit;
			form_addr_unit	:= null;
			parse_pfx		:= 'p';

		end if;

<<parse_prefix_end>>
	null;

--	=======================================================================================================

	this_word	:= replace (this_name, 'AVENUE');
	this_word	:= replace (this_word, 'AVE');
	this_word	:= replace (this_word, 'AV');
	this_word	:= ltrim   (rtrim (this_word));
	word_leng	:= length  (this_word);

	if	word_leng = 1
	and	this_word between 'A' and 'Z'				then
		this_name	:= 'AVENUE ' || this_word;
		name_leng	:= 08;
		goto	final_results;
	end if;

--	=======================================================================================================
<<parse_suffix>>

	if	form_addr_sfx > 'A'		then
		goto	parse_suffix_end;
	end if;


	hi_posn	:= instr (this_name, ' ', -1);

	if	name_leng - hi_posn  <= 05						then
		this_word	:= substr (this_name, hi_posn + 01);
		this_sfx	:= adr_verify_street_prefix (this_word);
		if	this_sfx is not null						then
			form_addr_sfx	:= this_sfx;
			parse_sfx		:= 's';
			this_name		:= rtrim (substr (this_name, 01, hi_posn));
			name_leng 		:= length(this_name);
		end if;
	end if;

<<parse_suffix_end>>
	null;

--	=======================================================================================================
<<parse_str_type>>

	if	form_addr_type > 'A'		then
		goto	parse_str_type_end;
	end if;


if	do_test > 0 			then
dbms_output.put_line ('str type a  /' || this_name ||'/'|| '' ||'/'|| '' ||'/'|| '' ||'/'|| '' );
end if;


	hi_posn := instr  (this_name, ' ', -1);
	if	name_leng - hi_posn 	between 1 and 20		then
		this_word	:= substr (this_name, hi_posn + 01);
	else
		this_word	:= null;
	end if;

	this_type	:= adr_verify_street_type (this_word);	

	if	this_type is not null					then
		form_addr_type	:= this_type;
		parse_type		:= 't';
		this_name		:= rtrim (substr (this_name, 01, hi_posn));			--	new
		name_leng 		:= length(this_name);
	end if;

<<parse_str_type_end>>
	null;

--	=======================================================================================================
--	street type & street suffix may occur in reverse order

	this_name	:= rtrim  (this_name);
	name_leng	:= length (this_name);

	if	form_addr_sfx  > 'A'		then
		null;
	elsif	form_addr_type > 'A'
	and	retry_suffix  = true		then
		retry_suffix := false;
		goto	parse_suffix;
	end if;

--	=======================================================================================================
--	unit number may exist without preceding unit type 
--	if so, get the unit and then look again for street type & suffix

	space_posn := instr (this_name, ' ', -1);

	if	space_posn > min_name_size 					then
		this_word  := substr (this_name, space_posn + 01);
	else
		space_posn := 0;
	end if;


	this_posn	:= instr (this_pattern, '9XX', space_posn);			

	if	this_posn > 0
	and	substr (that_name, this_posn, 02) in ( 'ST', 'ND', 'RD', 'TH')	then
		this_posn	:= 0;
	else
		this_posn	:= 1;
	end if;

--	=======================================================================================================

	if	not retry_ending							
	or 	space_posn     =  0
	or 	this_posn      =  0							--	new
	or  	form_addr_unit > '0'  							
	or  	form_addr_sfx  > 'A'  						
	or	form_addr_type > 'A'					
	then
		null;
	else
		word_leng := length (this_word);
		if	word_leng = 01
		or (	word_leng between 02 and unit_size
		and	word_leng <> length (nvl (translate(this_word, '/0123456789', '/'),' '))	)
		then
			form_addr_unit	:= this_word;
			parse_unit		:= 'u';
			this_name		:= rtrim (substr (this_name, 01, space_posn));
			name_leng		:= length (this_name);
			retry_ending	:= false;
			goto	parse_suffix;	
		end if;
	end if;		

--	=======================================================================================================
--	does street name contain leading  unit number
--	does street name contain trailing unit number

	name_leng	:= length(this_name);

	if	parse_unit = '.'				
	and	substr(this_name, 02, 01) = ' '					then
		form_addr_unit	:= substr (this_name, 01, 01);
		parse_unit		:= 'u';
		this_name		:= substr (this_name, 03);
		
	elsif	parse_unit = 'u'								then
		this_word := substr (this_name, name_leng - 01);
		if	this_word like ' %'						then
			form_addr_unit	:= form_addr_unit || this_word;
			this_name		:= ltrim (rpad (this_name, name_leng - 02));
		end if;
	end if;	

--	=======================================================================================================
<<final_results>>

if	do_trace > 0			then
dbms_output.put_line ('$final  ' ||this_name||'/'||form_addr_num ||'/'||form_addr_pfx||'/'||form_addr_name||'/'||form_addr_type||'/'||form_addr_sfx ||'/');
end if;


	form_addr_name	:= this_name;
	how_parse		:= parse_num || parse_pfx || parse_type || parse_sfx || parse_code || parse_unit;
	form_parse		:= how_parse;

	addr_num		:= form_addr_num;
	addr_pfx		:= form_addr_pfx;
	addr_name		:= form_addr_name;
	addr_type		:= form_addr_type;
	addr_sfx		:= form_addr_sfx;
	addr_code		:= form_addr_code;
	addr_unit		:= form_addr_unit;
	addr_parse		:= form_parse;

	return;

end;

/*
--	=======================================================================================================
if	do_test > 9990 			then
dbms_output.put_line ('=  ' || '' ||'/'|| '' ||'/'|| '' ||'/'|| '' ||'/'|| '' ||'/'|| '' ));
end if;
--	=======================================================================================================
*/

