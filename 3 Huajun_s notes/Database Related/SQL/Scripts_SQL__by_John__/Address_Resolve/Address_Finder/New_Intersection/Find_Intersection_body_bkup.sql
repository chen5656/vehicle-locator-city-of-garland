	set echo	on;
--	====================================================================		

	create or replace package body	garland.Find_Intersection	As

--	====================================================================		
	procedure	MATCH_ALIAS_TABLE;
	procedure	DISPLAY_INTERSECTION;
--	====================================================================

--		CHOICE

--		user_		IN OUT

--		Find_Location_Rule	table
--		Find_Address_Rule		view
--		Find_Intersection_Rule	view
--	====================================================================

	do_trace			binary_integer	:= 0;

	LINE				Intersection_Option;

	input1_name			varchar2(40);
	input2_name			varchar2(40);

	search_key			varchar2(10);
	search1_name		varchar2(40);
	search2_name		varchar2(40);
	search_lo			varchar2(10);
	search_hi			varchar2(10);

	this_choice			binary_integer;
	this_counter		binary_integer;
	this_corner			varchar2(10);
	this_twin			varchar2(10);

	this1_exact			varchar2(40);
	this1_close			varchar2(40);
	this1_pfx			varchar2(10);
	this1_name			varchar2(40);
	this1_type			varchar2(10);
	this1_sfx			varchar2(10);
	this1_block			binary_integer;

	this2_exact			varchar2(40);
	this2_close			varchar2(40);
	this2_pfx			varchar2(10);
	this2_name			varchar2(40);
	this2_type			varchar2(10);
	this2_sfx			varchar2(10);
	this2_block			binary_integer;

	work1_block			binary_integer;
	work1_pfx			varchar2(10);
	work1_name			varchar2(40);
	work1_type			varchar2(10);
	work1_sfx			varchar2(10);

	work2_block			binary_integer;
	work2_pfx			varchar2(10);
	work2_name			varchar2(40);
	work2_type			varchar2(10);
	work2_sfx			varchar2(10);

	work1_basic			varchar2(01);
	work1_whole			varchar2(01);
	work2_basic			varchar2(01);
	work2_whole			varchar2(01);

	spec1_block			binary_integer;
	spec1_pfx			varchar2(40);
	spec1_name			varchar2(40);
	spec1_type			varchar2(40);
	spec1_sfx			varchar2(40);

	spec2_block			binary_integer;
	spec2_pfx			varchar2(40);
	spec2_name			varchar2(40);
	spec2_type			varchar2(40);
	spec2_sfx			varchar2(40);

	spec_exact			varchar2(40);
	spec_close			varchar2(40);

	fetch_seq			binary_integer;
	factor_block		binary_integer;
	filter_basic_whole	binary_integer;
	filter1_block		binary_integer;
	filter2_block		binary_integer;
	filter_intersect_type	varchar2(20);
	first_letter		char;

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

	count1			binary_integer;
	count2			binary_integer;
	text1				varchar2(1000);
	text2				varchar2(1000);

--	====================================================================		
	cursor	Read_Intersection		is

	select all *
	from	 garland.Intersection
	
	where	search_key		between search_lo  and search_hi
	and	search1_name	in (' ', addr1_name)
	and	search2_name	in (' ', addr2_name)

	and (	intersect_id	like  filter_intersect_type

	or  (	work1_type		in ( ' ', addr1_type)	
	and	work1_pfx		in ( ' ', addr1_pfx)	
	and	work1_sfx		in ( ' ', addr1_sfx)	

	and	work2_type		in ( ' ', addr2_type)	
	and	work2_pfx		in ( ' ', addr2_pfx)	
	and	work2_sfx		in ( ' ', addr2_sfx)	

	and	addr1_block	* factor_block >= filter1_block
	and	addr2_block	* factor_block >= filter2_block
	    ))

	order by	rtrim(addr1_name, spec1_name), rtrim(addr1_type, spec1_type), 
			rtrim(addr2_name, spec2_name), rtrim(addr2_type, spec2_type), 
			addr1_block * spec1_block,	 addr2_block * spec2_block;

--	constrain results to basic & whole streets
--	and	basic1 + whole1 >= filter_basic_whole (1,10)
--	and	basic2 + whole2 >= filter_basic_whole (1,10)


	TAKE		Read_Intersection%rowtype;	

--	====================================================================
procedure	Main
(
	user1_block		in		varchar2,
	user1_pfx		in		varchar2,
	user1_name		in		varchar2,
	user1_type		in		varchar2,
	user1_sfx		in		varchar2,

	user2_block		in		varchar2,
	user2_pfx		in		varchar2,
	user2_name		in		varchar2,
	user2_type		in		varchar2,
	user2_sfx		in		varchar2,

	user_corner		in		varchar2,
	user_twin		in		varchar2,
	
	control		in out	varchar2,
	choice		in out	number,
	counter		in out	number,

	Intersect_Entry	out 		Intersection_Array,	
	Region_Entry	in out	Region_Array
)

Is

--	====================================================================		
	cursor	Read_Address_Control	is

	select * 
	from		garland.Find_Address_Rule_Vw
	where		rule_name = text1;

	RULE		Read_Address_Control%rowtype;

--	====================================================================		

begin

	this1_block		:= user1_block;
	this1_pfx		:= user1_pfx;
	this1_name		:= upper(user1_name);
	this1_type		:= user1_type;
	this1_sfx		:= user1_sfx;

	this2_block		:= user2_block;
	this2_pfx		:= user2_pfx;
	this2_name		:= upper(user2_name);
	this2_type		:= user2_type;
	this2_sfx		:= user2_sfx;

--	====================================================================		
--	Obtain Rule Records
	
	text1 := rule.rule_name;

	open	Read_Address_Control;
	fetch	Read_Address_Control		into Rule;
	if	read_address_control%notfound
	or	read_address_control%notfound is null		then
		control := 'ERROR - Invalid Address Control';
		close	Read_Address_Control;
		return;
	end if;
	close	Read_Address_Control;

--	====================================================================		
--	Initialize

	input1_name		:= this1_name;
	input2_name		:= this2_name;

--	====================================================================		
--	Match Primary Street

	spec1_block		:= this1_block;
	spec1_pfx		:= this1_pfx;
	spec1_name		:= this1_name;
	spec1_type		:= this1_type;
	spec1_sfx		:= this1_sfx;

	MATCH_ALIAS_TABLE;

	this1_exact		:= spec_exact;
	this1_close		:= spec_close;

	if	alias_weight >= rule.allow_weight		then
		this1_block	:= spec1_block;
		this1_pfx	:= spec1_pfx;
		this1_name	:= spec1_name;
		this1_type	:= spec1_type;
		this1_sfx	:= spec1_sfx;
	end if;

--	====================================================================		
--	Match Secondary Street

	spec1_block		:= this2_block;
	spec1_pfx		:= this2_pfx;
	spec1_name		:= this2_name;
	spec1_type		:= this2_type;
	spec1_sfx		:= this2_sfx;

	MATCH_ALIAS_TABLE;

	this2_exact		:= spec_exact;
	this2_close		:= spec_close;

	if	alias_weight >= rule.allow_weight		then
		this2_block	:= spec1_block;
		this2_pfx	:= spec1_pfx;
		this2_name	:= spec1_name;
		this2_type	:= spec1_type;
		this2_sfx	:= spec1_sfx;
	end if;

--	====================================================================		
--	Construct Name Search Key

	search_lo	:= 			substr(this1_name,1,1) || substr(this1_name,2,1);
	search_lo	:= search_lo ||	substr(this2_name,1,1) || substr(this2_name,2,1);
	search_hi	:= search_lo ||	'z';

	if	this1_exact is not null		then
		search1_name	:= this1_exact;
	else
		search1_name	:= ' ';
	end if;

	if	this2_exact is not null		then
		search2_name	:= this2_exact;
	else
		search2_name	:= ' ';
	end if;

--	====================================================================		
--	Set Query Controls

	spec1_name		:= ' ';
	spec1_type		:= ' ';
	spec1_block		:= 1;
	spec2_name		:= ' ';
	spec2_type		:= ' ';
	spec2_block		:= 1;

	if	rule.command = 'VERIFY'			then
		filter_intersect_type	:= 'AA%';
		filter_basic_whole	:= 10;

		factor_block		:= -1;
		filter1_block		:= 0;
		filter2_block		:= 0;

	elsif	rule.command like 'TRAVEL%'			then
		filter_intersect_type	:= 'BB%';
		filter_basic_whole	:= 10;

		factor_block		:= 1;
		filter1_block		:= 1;
		filter2_block		:= 1;

		if	rule.command = 'TRAVEL1'		then
			work2_type	:= ' ';
			work2_pfx	:= ' ';
			work2_sfx	:= ' ';

			spec1_name	:= null;
			spec1_type	:= null;
			spec1_block := null;

		elsif	rule.command = 'TRAVEL2'		then
			work1_type	:= ' ';
			work1_pfx	:= ' ';
			work1_sfx	:= ' ';

			spec2_name	:= null;
			spec2_type	:= null;
			spec2_block := null;
		end if;

	else
		filter_intersect_type	:= '%';
		filter_basic_whole	:= 0;

		factor_block		:= 1;
		filter1_block		:= 0;
		filter2_block		:= 0;
	end if;

--	====================================================================		
--	Execute Desired Query
--	Analyze Query Results

for	look in Read_Intersection		loop

	count1 := 08;

	if	this1_type		= look.addr1_type		then	
		count1		:= count1 - 01;
	end if;
	
	if	this2_type		= look.addr2_type		then
		count1		:= count1 - 01;
	end if;

	if	this1_pfx		= look.addr1_pfx		then
		count1		:= count1 - 01;
	end if;

	if	this2_pfx		= look.addr2_pfx		then
		count1		:= count1 - 01;
	end if;

	if	this1_block		= look.addr1_block	then
		count1		:= count1 - 01;
	end if;

	if	this2_block		= look.addr2_block	then
		count1		:= count1 - 01;
	end if;

	if	this1_sfx		= look.addr1_sfx		then
		count1		:= count1 - 01;
	end if;

	if	this2_sfx		= look.addr2_sfx		then
		count1		:= count1 - 01;
	end if;

	take	:= look;
	DISPLAY_INTERSECTION;

	fetch_seq				:= fetch_seq + 01;
	Intersect_Entry (fetch_seq)	:= Line;

end loop;

end	Main;

--	====================================================================
procedure	DISPLAY_INTERSECTION		is

begin

	line.addr1_block		:= take.addr1_block;
	line.addr1_pfx		:= take.addr1_pfx;
	line.addr1_name		:= take.addr1_name;
	line.addr1_type		:= take.addr1_type;
	line.addr1_sfx		:= take.addr1_sfx;

	line.addr2_block		:= take.addr2_block;
	line.addr2_pfx		:= take.addr2_pfx;
	line.addr2_name		:= take.addr2_name;
	line.addr2_type		:= take.addr2_type;
	line.addr2_sfx		:= take.addr2_sfx;

	line.location1_id		:= take.intersect_id;

end	Display_Intersection;

--	====================================================================
procedure	MATCH_ALIAS_TABLE		is

begin

	FIND_ALIAS_MATCH.MAIN
	( 
		spec1_block,		
		spec1_pfx,		
		spec1_name,		
		spec1_type,		
		spec1_sfx,		

		spec_exact,
		spec_close,
		alias_also,

		alias_match,
		alias_count,
		alias_method,	
		alias_weight	
	);

end	Match_Alias_Table;

--	====================================================================

end	Find_Intersection;


--	====================================================================
/*
--	====================================================================

	if	do_trace > 0	then
	null;
	dbms_output.put_line ('             /' || '' ||'/'|| '' ||'/'|| '' ||'/'|| '' ||'/'|| '' );
--	dbms_output.put_line ('             /' || '' ||'/'|| '' ||'/'|| '' ||'/'|| '' ||'/'|| '' );
	dbms_output.put_line (' ');
	end if;

--	====================================================================		
*/


