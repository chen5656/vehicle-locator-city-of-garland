	set echo	on;
--	=====================================================================
	CREATE or replace package body	garland.Resolve_Address		as
--	=====================================================================

--	enhancing

--	=====================================================================
--	TASKS

--	=====================================================================
--	MODIFICATIONS

--	<410>			track unique qualifiers	after match_qualifiers
--				update qualifiers 	during set_phase_results
--	sep 2003		feed reduced name to fuzzy name match ('bobbie', 'connie')
--	oct 2003		employ new ADR_FIND.MATCH_ALIAS
--	dec 2003		debug Alias matching
--	feb 2004		Final_Name:	removed "if best-count = 1"
--	feb 2004		set verify code = non_garland if addr_num exists
--				suppress non_address test     if addr_num exists

--	final name		fuzzy score <= do_type_C
--	parse			test for non_address when not parsing

--	=====================================================================

	do_insert			number		:= 0;
	do_test			number		:= 0;				-- sep 2003

	start_seq			number		:= 01;
	stop_seq			number		:= rule.capacity;
	stop_count			number		:= rule.capacity;
	trace_recs			number		:= 0;
	choose_name			varchar2(80)	:= '';
	choose_num			varchar2(80)	:= '';


--	========================================
--	TRACE BODY

	tr_trace			number;
	tr_show			number;
	tr_focus			varchar2(2000);

	who				varchar2(40); 
	whom				varchar2(40); 
	show				varchar2(400); 

	trace_level			number;
	trace_lines			number;
	trace_focus			number;
	trace_data			number;
	trace_done			number;
	trace_count1		number;
	trace_count2		number;
	trace_put			number;
	trace_flow_leng		number;
	trace_break			char;
	trace_who			varchar2(40); 
	trace_whom			varchar2(40); 
	trace_whox			varchar2(40); 
	trace_whatx			varchar2(40); 
	trace_what1			varchar2(40); 
	trace_what2			varchar2(40); 
	trace_option		varchar2(2000);
	trace_shown			varchar2(2000);
	trace_flown			varchar2(2000);
	trace_work			varchar2(4000);
	trace_work1			number;
	trace_work2			number;

	trace_done_init		number	:= -1;
	trace_done_test		number	:= 0;
	trace_done_show		number	:= 1;
	trace_done_shown		number	:= 2;


	procedure	Start_Trace ( spec_trace	number	default 0, 
					  spec_show		number	default 99, 
					  spec_focus	varchar2	default null );
	procedure	Stop_Trace;
	procedure	Track_Data;
	procedure	Trace_Flow;
	procedure	Show_Break;
	procedure	Show_		(spec_scope number);
	procedure	show_Trace	(spec_lines number);

	procedure	show_Rule	(spec_lines number);
	procedure	show_In	(spec_lines number);
	procedure	show_Out	(spec_lines number);
	procedure	show_Work	(spec_lines number);
	procedure	show_Read	(spec_lines number);
	procedure	show_Fetch	(spec_lines number);
	procedure	show_Best	(spec_lines number);
	procedure	show_Basic	(spec_lines number);
	procedure	show_Name	(spec_lines number);
	procedure	show_Audit	(spec_lines number);
	procedure	show_Accept	(spec_lines number);
	procedure	show_Weight	(spec_lines number);
	procedure	show_Score	(spec_lines number);
	procedure	show_Verify	(spec_lines number);


--	========================================
--	control constants

	prev_seq			number	:= start_seq - 01; 
	max_key_length		number	:= 20;		
	max_phase_loops		number	:= 02;
	loop_limit			number	:= 02;
	commit_size			number	:= 1000;

	street_phase		char		:= 'S';
	block_phase			char		:= 'B';
	segment_phase		char		:= 'R';
	address_phase		char		:= 'A';
	intersect_phase		char		:= 'X';
	
	spec_reduced		char		:= '2';	
	spec_compact		char		:= '4';
	spec_hi_range		number	:= 999999;

	decide_loop			number 	:= 10;
	decide_exit			number 	:= 20;
	decide_insert		number	:= 70;
	decide_return		number	:= 80;
	decide_error		number	:= 90;

	same_weight			number	:= 30;
	reduced_weight		number	:= 20;
	compact_weight		number	:= 10;

	reduced_alias		number	:= ADR_find.reduced_score;
	compact_alias		number	:= ADR_find.compact_score;

	match_weight		number	:= rule.match;
	blank_weight		number	:= rule.blank;
	append_weight		number	:= rule.append;
	change_weight		number	:= rule.change;
	remove_weight		number	:= rule.remove;
	forbid_weight		number	:= rule.match * - 10;

	like_non_address		varchar2(3)	:= '%'|| rule.mark_non_address;
	like_non_garland		varchar2(3)	:= '%'|| rule.mark_non_garland;
	like_non_complete		varchar2(3)	:= '%'|| rule.mark_non_complete;
	like_verify_only		varchar2(3)	:= '%'|| rule.mark_verify_only;
	like_parse_error		varchar2(3) := 	   rule.mark_parse_error || '%';

	parse_default		varchar2(90) := rule.parse_default;
	signals			varchar2(20) := '&@%#/\';

	process_qualifier		number	:= rule.do_street + rule.do_block	+ 
							   rule.do_range  + rule.do_address;

--	========================================
--	AUDIT

	append_type		char(04) := '/at ';
	append_pfx		char(04) := '/ap ';
	append_sfx		char(04) := '/as ';
	change_type		char(04) := '/ct ';
	change_pfx		char(04) := '/cp ';
	change_sfx		char(04) := '/cs ';
	remove_type		char(04) := '/rt ';
	remove_pfx		char(04) := '/rp ';
	remove_sfx		char(04) := '/rs ';

--	========================================
--	PHASE RECORD

	type phase_rec	is record
(
	rule_unq_type	number,
	rule_unq_pfx	number,
	rule_unq_sfx	number,
	rule_type		number,
	rule_pfx		number,
	rule_sfx		number,
	fetch_count		number,	
	match_count		number,
	match_score		number
);
	work			phase_rec;
	str			phase_rec;
	blk			phase_rec;
	seg			phase_rec;
	adr			phase_rec;

--	========================================
--	STREET QUALIFIERS

	type qualifier_record	is record
(
	addr_type		varchar2(04),
	addr_pfx		varchar2(02),
	addr_sfx		varchar2(02),
	record_id		varchar2(12),
	mslink		number			-- sep 2003
);

--	QUALIFIER  TABLE

	type qualifier_table	is table of		qualifier_record
		index by	binary_integer;
	qualifier		qualifier_table;

--	========================================

	total_read			number := 0;
	total_input			number := 0;
	total_output		number := 0;
	total_record		number := 0;
	total_fuzzy			number := 0;
	total_alias			number := 0;
	commit_count		number := 0;	

	phase				char;
	retry				number;
	step				number;
	recd				number;
	decision			number;
	verify_id			number;

	name_count			number;
	street_count		number;

	street_weight		number;		
	block_weight		number;
	segment_weight		number;
	address_weight		number;
	final_weight		number;

	range_lo			number;
	range_hi			number;

--	========================================
--	qualifier match 

	accept_count		number;	
	accept_initial		number;		
	accept_type			number;
	accept_prefix		number;
	accept_suffix		number;

	match_type			number;
	match_prefix		number;
	match_suffix		number;

	unique_type			varchar2(04);
	unique_prefix		varchar2(02);
	unique_suffix		varchar2(02);

	audit_type			char(04);
	audit_prefix		char(04);
	audit_suffix		char(04);

	permit_append		number;
	permit_remove		number;
	permit_change		number;

	prev_score			number;
	best_score			number;

--	========================================

	read_num			adrResult.appl_num%type;	
	read_pfx			adrResult.appl_pfx%type;
	read_name			adrResult.appl_name%type;
	read_type			adrResult.appl_type%type;
	read_sfx			adrResult.appl_sfx%type;
	read_code1			adrResult.appl_code1%type;
	read_unit1			adrResult.appl_unit1%type;
	read_code2			adrResult.appl_code2%type;
	read_unit2			adrResult.appl_unit2%type;
	read_id			varchar2(20);
	read_mslink			number;						-- sep 2003

	this_num			adrResult.addr_num%type;
	this_pfx			adrResult.addr_pfx%type;
	this_name			adrResult.addr_name%type;
	this_type			adrResult.addr_type%type;
	this_sfx			adrResult.addr_sfx%type;
	this_bldg			adrResult.addr_unit1%type;

	best_pfx			adrResult.addr_pfx%type;
	best_name			adrResult.addr_name%type;
	best_type			adrResult.addr_type%type;
	best_sfx			adrResult.addr_sfx%type;
	best_id			varchar2(20);
	best_mslink			number;						-- sep 2003

	prev_best			number;		
	best_weight			number;
	best_name_chg		char(01);
	best_audit			varchar2(80);

	this_weight			number;
	this_name_chg		char;
	this_audit			varchar2(80);

	parse_method		varchar2(80);
	alias_table			varchar2(08);
	alias_method		varchar2(08);
	alias_result		varchar2(08);

	alias_weight		binary_integer;			-- oct 2003
	alias_match			binary_integer;			-- oct 2003
	alias_second		varchar2(40);			-- oct 2003
	alias_also			varchar$v	:= varchar$v ('', '', '', '','');	-- oct 2003

	street_name			varchar2(80);
	reduced_name		varchar2(80);
	compact_name		varchar2(80);

	test_count1			number := 0;
	test_count2			number := 0;
	test_count3			number := 0;

--	========================================

	OUT 	garland.adrResult%rowtype;	

--	========================================
cursor	read_rowid_table		is

	select row_id, row_seq
	from	 garland.gis_app_rowid
	where	 row_seq > prev_seq
	and	 rownum < 2;

	ROW	read_rowid_table%rowtype;		

--	========================================
cursor	read_app_table		is

	select *
	from	garland.adrResult_Local
	where	rowid = row.row_id;

	APPL	read_app_table%rowtype;

--	========================================
cursor	read_street			is

	select	*
	from		garland.adrStreet_syn
	where		addr_compact = compact_name;

	STRT		read_street%rowtype;	

--	========================================
cursor	read_block			is

	select	--+	index_asc ( adrBlock  adrBlock_pkey)
			all *
	from		garland.adrBlock
	where		addr_name	= out.addr_name
	and		addr_block	= trunc (out.addr_num, -2);

	BLOK		read_block%rowtype;	

--	========================================
cursor	read_segment		is

	select	--+	index_asc ( trvehrcl  trvehrcl_x_name_num)
			distinct
			addr_name, addr_type, addr_pfx, addr_sfx, addr_lo, addr_hi, mslink
	from		garland.trvehrcl
	where		addr_name	 = out.addr_name
	and		addr_lo	>= range_lo
	and		addr_hi	<= range_hi
	order by	1,2,3,4,5,6,7;

	SEGM		read_segment%rowtype;	

--	========================================
cursor	read_address		is

	select	distinct
			addr_name, addr_type, addr_pfx, addr_sfx, addr_num, 
			addr_bldg, unit_num,  
			parcel_id, mslink						-- sep 2003
	from		garland.cdreladr
	where		addr_name	= out.addr_name
	and		addr_num	= out.addr_num
	order by	1,2,3,4,5,6,7,8;

	ADDR		read_address%rowtype;		

--	=================================================================
--	=================================================================
--	<A>
	procedure	Match_Alias_Street	is

begin

	      who:='$Alias'; whom:=''; Show_(50); show_Read(9);

	alias_table	:= alias_method;

	if	street_name <> read_name		then
		street_name  := read_name;
		reduced_name := ADR_compress_name (read_name, spec_reduced);
		compact_name := ADR_compress_name (read_name, spec_compact);
	end if;

	this_num	:= read_num;
	this_pfx	:= read_pfx;
	this_name	:= read_name;
	this_type	:= read_type;
	this_sfx	:= read_sfx;
	
	if	alias_table = 'alien'			then		-- oct 2003
	ADR_alias_match
--	TST_alias_match
	( 	alias_method, 
		read_num, read_pfx, read_name, read_type, read_sfx, 
	 	reduced_name, compact_name );	

	else
	garland.ADR_FIND_01.FIND_ALIAS				-- oct 2003
	( 
		read_num,		
		read_pfx,		
		read_name,		
		read_type,		
		read_sfx,		

		alias_second,
		alias_also,
		alias_method,
		alias_match,
		alias_weight
	);
	end if;

	alias_method := rtrim (alias_method);

--	dbms_output.put_line ( 'alias result: '||alias_table||'/'||alias_match||'/'||alias_method||'/'||this_name||'/'||read_name);		-- TEST

	
	if	alias_method  = ADR_Find.asis_method			-- nov 2003
	and	read_name <> this_name					then
		if	alias_match >= reduced_alias			then	-- dec 2003
			out.do_name	 := 'A';
		elsif	alias_match >= compact_alias			then
			out.do_name	 := 'B';
		end if;
	end if;

	if  (	out.do_name = 'A'	 and	rule.do_type_A = rule.no )	-- dec 2003
	or  (	out.do_name = 'B'	 and	rule.do_type_B = rule.no )
	or	alias_weight < rule.do_alias_weight			then		
		alias_method := null;
	end if;
	
	if	alias_method > ' '					then		-- sep 2003
		verify_id	:= null;
	end if;

    	if	alias_method like	   like_non_address		then
		verify_id	 := rule.non_address;

    	elsif	alias_method like	   like_non_garland		then
		verify_id	 := rule.non_garland;

    	elsif	alias_method like	   like_non_complete		then
		verify_id	 := rule.non_complete;

	elsif	alias_method like '%pull%'						-- may 2003
	and		replace (upper(out.appl_name), ' ')
	like	'%'|| replace (read_name, ' ') ||'%'		then
		alias_method	:= rule.mark_parse_undo;

	end if;
	
	if	alias_method  = ADR_Find.asis_method		then		-- dec 2003
		alias_method := null;
	end if;

	if	alias_method > ' '					then
		out.do_alias	:= alias_method;		
		alias_result	:= alias_method; 
		total_alias		:= total_alias + 01;
	end if;

	      who:=''; whom:=alias_table; Show_(70); show_Name(9); show_Read(1);

end	Match_Alias_Street;

--	===========================================================================
--	<I>
	procedure	Phase_Initialize		is

--	Accept_Type = 1	when user street type = GIS type or space
--	Specify trace_what range of numbers to search in TRVEHRCL
--	Initialize valid name search parameters
--	===========================================================================

begin

	      who:='$Init'; whom:=''; Show_(50);

	if	phase = street_phase
	and	street_name  <> out.addr_name		then
		street_name  := out.addr_name;
		reduced_name := adr_compress_name (out.addr_name, spec_reduced);
		compact_name := adr_compress_name (out.addr_name, spec_compact);
	end if;

	if	step	= rule.do_street			then		-- apr 2003

		if	out.addr_type = ' '		then
			accept_type  := 1;	
		else
			accept_type  := 0;	
		end if;

		if	out.addr_pfx = ' '		then
			accept_prefix := 1;	
		else
			accept_prefix := 0;	
		end if;

		if	out.addr_sfx = ' '		then
			accept_suffix := 1;	
		else
			accept_suffix := 0;	
		end if;

		accept_initial	:= accept_type + accept_prefix + accept_suffix;	

		      who:=''; whom:='s'; Show_(50);	
	end if;

	if	phase = street_phase			then

		best_name		:= out.addr_name;
		best_name_chg	:= ' ';
		best_weight		:= 0;
		      who:=''; whom:='sp'; Show_(50);

	elsif	phase = segment_phase			then

		select	min(start_lo),	max(stop_lo) + 99
		into		range_lo,		range_hi
		from		garland.block
		where		addr_name	= out.addr_name
		and		addr_block	= trunc(out.addr_num, -2);
		      who:=''; whom:='r'; Show_(50);

	elsif	phase = address_phase			then
	      who:=''; whom:='a'; Show_(50);
		this_bldg	:= ' ';
	end if;

	      who:=''; whom:=phase; Show_(70); show_Accept(9); show_Best(9);

end	Phase_Initialize;

--	=================================================================
--	<F>
	function	Phase_Filter	return number	is

--	Evaluate current adrStreet name for best street name match
--	Filter out duplicate or non-matching TRVEHRCL records
--	Filter out duplicate or non-matching CDRELADR records
--	=================================================================

begin

	      who:='$Filter'; whom:=''; Show_(50); show_Fetch(9); show_Read(9); 

	if	phase = street_phase					then

		if	strt.addr_name	 = out.addr_name		then
			this_weight		:= same_weight;	
			this_name_chg	:= ' ';

		elsif	alias_result	= rule.mark_verify_only		then		-- mar 2003
			return decide_loop;

		elsif	rule.do_type_A    >= rule.yes	
		and	strt.addr_reduced  = reduced_name
		and	alias_result is null				then		
			this_weight		:= reduced_weight;
			this_name_chg	:= 'A';

		elsif	rule.do_type_B    >= rule.yes	
		and	alias_result is null				then		
			this_weight		:= compact_weight;
			this_name_chg	:= 'B';

		else
			return decide_loop;
		end if;
	
		if	this_weight > best_weight			then
			best_weight		:= this_weight;
			best_name		:= strt.addr_name;
			best_name_chg	:= this_name_chg;
			name_count		:= 1;
			work.fetch_count	:= 0;

		elsif	this_weight < best_weight			

		or	name_count  > 1					then
			return decide_loop;

		elsif	strt.addr_name <> best_name			then
			name_count		:= 9;	
			return	decide_loop;
		end if;


	elsif	phase = segment_phase					then

		if	segm.addr_type = read_type
		and	segm.addr_pfx  = read_pfx
		and	segm.addr_sfx  = read_sfx			then
			return decide_loop;

		elsif	out.addr_num < segm.addr_lo
		or	out.addr_num > segm.addr_hi			then
			return decide_loop;
		end if;


	elsif	phase = address_phase					then

		if	addr.addr_type = read_type
		and	addr.addr_pfx  = read_pfx
		and	addr.addr_sfx  = read_sfx			then
			return decide_loop;

		elsif	addr.addr_bldg >= '0'				then
			if	this_bldg = ' '				then
				this_bldg := addr.addr_bldg;
			else
				return decide_loop;
			end if;

		elsif	addr.unit_num >= '0'				then 
			return decide_loop;
		end if;

	end if;

	      who:=''; whom:=phase; Show_(70); show_Name(9); show_Best(9); show_Weight(9); 

	return 00;

end	Phase_Filter;

--	=================================================================
--	<U1>
	procedure	Find_Unique_Invalid	is

--	Look for unique & invalid street name qualifiers
--	Example:	Street name "AUSTIN" has unique prefix, suffix, & type
--	Example:	"DR" is an invalid street type for "Country Club"
--	=================================================================

begin

	      who:='$Find'; whom:=recd; Show_(50); show_Read(9); show_Out(9);

	if	work.fetch_count = 01			then
		match_type		:= 0;
		match_prefix	:= 0;
		match_suffix	:= 0;

		unique_type		:= read_type;
		unique_prefix	:= read_pfx;
		unique_suffix	:= read_sfx;
	else
		if	unique_type   <> read_type	then
			unique_type	  := null;
		end if;
		if	unique_prefix <> read_pfx	then
			unique_prefix := null;
		end if;
		if	unique_suffix <> read_sfx	then
			unique_suffix := null;
		end if;
	end if;

	if	read_type = out.addr_type		then
		match_type   := 1;
	end if;
	if	read_pfx  = out.addr_pfx		then
		match_prefix := 1;
	end if;
	if	read_sfx  = out.addr_sfx		then
		match_suffix := 1;
	end if;

	      who:=''; whom:=phase; Show_(70); show_Read(1); show_Audit(9);

end	Find_Unique_Invalid;

--	==========================================================================
--	<U2>
	procedure	Apply_Unique_Invalid	is

--	Apply results of unique & invalid qualifier determinations (from above)
--	This may result in adding, changing, or removing a qualifier
--	==========================================================================

begin

	--       who:='$Apply'; whom:=''; Show_(50); show_Out(1);  

	if	out.addr_pfx  > ' '
	and	unique_prefix > ' '					
	and	unique_prefix <> out.addr_pfx
	and	prev_score		<= permit_change
	and	work.rule_unq_pfx <= rule.change_unq		then
		accept_prefix := 01;						
		out.addr_pfx := unique_prefix;
		this_audit	 := this_audit||change_pfx;

	elsif	out.addr_pfx   > ' '
	and	match_prefix   = 0					
	and	prev_score		<= permit_remove	
	and	work.rule_unq_pfx <= rule.remove_unq		then
		accept_prefix := 01;						
		out.addr_pfx := ' ';
		this_audit	 := this_audit||remove_pfx;	
	end if;

	if	out.addr_pfx  = ' '
	and	unique_prefix > ' '					
	and	prev_score		<= permit_append
	and	work.rule_unq_pfx <= rule.append_unq		then
		accept_prefix := 01;						
		out.addr_pfx := unique_prefix;
		this_audit	 := this_audit||append_pfx;
	end if;


	if	out.addr_type  > ' '
	and	unique_type    > ' '					
	and	unique_type	   <> out.addr_type
	and	prev_score		 <= permit_change
	and	work.rule_unq_type <= rule.change_unq		then
		accept_type	  := 01;						
		out.addr_type := unique_type;
		this_audit	  := this_audit||change_type;	

	elsif	out.addr_type  > ' '
	and	match_type 	   = 0
	and	prev_score		 <= permit_remove
	and	work.rule_unq_type <= rule.remove_unq		then
		accept_type	  := 01;						
		out.addr_type := ' ';
		this_audit	  := this_audit||remove_type;	
	end if;

	if	out.addr_type  = ' '
	and	unique_type    > ' '					
	and	prev_score		 <= permit_append	
	and	work.rule_unq_type <= rule.append_unq		then
		accept_type	  := 01;						
		out.addr_type := unique_type;
		this_audit	  := this_audit||append_type;
	end if;


	if	out.addr_sfx  > ' '
	and	unique_suffix > ' '					
	and	unique_suffix <> out.addr_sfx
	and	prev_score		<= permit_change
	and	work.rule_unq_sfx <= rule.change_unq		then
		accept_suffix := 01;						
		out.addr_sfx  := unique_suffix;
		this_audit	  := this_audit||change_sfx;

	elsif	out.addr_sfx   > ' '
	and	match_suffix   = 0					
	and	prev_score		<= permit_remove
	and	work.rule_unq_sfx <= rule.remove_unq		then
		accept_suffix := 01;						
		out.addr_sfx  := ' ';
		this_audit	  := this_audit||remove_sfx;	
	end if;

	if	out.addr_sfx  = ' '
	and	unique_suffix > ' '				
	and	prev_score		<= permit_append
	and	work.rule_unq_sfx <= rule.append_unq		then
		accept_suffix := 01;						
		out.addr_sfx  := unique_suffix;
		this_audit	  := this_audit||append_sfx;
	end if;

	      who:=''; whom:=phase; Show_(90); show_Out(-1); show_Audit(-1);

end	Apply_Unique_Invalid;

--	===========================================================================================
--	<Q>
	procedure	Match_Qualifiers		is

--	Look for the closest matching street
--	Use weighted match scores to determine closest match
--	Consider which operations (append, change, remove) are permitted
--	Consider match scores obtained from matching a previous GIS table,
--	Example:	Should '217 S Fifth Cir' be "corrected" if the 200 block of Fifth Cir exists? 
--	===========================================================================================

begin

	      who:='$Match'; whom:=recd; Show_(90); show_Out(-1); show_Read(-1);

	this_weight := 0;

	if	out.addr_pfx   = read_pfx					then
		accept_prefix	:= 01;
		audit_prefix	:= null;
		if	out.addr_pfx = ' '					then
			this_weight := this_weight + blank_weight;	
		else
			this_weight := this_weight + match_weight;	
		end if;

	elsif	out.addr_pfx  < '0'						then
		if	work.rule_pfx <= rule.append					
		and	prev_score	  <= permit_append			then
			audit_prefix	:= append_pfx;
			this_weight 	:= this_weight + append_weight;
		else
			this_weight		:= this_weight + forbid_weight;	
		end if;

	elsif	out.addr_pfx  > '0'							
	and	read_pfx	  < '0'						then
		if	work.rule_pfx <= rule.remove
		and	prev_score	  <= permit_remove			then
			audit_prefix	:= remove_pfx;
			this_weight		:= this_weight + remove_weight;
		else
			this_weight		:= this_weight + forbid_weight;	
		end if;

	elsif	out.addr_pfx  > '0'					
	and	read_pfx	  > '0'						then
		if	work.rule_pfx <= rule.change					
		and	prev_score	  <= permit_change			then
			audit_prefix	:= change_pfx;
			this_weight		:= this_weight + change_weight;
		else
			this_weight		:= this_weight + forbid_weight;	
		end if;
	end if;


	if	out.addr_type   = read_type					then
		accept_type		:= 01;
		audit_type	  	:= null;
		if	out.addr_type = ' '					then
			this_weight := this_weight + blank_weight;	
		else
			this_weight := this_weight + match_weight;	
		end if;

	elsif	out.addr_type  < '0'						then
		if	work.rule_type <= rule.append					
		and	prev_score	   <= permit_append			then
			audit_type		:= append_type;
			this_weight 	:= this_weight + append_weight;
		else
			this_weight		:= this_weight + forbid_weight;	
		end if;

	elsif	out.addr_type  > '0'							
	and	read_type	   < '0'						then
		if	work.rule_type <= rule.remove					
		and	prev_score	   <= permit_remove			then		
			audit_type		:= remove_type;
			this_weight		:= this_weight + remove_weight;
		else
			this_weight		:= this_weight + forbid_weight;	
		end if;

	elsif	out.addr_type  > '0'					
	and	read_type	   > '0'						then
		if	work.rule_type <= rule.change					
		and	prev_score	   <= permit_change			then
			audit_type		:= change_type;
			this_weight		:= this_weight + change_weight;
		else
			this_weight		:= this_weight + forbid_weight;
		end if;
	end if;

	if	out.addr_sfx   = read_sfx					then
		accept_suffix	:= 01;
		audit_suffix	:= null;
		if	out.addr_sfx = ' '					then
			this_weight := this_weight + blank_weight;	
		else
			this_weight := this_weight + match_weight;	
		end if;

	elsif	out.addr_sfx  < '0'						then
		if	work.rule_sfx <= rule.append					
		and	prev_score    <= permit_append			then
			audit_suffix	:= append_sfx;
			this_weight 	:= this_weight + append_weight;
		else
			this_weight		:= this_weight + forbid_weight;	
		end if;

	elsif	out.addr_sfx  > '0'							
	and	read_sfx	  < '0'						then
		if	work.rule_sfx <= rule.remove					
		and	prev_score	  <= permit_remove			then
			audit_suffix	:= remove_sfx;
			this_weight		:= this_weight + remove_weight;
		else
			this_weight		:= this_weight + forbid_weight;	
		end if;

	elsif	out.addr_sfx  > '0'					
	and	read_sfx	  > '0'						then
		if	work.rule_sfx <= rule.change					
		and	prev_score    <= permit_change			then
			audit_suffix	:= change_sfx;
			this_weight		:= this_weight + change_weight;
		else
			this_weight		:= this_weight + forbid_weight;
		end if;
	end if;

	      who:=''; whom:= phase; Show_(70); show_Audit(9); show_Weight(9); 

end	Match_Qualifiers;

--	==========================================================================
--	<N>
	function	Final_Name_Resolve	return number	is

--	If a street name is not resolved, consider other possible resolutions
--	For example, try a fuzzy name match
--	For example, see whether it is a non-address location
--	==========================================================================

	compare_best		varchar2(2000);
	compare_good		varchar2(2000);
	count_best			number;
	count_good			number;

begin

	      who:='$Final'; whom:=''; Show_(50); show_Basic(9); show_Name(9); 

	if	out.verify_code >= rule.non_address
	or	alias_result	 = rule.mark_verify_only	then			-- mar 2003
		retry			:= -1;

	elsif	name_count = 1 						then
		retry			:= -2;
		out.addr_name	:= best_name;
		if	best_name_chg > ' '				then			-- apr 2003
			out.do_name	:= best_name_chg;	
		end if;

	elsif	out.do_alias > '0'					then
		retry			:= -3;

	end if;

	      who:=''; whom:='retry'; Show_(50); show_Basic(9); show_Name(9); 	

	if	retry = 0
	and	rule.do_type_C >= rule.yes				then
		total_fuzzy := total_fuzzy + 01;

		compare_best := adr_compress_name (best_name, '2');			-- sep 2003
--		compare_best := best_name;			
--		ADR_compare_names (compare_best, compare_good, count_best, count_good);
		Compare_Names (compare_best, compare_good, count_best, count_good);		-- dec 2003

--		if	count_best = 01								-- feb 2004
		if	count_best <= rule.do_type_C						-- dec 2003
		and	length(compare_best) = 20						-- feb 2004
		and	(rtrim(out.addr_name, '0123456789') = out.addr_name) 
		  =	(rtrim(compare_best,  '0123456789') = compare_best)		then

			name_count		:= 01;
			retry			:= 11;
			out.do_name		:= 'C';			
			out.addr_name	:= rtrim (compare_best);
			reduced_name 	:= null;
			compact_name 	:= null;
			      who:=''; whom:='fuzzy'; Show_(90); show_Out(-2);
			return		decide_exit;
		end if;
	end if;

	if	out.addr_num > '0'				then					-- feb 2004
		null;

	elsif	retry = 0	
	and	rule.do_type_C >= rule.yes			then					-- feb 2003

--	test for duplex
		if	out.addr_code1 = 'DPLX'			then
			null;
--	test for oversize name
		elsif	length(out.addr_name) > 20
--	test for initials
		or	instr (out.addr_name, ' ') between 2 and 3				
--	test for 3 or more words
		or	instr (out.addr_name, ' ', 1,2) > 0						
--	test for trailing unit number
		or	rtrim(out.addr_name,'0123456789') <> out.addr_name
														then
			out.verify_code := rule.non_address;

--	test for persons initials
--	test for location symbols
		elsif	alias_result is null	
		and	out.verify_code is null					then	
			if	rtrim (out.addr_name) is null	
			or	instr (out.addr_name, ' ', 1,3) > 0							
			or	out.addr_name  <> 
				translate (out.addr_name, 'x'||signals, 'x')		
											then
				out.verify_code := rule.non_address;
			end if;
	
--	test for trailing numbers
		elsif	ltrim (out.addr_num, '0123456789') is not null	then	
			out.verify_code := rule.non_address;

		end if;

		if	out.verify_code = rule.non_address			then
			      who:='NonAdr'; whom:=''; Show_(90); show_Out(-1);
			return	decide_insert;
		end if;
		
	end if;

	      who:=''; whom:='end'; Show_(50); show_Out(2); show_Basic(9); 

	return	00;

end	Final_Name_Resolve;

--	============================================================================
--	<R>
	procedure	Set_Phase_Results		is
--	============================================================================

begin

	      who:='$Result'; whom:=''; Show_(50);

	if	best_weight < 0						then	
		work.match_count := 0;
	end if;

--	if best_weight exceeds prev_best by blank_weight alone, then multiple match_count

	this_weight := best_weight - prev_best;

	if	step  = rule.do_street
	and	work.match_count = 01						
	and	prev_best > 0
	and	this_weight < match_weight
	and	mod(this_weight, blank_weight) = 0				then  
		work.match_count := 02;

--	do not use best match if all qualifiers are blank

--	elsif	phase = street_phase						
	elsif	step  = rule.do_street
	and	accept_initial	= 3
	and	work.fetch_count	> 1					then
		work.match_count := 02;

	elsif	work.match_count = 01					then
		out.addr_type	:= best_type;
		out.addr_pfx	:= best_pfx;
		out.addr_sfx	:= best_sfx;

		best_audit		:= translate (best_audit, ' ', ';');
		this_audit		:= this_audit||best_audit;
	
		if	phase = address_phase				then
			out.parcel_id	:= best_id;
			out.segment_id	:= best_mslink;					-- sep 2003
		elsif	phase = segment_phase				then
			null;
--			out.segment_id	:= best_id;						-- sep 2003
		end if;

	elsif	work.match_count > 01					then			-- jun 2003
		if	unique_type <> out.addr_type			then
			if	unique_type = ' '				then
				this_audit := this_audit || remove_type;
			elsif	out.addr_type > ' '			then
				this_audit := this_audit || change_type;
			else
				this_audit := this_audit || append_type;
			end if;
			
			out.addr_type	:= unique_type;
		end if;

		if	unique_prefix <> out.addr_pfx			then
			if	unique_prefix = ' '			then
				this_audit := this_audit || remove_pfx;
			elsif	out.addr_pfx > ' '			then
				this_audit := this_audit || change_pfx;
			else
				this_audit := this_audit || append_pfx;
			end if;

			out.addr_pfx	:= unique_prefix;
		end if;

		if	unique_suffix <> out.addr_sfx			then
			if	unique_suffix = ' '			then
				this_audit := this_audit || remove_sfx;
			elsif	out.addr_sfx > ' '			then
				this_audit := this_audit || change_sfx;
			else
				this_audit := this_audit || append_sfx;
			end if;

			out.addr_sfx	:= unique_suffix;
		end if;

	end if;

	out.do_qual		:= out.do_qual || translate (this_audit, '/', phase);	
	work.match_score	:= best_score;

	if	step  = rule.do_street					then
		str.fetch_count	:= work.fetch_count;
		str.match_count	:= work.match_count;
		str.match_score	:= work.match_score;
		street_weight	:= best_weight;
	elsif	phase = address_phase					then
		adr.fetch_count	:= work.fetch_count;
		adr.match_count	:= work.match_count;
		adr.match_score	:= work.match_score;
		address_weight	:= best_weight;
	elsif	phase = block_phase					then
		blk.fetch_count	:= work.fetch_count;
		blk.match_count	:= work.match_count;
		blk.match_score	:= work.match_score;
		block_weight	:= best_weight;
	elsif	phase = segment_phase					then
		seg.fetch_count	:= work.fetch_count;
		seg.match_count	:= work.match_count;
		seg.match_score	:= work.match_score;
		segment_weight	:= best_weight;
	end if;

	      who:=''; whom:=phase; Show_(90); show_Out(-2); show_Work(-9);

end	Set_Phase_Results;

--	============================================================================
--	<V>
	procedure	Set_Verify_Code		is

--	The 	 Code indicates trace_what is right and trace_what is wrong with an address
--	See documentation for meaning of verification codes
--	============================================================================

	major			number;
	minor			number;
	match_count		number;

begin

	      who:='$Verify'; whom:=''; Show_(50);

	major := null;
	minor := 0;

	if	out.verify_code < rule.valid_name	
	and	out.verify_code > rule.non_address		then		--	???
		major		:= out.verify_code;

	elsif	adr.fetch_count > 0				then
		major 		:= rule.address_match;
		if	adr.match_count = 1			then
			minor	:= rule.full_match;	
		elsif	adr.match_count > 1			then
			minor	:= rule.partial_match;	
		end if;
		final_weight	:= address_weight;

	elsif	seg.fetch_count > 0				then
		major 		:= rule.segment_match;
		if	seg.match_count = 1			then
			minor	:= rule.full_match;
		elsif	seg.match_count > 1			then
			minor	:= rule.partial_match;
		end if;
		final_weight	:= segment_weight;

	elsif	blk.fetch_count > 0				then
		major 		:= rule.block_match;
		if	blk.match_count = 1			then
			minor	:= rule.full_match;
		elsif	blk.match_count > 1			then


			minor	:= rule.partial_match;
		end if;
		final_weight	:= block_weight;

	elsif str.fetch_count > 0				then
		if	nvl (out.addr_num, '0') > '0'		then
			major 	:= rule.orphan_match;
		else

			major 	:= rule.street_match;
		end if;

		if	str.match_count = 1			then
			minor	:= rule.full_match;
		elsif	str.match_count > 1			then
			minor	:= rule.partial_match;
		end if;
		final_weight	:= street_weight;

	end if;	

	if	major < rule.valid_name				then
		null;

	elsif	major is null					then
		if	name_count = 01				then
			major	:= rule.valid_name;
		elsif	out.addr_num > '0'			then		-- feb 2004
			major := rule.non_garland;
		else
			major	:= rule.non_address;				-- feb 2003
		end if;		

	elsif	process_qualifier = 0				then
		null;
	elsif	minor  = 0						then
		minor	:= -1;
	end if;

--	-------------------------------------------------------------------------------------------

if	minor < 0						then

	accept_type		:= 0;
	accept_prefix	:= 0;
	accept_suffix	:= 0;
	best_weight		:= 0;
--	match_count		:= 0;

for	look in (select * from adrStreets where addr_name = out.addr_name)	loop

	if	out.addr_type = look.addr_type
	or	out.addr_type < '0'		then
		accept_type		:= 1;
		match_type		:= 1;
	else
		match_type		:= 0;
	end if;		

	if	out.addr_pfx = look.addr_pfx
	or	out.addr_pfx < '0'		then
		accept_prefix	:= 1;
		match_prefix	:= 1;
	else
		match_prefix	:= 0;
	end if;		

	if	out.addr_sfx = look.addr_sfx
	or	out.addr_sfx < '0'		then
		accept_suffix	:= 1;
		match_suffix	:= 1;
	else
		match_suffix	:= 0;
	end if;		

	this_weight	:= match_type + match_prefix + match_suffix;

	if	this_weight  = 3				then
		best_weight := 3;
--		match_count	:= match_count + 01;
--	elsif	best_weight  < this_weight		then
--		best_weight := this_weight;
	end if;

end loop;

	this_weight := accept_type + accept_prefix + accept_suffix;

	if	this_weight < 3				then
		minor	:= rule.poor_match;

	elsif	best_weight < 3				then
		minor	:= rule.mixed_match;

--	elsif	major < rule.block_match
--	and	match_count > 1				then
--		minor	:= rule.partial_match;

	else
		minor	:= rule.wrong_match;
	end if;

end if;

--	-------------------------------------------------------------------------------------------

	verify_id	:= major + minor;							-- mar 2003
	if	verify_id >= nvl (out.verify_code, -1)			then
		out.verify_code	:= verify_id;
	end if;

	      who:=''; whom:=out.verify_code; Show_(90); show_Verify(-9); show_Out(2); 

end	Set_Verify_Code;


--	=================================================================
	function	Main_Driver		
	(		spec_Insert		number	default null,
			spec_seq		number	default null
	)
			return number	is
--	=================================================================

begin

	if	spec_insert > 0			then
		do_insert	:= spec_insert;
	end if;
	if	spec_seq   > 0			then
		start_seq	:= spec_seq;
		stop_seq	:= spec_seq;
	end if;

--	========================================
--	<10>		Initialize Input

	      who:='10Input'; whom:=''; Show_(50); show_Out(9); 

	if	out.verify_code < rule.valid_name			-- apr 2003
	and	rule.do_alien  * rule.do_parse * rule.do_name = 0	then
		      who:=''; whom:='ret'; Show_(50); 
		return	decide_return;
	end if;

	parse_method	:= null;			
	alias_method	:= null;			
	alias_result	:= null;
	verify_id		:= null;
	retry			:= 0;
	loop_limit		:= max_phase_loops;

	if	rule.do_parse > 0					then
		out.form_name	:= null;
		out.addr_name	:= null;
		out.do_parse	:= '';
		out.do_alias	:= '';
		out.do_name		:= '';
		out.do_qual		:= '';
		out.verify_code 	:= null;

	elsif	rule.do_reset = rule.reset_to_parsed	then
		out.addr_name	:= null;
		out.do_alias	:= '';
		out.do_name		:= '';
		out.do_qual		:= '';
		out.verify_code 	:= null;

	elsif	rule.do_name  > 0					then
		out.do_name		:= '';
		out.do_qual		:= '';

	elsif	rule.do_street > 0				then
		out.do_qual		:= '';
	end if;

	if	out.verify_code < rule.valid_name		then				-- may 2003
		out.do_name			:= '';
		out.do_qual			:= '';
--		if	out.verify_code = rule.non_address	then				-- feb 2004
--			out.form_name	:= '';	
--		end if;
	end if;

	if	out.verify_code >= rule.valid_name		then				-- may 2003
		if	rule.do_alias in (rule.alias_form, rule.alias_fuzzy)		then
			out.do_alias	:= '';
		end if;
	
		if	rule.do_name > 0				then
			out.verify_code	:= null;
		end if;
	end if;

	verify_id	:= out.verify_code;							-- sep 2003

--	---------

	if	out.addr_name > ' '			then
		read_num	:= out.addr_num;	
		read_pfx	:= out.addr_pfx;
		read_name	:= out.addr_name;
		read_type	:= out.addr_type;
		read_sfx	:= out.addr_sfx;
		read_code1	:= out.addr_code1;
		read_unit1	:= out.addr_unit1;
		read_code2	:= out.addr_code2;
	 	read_unit2	:= out.addr_unit2;

	elsif	out.form_name > ' '			then
		read_num	:= out.addr_num;	
		read_pfx	:= out.form_pfx;
		read_name	:= out.form_name;
		read_type	:= out.form_type;
		read_sfx	:= out.form_sfx;
		read_code1	:= out.form_code1;
		read_unit1	:= out.form_unit1;
		read_code2	:= out.form_code2;
	 	read_unit2	:= out.form_unit2;
		out.addr_name  := null;
	
	else
		read_num	:= out.appl_num;	
		read_pfx	:= out.appl_pfx;
		read_name	:= out.appl_name;
		read_type	:= out.appl_type;
		read_sfx	:= out.appl_sfx;
		read_code1	:= out.appl_code1;
		read_unit1	:= out.appl_unit1;
		read_code2	:= out.appl_code2;
	 	read_unit2	:= out.appl_unit2;
		out.form_name  := null;
		out.addr_name  := null;
	end if;

	if	out.form_name is null			then	
		out.form_pfx	:= null;
		out.form_type	:= null;
		out.form_sfx	:= null;
		out.form_code1	:= null;
		out.form_unit1	:= null;
		out.form_code2	:= null;
		out.form_unit2	:= null;
	end if;

	if	out.addr_name is null			then
		out.addr_num	:= null;
		out.addr_pfx	:= null;
		out.addr_type	:= null;
		out.addr_sfx	:= null;
		out.addr_code1	:= null;
		out.addr_unit1	:= null;
		out.addr_code2	:= null;
		out.addr_unit2	:= null;
	end if;

	read_pfx		:= upper (rtrim(read_pfx));				-- sep 2003 (rtrim)
	read_name		:= upper (rtrim(read_name));
	read_type		:= upper (rtrim(read_type));
	read_sfx		:= upper (rtrim(read_sfx));
	read_code1		:= upper (rtrim(read_code1));
	read_unit1		:= upper (rtrim(read_unit1));
	read_code2		:= upper (rtrim(read_code2));
	read_unit2		:= upper (rtrim(read_unit2));

	      who:=''; whom:='x'; Show_(50); show_Out(9); show_Read(9);

--	========================================
--	<20>		Unparsed User Exit	

	      who:='20User1'; whom:=''; Show_(50);

	if	rule.do_unparsed_exit >= rule.yes	then

		adr_Resolve_Unparsed_Exit 
		(read_num,	 read_pfx,	 read_name,	 read_type,	read_sfx, 
		 read_code1, read_unit1, read_code2, read_unit2,
		 parse_method, verify_id		);

		if	parse_method > '!'		then
			out.do_parse := parse_method;
		end if;

		      who:=''; whom:=parse_method; Show_(50); show_Read(2); show_Basic(9); 

		if	verify_id < rule.valid_name	then		
			goto	initialize_output;						
		end if;

		if	parse_method > ' '		then		
			goto	match_alias;
		end if;

	end if;

--	========================================
--	<30>		Match Unparsed Alias (Alien)

	      who:='30Alien'; whom:=''; Show_(50);

	if	rule.do_alien >= rule.yes			then
		alias_method := 'alien';

--	------------------------------------------------
		Match_Alias_Street;						--	CALL
--	------------------------------------------------

		if	verify_id < rule.valid_name		then
			goto	initialize_output;
		elsif	alias_result > ' '			then
			goto	match_alias;
		end if;
	end if;

--	========================================
--	<40>		Parse Address

	      who:='40Parse'; whom:=''; Show_(50);

	if	rule.do_parse > 0			then

		parse_method := rule.parse_options;					-- mar 2003

		TST_parse_address 
--		ADR_parse_address 
	(	read_num,   read_pfx,   read_name,	read_type,  read_sfx, 
		read_code1, read_unit1, read_code2,	read_unit2,	
		parse_method	);

		out.do_parse := parse_method;
	
		      who:=''; whom:=parse_method; Show_(50); show_Read(1); show_Basic(9);

		if	parse_method like like_parse_error		then
			verify_id	:= rule.non_address;
--			goto	initialize_output;					-- sep 2003
		else	
			out.form_pfx	:= nvl(rtrim(read_pfx ),  ' ');
			out.form_name	:= nvl(rtrim(read_name),  ' ');
			out.form_type	:= nvl(rtrim(read_type),  ' ');
			out.form_sfx	:= nvl(rtrim(read_sfx ),  ' ');
			out.form_code1	:= nvl(rtrim(read_code1), ' ');
			out.form_unit1	:= nvl(rtrim(read_unit1), ' ');
			out.form_code2	:= nvl(rtrim(read_code2), ' ');
			out.form_unit2	:= nvl(rtrim(read_unit2), ' ');
		end if;

	      who:=''; whom:='x'; Show_(50); show_Out(1);

	end if;


	if	parse_method like like_parse_error		then			-- dec 2003
		verify_id	:= rule.non_address;
	end if;


--	========================================
--	<50>		Parsed User Exit

	      who:='50User2'; whom:=''; Show_(50);

	if	rule.do_parsed_exit >= rule.yes	then

		adr_Resolve_Parsed_Exit 
		(read_num,	read_pfx,	read_name,	read_type,	read_sfx, 
		 read_code1,read_unit1, read_code2, read_unit2,
		 parse_method, verify_id	);

		if	parse_method > '!'		then
			out.do_parse := out.do_parse ||' '|| parse_method;		-- may 2003
		end if;

		      who:=''; whom:='x'; Show_(50); show_Read(2); show_Basic(9);

--		if	verify_id < rule.valid_name	then					-- sep 2003
--			goto	initialize_output;						
--		end if;

	end if;

--	========================================
--	<60>
<<match_alias>>

	      who:='60Alias'; whom:=''; Show_(50);

	if	rule.do_alias >= rule.yes		then
		alias_method := 'alias';
--	------------------------------------------------
		Match_Alias_Street;					--	CALL
--	------------------------------------------------
	end if;

--	========================================
--	<70>
<<initialize_output>>

	      who:='70Init'; whom:=''; Show_(50); show_Read(9);

	out.addr_num	:= read_num;
	out.addr_name	:= read_name;				
	out.addr_type	:= read_type;
	out.addr_pfx	:= read_pfx;
	out.addr_sfx	:= read_sfx;
	out.addr_code1	:= read_code1;
	out.addr_unit1	:= read_unit1;				
	out.addr_code2	:= read_code2;
	out.addr_unit2	:= read_unit2;				

	out.parcel_id	:= null;
	out.segment_id	:= null;

--	if	verify_id is not null				then			-- sep 2003
		out.verify_code	:= verify_id;
--	end if;

	      who:=''; whom:=out.verify_code; Show_(90); show_Out(-3); 

--	========================================
--	<80>

	if	out.verify_code < rule.valid_name					-- mar 2003
	or	rule.do_name + process_qualifier = 0	then	
		      who:='80ret'; whom:=''; Show_(50); 
		return	decide_insert;
	end if;

--	========================================
--	<100>
<<process_phase>>

	      who:='100Phase'; whom:=''; Show_(50);

--	loop_limit := loop_limit - 01;
--	if	loop_limit < 0				then
--		dbms_output.put_line ('ERROR - adrResolve is looping');
--		return decide_error;
--	end if;

	phase			:= null;
	street_count	:= 00;
	name_count		:= 00;							-- feb 2004

	if	out.verify_code >= rule.valid_name	then		
		name_count	:= 01;
	else
		name_count	:= 00;
	end if;

	str.fetch_count	:= 0;
	str.match_count	:= 0;
	str.match_score	:= 0;	
	blk.fetch_count	:= 0;
	blk.match_count	:= 0;
	blk.match_score	:= 0;
	seg.fetch_count	:= 0;
	seg.match_count	:= 0;
	seg.match_score	:= 0;
	adr.fetch_count	:= 0;
	adr.match_count	:= 0;
	adr.match_score	:= 0;

	this_type		:= out.addr_type;	
	this_pfx		:= out.addr_pfx;
	this_sfx		:= out.addr_sfx;

	this_audit 		:= null;

	if	alias_result like like_verify_only	then			-- apr 2003
		append_weight	:= forbid_weight;
		remove_weight	:= forbid_weight;
		change_weight	:= forbid_weight;
	else
		append_weight	:= rule.append;
		remove_weight	:= rule.remove;
		change_weight	:= rule.change;
	end if;

--	========================================
--	<110>
<<phase_loop>>

for steps in 1..5						loop

	      who:='110Loop'; whom:=step; Show_(50);

	step	:= steps;				

	if	step in (rule.do_name, rule.do_street)	then		
		phase				:= street_phase;
		work.rule_unq_type	:= rule.str_unq_type;
		work.rule_unq_pfx		:= rule.str_unq_pfx;
		work.rule_unq_sfx		:= rule.str_unq_sfx;
		work.rule_type		:= rule.str_type;
		work.rule_pfx		:= rule.str_pfx;
		work.rule_sfx		:= rule.str_sfx;

	elsif	step = rule.do_block				then
		phase			:= block_phase;
		work.rule_type	:= rule.blk_type;
		work.rule_pfx	:= rule.blk_pfx;
		work.rule_sfx	:= rule.blk_sfx;

	elsif	step = rule.do_range				then
		phase			:= segment_phase;
		work.rule_type	:= rule.rng_type;
		work.rule_pfx	:= rule.rng_pfx;
		work.rule_sfx	:= rule.rng_sfx;

	elsif	step = rule.do_address				then
		phase			:= address_phase;
		work.rule_type	:= rule.adr_type;
		work.rule_pfx	:= rule.adr_pfx;
		work.rule_sfx	:= rule.adr_sfx;
	else	
		      who:='110end'; whom:=''; Show_(50); 
		goto	end_phase_loop;
	end if;

	if	alias_result = rule.mark_verify_only	then			-- mar 2003
		work.rule_type	:= forbid_weight;
		work.rule_pfx	:= forbid_weight;
		work.rule_sfx	:= forbid_weight;
	end if;


	      who:= trace_new_line||'STEP'; whom:=step;  show_Work(9);

	if	nvl (out.addr_num, '0') = '0'
	and	phase <> street_phase					then
		      who:='110ext'; whom:=''; Show_(50); 
		exit;
	end if;			

	if	phase = address_phase					then
		prev_score		:= rule.permit_adr_basis;
		permit_append	:= rule.permit_adr_append;
		permit_remove	:= rule.permit_adr_remove;
		permit_change	:= rule.permit_adr_change;

	elsif	phase = segment_phase					then
		prev_score		:= rule.permit_rng_basis;
		permit_append	:= rule.permit_rng_append;
		permit_remove	:= rule.permit_rng_remove;
		permit_change	:= rule.permit_rng_change;

	elsif	phase = block_phase					then
		prev_score		:= rule.permit_blk_basis;
		permit_append	:= rule.permit_blk_append;
		permit_remove	:= rule.permit_blk_remove;
		permit_change	:= rule.permit_blk_change;

	elsif	phase = street_phase					then
		prev_score		:= 0;
		permit_append	:= rule.permit;	
		permit_remove	:= rule.permit;
		permit_change	:= rule.permit;
	end if;

	if	prev_score	= rule.do_street		then
		prev_score := str.match_score;
	elsif	prev_score	= rule.do_block		then
		prev_score := blk.match_score;
	elsif	prev_score	= rule.do_range		then
		prev_score := seg.match_score;
	elsif	prev_score	= rule.do_address		then
		prev_score := adr.match_score;
	else
		prev_score	:= rule.permit;
	end if;

	      who:='PHASE'; whom:=phase; Show_(90); show_Basic(-1); show_Work(1); show_Score(9);

--	------------------------------------------------
--	<120>
		PHASE_INITIALIZE;						--	CALL
--	------------------------------------------------

--	========================================
--	<130>

	      who:='130'; whom:=''; Show_(50); show_Work(9); show_Out(1); show_Basic(9); show_Name(9); show_Score(9);

	if	step		= rule.do_street				
	and	step - 1	= rule.do_name
	and	0		< rule.do_name 		then
		      who:='130goto'; whom:=''; Show_(50); 
		goto	alter_street_qualifiers;
	end if;

--	========================================
--	<200>		Fetch GIS Records

	      who:='200Fetch'; whom:=''; Show_(50);

	this_audit		:= null;
	read_type		:= null;
	read_pfx		:= null;
	read_sfx		:= null;
	this_weight		:= 0;
	best_score		:= 0;

	work.fetch_count	:= 0;
	work.match_count	:= 0;
	work.match_score	:= 0;	

	if	phase = street_phase		then
		open	read_street;
	elsif	phase = block_phase		then
		open	read_block;
	elsif	phase = segment_phase		then
		open	read_segment;
	elsif	phase = address_phase		then
		open	read_address;
	end if;

--	========================================
--	<210>
loop

	      who:='210Fetch'; whom:=phase; Show_(50);

	if	phase = street_phase				then
		fetch	read_street					into strt;
		exit when	read_street%notfound		
			or 	read_street%notfound is null;
	elsif	phase = address_phase				then
		fetch	read_address				into addr;
		exit when	read_address%notfound		
			or 	read_address%notfound is null;
	elsif	phase = block_phase				then
		fetch	read_block					into blok;
		exit when	read_block%notfound		
			or 	read_block%notfound is null;
	elsif	phase = segment_phase				then
		fetch	read_segment				into segm;
		exit when	read_segment%notfound		
			or 	read_segment%notfound is null;
	end if;

	      who:=''; whom:=work.fetch_count; Show_(90); show_Fetch(-7); show_Basic(-3);

--	------------------------------------------------
--	<220>
	decision := PHASE_FILTER;					--	CALL
--	------------------------------------------------

	if	decision = decide_loop			then
		      who:='220end'; whom:=''; Show_(50); 
		goto	end_fetch_loop;
	end if;

--	========================================
--	<230>		Get Fetch

	      who:='230Get'; whom:=''; Show_(50); show_Read(1);

	if	work.fetch_count > 0			then
		qualifier (work.fetch_count).addr_type	:= read_type;
		qualifier (work.fetch_count).addr_pfx	:= read_pfx;
		qualifier (work.fetch_count).addr_sfx	:= read_sfx;
		qualifier (work.fetch_count).record_id	:= read_id;
		qualifier (work.fetch_count).mslink		:= read_mslink;		-- sep 2003

	end if;

	work.fetch_count := work.fetch_count + 01;	
	recd := work.fetch_count;

	if	phase = street_phase			then
		read_type	:= strt.addr_type;
		read_pfx	:= strt.addr_pfx;
		read_sfx	:= strt.addr_sfx;
	elsif	phase = block_phase			then
		read_type	:= blok.addr_type;
		read_pfx	:= blok.addr_pfx;
		read_sfx	:= blok.addr_sfx;
	elsif	phase = segment_phase			then
		read_type	:= segm.addr_type;
		read_pfx	:= segm.addr_pfx;
		read_sfx	:= segm.addr_sfx;
		read_id	:= segm.mslink;
--		read_id	:= segm.segment_id;
	elsif	phase = address_phase			then
		read_type	:= addr.addr_type;
		read_pfx	:= addr.addr_pfx;
		read_sfx	:= addr.addr_sfx;
		read_id	:= addr.parcel_id;
		read_mslink	:= addr.mslink;							-- sep 2003

	end if;

	      who:=''; whom:=work.fetch_count; Show_(90); show_Read(-1);

--	========================================
--	<240>

	if	phase = street_phase			then
--	------------------------------------------------
		FIND_UNIQUE_INVALID;					--	CALL
--	------------------------------------------------
	end if;

	      who:='240Score'; whom:=''; Show_(50); 

	if	best_score  <  rule.full_match
	and	this_type	= read_type	
	and	this_pfx	= read_pfx
	and	this_sfx	= read_sfx			then
		best_score	:= rule.full_match;

	elsif	best_score  <  rule.part_match
	and	this_type	in (' ', read_type)
	and	this_pfx	in (' ', read_pfx)
	and	this_sfx	in (' ', read_sfx)	then
		best_score	:= rule.part_match;

	elsif	best_score  <  rule.base_match	then
		best_score	:= rule.base_match;
	end if;

	      who:=''; whom:=phase; Show_(50); show_Score(9);

<<end_fetch_loop>>
	null;

end loop;

--	========================================
--	<250>

	      who:='250Close'; whom:=''; Show_(50);

	if	phase = street_phase		then
		close	read_street;
	elsif	phase = address_phase		then
		close	read_address;
	elsif	phase = block_phase		then
		close	read_block;
	elsif	phase = segment_phase		then
		close	read_segment;
	end if;	

--	========================================
--	<300>
	<<alter_street_qualifiers>>						

	if	step  = rule.do_name
	or	work.fetch_count  = 0		then
		goto	reconsider;
	end if;

--	========================================
--	<310>

	if	step	= rule.do_street	then	
--	------------------------------------------------
		APPLY_UNIQUE_INVALID;					--	CALL
--	------------------------------------------------
	end if;

--	========================================
--	<400>		Match Against GIS table 

	      who:='400Match'; whom:=''; Show_(50); show_(9); show_(9); show_(9);

	best_weight	:= - 999999;
	prev_best	:= 0;							

for	q in reverse 01..work.fetch_count 			loop

	recd := q;

	      who:='400Loop'; whom:=recd; Show_(50); show_(9); 

	if	q < work.fetch_count				then
		read_type	:= qualifier (q).addr_type;
		read_pfx	:= qualifier (q).addr_pfx;
		read_sfx	:= qualifier (q).addr_sfx;
		read_id	:= qualifier (q).record_id;
		read_mslink	:= qualifier (q).mslink;		-- sep 2003
	end if;

--	------------------------------------
--	<410>
		MATCH_QUALIFIERS;						--	CALL
--	------------------------------------

	if	best_weight < this_weight			then
		prev_best		:= best_weight;			
		best_weight		:= this_weight;
		best_type		:= read_type;
		best_pfx		:= read_pfx;
		best_sfx		:= read_sfx;
		best_id		:= read_id;
		best_mslink		:= read_mslink;			-- sep 2003
		best_audit		:= audit_prefix||audit_type||audit_suffix;
		work.match_count	:= 0;
	end if;

	if	this_weight = best_weight			then
		work.match_count := work.match_count + 01;	

		if	work.match_count = 01			then			-- jun 2003
			unique_type		:= read_type;
			unique_prefix	:= read_pfx;
			unique_suffix	:= read_sfx;
		else
			if	unique_type <> read_type	then
				unique_type	:= null;
			end if;

			if	unique_prefix <> read_pfx	then
				unique_prefix := null;
			end if;

			if	unique_suffix <> read_sfx	then
				unique_suffix := null;
			end if;
		end if;

	end if;

	      who:=''; whom:=phase; Show_(50); show_Best(9); show_Weight(9);

<<end_match_loop>>
	null;
end loop;


--	========================================
--	<500>
<<reconsider>>

	      who:='500Recon'; whom:=''; Show_(50);

	if	alias_result > '0'			then
		retry	:= -3;
	end if;

	if	step = rule.do_street			then
		accept_count := accept_prefix + accept_type + accept_suffix;

	elsif	step = rule.do_name			then
--	------------------------------------------------
--	<510>
		decision := FINAL_NAME_RESOLVE;			--	CALL
--	------------------------------------------------

		if	decision = decide_exit		then
			      who:='510ext'; whom:=''; Show_(50); 
			exit;
		elsif	decision = decide_insert	then
			      who:='510ins'; whom:=''; Show_(50); 
			return	decide_insert;
		end if;
	end if;

--	------------------------------------------------
--	<510>	
		Set_Phase_Results;					--	CALL
--	------------------------------------------------

<<end_phase_loop>>

--	========================================
--	<600>	

	if	phase = street_phase
	and	name_count <> 01				then
		      who:='600ext1'; whom:=''; Show_(50); 
		exit;

	elsif	step <> rule.do_name
	and	out.addr_name < '0'			then		-- apr 2003
--	and	out.addr_name = '0'			then
		      who:='600ext2'; whom:=''; Show_(50); 
		exit;
	end if;

end loop;

--	========================================
--	<610>

	      who:='610Retry'; whom:=''; Show_(50); show_(9); show_(9); show_(9);

	if	retry  = 11						then
		retry := 12;
		if	rule.do_alias = rule.alias_fuzzy		then			-- mar 2003
			read_num	:= out.addr_num;			
			read_pfx	:= out.addr_pfx;
			read_name	:= out.addr_name;
			read_type	:= out.addr_type;
			read_sfx	:= out.addr_sfx;
			read_code1	:= out.addr_code1;
			read_unit1	:= out.addr_unit1;
			read_code2	:= out.addr_code2;
			read_unit2	:= out.addr_unit2;
			alias_result	:= null;
			goto	match_alias;
		else
			goto	process_phase;
		end if;
	end if;

--	------------------------------------------------
--	<620>
		SET_VERIFY_CODE;						--	CALL
--	------------------------------------------------

	if	out.verify_code = rule.non_address			then		-- mar 2003
		out.addr_num	:= out.appl_num;
		out.addr_pfx	:= out.appl_pfx;
		out.addr_name	:= out.appl_name;
		out.addr_type	:= out.appl_type;
		out.addr_sfx	:= out.appl_sfx;
		out.addr_code1	:= out.appl_code1;
		out.addr_unit1	:= out.appl_unit1;
		out.addr_code2	:= out.appl_code2;
		out.addr_unit2	:= out.appl_unit2;
		out.form_pfx	:= null;
		out.form_name	:= null;
		out.form_type	:= null;
		out.form_sfx	:= null;
		out.form_code1	:= null;
		out.form_unit1	:= null;
		out.form_code2	:= null;
		out.form_unit2	:= null;
	end if;

	return	00;

end	Main_Driver;


--	=================================================================
	procedure	Location_Driver		is
--	=================================================================

begin

	null;

end	Location_Driver;

--	=================================================================
	procedure	Batch_Driver
(
	spec_insert	in		number	default 0,
	spec_seq	in		number	default 0,

	spec_trace	in		number	default 0,
	spec_show	in		number	default 99,
	spec_focus	in		varchar2 default null
)
	is
--	=================================================================

	read_rowid			number := 0;
	read_app			number := 0;

begin

	      who:=''; Start_Trace (spec_trace, spec_show, spec_focus);

	      who:='Batch'; whom:='Begin'; Show_(90); show_Rule(-7);

	select count(*)
	into	total_record
	from  garland.adrResult;

	street_name		:= ' ';
	total_read		:= 0;
	total_input		:= 0;
	total_output	:= 0;
	total_record	:= 0;
	total_fuzzy		:= 0;
	commit_count	:= 0;	

loop

	read_rowid := 1;
	open	read_rowid_table;
	fetch	read_rowid_table		into row;
	exit when	read_rowid_table%notfound		
		or 	read_rowid_table%notfound is null
		or	row.row_seq > stop_seq;
	close	read_rowid_table;
	read_rowid := 0;
		
	read_app := 1;
	open	read_app_table;
	fetch	read_app_table		into appl;
	exit when	read_app_table%notfound		
		or 	read_app_table%notfound is null;
	close	read_app_table;
	read_app := 0;

	prev_seq	:= row.row_seq;
	total_read	:= total_read + 01;

	if	choose_name > '0'		then	
		if	appl.addr_name like '%'|| choose_name ||'%'	then
			null;
		else
			goto	end_record_loop;
		end if;
	end if;

	if	total_input < stop_count					then	
		total_input	:= total_input + 01;
	else
		dbms_output.put_line ('ERROR - Input Record Limit Exceeded');
		exit;
	end if;

--	if	total_input > trace_recs					then
--		tr_trace	:= 0;
--		trace_recs	:= null;
--	end if;

	      who:='Batch'; whom:='Appl'; Show_(90); show_In(-7); 

	out.appl_num	:= appl.appl_num;		
	out.appl_name	:= appl.appl_name;
	out.appl_type	:= appl.appl_type;
	out.appl_pfx	:= appl.appl_pfx ;
	out.appl_sfx	:= appl.appl_sfx ;
	out.appl_code1	:= appl.appl_code1;
	out.appl_unit1	:= appl.appl_unit1;
	out.appl_code2	:= appl.appl_code2;
 	out.appl_unit2	:= appl.appl_unit2;

	out.form_name	:= appl.form_name;	
	out.form_type	:= appl.form_type;
	out.form_pfx	:= appl.form_pfx ;
	out.form_sfx	:= appl.form_sfx ;
	out.form_code1	:= appl.form_code1;
	out.form_unit1	:= appl.form_unit1;
	out.form_code2	:= appl.form_code2;
 	out.form_unit2	:= appl.form_unit2;

	out.addr_num	:= appl.addr_num;		
	out.addr_name	:= appl.addr_name;
	out.addr_type	:= appl.addr_type;
	out.addr_pfx	:= appl.addr_pfx ;
	out.addr_sfx	:= appl.addr_sfx ;
	out.addr_code1	:= appl.addr_code1;
	out.addr_unit1	:= appl.addr_unit1;
	out.addr_code2	:= appl.addr_code2;
 	out.addr_unit2	:= appl.addr_unit2;

	out.verify_code	:= appl.verify_code;
	out.do_parse	:= appl.do_parse;
	out.do_alias	:= appl.do_alias;
	out.do_name		:= appl.do_name;
	out.do_qual		:= appl.do_qual;

	out.rec_rowid	:= appl.rec_rowid;			-- apr 2003
--	out.rec_rowid	:= row.row_id;				-- apr 2003

	out.rec_seq		:= row.row_seq;
	out.rec_key		:= rtrim(rpad(appl.rec_key, max_key_length));				

	out.parcel_id	:= appl.parcel_id;
	out.segment_id	:= appl.segment_id;

--	========================================

	decision := MAIN_DRIVER (spec_insert, spec_seq);	--	CALL

	if	decision = decide_loop		then
		goto	end_record_loop;
	end if;	

--	========================================
<<insert_result>>

	out.do_parse	:= nvl(out.do_parse, ' ');			
	out.do_alias	:= nvl(out.do_alias, ' ');
	out.do_name		:= nvl(out.do_name,  ' ');
	out.do_qual		:= nvl(out.do_qual,  ' ');

	      who:='Batch'; whom:='Insert'; Show_(50); show_Out(9); 

	if	rule.keep_unparsed = rule.no			then
		out.appl_name	:= null;
		out.appl_type	:= null;
		out.appl_pfx	:= null;
		out.appl_sfx	:= null;
		out.appl_code1	:= null;
		out.appl_unit1	:= null;
		out.appl_code2	:= null;
		out.appl_unit2	:= null;
		out.appl_num	:= null;
	end if;

	if	rule.keep_parsed = rule.no			then
		out.form_name	:= null;
		out.form_type	:= null;
		out.form_pfx	:= null;
		out.form_sfx	:= null;
		out.form_code1	:= null;
		out.form_unit1	:= null;
		out.form_code2	:= null;
		out.form_unit2	:= null;
	end if;

	if	rule.keep_unparsed = rule.yes				
	and	out.verify_code = rule.non_address		then
		out.addr_name	:= out.appl_name;
		out.addr_type	:= out.appl_type;
		out.addr_pfx	:= out.appl_pfx;
		out.addr_sfx	:= out.appl_sfx;
		out.addr_code1	:= out.appl_code1;
		out.addr_unit1	:= out.appl_unit1;
		out.addr_code2	:= out.appl_code2;
		out.addr_unit2	:= out.appl_unit2;
--		out.do_alias	:= null;	
	end if;

	if	do_insert > 0					then

		insert into	garland.adrResult		
		select			

			out.addr_num,	
			out.addr_pfx,						
			out.addr_name,	
			out.addr_type,	
			out.addr_sfx,
			out.addr_code1,	
			out.addr_unit1,	
			out.addr_code2,	
			out.addr_unit2,	

			out.verify_code,
			out.do_parse, 					
			out.do_alias, 
			out.do_name,  
			out.do_qual,  

			row.row_seq,	
--			row.row_id,
			out.rec_rowid,				-- apr 2003
			out.rec_key,

			out.parcel_id,
			out.segment_id,	

			out.form_pfx,			
			out.form_name,	
			out.form_type,	
			out.form_sfx,	
			out.form_code1,
			out.form_unit1,	
			out.form_code2,	
			out.form_unit2,	

			out.appl_pfx,
			out.appl_name,
			out.appl_type,
			out.appl_sfx,
			out.appl_code1,
			out.appl_unit1,
			out.appl_code2,	
			out.appl_unit2,	
			out.appl_num	

		from dual;

		total_output := total_output + sql%rowcount;

		commit_count := commit_count + 01;	
		if	commit_count >= commit_size		then
			commit_count := 0;
			commit;
		end if;

		if	total_record  < rule.capacity		then
			total_record := total_record + 01;
		else
			dbms_output.put_line ('ERROR - Output Record Limit Exceeded');
			exit;
		end if;

	end if;

--	========================================
<<end_record_loop>>

	null;

	      who:='Batch'; whom:='End'; Show_(90); show_Out(-7); 

end loop;	

	if	read_rowid > 0			then
		close read_rowid_table;
	end if;

	if	read_app > 0			then
		close read_app_table;
	end if;

	commit;

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'GIS ADDRESS RESOLVE  '||to_char (sysdate, 'mon dd,yyyy hh24:mi:ss' ));
	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'read       = '   	||lpad(total_read		,6));
	dbms_output.put_line ( 'input      = '   	||lpad(total_input	,6));
	dbms_output.put_line ( 'insert     = '   	||lpad(total_output	,6));
	dbms_output.put_line ( 'total      = '   	||lpad(total_record	,6));
	dbms_output.put_line ( 'alias      = '   	||lpad(total_alias	,6));
	dbms_output.put_line ( 'fuzzy      = '   	||lpad(total_fuzzy	,6));

--	dbms_output.put_line ( ' ' );
--	dbms_output.put_line ( 'test1	     = '   	||lpad(test_count1	,6));
--	dbms_output.put_line ( 'test2	     = '   	||lpad(test_count2	,6));
--	dbms_output.put_line ( 'test3	     = '   	||lpad(test_count3	,6));

	      who:=''; whom:=''; Show_(50); Stop_Trace;

	return;

end	Batch_Driver;


--	=================================================================
	procedure	Query_Driver
--	=================================================================

(
	addr_num	in out	varchar2,
	addr_pfx	in out	varchar2,
	addr_name	in out	varchar2,
	addr_type	in out	varchar2,
	addr_sfx	in out	varchar2,

	addr_code1	in out	varchar2,
	addr_unit1	in out	varchar2,
	addr_code2	in out	varchar2,
	addr_unit2	in out	varchar2,

	form_pfx	in out	varchar2,
	form_name	in out	varchar2,
	form_type	in out	varchar2,
	form_sfx	in out	varchar2,

	form_code1	in out	varchar2,
	form_unit1	in out	varchar2,
	form_code2	in out	varchar2,
	form_unit2	in out	varchar2,

	verify_code	out		number,
	gis_key	out		varchar2,
	audit		out		varchar2,

	spec_insert	in		number	default 0,
	spec_seq	in		number	default 0,

	spec_trace	in		number	default 0,
	spec_show	in		number	default 0,
	spec_focus	in		varchar2 default null
)

is
begin

	      who:=''; Start_Trace (spec_trace, spec_show, spec_focus);

	total_read		:= 0;
	total_input		:= 0;
	total_output	:= 0;
	total_record	:= 0;
	total_fuzzy		:= 0;
	commit_count	:= 0;	

	street_name		:= ' ';

	out.appl_num	:= addr_num;
	out.appl_pfx	:= addr_pfx;
	out.appl_name	:= addr_name;
	out.appl_type	:= addr_type;
	out.appl_sfx	:= addr_sfx;
	out.appl_code1	:= addr_code1;
	out.appl_unit1	:= addr_unit1;
	out.appl_code2	:= addr_code2;
	out.appl_unit2	:= addr_unit2;
	out.form_name	:= null;
	out.addr_name	:= null;

	      who:='Query'; whom:='Begin'; Show_(90); show_Out(-7); show_Rule(-7);

	decision := MAIN_DRIVER (spec_insert, spec_seq);	--	CALL

	addr_num		:= out.addr_num;
	addr_pfx		:= out.addr_pfx;
	addr_name		:= out.addr_name;
	addr_type		:= out.addr_type;
	addr_sfx		:= out.addr_sfx;
	addr_code1		:= out.addr_code1;
	addr_unit1		:= out.addr_unit1;
	addr_code2		:= out.addr_code2;
	addr_unit2		:= out.addr_unit2;

	form_pfx		:= out.form_pfx;
	form_name		:= out.form_name;
	form_type		:= out.form_type;
	form_sfx		:= out.form_sfx;
	form_code1		:= out.form_code1;
	form_unit1		:= out.form_unit1;
	form_code2		:= out.form_code2;
	form_unit2		:= out.form_unit2;

	verify_code		:= out.verify_code;
	gis_key		:= nvl(out.parcel_id, out.segment_id);

	out.do_parse	:= nvl(out.do_parse, ' ');			
	out.do_alias	:= nvl(out.do_alias, ' ');
	out.do_name		:= nvl(out.do_name,  ' ');
	out.do_qual		:= nvl(out.do_qual,  ' ');

	audit			:=	' '
					||'  parse=' || out.do_parse 
					||'  alias=' || out.do_alias 
					||'  name='	 || out.do_name  
					||'  qual='	 || out.do_qual;

	if	test_count1 + test_count2 + test_count3 > 0		then
		dbms_output.put_line ( 'Test Counts ' || test_count1 ||' '|| test_count2 ||' '|| test_count3);
	end if;

	      who:='Query'; whom:='End'; Show_(90); show_Out(-7); Stop_Trace;

	return;
	
end	Query_Driver;

--	==================================================================================
--	T R A C E   B E G I N
--	==================================================================================

--	========================================
	procedure	Start_Trace	(	spec_trace	number	default 0, 
						spec_show	number	default 99, 
						spec_focus	varchar2	default null	)		
	is
--	========================================
begin

	tr_trace		:= spec_trace;
	tr_show		:= spec_show;
	tr_focus		:= lower(spec_focus);

	if	tr_trace = 0	then
		return;
	end if;

	who			:= trace_new_line;	
	whom			:= null;
	trace_whox		:= null;
	trace_whatx		:= null;
	trace_what1		:= null;
	trace_what2		:= null;
	trace_who		:= null;
	trace_whom		:= null;
	show			:= null;
	trace_shown		:= null;
	trace_flown		:= null;
	trace_break		:= null;
	trace_done		:= 0;
	trace_count1	:= 0;
	trace_count2	:= 0;
	trace_put		:= 0;
	trace_flow_leng	:= 0;
	trace_data	:= 1;
	trace_option	:= '0'|| abs(tr_trace) ||'0';

	show_Break;		

end	Start_Trace;

--	========================================
	procedure	Stop_Trace		is
--	========================================
begin
	if	tr_trace = 0		then
		return;
	end if;

	who := trace_new_line; show_Break;
	Trace_Flow; 

	trace_work1	:= 01;
	trace_work2	:= length(trace_flown);
	trace_put	:= 0;
	while	trace_work2 > 0				loop
		trace_put	:= trace_put + 01;
		trace_work2	:= instr(trace_flown, chr(03), trace_work1);
		if	trace_work2 > 0					then
			trace_work2	:= trace_work2 - trace_work1;
			trace_work	:= substr (trace_flown, trace_work1, trace_work2);
			dbms_output.put_line (trace_work);

			if	trace_option like trace_file_on 	then	
				insert into gis_objects (item01,item02) 
						values	('flow.'||lpad(trace_put,03,'0'), trace_work);
			end if;
		end if;
		trace_work1	:= trace_work1 + trace_work2 + 01;
	end loop;
	Show_Break;	

end	Stop_Trace;

--	========================================
	procedure	Show_Break			is
--	========================================
begin
	trace_break	:= nvl (trace_break, '*');

	if	tr_trace <> 0						then	
		dbms_output.put_line (' ');
		dbms_output.put_line (rpad(trace_break,70,trace_break));
	end if;

	trace_break	:= null;
end	Show_Break;

--	========================================
--	========================================
	procedure	show_Rule	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Rule';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:= 	'N='	 || rule.do_name	||'\S=' || rule.do_street	    ||'\B=' || rule.do_block ||
			'\R='  || rule.do_range	||'\A=' || rule.do_address 	    ||	
			'|| P='|| rule.do_parse	||'\E1='|| rule.do_unparsed_exit  ||'\E2='|| rule.do_parsed_exit; 
	trace_what2 := 'Do';	Track_Data;

	show	:= 	'A='	 || rule.do_type_A	||'\B='|| rule.do_type_B	||'\C='|| rule.do_type_C	||
			'|| A='|| rule.do_alias;
	trace_what2 := 'Name';	Track_Data;

	show	:= 	'S=' 	 || rule.str_pfx ||','|| rule.str_type ||','|| rule.str_sfx ||
			'|B='	 || rule.blk_pfx ||','|| rule.blk_type ||','|| rule.blk_sfx;
	trace_what2 := 'Qual';	Track_Data;

	show	:=	'R='	 || rule.rng_pfx ||','|| rule.rng_type ||','|| rule.rng_sfx ||
			'|A='	 || rule.adr_pfx ||','|| rule.adr_type ||','|| rule.adr_sfx;
	trace_what2 := '';	Track_Data;

	show	:= 	'B\'	  || rule.permit_blk_basis ||','|| rule.permit_blk_append ||','|| rule.permit_blk_remove ||'\'|| rule.permit_blk_change ||
			'|| R\' || rule.permit_rng_basis ||','|| rule.permit_rng_append ||','|| rule.permit_rng_remove ||'\'|| rule.permit_blk_change ||
			'|| A\' || rule.permit_adr_basis ||','|| rule.permit_adr_append ||','|| rule.permit_adr_remove ||'\'|| rule.permit_blk_change;
	trace_what2 :=	'Permit';	Track_Data;
end;

--	========================================
	procedure	show_In	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'In';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:= 	'Seq='|| lpad(out.rec_seq, 5,'0') ||'\ Key='|| rpad(out.rec_key,20,'.');
	trace_what2 := 'Record';	Track_Data;

	show	:= 	''|| lpad(appl.addr_num, 5,'0') ||'\'|| rpad(appl.addr_pfx,2,'.') ||'\'|| rpad(appl.addr_name,15,'.') ||'\'|| 
			rpad(appl.addr_type,5,'.')	  ||'\'|| rpad(appl.addr_sfx,2,'.');
	trace_what2 := 'Addr';	Track_Data;

	show	:= 	''|| lpad(appl.addr_num, 5,'0') ||'\'|| rpad(appl.form_pfx,2,'.') ||'\'|| rpad(appl.form_name,15,'.') ||'\'|| 
			rpad(appl.form_type,5,'.')	  ||'\'|| rpad(appl.form_sfx,2,'.');
	trace_what2 := 'Form';	Track_Data;

	show	:= 	''|| lpad(appl.appl_num, 5,'.') ||'\'|| rpad(appl.appl_pfx,2,'.') ||'\'|| rpad(appl.appl_name,15,'.') ||'\'|| 
			rpad(appl.appl_type,5,'.')	  ||'\'|| rpad(appl.appl_sfx,2,'.');
	trace_what2 := 'Appl';	Track_Data;
end;

--	========================================
	procedure	show_Out	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Out';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:= 	''|| lpad(out.addr_num, 5,'0') ||'\'|| rpad(out.addr_pfx,2,'.') ||'\'|| rpad(out.addr_name,15,'.') ||'\'|| 
			rpad(out.addr_type,5,'.')	 ||'\'|| rpad(out.addr_sfx,2,'.');
	trace_what2 := 'Addr';	Track_Data;

	show	:= 	'verify=' || (out.verify_code)	||'/alias='|| (out.do_alias)  ||'/name='|| (out.do_name) 
			||'/qual='|| (out.do_qual)		||'/parse='|| (out.do_parse);
	trace_what2 := 'Flags';	Track_Data;

	show	:= 	''|| lpad(out.addr_num, 5,'0') ||'\'|| rpad(out.form_pfx,2,'.') ||'\'|| rpad(out.form_name,15,'.') ||'\'|| 
			rpad(out.form_type,5,'.')	 ||'\'|| rpad(out.form_sfx,2,'.');
	trace_what2 := 'Form';	Track_Data;

	show	:= 	''|| lpad(out.appl_num, 5,'.') ||'\'|| rpad(out.appl_pfx,2,'.') ||'\'|| rpad(out.appl_name,15,'.') ||'\'|| 
			rpad(out.appl_type,5,'.')	 ||'\'|| rpad(out.appl_sfx,2,'.');
	trace_what2 := 'Appl';	Track_Data;
end;

--	========================================
	procedure	show_Read	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Read';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:= 	''|| lpad(read_num, 5,'0') ||'\'|| rpad(read_pfx,2,'.') ||'\'|| rpad(read_name,15,'.') ||'\'|| 
			rpad(read_type,5,'.')	   ||'\'|| rpad(read_sfx,2,'.');
	trace_what2 := 'Addr';	Track_Data;

	show	:= 	''|| rpad(read_code1,5,'.')	||'\'|| rpad(read_unit1,10,'.') ||'\'|| 
			rpad(read_code2,5,'.')		||'\'|| rpad(read_unit2,10,'.');
	trace_what2	:= 'Unit';	Track_Data;
end;

--	========================================
	procedure	show_Fetch	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Fetch';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	if	phase = street_phase					then
	trace_what2 := 'STRT';	
	show	:=	rpad(' ',5)	||'\'||
			rpad(strt.addr_pfx, 2,'.') ||'\'|| rpad(strt.addr_name,15,'.') ||'\'|| 
			rpad(strt.addr_type,5,'.') ||'\'|| rpad(strt.addr_sfx,2,'.');

	elsif	phase = block_phase					then
	trace_what2 := 'BLOK';	
	show	:=	 lpad(blok.addr_block, 5,'0') ||'\'|| rpad(blok.addr_pfx, 2,'.') ||'\'|| rpad(blok.addr_name,15,'.')||'\'|| 
			 rpad(blok.addr_type,  5,'.')	||'\'|| rpad(blok.addr_sfx, 2,'.');

	elsif	phase = address_phase					then
	trace_what2 := 'ADDR';	
	show	:=	lpad(addr.addr_num, 5,'0') ||'\'|| rpad(addr.addr_pfx, 2,'.') ||'\'|| rpad(addr.addr_name,15,'.')||'\'|| 
			rpad(addr.addr_type,5,'.') ||'\'|| rpad(addr.addr_sfx, 2,'.');

	elsif	phase = segment_phase					then
	trace_what2 := 'SEGM';	
	show	:=	lpad(segm.addr_lo,  5,'0') ||'\'|| rpad(segm.addr_pfx, 2,'.') ||'\'|| rpad(segm.addr_name,15,'.')||'\'|| 
			rpad(segm.addr_type,5,'.') ||'\'|| rpad(segm.addr_sfx, 2,'.');

	end if;

	Track_Data;


	if	phase = street_phase					then
		show	:=	'Compact='	|| strt.addr_compact || ' Reduce=' || strt.addr_reduced;
		Track_Data;
	end if;

end;

--	========================================
	procedure	show_Best	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Best';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:= 	''||	lpad(this_num, 5,'0') ||'\'|| rpad(this_pfx,2,'.') ||'\'|| rpad(this_name,15,'.') ||'\'|| 
				rpad(this_type,5,'.') ||'\'|| rpad(this_sfx,2,'.');
	trace_what2 := 'This';	Track_Data;

	show	:= 	''||	rpad(' ', 5)		||'\'|| rpad(best_pfx,2,'.') ||'\'|| rpad(best_name,15,'.') ||'\'|| 
				rpad(best_type,5,'.')	||'\'|| rpad(best_sfx,2,'.');
	trace_what2 := 'Best';	Track_Data;
end;

--	========================================
	procedure	show_Basic	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Basic';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:=	'Phase='	|| step ||','|| phase || 
			' Verify='	|| verify_id ||' Decide='|| decision	||' Retry='|| retry;
	trace_what2 := '';	Track_Data;

	show	:=	'NameNum='	|| out.addr_name||','|| out.addr_num;
	trace_what2 := '';	Track_Data;

	show	:=	'Compact='	|| compact_name	|| '\ Reduce=' || reduced_name ||
			'\ Range='	|| range_lo||','	|| range_hi;
	trace_what2 := '';	Track_Data;
end;

--	========================================
	procedure	show_Verify	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Verify';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:=	'Verify='|| out.verify_code ||'\ Str#='|| street_count ||'\ Accept#='|| accept_count;
	trace_what2 := '';	Track_Data;

	show	:=	   'Str=' || str.fetch_count ||','|| str.match_count ||','|| str.match_score
			||' Blk=' || blk.fetch_count ||','|| blk.match_count ||','|| blk.match_score 
			||' Seg=' || seg.fetch_count ||','|| seg.match_count ||','|| seg.match_score
			||' Adr=' || adr.fetch_count ||','|| adr.match_count ||','|| adr.match_score;
	trace_what2 := 'FeMaSc';	Track_Data;
end;

--	========================================
	procedure	show_Name	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Name';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:=	'Street='|| street_name ||'\ Name#='|| name_count;
	trace_what2 := '';	Track_Data;

	show	:=	'Table='	|| alias_table	||'\ Method='|| alias_method ||'\ Result='|| alias_result;
	trace_what2 := 'Alias';	Track_Data;

	show	:=	'This=' || this_name_chg||'\ Best=' || best_name_chg ||'\'|| best_name;
	trace_what2 := 'Chg';	Track_Data;
end;

--	========================================
	procedure	show_Audit	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Audit';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:= 	'Mat='	|| match_prefix ||','|| match_type ||','|| match_suffix 
			||'| Unq='	|| unique_prefix||','|| unique_type||','|| unique_suffix;
	trace_what2 := '';	Track_Data;

	show	:=	'Aud='	|| audit_prefix	||','|| audit_type ||','|| audit_suffix 
			||'| This='	|| this_audit	||'\Best='|| best_audit;
	trace_what2 := '';	Track_Data;
end;

--	========================================
	procedure	show_Accept	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Accept';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:= 	'PTS='		|| accept_prefix ||','||		accept_type ||','|| accept_suffix
			||'| Initial='	|| accept_initial||'\ Accept='||	accept_count; 
	trace_what2 := '';	Track_Data;
end;

--	========================================
	procedure	show_Weight	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Weight';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:= 	'Str='	|| street_weight ||' Blk=' || block_weight 
			||' Seg='	|| segment_weight||' Adr=' || address_weight; 
	trace_what2 := 'SBRA';	Track_Data;

	show	:= 	'Prev='	|| prev_best ||'\This='|| this_weight ||'\Best='|| best_weight; 
	trace_what2 := '';	Track_Data;
end;

--	========================================
	procedure	show_Score	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Score';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;	

	show	:=	'Str='|| str.match_score ||'\ Blk='||  blk.match_score ||'\ Seg='|| seg.match_score ||'\ Adr='|| adr.match_score;
	trace_what2 := 'Match';	Track_Data;

	show	:=	'Prev='|| prev_score	||'\ Best='|| best_score;
	trace_what2 := 'Score';	Track_Data;

	show	:=	'App='||  permit_append	||'\ Rem='||  permit_remove   ||'\ Upd='|| permit_change;
	trace_what2 := 'Permit';	Track_Data;
end;

--	========================================
	procedure	show_Work	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Work';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:= 	'Rule=' || work.rule_pfx	||','|| work.rule_type	 ||','|| work.rule_sfx	||
			'| FMS='|| work.fetch_count	||','|| work.match_count ||','|| work.match_score;
	trace_what2 := '';		Track_Data;
end;
		
--	========================================
	procedure	show_Trace	(spec_lines number)	is
--	========================================
begin	
	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:=	'	'||
			trace_whox   ||	rpad('='|| whom, sign(length(whom)) * (length(whom) + 01))	|| '  ' ||	
			' trace level=' || trace_level ||' trace focus='|| trace_focus ||' trace button='|| trace_data ||
			' trace done='  || trace_done;
	dbms_output.put_line (show);	

	if	trace_lines > 01		then
		show	:= 'trace lines='	|| trace_lines ||' trace put=' || trace_put ||
			   ' tr trace='	|| tr_trace	   ||' tr show='	 || tr_show	  ||' tr focus='|| tr_focus;
		dbms_output.put_line (show);	
	end if;

	if	trace_lines > 02		then
		dbms_output.put_line (show);	
	end if;

--	if	trace_lines > 0		then
--		show	:= 	''||  ||''||  ||''||  ||''||  ||''||   ||''||  ||
--				''||  ||''||  ||''||  ||''||  ||''||   ||''||  ||
--		dbms_output.put_line (show);	
--	end if;

	dbms_output.put_line (' ');	
	show	:= null;

end;

--	========================================
--	========================================
	procedure	Track_Data			is
--	========================================
begin

	if	tr_trace = 0			then	
		return;
	end if;

	if	who >= '!'				then
		trace_whox		:= ltrim(who, trace_new_line);
		trace_who	:= who;
		trace_whom	:= whom;
	elsif	whom >= '!'				then
		trace_who	:= trace_whox;
		trace_whom	:= whom;
	end if;

	trace_who := ltrim(trace_who, trace_new_line);

	if	trace_what1 >= '!'
	and	trace_what1 <> trace_whatx	then
		trace_put	:= 0;
		trace_done	:= 0;
	end if;
	
	if	trace_done < 1			then		
		trace_work 		:= chr(01) || trace_what1 || chr(01);
		trace_work1		:= instr (trace_shown, trace_work);		-- has data group been shown ?
		if	trace_work1	= 0		then					-- if not
			trace_done	:= 1;							-- then mark for show
			trace_shown	:= trace_shown || trace_work;		
		else
			trace_done	:= 2;							-- else mark as done
		end if;
	end if;

	trace_work1	:= 0;								--	show data ?
	trace_work2	:= 0;								--	show step ?

	if (	tr_trace	> 0  							--	if  trace = all   & spec = on
	or	trace_lines	< 0	)						--	or  trace = basic & spec = basic
	and	trace_level <= tr_show				then		--	and data level is within scope
		trace_work1 := 1;
	elsif	trace_focus > 0					then		--	if  focus data
		trace_work1 := 1;							
	end if;		
	
	if	trace_work1  > 0
	and	trace_who || show is not null					--	if  there is something to show
	and 	trace_put  < abs(trace_lines)					--	and displayed lines < spec lines
	and	trace_done = 1							--	and this display is being done
	and	tr_show   <> 0					then
		null;						
	else
		trace_work1 := 0;
	end if;

	if	trace_work1 > 0					then

		if	trace_who >= '!'				then
			dbms_output.put_line (' ');
		end if;

		trace_who	:= nvl(trace_who  ,' ');
		trace_what1	:= nvl(trace_what1,' ');
		trace_what2	:= nvl(trace_what2,' ');

		if	trace_whom >= '!'				then
			trace_who := trace_who || '=' || trace_whom;
		end if;

--		if	show is null
--		and	tr_show < 0					then
--			null;
--		else

			trace_count1 := trace_count1 + 01;
			trace_work := rpad(trace_who, trace_who_leng);
			trace_work := trace_work 				||' ' ||
					rpad(trace_what1, trace_what1_leng)	||' ' ||
					rpad(trace_what2, trace_what2_leng)	||' |'|| 
					show ||'|';

			if	trace_option not like trace_print_off 		then
				dbms_output.put_line (trace_work);
				if	length (trace_work) > trace_line_leng	then
					dbms_output.put_line (rpad('`',trace_line_leng,'`'));
				end if;
			end if;
			
			if	trace_option like trace_file_on 		then
				insert into gis_objects (item01, item02, item03, item04,item05)	values
				( 'data' ||'.'|| lpad(trace_count1,3,'0'), trace_work, who, trace_what1, trace_what2);
			end if;
--		end if;

		if	trace_what1 >= '!'				then
			trace_whatx		:= trace_what1;
			trace_what1		:= ' ';
		end if;

		trace_who	:= null;
		trace_whom	:= null;
		trace_put	:= trace_put + 01;
	end if;

	trace_what2		:= ' ';
	show		:= null;

	if	trace_option like trace_of_debug1		then			-- DEBUG
		show_Trace (1);
	end if;

	if	trace_count1 > trace_max_data	then
		raise_application_error (-20101 ,'TRACE ERROR - maximum tracking exceeded');
	end if;

	Trace_Flow;

end	Track_Data;

--	========================================
	procedure	Trace_Flow			is
--	========================================
begin

	if	tr_trace = 0		then	
		return;
	end if;

	if	whom >= '!'					then
		who	:= nvl(who, trace_whox);
	end if;

	if	who >= '!'	
	and	trace_option not like trace_flow_off		then
		trace_count2	:= trace_count2 + 01;

		if 	who like trace_new_line || '%'
		or	trace_flow_leng + trace_who_leng > trace_line_leng	then	
			trace_flown		:= rtrim(trace_flown) || chr(03);
			trace_flow_leng	:= 0;
		end if;

		if	whom >= '!'					then
			who	:= who || '=' || whom;
		end if;

		if	who <> trace_new_line			then
			who			:= rpad (ltrim(who, trace_new_line), trace_who_leng);
			trace_flown 	:= trace_flown || who || ' ';
			trace_flow_leng	:= trace_flow_leng + trace_who_leng + 01;	
		end if;

	end if;

	who	:= null;
	whom	:= null;

	if	trace_count2 > trace_max_flow		then
		raise_application_error (-20102 ,'TRACE ERROR - maximum tracing exceeded');
	end if;

end	Trace_Flow;

--	========================================
	procedure	Show_	(spec_scope number) is
--	========================================
begin
	trace_level	:= spec_scope;	

	if	tr_trace = 0		then
		return;
	end if;

	if	who || whom >= '!'	then		--	always show trace flow ("who")
		trace_done	:= 0;
		trace_data	:= 0;
		show		:= null;
		Track_Data;
	end if;

	trace_data := 01;

	trace_what1	:= chr(02);
	trace_whatx	:= chr(02);
	trace_shown	:= chr(01);
	trace_focus	:= 1;

	if	trace_done = -1		then		--	rearrange
		trace_level	:= 0;
	else
		trace_done	:= 0;
	end if;

--	Choose FOCUS data display(s)
	if	trace_level <> 0		then
		trace_put	:= 0;
		if tr_focus is not null	then

		if tr_focus like	'%out%'		then show_Out	(9);	end if;
		if tr_focus like	'%weight%'		then show_Weight	(9);	end if;
		if tr_focus like	'%score%'		then show_Score	(9);	end if;
		if tr_focus like	'%work%'		then show_Work	(9);	end if;
		if tr_focus like	'%read%'		then show_Read	(9);	end if;
		if tr_focus like	'%fetch%'		then show_Fetch	(9);	end if;
		if tr_focus like	'%best%'		then show_Best	(9);	end if;
		if tr_focus like	'%name%'		then show_Name	(9);	end if;
		if tr_focus like	'%audit%'		then show_Audit	(9);	end if;
		if tr_focus like	'%accept%'		then show_Accept	(9);	end if;
		if tr_focus like	'%basic%'		then show_Basic	(9);	end if;
		if tr_focus like	'%verify%'		then show_Verify	(9);	end if;
		if tr_focus like	'%rule%'		then show_Rule	(9);	end if;
		if tr_focus like	'%in%'		then show_In	(9);	end if;

		end if;
	end if;

	trace_focus	:= 0;
	trace_done	:= -1;

end	Show_;


--	========================================
	procedure	Trace_Developer		is
--	========================================
--	--------------------------------------------------------------

	trace_all		number;
	trace_range		number;
	trace_step		number;
	trace_data		number;
	trace_both		number;

--	trace_all		whether to show all or selected steps
--	trace_range		whether within range of steps for display
--	trace_step		whether to show step
--	trace_data		whether to show data
--	trace_both		track only steps with data

--	--------------------------------------------------------------

begin

--	Start Trace

	trace_range := 0;

	if	tr_focus like '-%'	then
		trace_all := 0;
	else
		trace_all := 1;
	end if;

	if	tr_focus like '%=%'	then
		trace_both := 1;
	else
		trace_both := 0;
	end if;

--	Show_()

	trace_step := trace_all;

--	is this a non-basic step ?

	if	tr_show	 < 0
	and	trace_level  > 0				then
		trace_step  := 0;
	end if;


--	should all steps be traced 
--	or is this a focus step

	if	trace_step > 0				then
		trace_work1	:= 0;
	else
		trace_work1	:= instr (tr_focus, who);
	end if;
		
	if	trace_work1 > 0			then
		trace_work	:= substr (tr_focus, trace_work1 - 01, 01);
		if	trace_work =  '+'		then
			trace_range	:= trace_range + 01;
		elsif	trace_work =  '-'		then
			trace_range	:= trace_range - 01;
		elsif	trace_work = '.'		then
			trace_range	:= 0;
		elsif	trace_work = ':'		then
			trace_range	:= 1;
		end if;

		if	trace_work  = ' '
		or	trace_range > 0		then
			trace_step := 1;
		else
			trace_step := 0;
		end if;
	end if;
	

--	should data be tracked ?

	if	show is not null
	and	trace_step > 0
	and	trace_put  < abs(trace_lines)		then
		trace_data	:= 1;
	else
		trace_data	:= 0;
	end if;

--	track any data 
--	or trace basic data

	if	tr_trace > 0
	or	trace_lines < 0				then
		null;
	else
		trace_data	:= 0;
	end if;

--	is this a focus step 
--	is data level too high
--	has data already been shown at this step

	if	trace_level = 0				then
		trace_data	:= 1;
	elsif	abs(trace_level) > abs(tr_show)	then
		trace_data	:= 0;
	elsif	trace_done <> 2				then
		trace_data	:= 0;
	end if;

--	========================================
end;

--	==================================================================================
	procedure	Resolve_Developer		is
--	==================================================================================

--	==================================================================================

begin

	null;

end;

--	==================================================================================

--	==================================================================================
--	T R A C E   E N D
--	==================================================================================

end	Resolve_Address;

--	==================================================================================
/*
--	================================================================================================
	DOCUMENT & TEMPLATES
--	================================================================================================

	tr_trace		spec	options
				neg	track basic data only
				zero	suppress trace

	tr_show		spec	priority level
				neg	track only steps w/ data
				zero	trace flow only

	tr_focus		spec	focus steps & focus data

				step	= who
				data	= what1

				stp			do who='stp'		(ignore trace_range)
				[abc ]def		do 'abc' thru 'def'	(nested trace_range)
				+jkl			track on  at 'jkl'	(reset  trace_range = 1)
				-mnp			track off at 'mnp'	(reset  trace_range = 0)

				'...'			show focus data & data levels
				'- ...'		do focus steps only
				'-- ..'		do focus steps and focus data only (no basic data)
				'/....'		ignore tr_focus

	options

			trace_print_only		default
			trace_file_only		varchar2(10)	:= '%0110%';	
			trace_print_file		varchar2(10)	:= '%0120%';	

			trace_debug1		varchar2(10)	:= '%0910%';
			trace_debug2		varchar2(10)	:= '%0920%';



	who & whom		define a "step" in the trace
	Show_()		controls trace_what happens at this "step"
	show_xxxx()		calls a "display" procedure of 1 or more lines

	Show_(...)		does "focus" displays which are shown at every "step"

	Show_(0)		print "focus" displays only
	Show_(s)		print "step" displays if "scope" |s| <= tr_show
	Show_(-s)		"basic step" with "scope" = s

	show_xxxx (0)	suppress this "display" 
	show_xxxx (m)	prints max of m lines of "display" 
	show_xxxx (-m)	"basic item" with max lines = m

	Options		example:  0110120910 = options 11, 12, & 91
				(see package constants)

	tr_trace	
		 0		suppress trace entirely
		+o,-o		activate trace, set options = o
		-o		track "basic items" only

	tr_show
		 0		trace logic flow only
		+s		track all steps	  with scope <= s
		-s		track "basic steps" with scope <= s

	tr_focus		specify focus steps (who)
				specify focus items (trace_what1)

--	========================================
--	Tasks
		trace_data	levels (spec_level in pkg)
		trace_done		named constants
		
--	========================================
	procedure	Show_	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= '';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;	

	show	:= 	''||  ||''||  ||''||  ||''||  ||''||   ||''||  ||
			''||  ||''||  ||''||  ||''||  ||''||   ||''||  ||
	trace_what2 := '';	Track_Data;

	show	:= 	''||  ||''||  ||''||  ||''||  ||''||   ||''||  ||
			''||  ||''||  ||''||  ||''||  ||''||   ||''||  ||
	trace_what2 := '';	Track_Data;

	show	:= 	''||  ||''||  ||''||  ||''||  ||''||   ||''||  ||
			''||  ||''||  ||''||  ||''||  ||''||   ||''||  ||
	trace_what2 := '';	Track_Data;

	show	:=	''|| rpad(,,'.') ||''|| rpad(,,'.') ||''|| rpad(,,'.') ||''|| rpad(,,'.') ||
			''|| rpad(,,'.') ||''|| rpad(,,'.') ||''|| rpad(,,'.') ||''|| rpad(,,'.') ||
	trace_what2 := '';	Track_Data;
end;
--	================================================================================================

		if tr_focus like	'%%'		then show_	(9);	end if;

	      who:=''; whom:=''; Start_Trace (tr_trace, tr_show, tr_focus);
	      who:=''; whom:=''; Stop_Trace;

	      who:= trace_new_line;	Show_(0); 
	      who:= 'LOOP'; whom:=''; Show_(50); 

	      who:=''; whom:=''; Show_(50); show_(9); show_(9); show_(9); show_(9); show_(9);

--	================================================================================================
*/



