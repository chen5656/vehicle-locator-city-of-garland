	set echo 	off;
--	========================================================================

	create or replace	package body	garland.Find_Address		As

--	========================================================================
--	TASKS

--	Command = Select
--	entity		what is the better status: 1B3 or 1S0 ?

--	========================================================================
--	ENHANCE
--		Fuzzy/Soundex	when no Alias match
--		addr num		901A
--		Units			Display only
--	========================================================================

	do_trace			binary_integer	:= 0;

	this_num			binary_integer;
	this_pfx			varchar2(10);
	this_name			varchar2(40);
	this_type			varchar2(10);
	this_sfx			varchar2(10);

	input_name			varchar2(40);	-- per alias
	user_exact			varchar2(40);	-- per alias
	user_close			varchar2(40);	-- per alias
	look_like			varchar2(40);
	good_fuzzy			varchar2(1000);

	good_lo			varchar2(40);
	good_hi			varchar2(40);
	begin_lo			varchar2(40);
	begin_hi			varchar2(40);
	partial_lo			varchar2(40);
	partial_hi			varchar2(40);

	fetch_seq			binary_integer;
	lo_block			binary_integer;
	hi_block			binary_integer;
	lo_num			binary_integer;
	hi_num			binary_integer;

	alias_also			varchar2(80);
	alias_method		varchar2(10);
	alias_match			binary_integer;
	alias_count			binary_integer;
	alias_weight		binary_integer;
	alias_class			binary_integer;

	match_status		varchar2(10);
	best_status			varchar2(10);
	best_entity			char;
	best_class			binary_integer;
	best_qual			binary_integer;
	best_choice			binary_integer;
	best_count			binary_integer;

	first_letter		char;

	count1			binary_integer;
	count2			binary_integer;
	text1				varchar2(1000);
	text2				varchar2(1000);

	LINE				Address_Option;

--	========================================================================
	cursor	Read_Control	is

	select * 
	from		garland.Find_Address_Rule_Vw
	where		rule_name = text1;

	RULE		Read_Control%rowtype;
--	========================================================================

cursor	Read_GIS		is

	select	--+ first_rows

		sign(a.addr_num	+ 01) 				addr_group,		-- null or 01
		sign(b.addr_block + 01) + rule.display_block	blok_group,		-- null or 01
		n.name_class						name_class,		-- 1-4

		s.addr_pfx,   
		s.addr_name, 						
		s.addr_type,  
		s.addr_sfx,		

		nvl(b.addr_block, 0)	addr_block,				
		nvl(a.addr_num,   0)	addr_num,	

		x.addr2_pfx			x1_pfx,   
		x.addr2_name		x1_name, 						
		x.addr2_type		x1_type,  
		x.addr2_sfx			x1_sfx,		

		y.addr2_pfx			x2_pfx,   	
		y.addr2_name		x2_name, 						
		y.addr2_type		x2_type,  
		y.addr2_sfx			x2_sfx,		

		s.street_id,
		b.block_id,
		a.addr_id,
		a.parcel_id,
		x.intersect_id		intersect1_id,
		y.intersect_id		intersect2_id
	from
(
	select	addr_name, 
			min(name_class)  name_class	--	a name may arise in more than one name query		
	from
(
	select --+ index (s, adrStreets_pkey)
			Exact_class  Name_Class,	addr_name			-- class = 1
	from		garland.adrStreets
	where		addr_Name = User_Exact						-- revised name	
	or		addr_Name = Input_name						-- input name

	union											
	select --+ index (adrStreets adrStreets_x_Compact) index(adrStreets adrStreets_Pkey)
			Close_class,			addr_name			-- class = 2
	from		garland.adrStreets
	where		addr_Compact = User_Close					-- close to input	
	or		addr_Name between Partial_lo and Partial_hi		-- like alias partial

	union									
	select	--+ index(adrStreets adrStreets_Pkey)
			Good_class,				addr_name			-- class = 2
	from		garland.adrStreets
	where		addr_name	between Good_Lo and Good_Hi			-- near or far	
	and		instr (Good_Fuzzy , addr_name) > 0		

	union	
	select	Fair_class,				addr_name			-- class = 3
	from		garland.adrStreets
	where		instr (Alias_Also , addr_name) > 0		

	union										
	select	--+ index(adrStreets adrStreets_Pkey)
			Like_class,				addr_name			-- class = 4
	from		garland.adrStreets
	where		addr_name between Begin_Lo and Begin_Hi			-- near or far
	and		addr_name like Look_Like					-- User(%x%x%x)  Begin(%)

)							
	group by 	addr_name
)							N,
		garland.adrStreets		S,
		garland.Block			B,
		garland.cdrelADR			A,
		garland.Intersection		X,
		garland.Intersection		Y

	where		n.addr_name	=	s.addr_name

	and		s.addr_name	= 	b.addr_name (+)
	and		s.addr_type = 	b.addr_type (+)
	and		s.addr_pfx	= 	b.addr_pfx  (+)
	and		s.addr_sfx	=	b.addr_sfx  (+)
	and		b.addr_block (+)  between Lo_Block and Hi_Block

	and		b.addr_name	= 	a.addr_name (+)
	and		b.addr_type = 	a.addr_type (+)
	and		b.addr_pfx	= 	a.addr_pfx  (+)
	and		b.addr_sfx	=	a.addr_sfx  (+)
	and		b.addr_block =	trunc(a.addr_num(+), -2)

	and		a.addr_num (+)	between Lo_Num and Hi_Num
	and		rtrim(a.addr_bldg (+))	is null
--	and		rtrim(a.unit_type (+))	is null		-- not populated (2004)
	and		rtrim(a.unit_num  (+)) 	is null

	and		b.intersect1_id =	x.intersect_id (+)	
	and		b.intersect2_id =	y.intersect_id (+)	

	order by	1, 2, 	
			decode (sign(n.name_class - rule.display_upper), null, null, +1,2,  1),
			04,05,06,07, 8, 09;

	READ		Read_GIS%rowtype;

--	========================================================================

	procedure	Match_Alias_Table;

--	========================================================================

	procedure	MAIN
(
	user_num		in		varchar2,
	user_pfx		in		varchar2,
	user_name		in		varchar2,
	user_type		in		varchar2,
	user_sfx		in		varchar2,
	user_bldg		in		varchar2,
	user_unit		in		varchar2,
	
	control		in out	varchar2,
	choice		in out	number,
	occurs		in out	number,

	Address_Entry	out 		Address_Array,	

	Region_Entry	in out	Region_Array
)
	IS

--	========================================================================

	Region_List				Region_Array;

begin

--	<>	==============================================================

	this_name	:= upper(rtrim (user_name, '. '));
	this_type	:= nvl(user_type,' ');
	this_pfx	:= nvl(user_pfx, ' ');
	this_sfx	:= nvl(user_sfx, ' ');

	text1		:= rtrim(user_num,'. ');
	if	translate (text1, 'x0123456789', 'x') is null	then
		this_num	:= text1;
	else
		this_num	:= null;
	end if;

	input_name	 := this_name;
	first_letter := rpad(this_name,01);

	Region_List	:= Region_Entry;

--	<>	==============================================================
--	Initialization

	alias_class		:= null;
	good_fuzzy		:= null;
	good_lo		:= null;
	begin_lo		:= null;
	partial_lo		:= null;
	look_like		:= null;

	fetch_seq		:= 0;

	best_status		:= null;
	best_entity		:= null;
	best_class		:= null;
	best_qual		:= null;
	best_choice		:= null;
	best_count		:= null;

--	<>	==============================================================

	text1 := control;

	open	Read_Control;
	fetch	Read_Control		into Rule;
	if	read_control%notfound
	or	read_control%notfound is null		then
		control := 'ERROR - Invalid Address Control';
		close	Read_Control;
		return;
	end if;
	close	Read_Control;

	control := null;

--	<>	====================================================================
--	Alias Weight  determines the Acceptability Class of the User entry
--	Acceptability determines whether Immediate Acceptance is permitted
--	Could be used for both Interactive and Batch processing

	MATCH_ALIAS_TABLE;

	if	user_exact is not null				then
		input_name	:= user_exact;
	end if;

	if	alias_weight >= rule.alias_right		then
		alias_class  := right_class;	
	elsif	alias_weight >= rule.alias_good		then
		alias_class  := good_class;
	elsif	alias_weight >= rule.alias_fair		then
		alias_class  := fair_class;
	else
		alias_class  := poor_class;
	end if;

--	<>	====================================================================
--	Should fuzzy match be run if this_num does not occur in exact (right class) this_name?
--	What about other alias classes ?
--	rule.do_fuzzy_alias answers this question	

	if	rule.fuzzy_alias > 0			then
		select count(*)	
		into	 count1
		from	 garland.cdrelADR
		where	 addr_name	= this_name
		and	 addr_num	= this_num;
	else
		count1 := 0;
	end if;

	if	user_exact is nulL
	and	rule.fuzzy_per_class = exact_class		then
		null;
	elsif	count1 > 0						then
		if	alias_class > rule.fuzzy_alias 	then		-- how bad a name before fuzzy is used
			rule.fuzzy_good := 0;
		end if;
	end if;

	if	do_trace > 0	then
	null;
	dbms_output.put_line ('alias.fuzzy.good/' || alias_class ||'/'|| rule.fuzzy_alias ||'/'|| rule.fuzzy_good );
--	dbms_output.put_line ('          /' || '' ||'/'|| '' ||'/'|| '' ||'/'|| '' ||'/'|| '' );
	dbms_output.put_line (' ');
	end if;

--	<>	====================================================================
--	Fuzzy Name Match

	if	rule.fuzzy_good > 0				then
		text1	 := input_name;
		text2	 := null;
		count1 :=   rule.fuzzy_scope;			-- "far"  "merge good"		
		count2 := - rule.fuzzy_good;			-- highest good score

	if	do_trace > 0	then
	null;
	dbms_output.put_line ('Fuzzy In  /' || text1 ||'/'|| count1 ||'/'|| count2 ||'/alias class/'|| alias_class );
	end if;

		FIND_FUZZY_NAMES	(text1, text2, count1, count2);
--		COMPARE_NAMES	(text1, text2, count1, count2);

		if	count2 <= rule.fuzzy_good		then
			good_fuzzy	:= text1 || text2;
		elsif	count1 <= rule.fuzzy_good		then
			good_fuzzy	:= text1;
		end if;

	if	do_trace > 0	then
	null;
	dbms_output.put_line ('Fuzzy Out /' || text1 ||'/'|| text2 ||'/'|| count1 ||'/'|| count2 ||'/' );
	dbms_output.put_line ('          /' || good_fuzzy ||'/'|| length(text1) ||'/'|| '' ||'/'|| '' );
--	dbms_output.put_line ('          /' || '' ||'/'|| '' ||'/'|| '' ||'/'|| '' ||'/'|| '' );
	dbms_output.put_line (' ');
	end if;

		if	good_fuzzy is not null				then
			alias_class := null;
			if   length(text1) = fuzzy_name_leng	then		-- fuzzy count = 1
				this_name 	 := rtrim(text1,' +');			-- '.' means same 1st letter
				MATCH_ALIAS_TABLE;
				user_exact	:= null;
			end if;
		end if;

	end if;


--	<70>	================================================================
--	block & address ranges

	if	nvl(this_num, 0) = 0		then
		this_num	:= null;
		lo_num	:= null;
		hi_num	:= null;
	elsif	rule.show_range	= 'ALL'	then
		lo_num	:= 01;
		hi_num	:= 999999;
	else
		lo_num	:= this_num;
		hi_num	:= this_num;
	end if;

	if	rule.show_range = 'NEAREST'
	and	lo_num > 0				then
		garland.FIND_NEAR_RANGE (this_name, lo_num, hi_num);
	end if;

	lo_block	:= trunc(lo_num, -2);
	hi_block	:= trunc(hi_num, -2);


--	<>	====================================================================
--	Apply rules


	if	do_trace > 10	then
	null;
	dbms_output.put_line ('Apply Rules  /' || rule.display_class ||'/'|| option_show_good ||'/'|| good_fuzzy ||'/'|| rule.fuzzy_scope ||'/'|| option_far_fuzzy );
--	dbms_output.put_line ('             /' || '' ||'/'|| '' ||'/'|| '' ||'/'|| '' ||'/'|| '' );
	dbms_output.put_line (' ');
	end if;


	if 	good_fuzzy is not null
	and	rule.fuzzy_scope >= option_far_fuzzy			then
		good_lo	:= ' ';
		good_hi	:= 'z';
	else	
		good_lo	:= first_letter;
		good_hi	:= first_letter || 'z';
	end if;

	if	rule.display_also >= option_show_rhyme			then
		null;
	elsif	rule.display_also >= option_show_transpose		then
		alias_also	:= rpad(alias_also, instr(alias_also, ';'));
	else	
		alias_also	:= null;
	end if;


	if	rule.show_like	= 'COMPLEX'			then
		look_like	:= this_name;

		if	ltrim(this_name, '%') = this_name	then				-- if "begins" exists
			Begin_lo		:= translate(this_name, '%', ' ');		-- do range search
			Begin_hi		:= translate(this_name, '%', 'z');
		else
			Begin_lo		:= ' ';
			Begin_hi		:= 'z';
		end if;

	elsif	rule.show_like	= 'BEGIN'			then
		look_like	:= '%';
		Begin_lo	:= rpad(input_name, 03);
		Begin_hi	:= begin_lo || 'z';
	end if;

	If	lower(Alias_Method) = alias_is_partial	then
		Partial_lo	:= this_name;
		Partial_hi	:= this_name || 'z';
	end if;


	if	do_trace > 0	then
	null;
--	dbms_output.put_line ('Fuzzy Rules  /' || good_fuzzy ||'/'|| good_lo ||'/'|| good_hi ||'/'|| rule.fuzzy_scope ||'/'|| good_class );
	dbms_output.put_line ('Begin        /' || look_like ||'/'|| begin_lo ||'/'|| begin_hi ||'/'|| '' ||'/'|| '' );
--	dbms_output.put_line ('             /' || '' ||'/'|| '' ||'/'|| '' ||'/'|| '' ||'/'|| '' );
	dbms_output.put_line (' ');
	end if;

--	<>	====================================================================
--	fetch GIS

	if	do_trace > 0	then
	null;
	dbms_output.put_line ('Controls     Begin/' || begin_lo ||'/'|| begin_hi ||'/Partial/'|| partial_lo ||'/'|| partial_hi ||'/Also/'|| alias_also );
	dbms_output.put_line ('             Fuzzy/' || good_lo  ||'/'|| good_hi  ||'/Range/'  || lo_num     ||'/'|| hi_num     ||'/this/'|| this_num );
	dbms_output.put_line ('             Block/' || lo_block ||'/'|| hi_block ||'/'|| '' ||'/'|| '' ||'/'|| '' );
	dbms_output.put_line ('             Name /' || user_exact  ||'/'|| user_close ||'/'|| look_like  ||'/'|| '' ||'/'|| '' );
	dbms_output.put_line ('             Class/' || exact_class ||'/'|| close_class||'/'|| good_class ||'/'|| fair_class ||'/'|| like_class );
--	dbms_output.put_line ('             /' || '' ||'/'|| '' ||'/'|| '' ||'/'|| '' ||'/'|| '' );
	dbms_output.put_line (' ');
	end if;

	fetch_seq	:= 0;
	best_status	:= 'zzz';

	for	look in Read_GIS			loop

	if	do_trace > 0	then
	null;
	dbms_output.put_line ('Fetch        /' || look.addr_num   ||'/'|| look.addr_pfx ||'/'|| look.addr_name ||'/'|| look.addr_type ||'/'|| look.addr_sfx ||'/');
	dbms_output.put_line ('class.group  /' || look.name_class ||'/'|| look.addr_group ||'/'|| look.blok_group ||'/'|| '' );
--	dbms_output.put_line ('             /' || '' ||'/'|| '' ||'/'|| '' ||'/'|| '' ||'/'|| '' );
	dbms_output.put_line (' ');
	end if;

		fetch_seq := fetch_seq + 01;

		if	look.addr_group = 1			then
			text1		:= 'A';
		elsif	look.blok_group = 1			then
			text1		:= 'B';
		else
			text1		:= 'S';
		end if;

		if	text1 = 'A'					then
			line.addr_num	:= look.addr_num;
			line.location1_id	:= look.addr_id;	
			line.location2_id	:= look.parcel_id;	

		elsif	text1 = 'B'					then
			line.addr_num	:= look.addr_block;
			line.location1_id	:= look.block_id;	
			line.location2_id	:= null;	
		else
			line.addr_num	:= 0;
			line.location1_id	:= look.street_id;	
			line.location2_id	:= null;	
		end if;

		line.addr_pfx		:= look.addr_pfx;	
		line.addr_name		:= look.addr_name;	
		line.addr_type		:= look.addr_type;	
		line.addr_sfx		:= look.addr_sfx;	

		line.intersect1		:= ltrim(rtrim(look.x1_pfx ||' '|| look.x1_name ||' '|| look.x1_type 
							||' '||  look.x1_sfx ));

		line.intersect2		:= ltrim(rtrim(look.x2_pfx ||' '|| look.x2_name ||' '|| look.x2_type 
							||' '||  look.x2_sfx ));


--		the Alias Class of the User entry overrides the Name Class of the GIS location
--		Acceptability of the GIS Name is constrained by the Acceptability of the search (Alias) Name 

		if	look.name_class  < alias_class	then
			look.name_class := alias_class;
		end if;

		count1 := 3;
		if	this_type in (' ',look.addr_type)	then
			count1 := count1 - 01;
		end if;
		if	this_pfx in (' ', look.addr_pfx)	then
			count1 := count1 - 01;
		end if;
		if	this_sfx in (' ', look.addr_sfx)	then
			count1 := count1 - 01;
		end if;

		line.status		:= text1 || look.name_class || count1;		-- 'A10'
			
		if	rule.status_format = '1A0'		then
			match_status	:= look.name_class || text1  || count1;	-- '1A0'
		else
			match_status	:= look.name_class || count1 || text1;	-- '10A'
		end if;
		
		if	match_status < best_status		then
			best_status	:= match_status;
			best_entity	:= text1;
			best_qual	:= count1;
			best_class	:= look.name_class;
			best_count	:= 0;
		end if;

		if	best_status = match_status		then
			if	best_count = 0			then
				best_choice := fetch_seq;
			end if;

			best_count	:= best_count + 01;
		end if;

		Address_Entry (fetch_seq) := Line;

	if	do_trace > 9	then
	null;
	dbms_output.put_line ('=' || fetch_seq );
	dbms_output.put_line ('Line Address /' || line.addr_num  ||'/'|| line.addr_pfx ||'/'|| line.addr_name ||'/'|| line.addr_type ||'/'|| line.addr_sfx );
	dbms_output.put_line ('name.qual.obj/' || look.name_class||'/'|| count1 ||'/'|| text1 ||'/' || match_status||'/' || line.status);
	dbms_output.put_line ('best         /' || best_class  ||'/'|| best_qual ||'/'|| best_entity ||'/'|| best_status );
	dbms_output.put_line ('cho.cnt.seq  /' || best_choice ||'/'|| best_count||'/'|| fetch_seq   ||'/'|| '' );
--	dbms_output.put_line ('             /' || '' ||'/'|| '' ||'/'|| '' ||'/'|| '' ||'/'|| '' );
	dbms_output.put_line (' ');
	end if;

	end loop;

--	<>	====================================================================
--	finalize output

	line.status			:= end_of_list;
	fetch_seq			:= fetch_seq + 01;
	Address_Entry(fetch_seq):= line;

	choice			:= best_choice;
	occurs			:= best_count;

	if	rule.command = 'VERIFY'				then	
		if	best_status <= right_status
		and	best_count  = 01				then
			control	:= 'ACCEPT';				-- immediate acceptance
			line		:= Address_Entry (choice);

		elsif	best_entity	<= rule.allow_entity
		and	best_class	<= rule.allow_name
		and	best_qual	<= rule.allow_qual	then
			control	:= 'CHOOSE';				-- recommend
		else
			control	:= 'REJECT ';				-- override only
		end if;

	elsif	rule.command = 'SELECT'				then		
		line	:= Address_Entry(choice);				-- all info except regions
		text1	:= rpad(line.status,1);					-- status entity

		if	text1 <= rule.allow_entity		then
			control	:= 'ACCEPT';
		else
			control	:= 'REJECT ';	
		end if;		
	end if;

	if 	best_count = 1
	and	Region_List (01) > '0'				then

		if	best_entity = address_entity		then
			FIND_ADDRESS_REGION.Main (line.location1_id, Region_List);		

		elsif	best_entity = block_entity		then	
			FIND_BLOCK_REGION.Main   (line.location1_id, line.addr_num, Region_List);		
		end if;
	else
		Region_List (01)	:= end_of_list;
	end if;

	Region_Entry := Region_List;


	if	do_trace > 0	then
	null;
	dbms_output.put_line ('User Addr    /' || user_num ||'/'|| user_pfx ||'/'|| user_name ||'/'|| user_type ||'/'|| user_sfx );
	dbms_output.put_line ('CCO          /' || control  ||'/'|| choice   ||'/'|| occurs ||'/'|| '' );
	dbms_output.put_line ('Regions      /' || region_entry(1) ||'/'|| region_entry(2) ||'/'|| region_entry(3) ||'/'|| '' ||'/'|| '' );
--	dbms_output.put_line ('             /' || '' ||'/'|| '' ||'/'|| '' ||'/'|| '' ||'/'|| '' );
	dbms_output.put_line (' ');
	end if;

	return;
 
end	Main;

--	====================================================================
	procedure	MATCH_ALIAS_TABLE		is

begin

	if	do_trace > 0	then
	null;
	dbms_output.put_line ('Alias Input  /' || this_num ||'/'|| this_pfx ||'/'|| this_name ||'/'|| this_type ||'/'|| this_sfx );
--	dbms_output.put_line ('             /' || '' ||'/'|| '' ||'/'|| '' ||'/'|| '' ||'/'|| '' );
	dbms_output.put_line (' ');
	end if;

	line.addr_num	:= this_num;
	line.addr_pfx	:= this_pfx;
	line.addr_name	:= this_name;
	line.addr_type	:= this_type;
	line.addr_sfx	:= this_sfx;


	FIND_ALIAS_MATCH.MAIN
	( 
		line.addr_num,		
		line.addr_pfx,		
		line.addr_name,		
		line.addr_type,		
		line.addr_sfx,		

		user_exact,
		user_close,
		alias_also,

		alias_match,
		alias_count,
		alias_method,	
		alias_weight	
	);

	if	alias_weight >= rule.allow_weight		then
		this_num	:= line.addr_num;
		this_pfx	:= line.addr_pfx;
		this_name	:= line.addr_name;
		this_type	:= line.addr_type;
		this_sfx	:= line.addr_sfx;
	end if;

	if	do_trace > 0	then
	null;
	dbms_output.put_line ('Alias Output /' || this_num ||'/'|| this_pfx ||'/'|| this_name ||'/'|| this_type ||'/'|| this_sfx );
	dbms_output.put_line ('meth.mch.wgt /' || alias_method  ||'/'|| alias_match ||'/'|| alias_weight ||'/'|| '' ||'/'|| '' );
--	dbms_output.put_line ('             /' || '' ||'/'|| '' ||'/'|| '' ||'/'|| '' ||'/'|| '' );
	dbms_output.put_line (' ');
	end if;

end	Match_Alias_Table;

--	====================================================================

end	Find_Address;

--	====================================================================
/*

	accept_good			'1A0'			Accept

	choose_good			'2S3'			Choose

	choose_fair			'S33'			Choose

					else			Reject

	right_status
	good_status
	fair_status

--	====================================================================

	if	do_trace > 0	then
	null;
	dbms_output.put_line ('             /' || '' ||'/'|| '' ||'/'|| '' ||'/'|| '' ||'/'|| '' );
--	dbms_output.put_line ('             /' || '' ||'/'|| '' ||'/'|| '' ||'/'|| '' ||'/'|| '' );
	dbms_output.put_line (' ');
	end if;

*/
--	====================================================================
