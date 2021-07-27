	set echo	off;
	set timing	off;

--	jan 05 2004   modify

--	================================================================
--	address verification procedure called by adrFinder VB app
--	================================================================
/*
--	----------------------------------------------------------------
--	TASKS

	unique fuzzy		treated as original reduced (wallingford)

	package spec		constants

*/
--	================================================================
--	reduced name is the basis of "same" names
--	any other names are "like" names
--	================================================================
  
--	Create or replace	package body	ADR_FINDER		as 

	Create or replace	package body	ADR_FINDER_01	as 

	do_test			binary_integer	:= 0;

	weight_same_name		binary_integer	:= 30;		-- dec 2003
	weight_like_name		binary_integer	:= 20;
	weight_near_name		binary_integer	:= 10;

	weight_soft			binary_integer	:= 01;		-- soft qual match

--	weight_address		binary_integer	:= 003;
--	weight_block		binary_integer	:= 002;
--	weight_street		binary_integer	:= 001;

	address_entity		char			:= 'A';		-- jan 2004
	block_entity		char			:= 'B';
	street_entity		char			:= 'S';

	same_alias			varchar2(10)	:= rtrim(adr_find_01.Reduced_Score);

	safe_alias			binary_integer	:= 7;			-- feb 2004
	fair_alias			binary_integer	:= 4;
	risk_alias			binary_integer	:= 2;

	error_entry			varchar2(10)	:= '10';
	error_name			varchar2(10)	:= '0';

	good_fuzzy_score		binary_integer	:= 120;
	max_fuzzy_score		binary_integer	:= 250;
	soundex_leng		binary_integer	:= 03;
	read_max			binary_integer	:= 100;
	status_stop			varchar2(05)	:= 'stop';

	option_parse		varchar2(10)	:= '%parse%';	--  parse input
	option_all_names		varchar2(10)	:= '%name%';	--  all name searches
	option_far_number		varchar2(10)	:= '%far%';		--  all numbers on street
	option_near_number	varchar2(10)	:= '%near%';	--  all numbers on near blocks
	option_batch_mode		varchar2(10)	:= '%batch%';	--  limited output
--	option_full_mode		varchar2(10)	:= '%new%';		--  TEMPORARY

	spec_fuzzy_alias		varchar2(10)	:= '$alias';

--	================================================================

	do_parse		boolean;
	do_all_names	boolean;
	do_near_number	boolean;
	do_far_number	boolean;
	do_batch_mode	boolean;
--	do_full_mode	boolean;

	lo_num		binary_integer;
	hi_num		binary_integer;
	lo_block		binary_integer;
	hi_block		binary_integer;
	parity		binary_integer;

	this_num		binary_integer;
	this_pfx		varchar2(02);
	this_name		varchar2(40);
	this_type		varchar2(04);
	this_sfx		varchar2(02);
	this_code1		varchar2(10);
	this_unit1		varchar2(20);
	this_code2		varchar2(10);
	this_unit2		varchar2(20);

	reduced_name	varchar2(40);
	compact_name	varchar2(40);
	input_name		varchar2(40);
	second_name		varchar2(40);
	same_name1		varchar2(40);
	same_name2		varchar2(40);
	this_prefer		varchar2(01);
	best_prefer		varchar2(01);

	also_array		varchar$v;

	fuzzy1		varchar2(20);	
	fuzzy2		varchar2(20);	
	fuzzy3		varchar2(20);	
	fuzzy4		varchar2(20);	

	alias_method	varchar2(10);
	alias_match		varchar2(10);
	alias_weight	binary_integer;
	alias_count		binary_integer;

	entity		char;
	read_count		binary_integer;
	score			binary_integer;
	fuzzy_score		binary_integer;
	best_score		binary_integer;
	best_count		binary_integer;
	best_idx		binary_integer;
	idx			binary_integer;

	text1			varchar2(2000);
	text2			varchar2(2000);
	count1		binary_integer;
	count2		binary_integer;

--	================================================================
	cursor READ_STREET_BLOCK_ADDRESS		is

--	truncate table	plan_table		reuse storage;
--	explain plan	set statement_id = 'xxx'   for

	select	--+  cache (s)
--			distinct

			sign(nvl(a.addr_num,   0))		address_match,
			sign(nvl(b.addr_block, 0))		block_match,

			decode(s.addr_name, same_name1,'1', same_name2,'1',  '2')	same_name,

			s.addr_name, 						
			s.addr_type,  s.addr_pfx,   s.addr_sfx,		
			nvl(b.addr_block,0)		addr_block,				
			nvl(a.addr_num,  0)		addr_num,	

			s.street_id,
			b.block_id,
			a.addr_id,
			a.parcel_id,
			s.addr_compact					-- dec 2003

	from		adrStreets		s,
			Block			b,
			cdreladr		a

	where	(	s.addr_compact =	compact_name
	or		s.addr_name	   =	this_name
	or		s.addr_name	like	second_name
	or		s.addr_name	in ( fuzzy1, fuzzy2, fuzzy3, fuzzy4  )   
	or		s.addr_name in ( also_array(1), also_array(2), also_array(3) )
		)

	and		s.addr_name	= 	b.addr_name (+)
	and		s.addr_type = 	b.addr_type (+)
	and		s.addr_pfx	= 	b.addr_pfx  (+)
	and		s.addr_sfx	=	b.addr_sfx  (+)
	and		b.addr_block  (+) between lo_block  and hi_block

	and		b.addr_name	= 	a.addr_name (+)
	and		b.addr_type = 	a.addr_type (+)
	and		b.addr_pfx	= 	a.addr_pfx  (+)
	and		b.addr_sfx	=	a.addr_sfx  (+)

	and		trunc(a.addr_num(+),-2)	= b.addr_block
	and		a.addr_num (+)	between lo_num and hi_num

	and		rtrim(a.unit_type (+))	is null
--	and		rtrim(a.unit_num  (+)) 	is null	

	order by	1 desc, 2 desc, 3, 04,05,06,07, 8, 09;

--	select * from explain_plan;

--	RESULT	read_street_block_address%rowtype;		--  TEMPORARY

--	================================================================

--	================================================================
Procedure VERIFY_ADDRESS
(          
	num_in		in	varchar2,           -- changed from number	jun 2004
	pfx_in		in	varchar2,         
	name_in		in	varchar2,       
	type_in		in	varchar2,         
	sfx_in		in	varchar2,         

	num_out		out	adr_num,     
	pfx_out		out	adr_prefix,    
	name_out		out	adr_name,    
	type_out		out	adr_type,      
	sfx_out		out	adr_suffix,    

	parcel_id_out	out	adr_parcel,
	addr_id_out		out	adr_id,
	status_out		out	adr_status,

	best_option	   in	out	varchar2,
	best_choice	   in out	number
)    
Is   

Begin

	if	do_test > 0		then
	dbms_output.put_line ( 'ADRFINDER' );
	null;
	end if;

--	<00>	==============================================================

	this_name	:= upper(rtrim (name_in, '. '));
	this_type	:= type_in;
	this_pfx	:= pfx_in;
	this_sfx	:= sfx_in;

	text1	:= rtrim(num_in,'. ');
	if	translate (text1, 'x0123456789', 'x') is null		then
		this_num	:= text1;
	else
		this_num	:= null;
	end if;

--	if	best_option is not null		then
		do_parse		:= best_option like	option_parse;
		do_all_names	:= best_option like	option_all_names;
		do_near_number	:= best_option like	option_near_number;	
		do_far_number	:= best_option like	option_far_number;
		do_batch_mode	:= best_option like	option_batch_mode;
--		do_full_mode	:= best_option like	option_full_mode;
--	end if;

--	<10>	==============================================================
--	parse input 

	if	do_parse			then
		adr_parse_address ( this_num,	  this_pfx,   this_name,   this_type,   this_sfx,
					  this_code1, this_unit1, this_code2, this_unit2,
					  text1	);
	end if;

	input_name	:= this_name;


--	<15>	==============================================================

/*
	if	not do_full_mode 			then
		num_out    (1)	:= null;	
		pfx_out    (1)	:= null;
		name_out   (1)	:= null;
		type_out   (1)	:= null;
		sfx_out    (1)	:= null;
		parcel_id_out(1)	:= null;
		addr_id_out(1)	:= null;
		status_out (1)	:= 6;	
	end if;
*/

	compact_name	:= ADR_COMPRESS_NAME (this_name, '4');
	same_name1		:= null;
	same_name2		:= null;
	best_prefer		:= null;

	second_name		:= null;
	fuzzy1		:= null;
	fuzzy2		:= null;
	fuzzy3		:= null;
	fuzzy4		:= null;
	fuzzy_score		:= null;

	also_array		:= varchar$v (' ',' ',' ',' ',' ',' ',' ');	--  review

	alias_match		:= null;
	alias_weight	:= null;
	alias_method	:= null;			-- jan 2004
	alias_count		:= 0;

 	read_count		:= 0;
	best_score		:= 0;
	best_count		:= 0;
	best_idx		:= 0;
 	idx			:= 0;

	if	this_name is null			then
		idx			:= 0;
		best_choice		:= error_entry;
		best_option		:= ' ';
		goto	final_result;
	end if;

--	<20>	================================================================
--	qualifier corrections per Item table

	this_type	:= garland.Adr_Find_01.FIND_QUALIFIER (this_type);
	this_pfx	:= garland.Adr_Find_01.FIND_QUALIFIER (this_pfx);
	this_sfx	:= garland.Adr_Find_01.FIND_QUALIFIER (this_sfx);

--	<30>	================================================================
--	street corrections per Alias table

<<alias_matcher>>

--	garland.ADR_FIND.FIND_ALIAS
	garland.ADR_FIND_01.FIND_ALIAS

	( 
		this_num,		
		this_pfx,		
		this_name,		
		this_type,		
		this_sfx,		

		second_name,		--  1st & 2nd have same name+qual score
		also_array,			--  eg. transpose, rhyme
		alias_method,		--  eg. tpush, tpull
		alias_match,		--  name + qualifiers + count + alias
		alias_weight		--  eg. 1900
	);

	if	alias_match >= same_alias				-- nov 2003
	and	fuzzy1 is null				then
		same_name1	:= this_name;
		same_name2	:= second_name;
	end if;


	if	do_test > 0		then
	dbms_output.put_line ( 'ALIAS' );
	dbms_output.put_line ( 'input   '	|| input_name	||'/'|| compact_name 	);			
	dbms_output.put_line ( 'names   '	|| this_name	||'/'|| second_name	);			
	dbms_output.put_line ( 'also    '	|| also_array (1)	);			
	dbms_output.put_line ( 'params  '	|| alias_method	||'/'|| alias_match ||'/'|| alias_weight);			
	null;
	end if;



--	<40>	================================================================
--	fuzzy match names

	if	do_test > 0		then
	dbms_output.put_line ( '<40> ' || alias_match ||' ' || same_alias  ||' '|| compact_name);
	null;
	end if;

	if	alias_match >= same_alias				-- nov 2003
	or	compact_name = 'fuzzy'			then
		null;
	else
		text1	:= input_name;
		text2	:= spec_fuzzy_alias;

		garland.COMPARE_NAMES (text1, text2, fuzzy_score, count2);		-- dec 2003

		if	fuzzy_score > max_fuzzy_score		then
			text2 := null;
		elsif	do_all_names				then
			text2 := text1 || text2;
		else
			text2	:= text1;
		end if;

		count1 := nvl(length(text2),0) / 20;					-- dec 2003

		if	count1 > 0			then
			fuzzy1	:= rtrim(substr (text2, 01,20));
		if	count1 > 1			then
			fuzzy2	:= rtrim(substr (text2, 21,20));
		if	count1 > 2			then
			fuzzy3	:= rtrim(substr (text2, 41,20));
		if	count1 > 3			then
			fuzzy4	:= rtrim(substr (text2, 61,20));
		end if;
		end if;
		end if;
		end if;


	if	do_test > 0		then
	dbms_output.put_line ( 'FUZZY' );
	dbms_output.put_line ( 'score   '	|| fuzzy_score ||'/'|| text2 );
	dbms_output.put_line ( 'fuzzy   '	|| fuzzy1 ||'/'|| fuzzy2 ||'/'|| fuzzy3 ||'/'|| fuzzy4);	
	null;
	end if;

		if	alias_weight is null			--  if   alias compact match failed
		and	fuzzy_score <= good_fuzzy_score	--  and  acceptable fuzzy score		-- jan 2004	
		and	count1  = 1			then		--  and  best fuzzy is unique
			this_name	  := fuzzy1;		--  then do alias match using best fuzzy
			compact_name := 'fuzzy';
			goto	alias_matcher;
		end if;

	end if;

--	<60>	================================================================
--	soundex name

	if	alias_weight is null			-- no alias match
	and	fuzzy1 is null		then		-- no fuzzy match
		do_all_names := true;
	end if;
	
	if	do_all_names					then
		second_name	:= rtrim(rpad (input_name, soundex_leng)) || '%';
	end if;
						
--	<70>	================================================================
--	block & address ranges

<<set_ranges>>

	if	nvl(this_num, 0) = 0		then
		this_num	:= 0;
		lo_num	:= null;
		hi_num	:= null;
	else
		lo_num	:= this_num;
		hi_num	:= this_num;
	end if;

	if	do_far_number
	and	second_name is null		then
--	and	alias_count = 01			then
		lo_num	:= 0;
		hi_num	:= 99999;

	elsif	do_near_number
	and	second_name is null
--	and	alias_count = 01
	and	lo_num > 0				then
		garland.FIND_NEAR_RANGE (this_name, lo_num, hi_num);
	end if;

	if	this_num <> lo_num		then
		second_name		:= null;
		fuzzy1		:= null;
		fuzzy2		:= null;
		fuzzy3		:= null;
		fuzzy4		:= null;
		also_array (1)	:= ' ';
		also_array (2)	:= ' ';
		also_array (3)	:= ' ';
		if	do_far_number		then
			compact_name := null;
		end if;
	end if;

	parity	:= mod  (this_num,2);
	lo_block	:= trunc(lo_num, -2);
	hi_block	:= trunc(hi_num, -2);

	if	do_test > 0		then
	dbms_output.put_line ( 'RANGE' );
	dbms_output.put_line ( 'this    '	|| input_name	||'/'|| this_name ||'/'|| second_name);			
	dbms_output.put_line ( 'range   '	|| lo_num ||'-'|| hi_num ||'     '|| lo_block ||'-'|| hi_block);			
	null;
	end if;

--	<80>	================================================================


for look in  read_street_block_address		loop

	-- tr$_read	:= look;

	read_count	:= read_count + 01;
	exit when	read_count > read_max;

	if	look.addr_name in (this_name, second_name)		then		-- jan 2004
		this_prefer := '*';
	elsif	look.addr_name in (fuzzy1, fuzzy2, fuzzy3, fuzzy4)	then
		this_prefer := '.';								-- jun 2004
	else
		this_prefer := null;
	end if;

--	------------------------------------------------------------------------------------------
--	Is cursor record an address, block, or street

	if	look.address_match = 1			then
		entity := address_entity;					-- dec 2003
	elsif	look.block_match	 = 1			then
		entity := block_entity;
	else
		entity := street_entity;
	end if;

	exit when	this_num <> lo_num		--  near / far
		and	entity > address_entity;

	if	do_test > 0		then
	dbms_output.put_line ( 'ENTITY' );
	dbms_output.put_line ( 'entity   /'	|| entity			||'/'|| score			);
	dbms_output.put_line ( 'name     /'	|| input_name		||'/'|| look.addr_name		);
	dbms_output.put_line ( 'match    /'	|| look.address_match	||'/'|| look.block_match	);
	null;
	end if;

--	------------------------------------------------------------------------------------------
--	How good is the name match								-- jan 2004

	score := 0;		
	exit when	alias_weight is null
		and	fuzzy_score is null;

	if	look.addr_name = input_name	
--	or	look.same_name = '1'						then
	or (	look.same_name = '1'	and alias_weight > 4)		then		--  TEST TEST TEST
		score	:= weight_same_name;

	elsif	this_prefer is null						then
		score	:= weight_near_name;

	elsif	alias_weight is not null					then
		score	:= weight_like_name;

	elsif	fuzzy_score <= good_fuzzy_score			
	and	this_prefer = '.'							then
		score	:= weight_like_name;

	else
		score	:= weight_near_name;
	end if;


/*
	if	look.addr_name = input_name					then
		score		:= score + weight_same_name;
	elsif	look.same_name = '1'						then
		score		:= score + weight_same_name;
	elsif	look.addr_compact = compact_name				then
		score		:= score + weight_like_name;
	elsif	fuzzy_score <= good_fuzzy_score			
	and	this_prefer = ' '							then
		score		:= score + weight_like_name;
	else
		score		:= score + weight_near_name;
	end if;
*/


	if	do_test > 0		then
	dbms_output.put_line ( 'NAME' );
	dbms_output.put_line ( 'score    /'	|| score		);
	dbms_output.put_line ( 'name     /'	|| input_name	||'/'|| look.addr_name	);
	dbms_output.put_line ( 'compact  /'	|| compact_name	||'/'|| look.addr_compact );
	dbms_output.put_line ( 'fuzzy    /'	|| fuzzy_score	||'/'|| good_fuzzy_score );
	null;
	end if;

--	------------------------------------------------------------------------------------------
--	How good is the qualifier match
--	Use only for best alias match, which may have improved the qualifiers

	if	this_type in (look.addr_type, ' ')		then			-- jan 2004
		score	:= score + weight_soft;
	end if;

	if	this_pfx in (look.addr_pfx,  ' ')		then
		score	:= score + weight_soft;
	end if;

	if	this_sfx in (look.addr_sfx,  ' ')		then
		score	:= score + weight_soft;
	end if;

	if	do_test > 0		then
	dbms_output.put_line ( 'QUALIFY' );
	dbms_output.put_line ( 'name 1,2 /' || this_name	||'/'|| second_name	);
	dbms_output.put_line ( 'type     /' || this_type	||'/'|| look.addr_type	);
	dbms_output.put_line ( 'pfx      /' || this_pfx		||'/'|| look.addr_pfx	);
	dbms_output.put_line ( 'sfx      /' || this_sfx		||'/'|| look.addr_sfx	);
	null;
	end if;

--	<90>	================================================================
--	best score
--	output arrays

<<analyze_score>>									-- dec 2003

--	if 	do_full_mode  or  entity >= weight_address 		then	

		idx	:= idx + 01;

		num_out      (idx)	:= ltrim(greatest (look.addr_num, look.addr_block),'0');	
		pfx_out      (idx)	:= look.addr_pfx;	
		name_out     (idx)	:= look.addr_name;
		type_out     (idx)	:= look.addr_type;	
		sfx_out      (idx)	:= look.addr_sfx;	

--		status_out   (idx)	:= score || entity || this_prefer;		-- jan 2004
		status_out   (idx)	:= score || entity;				-- jun 2004

		parcel_id_out(idx)	:= look.parcel_id;
		if	entity  = address_entity				then		-- dec 2003
			addr_id_out  (idx)	:= look.addr_id;
		elsif	entity  = block_entity					then
			addr_id_out  (idx)	:= look.block_id;
		else
			addr_id_out  (idx)	:= look.street_id;
		end if;

--		if not do_full_mode then status_out (idx) := 2; end if;
--	end if;

--	if	look.addr_name in (this_name, second_name)		then		-- dec 2003

		if	best_score < score					then
			best_score	:= score;
			best_count	:= 0;
			best_idx	:= idx;
			best_prefer	:= this_prefer;
		end if;

		if	best_score  = score					then
			best_count	:= best_count + 01;
		end if;
--	end if;	

	if	do_test > 0		then
	dbms_output.put_line ( 'SCORE' );
	dbms_output.put_line ( 'score    /'	|| score		||'/'|| best_score	||'/'|| best_count	);
	dbms_output.put_line ( 'idx      /'	|| idx		||'/'|| best_idx		 );
	null;
	end if;

end loop;

--	<100>	================================================================
--	best option & best choice

<<final_result>>

	idx			:= idx + 01;
	status_out (idx)	:= status_stop;

	if	read_count = 0			then
		best_choice := error_name;

	elsif	best_count = 1			then
		best_choice := best_idx;

	elsif	best_count > 1			then				-- dec 2003
		best_choice := - best_idx;

	else
		best_choice	:= 0;
	end if;

	if	best_prefer = '*'			then
		if	alias_weight >= safe_alias	then				-- dec 2003
			text1	:= '3';
		elsif	alias_weight >= fair_alias	then
			text1	:= '2';
		elsif	alias_weight >= risk_alias	then				-- jan 2004
			text1	:= '1';
		else
			text1	:= '0';							-- jan 2004
		end if;

		best_option	:= text1 || '.'|| alias_method;			-- dec 2003
	end if;

	if	do_test > 0		then
	dbms_output.put_line ( 'read='   || read_count  ||'  count='  || best_count );
	dbms_output.put_line ( 'option=' || best_option ||'  choice=' || best_choice);
	null;
	end if;

End	VERIFY_ADDRESS;

--	--------------------------------------------------------

End;	-- ADR_FINDER;

--	--------------------------------------------------------
