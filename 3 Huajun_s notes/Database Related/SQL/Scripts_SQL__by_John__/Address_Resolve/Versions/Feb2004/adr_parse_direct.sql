	set echo 		off;
	set timing		off;
	set serveroutput	on;
--	===============================================	
--		Address Parsing Routine
--	===============================================	

--	remove number limit
--	===============================================	

declare
	do_compile	number := 01;

--	dispay trace					pos=yes  neg=in/out	
	do_trace	number		:= 01;

--	choose seq from adrResult			pos=yes  neg=hard code
	do_seq	number		:= -2672;

--	choose key from adr_parse_test_vw
	do_choice	number		:= 16;	

--	===============================================	

--	addr_name	varchar2(80) :=	'forest lane/marion'	;	
--	addr_name	varchar2(80) :=	'forest la @ s shiloh'	;	
--	addr_name	varchar2(80) :=	'rowlett & chaha'	;	
--	addr_name	varchar2(80) :=	'901 & 902 w avenue e n s'	;	
--	addr_name	varchar2(80) :=	'901 -902  w avenue e '	;	
--	addr_name	varchar2(80) :=	'frances dr 1904-1902 '	;	

	addr_name	varchar2(80) :=	'bois d''arc'	;	
	addr_pfx	varchar2(10) :=	''	;		
	addr_type	varchar2(10) :=	''	;	
	addr_sfx	varchar2(10) :=	''	;	
	addr_num	varchar2(20) :=	'2218'	;	

	addr_code1	varchar2(10) :=	''	;	
	addr_unit1	varchar2(20) :=	''	;	
	addr_code2	varchar2(10) :=	''	;	
	addr_unit2	varchar2(20) :=	''	;	

	addr_audit	varchar2(40) :=	''	;	
	addr_ignore	varchar2(40) :=	' '	;	

	msg		varchar2(200);
	msg1		varchar2(200);
	msg2		varchar2(200);
	msg3		varchar2(200);
	stars		varchar2(80) := rpad('*',50,'*');
	item_count	number	 := 0;

--	===============================================	
	cursor	read_test_input		is

	select	addr_num,   addr_pfx,   addr_name,  addr_type,  addr_sfx,
			addr_code1, addr_unit1, addr_code2, addr_unit2,
			addr_audit
	from		garland.adr_parse_test_vw
	where		key = do_choice;

--	===============================================	
	cursor	read_adrResult		is

--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for

	select
		r.addr_num,
		r.appl_pfx,   r.appl_name,  r.appl_type,  r.appl_sfx,	
		r.appl_code1, r.appl_unit1, r.appl_code2, r.appl_unit2,
		' '	addr_audit

	from 	garland.adrResult		r,
		garland.gis_app_rowid	g
	where	g.row_seq	= do_seq
	and	g.row_id	= r.rec_rowid;


--	from 	adrResult		r,
--		garland.adrResult_Local	l,
--		garland.gis_app_rowid	g
--	where	g.row_seq	= do_seq
--	and	g.row_id	= l.rowid
--	and	r.rec_key	= l.rec_key;

--	select * from explain_plan;

--	===============================================	
--	LIMITS		--	<<<<<<=================     copy into production version starting here

	address_limit	number := 100;	--	max address length
	name_limit		number := 20;	--	max name length
--	number_limit	number := 05;	--	max number length
	fraction_limit	number := 01;	--	max fraction number length
	compass_limit	number := 05;	--	max compass length
	unit_limit		number := 10;	--	max unit length

	name_min		number := 01;	--	min name length				-- oct 2003
	code_min		number := 03;	--	min code length
	item_min		number := 02;	--	min item length

	max_options		number := 10;	
	max_warns		number := 05;	
	max_parts		number := 20;	
	max_redo		number := 20;	
	max_loops		number := 40;	

--	PART

	type part_record	is record
(
	text			varchar2(80),
	before		char,	
	kind			char,
	field			number,
	what 			number,		--  role class
	role 			number,
	width			number
);
	part			part_record;	
	prev			part_record;	--  previous
	prec			part_record;	--  preceding

--	PART TABLE

	type part_table	is table of	part_record
		index by	binary_integer;
	part_entry		part_table;


--	ITEM TABLE

	type item_table	is table of	garland.adrItem%rowtype
		index by	binary_integer;
	item_entry		item_table;


--	ITEM CLASS		(from AdrItem table)

	is_compass_item	constant	char	:= 'D';	--  direction
	is_type_item	constant	char	:= 'T';
	is_code_item	constant	char	:= 'C';
	is_highway_item	constant	char	:= 'H';

--	AUDIT

	type audit_record	is record
(
	role		char,
	add		char,
	del		char
);

--	AUDIT TABLE

	type audit_table	is table of	audit_record
		index by	binary_integer;
	audit		audit_table;

--	===============================================	
---	GENERAL

	before		char		:= ' ';	

	idx			number	:= 0;
	ndx			number	:= 0;
	prec_idx		number	:= 0;
	prev_idx		number	:= 0;
	twin_idx		number	:= 0;

	is_ending		number	:= 0;
	unit_only		number	:= 0;

	field_role		number;
	redo_role		number;

	is_alone		number;
	allow_code_unit	number;
	allow_code		number;
	allow_unit		number;

	counter		number;
	this_start		number;
	this_leng		number;

	next_start		number;
	next_leng		number;
	next_kind		char;

	address		varchar2(100);
	next_pattern	varchar2(100);

	trim			varchar2(4);
	compass2		varchar2(4);
	keep_code1		varchar2(5) := ' ';
	keep_code2		varchar2(5) := ' ';

--	KIND	

	is_field_mark	char	:= chr(01);

	is_alphabetic	char	:= 'A';	
	is_numeric		char	:= 'N';

	is_space		char	:= 'o';	
	is_punctuation	char	:= 'p';		
	is_dot		char	:= 'q';		
	is_dash		char	:= 'r';		
	is_hash		char	:= 's';		
	is_slash		char	:= 'x';		
	is_amper		char	:= 'y';		
	is_at			char	:= 'z';		

	has_space		char	:= ' ';
	has_dot		char	:= '.';
	has_dash		char	:= '-';
	has_hash		char	:= '#';
	has_slash		char	:= '/';
	has_amper		char	:= '&';
	has_at		char	:= '@';

	has_near		varchar2(8)	:= 'near';

	ignore		varchar2(30)	:= ',;:()*';
	punctuation		varchar2(30)	:= '"`''';
	reject		varchar2(30)	:= '\_~!?$%^+=|[]{}<>';

	from_pattern	varchar2(80) :=	
			 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789' || 
			 has_dot || has_dash || has_hash || has_slash || has_amper || has_at	||
			 has_space || chr(9)						     ||
			 ignore    || punctuation || reject;

	to_pattern		varchar2(80) :=	
			'AAAAAAAAAAAAAAAAAAAAAAAAAANNNNNNNNNN'				|| 
			 is_dot || is_dash  || is_hash  || is_slash  || is_amper    || is_at	||
			 is_space  || is_space							||
			 rpad(is_space, length(ignore))					||	
			 rpad(is_punctuation, length(punctuation), is_punctuation);			--	dec 2002
--			 rpad(is_punctuation, length(punctuation||reject), is_punctuation);

--	ROLE

	is_ignore		number := 0;

	is_number		number := 1;	--  'n'
	is_prefix		number := 2;	--  'p'
	is_name		number := 3;	--  'm'
	is_type		number := 4;	--  't'
	is_suffix		number := 5;	--  's'

	is_code1		number := 6;	--  'c' 
	is_unit1		number := 7;	--  'u' 
	is_code2		number := 8;	--  'k'
	is_unit2		number := 9;	--  'v'	

	is_code		number := 10;	--  'c' / 'k'
	is_unit		number := 20;	--  'u' / 'v'	

--	ROLE POINTERS

	number_idx		number	:= 0;
	type_idx		number	:= 0;
	prefix_idx		number	:= 0;
	suffix_idx		number	:= 0;
	code1_idx		number	:= 0;
	code2_idx		number	:= 0;

	name_idx 		number	:= 0;	
	name_occur		number	:= 0;
	name_count		number	:= 0;

	unit1_idx		number	:= 0;	
	unit1_occur		number	:= 0;
	unit1_count		number	:= 0;	

	unit2_idx		number	:= 0;
	unit2_occur		number	:= 0;
	unit2_count		number	:= 0;


--	LITERALS

	empty_audit		varchar2(20):= '.........';
	duplex_code		char(4) 	:= 'DPLX';

--	OUTPUT ADDRESS

	form_num		varchar2(10);
	form_pfx		varchar2(02);
	form_name		varchar2(80);
	form_type		varchar2(04);
	form_sfx		varchar2(02);
	form_code1		varchar2(10);
	form_unit1		varchar2(80);
	form_code2		varchar2(10);
	form_unit2		varchar2(80);

--	OUTPUT WARNING / ERROR

	warn_compass2	varchar2(8):= '%/nesw%';
	warn_suffix		varchar2(8):= '%/sufx%';
	warn_duplex		varchar2(8):= '%/dplx%';
	warn_fraction	varchar2(8):= '%/frac%';
	warn_unit		varchar2(8):= '%/unit%';
	warn_trailer	varchar2(8):= '%/tail%';
	warn_xstr		varchar2(8):= '%/xstr%';

	is_error		char(2) := '50';

	is_non_address	char(2) := '70';

	is_code_error	char(2) := '81';
	is_unit_error	char(2) := '82';
	is_fraction_error	char(2) := '83';

	is_length_error	char(2) := '90';
	is_format_error	char(2) := '91';
	is_parts_error	char(2) := '92';
	is_redo_error	char(2) := '93';
	is_loop_error	char(2) := '94';

	warn_count		number  := 0;
	warn_exit		number  := 0;
	warn			varchar2(07);
	warning		varchar2(35);
		
--	===============================================	
	cursor read_adrItem	is

	select --+	cache (adrItem)
	all *
	from	garland.adrItem
	where	possible = part.text; 

	item		garland.adrItem%rowtype;
	previ		garland.adrItem%rowtype;

--	===============================================	
begin

	if	do_compile > 0		then
		return;	
	end if;


	if	do_seq < 0			then		--	<<<===  remove if clause from production version
		null;

	elsif	do_choice > 0		then
		open	read_test_input;
		fetch	read_test_input	
		into	addr_num,   addr_pfx,   addr_name,  addr_type,  addr_sfx,
			addr_code1, addr_unit1, addr_code2, addr_unit2, addr_audit;
		close	read_test_input;

	elsif	do_seq > 0			then
		open	read_adrResult;
		fetch	read_adrResult	
		into	addr_num,   addr_pfx,   addr_name,  addr_type,  addr_sfx,
			addr_code1, addr_unit1, addr_code2, addr_unit2, addr_audit;
		close	read_adrResult;
	end if;	

	if	do_trace > 0		then
		dbms_output.put_line (stars);
		dbms_output.put_line ('input   |'|| 
		rpad(addr_num||'\'||addr_pfx||'\'||addr_name||'\' ||addr_type||'\'||addr_sfx|| '|',40) 
		|| '|'||addr_code1||'\'||addr_unit1||'\'||addr_code2||'\'||addr_unit2		||'|'); 
	end if;

--	===============================================	
--	initialize

	part_entry (0)	:= null;

	item			:= null;
	item.class		:= has_space;
	item_entry (0)	:= item;

	addr_audit		:= has_space;

	audit (is_number).role	:= 'n';
	audit (is_prefix).role	:= 'p';
	audit (is_name).	role	:= 'm';
	audit (is_type).	role	:= 't';
	audit (is_suffix).role	:= 's';
	audit (is_code1).	role	:= 'c';
	audit (is_unit1).	role	:= 'u';
	audit (is_code2).	role	:= 'k';
	audit (is_unit2).	role	:= 'v';

	if	addr_ignore  > has_space
	and	addr_ignore <> ignore		then
		reject := translate (reject||ignore, 'x'||addr_ignore, 'x');
		ignore := addr_ignore;
	end if;
	
--	===============================================	
--	set address & pattern
						
	address :=	addr_num 	|| is_field_mark ||
			addr_pfx 	|| is_field_mark ||	
			addr_name	|| is_field_mark ||
			addr_type	|| is_field_mark ||	
			addr_sfx 	|| is_field_mark ||	
			addr_code1	|| is_field_mark ||	
			addr_unit1  || is_field_mark ||	
			addr_code2  || is_field_mark ||	
			addr_unit2;

	address	 := rtrim (upper(address), is_field_mark) ||' ';
	next_leng	 := length(address);
	next_pattern := translate (address, from_pattern, to_pattern);

	if	next_leng  > address_limit		then
--	or	next_leng <> length(next_pattern)	then
		warn	:= is_length_error;
		goto	final;
	end if;

	field_role	:= 01; 
	next_start	:= 01;
	next_kind	:= rpad(next_pattern, 01);

	if	do_trace > 0	then	-- at set address
		dbms_output.put_line ('address |' || address	||'|');
		dbms_output.put_line (stars);
	end if;

--	===============================================	
--	process each "part" of the address

<<part_loop>>
loop

	max_loops := max_loops - 01;
	if	max_loops < 0			then
		warn := is_loop_error;
		exit;
	end if;

--	if	do_trace > 0	then	-- at part loop
--		dbms_output.put_line ('next pattern |' || next_pattern ||'|');
--		dbms_output.put_line ('next |'||next_start||'\'||next_leng||'\'||next_kind	||'|');
--		dbms_output.put_line ( ' ' );
--	end if;

	twin_idx	:= 0;
	redo_role	:= null;
	before	:= part.kind;

	this_start	 := next_start;
	this_leng	 := next_leng;

	next_pattern := ltrim (next_pattern, next_kind);
	next_leng	 := length(next_pattern);
	counter	 := this_leng  - next_leng;
	next_start	 := this_start + counter;

	exit part_loop	when next_pattern is null;	

	if	next_kind = is_field_mark			then
		field_role	:= field_role + counter;
--		part.text	:= has_space;
		part.kind	:= is_space;
	else
		part.text	:= substr (address, this_start, counter);	
		part.kind	:= next_kind;
	end if;

	next_kind	:= rpad (next_pattern, 01);

	part.field	:= field_role;
	part.width	:= counter;
	part.before := before;
	part.what	:= null;
	part.role	:= null;

	if	part.kind = is_space		then
		goto	part_loop;
	elsif	idx < max_parts			then
		idx := idx + 01;
		ndx := idx;
	else
		warn := is_parts_error;
		exit;
	end if;

--	===============================================	
--	adrItem class = possible "role" for part text
--	for speed, avoid reading adrItem when possible

	item := item_entry (0);

	if	part.text = has_hash			then
		item.standard := has_hash;
		item.class	  := is_code_item;

	elsif	part.kind  >= is_punctuation		then
		null;

	elsif	part.width = 1
	and	part.text in ('N', 'S', 'E', 'W')	then
		item.standard := part.text;
		item.class	  := is_compass_item;
		select decode (part.text,	
			'N','NORTH', 'S','SOUTH', 'E','EAST', 'W','WEST', 
			' ')
			into	item.name	from	dual;


	elsif	part.width < item_min 
	or	prev.what  = is_code

--	numeric & not highway	

	or  (	part.kind = is_numeric			
	and ( idx = 1  or  is_ending > 0 )	)


--	need name & not num or pfx	
--	or  ( name_count = 0				
--	and  	part.width > compass_limit
--	and 	part.kind  = is_alphabetic	)

	then
		null;
	else

   msg := msg || ' item';
		open	read_adrItem;
		fetch	read_adrItem	into item;
		close	read_adrItem;
	end if;

--	item_entry (idx) := item;


--	===============================================	

	if	item.class in ('B', 'K')		then
		warn := is_non_address;
   msg := msg || ' v0';
		exit;
	end if;

--	===============================================	

	if	do_trace > 0	then	-- after adrItem
		dbms_output.put_line ('TEXT |' ||part.text	||'|');
		dbms_output.put_line ('ADDR |' || address		||'|');
		dbms_output.put_line (' ');
		dbms_output.put_line ('indx |' ||'idx='||idx ||'\prev='||prev_idx||'\prec='||prec_idx
							 ||'\twin='||twin_idx	 ||'|');
		dbms_output.put_line ('prev |' ||previ.class||'\'||previ.standard ||'\'||previ.name		||'|');
		dbms_output.put_line ('item |' ||item.class ||'\'||item.standard  ||'\'||item.name		||'|');

		dbms_output.put_line ('prev |' ||prev.text ||'\'||prev.before||'\' ||prev.kind  ||'\'||prev.what||'\'
							 ||prev.role||'\' ||prev.field ||'\' ||prev.width ||'|');
		dbms_output.put_line ('prec |' ||prec.text ||'\'||prec.before||'\' ||prec.kind  ||'\'||prec.what||'\'
							 ||prec.role||'\' ||prec.field ||'\' ||prec.width ||'|');
		dbms_output.put_line ('part |' ||part.text ||'\'||part.before||'\' ||part.kind  ||'\'||part.what||'\'
							 ||part.role||'\' ||part.field ||'\' ||part.width ||'|	'	
							 || '(text/before/kind/what/role/field/width)'	);

   msg := msg || ' *';
	end if;

--	===============================================	
<<determine_role>>

--	===============================================	
--	is single part standing "alone" between spaces

	if	part.before in (is_field_mark, is_space, is_dot)
	and	next_kind   in (is_field_mark, is_space, is_dot)	then
		is_alone	:= 1;
   msg := msg || ' aln';
	else
		is_alone	:= 0;
	end if;

--	===============================================	
--	is code or unit allowed

	if	name_count > 0
	or	prefix_idx = 0			then
		allow_code_unit := 1;
   msg := msg || ' acu';
	else
		allow_code_unit := 0;
	end if;

	if	item.class = is_code_item
	and	code2_idx  = 0	
	and  	allow_code_unit > 0		then
		allow_code := 1;
   msg := msg || ' ac';
	else
		allow_code := 0;
	end if;

	if	allow_code_unit = 0
	or	part.width > unit_limit
	or	number_idx + name_count + code1_idx = 0	then
		allow_unit := 0;
	else
		allow_unit := 1;
   msg := msg || ' au';
	end if;

--	===============================================	
--	is compass direction in 2 parts

	compass2 := null;

	if	part.width = 1
	and	prev.width = 1				then
		if	previ.standard in ( 'N', 'S')	
		and	item.standard  in ( 'E', 'W')	then
			compass2 := previ.standard || item.standard;
	   msg := msg || ' ne';
		elsif	previ.standard in ( 'E', 'W')	
		and	item.standard  in ( 'N', 'S')	then
			compass2 := has_space;
	   msg := msg || ' en';
		end if;
	end if;

   msg := msg || ';';

--	===============================================		
--	ordinal street name

	if	part.width = 2	
	and (	part.text in ('TH', 'ND')
	or  (	part.text in ('ST', 'RD')  
	and   part.before <> is_space ) )
	and	unit_only  = 0				then
   msg := msg || ' th';
		if	prec.kind	 = is_numeric
		and	prec.before  = is_space
		and	name_count  <= 1			then
			part.role	:= is_name;	
			before	:= null;
			item		:= item_entry (0);
			redo_role	:= is_name;
			ndx		:= prev_idx;
   msg := msg || ' 1';
		end if;

--	===============================================	
--	code

	elsif	item.class = is_code_item
	and	allow_code > 0				then
		part.role := is_code;
   msg := msg || ' cd1';
		if	prev.what = is_code	
		and	part.text = has_hash		then
			part.role := is_ignore;
   msg := msg || ' 1';
		end if;

	elsif	part.field >= is_code1			
	and	part.width >= code_min
	and	allow_code > 0				then
		part.role := is_code;
   msg := msg || ' cd2';

--	===============================================	
--	unit processing

	elsif	allow_unit > 0				then
   msg := msg || ' UN';


--	===============================================	

		if	prec.what  = is_unit	
		and	prec.field = part.field
		and	prec.field >= is_code1		then
			part.what := is_unit;
			part.role := prec.role;				--	new
   msg := msg || ' pu';

--	===============================================	
--	fractional unit

		elsif	prec.text   = has_slash
		and	number_idx  > 0
		and	number_idx <> prev_idx				then
   msg := msg || ' fr';
--	901 1/2
			if	prev.width <= fraction_limit				
			and	part.width <= fraction_limit
			and	prev.kind   = is_numeric		
			and	part.kind   = is_numeric		
			and	addr_audit not like warn_fraction	then
				warn		:= warn_fraction;
				part.role   := is_unit;
				redo_role	:= is_unit;
				ndx		:= prev_idx;
   msg := msg || ' 1';

--	901 A/10
			elsif	prev.what  in (is_code, is_unit)	then	
				part.role := is_unit;		
   msg := msg || ' 2';
			else
				warn := is_fraction_error;
				exit;
			end if;

--	===============================================	
--	duplex units

		elsif	prec.width = 1
		and	prec.text in (has_dash, has_amper, has_slash)
		and	part.width  = prev.width
		and	part.kind   = is_numeric
		and 	prev.kind   = is_numeric		  		
		and	addr_audit not like warn_duplex		then
			warn := warn_duplex;
   msg := msg || ' dpl';

			part_entry(idx-1).field	:= 0;
			part_entry(idx-1).what	:= 0;
			part.role 	:= is_unit;
			redo_role 	:= is_unit;
			ndx	    	:= prev_idx;	

			if  (	number_idx = 0  or  prev.role = is_number )	
			and	code1_idx  = 0				then
				keep_code1	:= duplex_code;
   msg := msg || ' cd';
			end if;

--	===============================================	
--	unit attached to number

		elsif	part.field = is_name
		and	unit_only  > 0					then
			part.role := is_unit;
	   msg := msg || ' uo';

		elsif	prev.role  = is_number		
		and	part.before <> is_space				then
   msg := msg || ' nun';

--	901B
			if	part.kind  = is_alphabetic		then
				part.role := is_unit;			
   msg := msg || ' 1';
--	901-B
			elsif	prec.text in (has_dash, has_dot)	then
				part.role := is_unit;			
   msg := msg || ' 2';
			end if;
	
--	===============================================		
--	normal unit

--	901 Apt B
--	901 Apt B10
--	#901 - A
		elsif	part.kind <= is_numeric				then	
			if	prev.what  = is_code			

--			or	was_unit   > 0				
			or  (	prev.what = is_unit
			and	part.before <> is_space		)

			or	part.field in (is_unit1, is_unit2)
			or  (	part.field = is_number
			and	number_idx > 0			)
			or  (	prev.what  = is_unit			
			and	prec.kind  > is_punctuation	)	then
				part.role := is_unit;
   msg := msg || ' un';
			end if;

		end if;
	end if;

--	===============================================	

	if	part.text in (has_at, has_near)
	and	part.field <= is_suffix				then		--	new
		if	number_idx > 0
		and	addr_audit not like warn_xstr		then
			warn		:= warn_xstr;
			warn_exit	:= 1;
   msg := msg || ' w1';
			goto	set_warning;
		else
			warn		:= is_format_error;
   msg := msg || ' w2';
		end if;
		exit;
	end if;	

	if	part.role is null 
	and	part.field = is_name
	and	prec.kind >= is_slash		then
		warn := is_format_error;
   msg := msg || ' w3';
		exit;
	end if;

--	===============================================	
--	before_street_name

	if	part.role is null 		then
	if	name_count = 0			then
   msg := msg || ' N<';

--	===============================================		
--	street number
		
		if	part.kind   = is_numeric
--		and	part.width <= number_limit
		and	number_idx + prefix_idx = 0		then
			part.role  := is_number;	
   msg := msg || ' nbr';

--	===============================================
--	street prefix

		elsif	item.class	= is_compass_item	
		and	is_alone > 0				then
   msg := msg || ' pf';

			if	prefix_idx = 0			then
				part.role := is_prefix;
   msg := msg || ' 1';

--	901 N E I30 => 901 NE I30
			elsif	compass2 > has_space			
			and	addr_audit not like warn_compass2 then
				part_entry(prev_idx).role := is_ignore;
				part.role	  := is_prefix;
				part.text	  := compass2;
				item.standard := compass2;
				warn		  := warn_compass2;
   msg := msg || ' 2';

--	901 N E I30 / 901 E N I30
			elsif	part.text <> item.name		
			and	prev.text <> previ.name

			and	addr_audit not like warn_unit  then
				part.role 	:= is_prefix;
				redo_role	:= is_unit;
				ndx		:= prev_idx;
				twin_idx	:= prev_idx;
				warn		:= warn_unit;
   msg := msg || ' 3';
			end if;
		end if;

--	===============================================
--	after street name

	else
   msg := msg || ' N>';

--	===============================================
--	street type 

		if	item.class	= is_type_item
		and	is_alone > 0				then
			part.role  := is_type;
   msg := msg || ' typ';

--	901 Walnut Cir E Rd
			if	type_idx > 0			then
				redo_role	:= is_name;			
				ndx		:= name_idx + name_count;
				twin_idx	:= type_idx;
   msg := msg || ' 1';
			end if;
				
--	===============================================	
--	street suffix

		elsif	item.class	= is_compass_item
		and	is_alone > 0				then
   msg := msg || ' sf';

--	901 Ave E
			if	previ.standard = 'AVE'		then
				part.role := is_name;
				item.name := item.standard;

--	901 Country Club E
			elsif	suffix_idx = 0			then	
				part.role := is_suffix;			
   msg := msg || ' 1';

--	901 I30 N E  => 901 I30 NE 
			elsif	compass2 > has_space	
			and	addr_audit not like warn_compass2 then
				part_entry(prev_idx).role := is_ignore;
				part.role	  := is_suffix;		
				part.text	  := compass2;
				item.standard := compass2;
				warn		  := warn_compass2;
   msg := msg || ' 2';

			elsif	compass2 is not null		then	

--	901 Park East N
				if	prev.text = previ.name		
				or	addr_audit like warn_unit then
					part.role 	:= is_suffix;
					redo_role	:= is_name;
					ndx		:= prev_idx;
					warn		:= warn_suffix;

   msg := msg || ' 3';
--	901 I30 N E / 901 I30 E N
				else
					part.role	:= is_unit;		
					warn		:= warn_unit;
   msg := msg || ' 4';
				end if;

			else							
--	901 Walnut E Cir S
				part.role	:= is_unit;
				warn		:= warn_unit;
   msg := msg || ' 5';
			end if;
		end if;

	end if;
	end if;

--	===============================================	
--	other redo

--	#A 10 Bldg 
	if	part.role = is_code					
	and	prev.role = is_unit2			then
		ndx		:= unit2_idx + unit2_count - 1;
		redo_role	:= is_unit1;
   msg := msg || ' $u';


--	11901 STATE HIGHWAY 66
	elsif	part.kind	 = is_numeric
	and	prev.width	 > code_min
	and	name_count	 > 0
	and	allow_unit	 > 0	
	and	prev.field	 = is_name 
	and (	previ.class	 = is_highway_item
	or	previ.standard in ('FRWY', 'HWY')		)
	and	addr_audit not like warn_trailer	then
		part.role	:= is_name;
		ndx		:= prev_idx;
		redo_role	:= is_name;
   msg := msg || ' =tn';

	end if;

--	===============================================	
--	resolve unassigned role

  msg1 := part.text || next_kind || is_punctuation || name_idx;

	if	part.role is null		then

		if	part.kind >= is_punctuation			then
			if	prev.what in (is_name, is_unit)	then
				part.role := prev.role;
   msg := msg || ' =p';

			elsif	name_idx  > 0	
			and 	part.kind >= is_slash			then
				part.role := is_unit;
   msg := msg || ' =sl';
			
			else							
				part.role := is_ignore;
   msg := msg || ' =ig';
			end if;


--	11901 30
		elsif	item.class	= is_highway_item		then
			part.role  := is_name;
			item.name  := null;
   msg := msg || ' =hm';

--	11901 30 105
		elsif	prev.role	= is_name		
		and	part.kind	= is_numeric
--		and	prev.kind	= is_numeric 
		and	allow_unit	> 0				then
			part.role  := is_unit;
   msg := msg || ' =hu';

--	901 carriagehouse e-4						-- jun 2002	
		elsif	next_kind  >= is_punctuation
		and	part.before = is_space
		and	name_idx   >  0	
		and	name_idx   <  idx	
		and	allow_unit >  0				then
			part.role  := is_unit;
   msg := msg || ' =up';

		elsif	is_ending > 0				then
			part.role := is_unit; 
   msg := msg || ' =eu';

		else
			part.role := is_name;
   msg := msg || ' =m';
		end if;
	end if;

--	===============================================	
--	ignore duplicate text

	if	ndx < idx
	and	twin_idx > 0							then
   msg := msg || ' tw';

		if	item.standard = item_entry (twin_idx).standard
		or	part.text	  = part_entry (twin_idx).text	then
			part.role	:= is_ignore;
			redo_role	:= null;
			ndx 		:= idx;
   msg := msg || ' 1';
		end if;
	end if;		

--	===============================================	
--	prepare for redo

	if	part.what is null			then
		part.what := part.role;
	end if;

   msg := msg || ';';

	if	ndx < idx				then
		part_entry (idx)	:= part;
		item_entry (idx)	:= item;
   msg := msg || ' put';

		prec			:= part_entry (ndx - 1);
		if	prec.kind >= is_punctuation	then
			prev		:= part_entry (ndx - 2);
		else
			prev		:= prec;
		end if;
	end if;

--	===============================================	
<<process_role>>

	if	redo_role is not null		then
		part	:= part_entry (ndx);
		item	:= item_entry (ndx);
   msg := msg || ' get';

		max_redo	:= max_redo - 1;
		if	max_redo < 0		then
			warn	:= is_redo_error;
			exit;
		end if;

		if	part.field = 0		then
   msg := msg || ' f0';
			goto	completed_part;
		end if;
	end if;

--	===============================================	
--	if redo, then remove old "role pointer"  

	if	ndx < idx					then
--	and	redo_role <> part.role			then

		audit (part.role).add := has_dot;

		if	part.role = is_type		then
			type_idx := 0;
   msg := msg || ' -t';

		elsif	part.role = is_prefix		then
			prefix_idx := 0;
   msg := msg || ' -p';

		elsif	part.role = is_suffix		then
			suffix_idx := 0;
   msg := msg || ' -s';

		elsif	part.role = is_number		then
			number_idx := 0;
   msg := msg || ' -n';


		elsif	part.role = is_name		then
			name_count := name_count - 01;
   msg := msg || ' -m';
			if	part.kind <= is_numeric	then
				name_occur := name_occur - 01;
   msg := msg || ' 1';
			end if;


		elsif	part.role = is_unit1		then
			unit1_count := unit1_count - 01;
   msg := msg || ' -u1';
			if	part.kind <= is_numeric	then
				unit1_occur := unit1_occur - 01;
   msg := msg || ' 1';
			end if;

		elsif	part.role = is_unit2		then
			unit2_count := unit2_count - 01;
   msg := msg || ' -u2';
			if	part.kind <= is_numeric	then
				unit2_occur := unit2_occur - 01;
   msg := msg || ' 1';
			end if;
		end if;
	end if;

--	===============================================	

	if	ndx < idx					then
		part.role := redo_role;
		part.what := redo_role;
   msg := msg || ' redo';
	end if;

--	===============================================	
--	set code & unit

	if	part.what = is_code
	and	part.role = is_code			then			--	new
		if	code1_idx + unit1_idx = 0	then
			part.role := is_code1;
   msg := msg || ' =c1';
		else
			part.role := is_code2;
   msg := msg || ' =c2';
		end if;


	elsif	part.what = is_unit
	and	part.role = is_unit			then			--	new

		if	code2_idx > 0
		or	unit2_occur > 0			then
			part.role  := is_unit2;
   msg := msg || ' =u21';

		elsif	unit1_occur = 0			then
			part.role  := is_unit1;
   msg := msg || ' =u11';

		elsif	prec.what  <> is_unit
		or ( 	prec.kind  <= is_numeric  
		and	part.before = is_space	)	then
			part.role  := is_unit2;
   msg := msg || ' =u22';

		else
			part.role  := is_unit1;
   msg := msg || ' =u12';
		end if;

	end if;

--	===============================================	
--	punctuation

	if	prec.kind > is_punctuation		then
		part.before := null;					
	end if;

	if	part.before = is_punctuation		then
		item.class := null;
	end if;

	if	part.kind >= is_punctuation		then
		part.before := null;					
	end if;

	if	part.kind  = is_dot			then
		part.text := has_space;
	end if;

--	===============================================	
--	set occurrence & length

	if	part.role = is_name		then
		name_count := name_count + 01;
   msg := msg || ' +m';
		if	part.kind <= is_numeric	then
			name_occur	:= name_occur + 01;
   msg := msg || ' +';
		end if;

	elsif	part.role = is_unit1		then
		unit1_count := unit1_count + 01;
   msg := msg || ' +u1';
		if	part.kind <= is_numeric	then
			unit1_occur	:= unit1_occur + 01;
   msg := msg || ' +';
		end if;

	elsif	part.role = is_unit2		then
		unit2_count := unit2_count + 01;
   msg := msg || ' +u2';
		if	part.kind <= is_numeric	then
			unit2_occur	:= unit2_occur + 01;
   msg := msg || ' +';
		end if;

	end if;

--	===============================================	
--	set role pointer

	if	part.role	= is_name
	and	name_count = 01			then
		name_idx := ndx;
   msg := msg || ' @m';

	elsif	part.role = is_number		then
		number_idx := ndx;
   msg := msg || ' @n';

	elsif	part.role = is_type		then
		type_idx := ndx;
   msg := msg || ' @t';

	elsif	part.role = is_prefix		then
		prefix_idx := ndx;
   msg := msg || ' @p';

	elsif	part.role = is_suffix		then
		suffix_idx := ndx;
   msg := msg || ' @s';

	elsif	part.role = is_code1		then
		code1_idx := ndx;
   msg := msg || ' @c1';

	elsif	part.role = is_code2		then
		code2_idx := ndx;
   msg := msg || ' @c2';

	elsif	part.role	 = is_unit1
	and	unit1_count = 01			then
		unit1_idx  := ndx;
   msg := msg || ' @u1';

	elsif	part.role	 = is_unit2
	and	unit2_count = 01			then
		unit2_idx  := ndx;
   msg := msg || ' @u2';
	end if;

--	===============================================	
--	audit when field role differs from assigned role

	if	part.role <> part.field
	and	part.kind <= is_hash
	and	part.role  > 0
	and	part.field > 0				then
		audit (part.field).del	:= audit (part.field).role;
		audit (part.role). add	:= audit (part.role). role;
   msg := msg || ' aud';
	end if;

--	===============================================	
<<set_warning>>

--	exit part_loop when warn >= is_error;

	if	warn is not null
	and	warn_count < max_warns		then
		warn_count	:= warn_count + 01;
		warning	:= warning || warn;
		warn		:= null;
   msg := msg || ' wrn';
	end if;

	if	warn_exit  > 0			then
		warn_exit := 0;
		exit;
	end if;

--	===============================================	
<<completed_part>> 

   msg := msg || ' keep';

	part_entry (ndx) := part;
	item_entry (ndx) := item;

	prec		:= part;
	prec_idx	:= idx;

	if	part.kind <= is_numeric	then	
		prev		:= part;
		previ		:= item;	
		prev_idx	:= idx;
	end if;

--	===============================================	
   msg := msg || ' *';

	if	do_trace <> 0	then	-- at end loop
		if	item.possible is not null	then
			item_count := item_count + 01;
		end if;
	end if;

	if	do_trace > 0	then	-- at end loop

		if	redo_role is not null		then
			dbms_output.put_line (' ');
			dbms_output.put_line ('ADDR |' || address		||'|');
			dbms_output.put_line ('TEXT |' ||part.text	||'|');
		end if;

		dbms_output.put_line (' ');
		dbms_output.put_line ('role |' ||'n=' ||number_idx ||'\p='||prefix_idx 
							 ||'\m='||name_idx   ||':'  ||name_occur ||','	 ||name_count
							 ||'\t='||type_idx   ||'\s='||suffix_idx
							 ||' \c='||code1_idx  
							 ||'\u=' ||unit1_idx  ||':'  ||unit1_occur||','  ||unit1_count
							 ||' \k='||code2_idx 
							 ||'\v=' ||unit2_idx  ||':'  ||unit2_occur||','  ||unit2_count	||'|');

		dbms_output.put_line (' ');
		dbms_output.put_line ('flow |'|| ltrim(msg)	||'|');
		dbms_output.put_line (' ');

	if	redo_role is not null		then
		dbms_output.put_line ('prev |' ||prev.text ||'\'||prev.before||'\'||prev.kind ||'\'||prev.what||'\'
							 ||prev.role ||'\'||prev.field ||'\'||prev.width	||'|');
		dbms_output.put_line ('prec |' ||prec.text ||'\'||prec.before||'\'||prec.kind ||'\'||prec.what||'\'
							 ||prec.role ||'\'||prec.field ||'\'||prec.width	||'|');
	end if;

		dbms_output.put_line ('part |' ||part.text ||'\'||part.before||'\' ||part.kind  ||'\'||part.what||'\'
							 ||part.role||'\' ||part.field ||'\' ||part.width ||'|	'	
							 || '(text/before/kind/what/role/field/width)'	);

		dbms_output.put_line (' ' );
		dbms_output.put_line ('step |' ||'idx='|| idx  ||'\ndx='||ndx
							 ||'\redo='||redo_role ||'\warn='||warn 	||'|');
		dbms_output.put_line ('cntl |' ||'alone='||is_alone  ||'\end=' ||is_ending
							 ||'\bef=' ||before
							 ||'\acu=' ||allow_code_unit||'\ac='||allow_code||'\au='||allow_unit
							 ||'\only='||unit_only		||'|');

		if	msg1 is not null		then
			dbms_output.put_line ('msg1 |'||msg1	||'|');
			end if;
		if	msg2 is not null		then
			dbms_output.put_line ('msg2 |'||msg2	||'|');
			end if;
		if	msg3 is not null		then
			dbms_output.put_line ('msg3 |'||msg3	||'|');
			end if;

		dbms_output.put_line (stars);

	end if;

	msg	:= null;
	msg1	:= null;
	msg2	:= null;
	msg3	:= null;

--	===============================================	
--	if redo, then do next part

	if	ndx  < idx				then
		ndx := ndx + 01;
		goto	process_role;
	end if;

--	===============================================	
<<end_loop>>

	if	name_count > 0
	and	part.role  > is_name		then
		is_ending	:= 1;
   msg := msg || ' end';
	end if;

	if	part.role >= is_code1 
	and	name_count > 0			then
		unit_only	:= 1;
   msg := msg || ' only';

	end if;

end loop;

--	===============================================	
--	special cases

--	901 ST.JAMES
	if	part_entry (name_idx).text  = 'ST'		then
		item_entry (name_idx).class := null;
	end if;

--	===============================================	
--	prepare final results
		
	form_num	:= part_entry(number_idx).text;
	form_type	:= nvl(item_entry(type_idx).  standard,' ');
	form_pfx	:= nvl(item_entry(prefix_idx).standard,' ');
	form_sfx	:= nvl(item_entry(suffix_idx).standard,' ');

	form_code1	:= nvl(item_entry(code1_idx). standard, keep_code1);
	form_code2	:= nvl(item_entry(code2_idx). standard, keep_code2);

	trim		:= has_space || has_dash || has_dot;
--	===============================================	
--	assemble address name

	ndx := name_idx;
	while name_count > 0		loop

		if	part_entry (ndx).role > 0				then

			if	ndx > name_idx
			and	part_entry (ndx).before = is_space		then
				form_name := form_name || has_space;
			end if;

			if	item_entry (ndx).class in (is_compass_item, is_type_item)	then		
				form_name := form_name || item_entry (ndx).name;
			else
				form_name := form_name || part_entry (ndx).text;
			end if;

		end if;

		ndx		:= ndx + 01;
		name_count	:= name_count - 01;

	end loop;

	form_name	:= nvl(ltrim(rtrim (form_name, trim),trim),has_space);

--	===============================================	
--	assemble address units

	ndx := unit1_idx;
	while unit1_count > 0			loop

		if	ndx > unit1_idx
		and	part_entry (ndx).before = is_space		then
			form_unit1 := form_unit1 || has_space;
		end if;

		form_unit1	:= form_unit1 || part_entry (ndx).text;
		ndx		:= ndx + 01;
		unit1_count	:= unit1_count - 01;
	end loop;


	ndx := unit2_idx;
	while	unit2_count > 0			loop

		if	ndx > unit2_idx
		and	part_entry (ndx).before = is_space		then
			form_unit2 := form_unit2 || has_space;
		end if;

		form_unit2	:= form_unit2 || part_entry (ndx).text;
		ndx		:= ndx + 01;
		unit2_count	:= unit2_count - 01;
	end loop;

	form_unit1	:= nvl(ltrim(rtrim (form_unit1, trim),trim),has_space);
	form_unit2	:= nvl(ltrim(rtrim (form_unit2, trim),trim),has_space);

--	===============================================	
<<final>>

	if	do_trace <> 0		then	-- at return
		dbms_output.put_line (stars);

		if	warn > is_error	then
			dbms_output.put_line (' ');
			dbms_output.put_line ('flow |'|| ltrim(msg)	||'|');
			dbms_output.put_line (' ');
		end if;

		dbms_output.put_line ('input   |'|| 
			rpad(addr_num   ||'\'||addr_pfx  ||'\'||addr_name ||'\'||addr_type||'\'||addr_sfx|| '|', 40) 
			|| '|'|| addr_code1 ||'\'||addr_unit1||'\'||addr_code2||'\'||addr_unit2||'|' ); 
		dbms_output.put_line ('        |'|| addr_audit || '|'); 
	end if;


	if  (	length(form_name)  < name_min		and form_name >= 'A')
	or	length(form_name)  > name_limit
	or	length(form_unit1) > unit_limit
	or	length(form_unit2) > unit_limit	then
		warn := is_length_error;

	elsif	translate (form_name, 'x'||reject, 'x') <> form_name	then
		warn := is_format_error;

	end if;

	addr_audit		:= null;	
	for x in 1..9	loop
		addr_audit	:= addr_audit || nvl( upper(audit(x).del), nvl(audit(x).add, has_dot) );
	end loop;

	if	addr_audit = upper(addr_audit)	then
		addr_audit:= empty_audit;
	end if;

	if	nvl (form_num,'0')   <= '0'				-- oct 2003			
	and	nvl (form_code1,' ') <> duplex_code	
	and	substr (addr_audit, 06) > '....'	then		
		warn := is_non_address;
	end if;

	if	warning is not null			then
		warning := ' ' || translate (warning, '/%', '\');
	end if;

	if	warn >= is_error		then				-- oct 2003  (relocate)
		address	:= '!'||warn ||' ';
	else
		address	:= null;
		addr_num	:= form_num;
		addr_pfx	:= form_pfx;
		addr_name	:= form_name;
		addr_type	:= form_type;
		addr_sfx	:= form_sfx;
		addr_code1	:= form_code1;
		addr_unit1	:= form_unit1;
		addr_code2	:= form_code2;
		addr_unit2	:= form_unit2;
	end if;

	addr_audit := address || addr_audit || warning;

	if	do_trace <> 0	then	-- at return
		if	msg1 is not null	then
			dbms_output.put_line (msg1);
		end if;

		dbms_output.put_line ('output  |'|| 
			rpad(addr_num ||'\'||addr_pfx||'\'||addr_name||'\'||addr_type||'\'||addr_sfx|| '|', 40) 
			|| '|'||addr_code1||'\'||addr_unit1||'\'||addr_code2||'\'||addr_unit2||'|' ); 

		dbms_output.put_line ('audit   |'|| addr_audit || '|'); 

		dbms_output.put_line ('puncs   |'|| length(ignore||reject||punctuation) || '|'); 
		dbms_output.put_line ('items   |'|| item_count || '|'); 

		if	msg1 is not null		then
			dbms_output.put_line ('msg1 |'||msg1|| '|');
		end if;
		if	msg2 is not null		then
			dbms_output.put_line ('msg2 |'||msg2|| '|');
		end if;
		if	msg3 is not null		then
			dbms_output.put_line ('msg3 |'||msg3|| '|');
		end if;
	end if;

	if	do_trace < 0	then
		dbms_output.put_line (' '); 
	end if;

	return;
end;

--	===============================================	
/*	TASKS

	punctuation			ignore / reject / accept = 32
	punctuation			kind = class; text = particular

	slash				fraction / intersection
	ampersand			duplex / intersection

	warning			duplicate part
	punctuation			comment signal

	adrItem			punctuation / item_min
	avenue			secondary class
	st				secondary class
	hwy				secondary class

	varray			faster?

--	===============================================	

	heiroglyphs			varchar2(20) := '~!?$%^*_+=|';			
	delimits			varchar2(20) := '-,.;:`''' || chr(09);
	dividers			varchar2(20) := '()[]{}<>"';
	delimiters			varchar2(40) := delimits || dividers;
	spaces			char(40)	 := ' ';

*/			
--	===============================================	