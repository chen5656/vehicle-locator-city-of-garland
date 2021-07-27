--	=====================================================================
set echo		off;
set linesize	2000;
set pagesize	9999;
set sqlblanklines	on;
set timing		off;
set serveroutput	on	size 99999;

--	=====================================================================
	create or replace	package body  garland.SCRUB_ADDRESS_RESULT	AS
--	=====================================================================

--	=====================================================================
--	TASKS

		rule.		
		user exits
		

--	=====================================================================
--	MODIFICATIONS

--	=====================================================================

--	=====================================================================

	do_insert			binary_integer		:= 0;

	start_seq			binary_integer		:= 01;
	stop_seq			binary_integer		:= rule.capacity;
	stop_count			binary_integer		:= rule.capacity;
	choose_name			varchar2(80)		:= '';
	choose_num			varchar2(80)		:= '';

--	========================================
--	control constants

	prev_seq			binary_integer	:= start_seq - 01;
	max_key_length		binary_integer	:= 20;		
	max_phase_loops		binary_integer	:= 02;
	loop_limit			binary_integer	:= 02;

--	commit_size			binary_integer	:= 1000;
	commit_size			binary_integer	:= 01;	

	street_phase		char		:= 'S';
	block_phase			char		:= 'B';
	segment_phase		char		:= 'R';
	address_phase		char		:= 'A';
	intersect_phase		char		:= 'X';
	
	spec_reduced		char		:= '1';	
	spec_compact		char		:= '4';
	spec_hi_range		binary_integer	:= 999999;

	decide_loop			binary_integer 	:= 10;
	decide_exit			binary_integer 	:= 20;
	decide_insert		binary_integer	:= 70;
	decide_return		binary_integer	:= 80;
	decide_error		binary_integer	:= 90;

	same_weight			binary_integer	:= 30;
	reduced_weight		binary_integer	:= 20;
	compact_weight		binary_integer	:= 10;

	reduced_alias		binary_integer	:= ADR_find.reduced_score;
	compact_alias		binary_integer	:= ADR_find.compact_score;

	match_weight		binary_integer	:= rule.match;
	blank_weight		binary_integer	:= rule.blank;
	append_weight		binary_integer	:= rule.append;
	change_weight		binary_integer	:= rule.change;
	remove_weight		binary_integer	:= rule.remove;
	forbid_weight		binary_integer	:= rule.match * - 10;

	like_non_address		varchar2(3)	:= '%'|| rule.mark_non_address;
	like_non_garland		varchar2(3)	:= '%'|| rule.mark_non_garland;
	like_non_complete		varchar2(3)	:= '%'|| rule.mark_non_complete;
	like_verify_only		varchar2(3)	:= '%'|| rule.mark_verify_only;
	like_parse_error		varchar2(3) := 	   rule.mark_parse_error || '%';

	parse_default		varchar2(90) := rule.parse_default;
	signals			varchar2(20) := '&@%#\/' || chr(47);
--	chr(47) = ampersand

	process_qualifier		binary_integer	:= rule.do_street + rule.do_block	+
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
	rule_unq_type	binary_integer,
	rule_unq_pfx	binary_integer,
	rule_unq_sfx	binary_integer,
	rule_type		binary_integer,
	rule_pfx		binary_integer,
	rule_sfx		binary_integer,
	fetch_count		binary_integer,	
	match_count		binary_integer,
	match_score		binary_integer
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
	mslink		binary_integer			
);

--	QUALIFIER  TABLE

	type qualifier_table	is table of		qualifier_record
		index by	binary_integer;
	qualifier		qualifier_table;

--	========================================

	total_read			binary_integer := 0;
	total_input			binary_integer := 0;
	total_output		binary_integer := 0;
	total_record		binary_integer := 0;
	total_fuzzy			binary_integer := 0;
	total_alias			binary_integer := 0;
	commit_count		binary_integer := 0;	

	phase				char;
	retry				binary_integer;
	step				binary_integer;
	recd				binary_integer;
	decision			binary_integer;
	verify_id			binary_integer;

	name_count			binary_integer;
	street_count		binary_integer;

	street_weight		binary_integer;		
	block_weight		binary_integer;
	segment_weight		binary_integer;
	address_weight		binary_integer;
	final_weight		binary_integer;

	range_lo			binary_integer;
	range_hi			binary_integer;

--	========================================
--	qualifier match

	accept_count		binary_integer;	
	accept_initial		binary_integer;		
	accept_type			binary_integer;
	accept_prefix		binary_integer;
	accept_suffix		binary_integer;

	match_type			binary_integer;
	match_prefix		binary_integer;
	match_suffix		binary_integer;

	unique_type			varchar2(04);
	unique_prefix		varchar2(02);
	unique_suffix		varchar2(02);

	audit_type			char(04);
	audit_prefix		char(04);
	audit_suffix		char(04);

--	permit_append		binary_integer;
--	permit_remove		binary_integer;
--	permit_change		binary_integer;

	prev_score			binary_integer;
	best_score			binary_integer;

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
	read_mslink			binary_integer;						

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
	best_mslink			binary_integer;						

	prev_best			binary_integer;		
	best_weight			binary_integer;
	best_name_chg		char(01);
	best_audit			varchar2(80);

	this_weight			binary_integer;
	this_name_chg		char;
	this_audit			varchar2(80);

	parse_method		varchar2(80);
	alias_table			varchar2(08);
	alias_method		varchar2(08);
	alias_result		varchar2(08);

	alias_weight		binary_integer;			
	alias_match			binary_integer;			
	alias_second		varchar2(40);			
	alias_also			varchar$v	:= varchar$v ('', '', '', '','');	

	street_name			varchar2(80);
	reduced_name		varchar2(80);
	compact_name		varchar2(80);

	test_count1			binary_integer := 0;
	test_count2			binary_integer := 0;
	test_count3			binary_integer := 0;

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
	from	garland.adrResult_Input				
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
			parcel_id, mslink						
	from		garland.cdreladr
	where		addr_name	= out.addr_name
	and		addr_num	= out.addr_num
	order by	1,2,3,4,5,6,7,8;

	ADDR		read_address%rowtype;		

--	=================================================================
--	<A>
	procedure	Match_Alias_Street	is

begin

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

	if	alias_table = 'alien'			then		
	ADR_alias_match
--	TST_alias_match
	( 	alias_method,
		read_num, read_pfx, read_name, read_type, read_sfx,
	 	reduced_name, compact_name );	

	else
	garland.ADR_FIND.FIND_ALIAS					
--	garland.ADR_FIND_01.FIND_ALIAS				
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

	if	alias_method  = ADR_Find.asis_method			
	and	read_name <> this_name					then
		if	alias_match >= reduced_alias			then	
			out.do_name	 := 'A';
		elsif	alias_match >= compact_alias			then
			out.do_name	 := 'B';
		end if;
	end if;

--	if	alias_method in ( 'a', 'b', 'c')			then	
--		out.do_name	 := alias_method;
--	end if;

	if  (	out.do_name = 'A'	 and	rule.do_type_A = rule.no )	
	or  (	out.do_name = 'B'	 and	rule.do_type_B = rule.no )

	or	alias_weight < rule.do_alias_weight			then		

		alias_method := null;
		out.do_name	 := null;						

		read_name	:= this_name;					
		read_type	:= this_type;
		read_pfx	:= this_pfx;
		read_sfx	:= this_sfx;
		read_num	:= this_num;
	end if;

	if	alias_method >= 'A'
	and	lower(alias_method) <> 'part'						
	and	read_name	= this_name							
	and	read_type	= this_type
	and	read_pfx	= this_pfx
	and	read_sfx	= this_sfx
	and	read_num	= this_num					then
		alias_method := null;
	end if;

	if	alias_method > ' '					then		
		verify_id	:= rule.valid_name;					
	end if;

    	if	alias_method like	   like_non_address		then
		verify_id	 := rule.non_address;

    	elsif	alias_method like	   like_non_garland		then
		verify_id	 := rule.non_garland;

    	elsif	alias_method like	   like_non_complete		then
		verify_id	 := rule.non_complete;

	elsif	alias_method like '%pull%'						
	and		replace (upper(out.appl_name), ' ')
	like	'%'|| replace (read_name, ' ') ||'%'		then
		alias_method	:= rule.mark_parse_undo;

	end if;
	
-- ****
	if	alias_method  = ADR_Find.asis_method		then		
		alias_method := null;
	end if;

	if	alias_table  = 'alien'							
	and	alias_method > ' '	
	and	nvl(verify_id,0)	> rule.non_address		then
		out.form_name	:= read_name;
		out.form_type	:= read_type;
		out.form_pfx	:= read_pfx;
		out.form_sfx	:= read_sfx;
	end if;

	if	alias_method > ' '					then
		out.do_alias	:= alias_method;		
		out.alias_score	:= alias_weight;					
		alias_result	:= alias_method;
		total_alias		:= total_alias + 01;
	end if;

	if	alias_table	= 'alien'							
	and	alias_result > ' '					then
		alias_match		:= 0;
		alias_weight	:= 9;
	end if;

end	Match_Alias_Street;

--	===========================================================================
--	<I>
	procedure	Phase_Initialize		is

--	Accept_Type = 1	when user street type = GIS type or space
--	Initialize valid name search parameters
--	===========================================================================

begin

	if	phase = street_phase
	and	street_name  <> out.addr_name		then
		street_name  := out.addr_name;
		reduced_name := adr_compress_name (out.addr_name, spec_reduced);
		compact_name := adr_compress_name (out.addr_name, spec_compact);
	end if;

	if	step	= rule.do_street			then		

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

	end if;

	if	phase = street_phase			then

		best_name		:= out.addr_name;
		best_name_chg	:= ' ';
		best_weight		:= 0;

	elsif	phase = segment_phase			then

		select	min(start_lo),	max(stop_lo) + 99
		into		range_lo,		range_hi
		from		garland.block
		where		addr_name	= out.addr_name
		and		addr_block	= trunc(out.addr_num, -2);

	elsif	phase = address_phase			then
		this_bldg	:= ' ';
	end if;

end	Phase_Initialize;

--	=================================================================
--	<F>
	function	Phase_Filter	return number	is

--	Evaluate current adrStreet name for best street name match
--	Filter out duplicate or non-matching TRVEHRCL records
--	Filter out duplicate or non-matching CDRELADR records
--	=================================================================

begin

		-- dbms_output.put_line ( 'phase filter' );

	if	phase = street_phase					then

		if	strt.addr_name	 = out.addr_name		then
			this_weight		:= same_weight;	
			this_name_chg	:= ' ';

		elsif	alias_result	= rule.mark_verify_only		then		

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

	return 00;

end	Phase_Filter;

--	=================================================================
--	<U1>
	procedure	Find_Unique_Invalid	is

--	Look for unique and invalid street name qualifiers
--	Example:	Street name "AUSTIN" has unique prefix, suffix, and type
--	Example:	"DR" is an invalid street type for "Country Club"
--	=================================================================

begin

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

end	Find_Unique_Invalid;

--	==========================================================================
--	<U2>
	procedure	Apply_Unique_Invalid	is

--	Apply results of unique and invalid qualifier determinations (from above)
--	This may result in adding, changing, or removing a qualifier
--	==========================================================================

begin

	if	out.addr_pfx  > ' '
	and	unique_prefix > ' '					
	and	unique_prefix <> out.addr_pfx
--	and	prev_score		<= permit_change
	and	work.rule_unq_pfx <= rule.change_unq		then
		accept_prefix := 01;						
		out.addr_pfx := unique_prefix;
		this_audit	 := this_audit||change_pfx;

	elsif	out.addr_pfx   > ' '
	and	match_prefix   = 0					
--	and	prev_score		<= permit_remove	
	and	work.rule_unq_pfx <= rule.remove_unq		then
		accept_prefix := 01;						
		out.addr_pfx := ' ';
		this_audit	 := this_audit||remove_pfx;	
	end if;

	if	out.addr_pfx  = ' '
	and	unique_prefix > ' '					
--	and	prev_score		<= permit_append
	and	work.rule_unq_pfx <= rule.append_unq		then
		accept_prefix := 01;						
		out.addr_pfx := unique_prefix;
		this_audit	 := this_audit||append_pfx;
	end if;


	if	out.addr_type  > ' '
	and	unique_type    > ' '					
	and	unique_type	   <> out.addr_type
--	and	prev_score		 <= permit_change
	and	work.rule_unq_type <= rule.change_unq		then
		accept_type	  := 01;						
		out.addr_type := unique_type;
		this_audit	  := this_audit||change_type;	

	elsif	out.addr_type  > ' '
	and	match_type 	   = 0
--	and	prev_score		 <= permit_remove
	and	work.rule_unq_type <= rule.remove_unq		then
		accept_type	  := 01;						
		out.addr_type := ' ';
		this_audit	  := this_audit||remove_type;	
	end if;

	if	out.addr_type  = ' '
	and	unique_type    > ' '					
--	and	prev_score		 <= permit_append	
	and	work.rule_unq_type <= rule.append_unq		then
		accept_type	  := 01;						
		out.addr_type := unique_type;
		this_audit	  := this_audit||append_type;
	end if;


	if	out.addr_sfx  > ' '
	and	unique_suffix > ' '					
	and	unique_suffix <> out.addr_sfx
--	and	prev_score		<= permit_change
	and	work.rule_unq_sfx <= rule.change_unq		then
		accept_suffix := 01;						
		out.addr_sfx  := unique_suffix;
		this_audit	  := this_audit||change_sfx;

	elsif	out.addr_sfx   > ' '
	and	match_suffix   = 0					
--	and	prev_score		<= permit_remove
	and	work.rule_unq_sfx <= rule.remove_unq		then
		accept_suffix := 01;						
		out.addr_sfx  := ' ';
		this_audit	  := this_audit||remove_sfx;	
	end if;

	if	out.addr_sfx  = ' '
	and	unique_suffix > ' '				
--	and	prev_score		<= permit_append
	and	work.rule_unq_sfx <= rule.append_unq		then
		accept_suffix := 01;						
		out.addr_sfx  := unique_suffix;
		this_audit	  := this_audit||append_sfx;
	end if;

end	Apply_Unique_Invalid;

--	=============================================================================
--	<Q>
	procedure	Match_Qualifiers		is

--	Look for the closest matching street
--	Use weighted match scores to determine closest match
--	Consider which operations (append, change, remove) are permitted
--	Consider match scores obtained from matching a previous GIS table,
--	Example:	Should '217 S Fifth Cir' be "corrected" if the 200 block of Fifth Ci
--	=============================================================================

begin

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
		if	work.rule_pfx <= rule.append				then
--		and	prev_score	  <= permit_append			then
			audit_prefix	:= append_pfx;
			this_weight 	:= this_weight + append_weight;
		else
			this_weight		:= this_weight + forbid_weight;	
		end if;

	elsif	out.addr_pfx  > '0'							
	and	read_pfx	  < '0'						then
		if	work.rule_pfx <= rule.remove				then
--		and	prev_score	  <= permit_remove			then
			audit_prefix	:= remove_pfx;
			this_weight		:= this_weight + remove_weight;
		else
			this_weight		:= this_weight + forbid_weight;	
		end if;

	elsif	out.addr_pfx  > '0'					
	and	read_pfx	  > '0'						then
		if	work.rule_pfx <= rule.change				then
--		and	prev_score	  <= permit_change			then
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
		if	work.rule_type <= rule.append				then
--		and	prev_score	   <= permit_append			then
			audit_type		:= append_type;
			this_weight 	:= this_weight + append_weight;
		else
			this_weight		:= this_weight + forbid_weight;	
		end if;

	elsif	out.addr_type  > '0'							
	and	read_type	   < '0'						then
		if	work.rule_type <= rule.remove				then
--		and	prev_score	   <= permit_remove			then		
			audit_type		:= remove_type;
			this_weight		:= this_weight + remove_weight;
		else
			this_weight		:= this_weight + forbid_weight;	
		end if;

	elsif	out.addr_type  > '0'					
	and	read_type	   > '0'						then
		if	work.rule_type <= rule.change				then
--		and	prev_score	   <= permit_change			then
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
		if	work.rule_sfx <= rule.append				then
--		and	prev_score    <= permit_append			then
			audit_suffix	:= append_sfx;
			this_weight 	:= this_weight + append_weight;
		else
			this_weight		:= this_weight + forbid_weight;	
		end if;

	elsif	out.addr_sfx  > '0'							
	and	read_sfx	  < '0'						then
		if	work.rule_sfx <= rule.remove				then
--		and	prev_score	  <= permit_remove			then
			audit_suffix	:= remove_sfx;
			this_weight		:= this_weight + remove_weight;
		else
			this_weight		:= this_weight + forbid_weight;	
		end if;

	elsif	out.addr_sfx  > '0'					
	and	read_sfx	  > '0'						then
		if	work.rule_sfx <= rule.change				then
--		and	prev_score    <= permit_change			then
			audit_suffix	:= change_sfx;
			this_weight		:= this_weight + change_weight;
		else
			this_weight		:= this_weight + forbid_weight;
		end if;
	end if;

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

	if	retry = 0							then			
		if	length(best_name) in (2,3)			then
			out.verify_code := rule.non_address;
		end if;
	end if;

	if	out.verify_code >= rule.non_address
	or	alias_result	 = rule.mark_verify_only	then			
		retry			:= -1;

	elsif	name_count = 1 						then
		retry			:= -2;
		out.addr_name	:= best_name;
		if	best_name_chg > ' '				then			
			out.do_name	:= best_name_chg;	
		end if;

	elsif	out.do_alias > '0'					then
		retry			:= -3;

	end if;


	if	retry = 0
	and	rule.do_type_C >= rule.yes				then
		total_fuzzy := total_fuzzy + 01;

		compare_best := adr_compress_name (best_name, spec_reduced);	
--		compare_best := best_name;			
--		ADR_compare_names (compare_best, compare_good, count_best, count_good);
		Compare_Names (compare_best, compare_good, count_best, count_good);		

--		if	count_best = 01								
		if	count_best <= rule.do_type_C						
		and	length(compare_best) = 20						
		and	(rtrim(out.addr_name, '0123456789') = out.addr_name)
		  =	(rtrim(compare_best,  '0123456789') = compare_best)		then

			name_count		:= 01;
			retry			:= 11;
			out.do_name		:= 'C';			
			out.name_score	:= count_best;					
			out.addr_name	:= rtrim (compare_best);
			reduced_name 	:= null;
			compact_name 	:= null;
			return		decide_exit;
		end if;
	end if;

	if	out.addr_num > '0'				then					
		null;

	elsif	retry = 0	
	and	rule.do_type_C >= rule.yes			then					

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
			return	decide_insert;
		end if;
		
	end if;

	return	00;

end	Final_Name_Resolve;

--	============================================================================
--	<R>
	procedure	Set_Phase_Results		is
--	============================================================================

begin

	if	best_weight < 0						then	
		work.match_count := 0;
	end if;

--	if best_weight exceeds prev_best by blank_weight alone, then multiple match_c

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
			out.segment_id	:= best_mslink;					
		elsif	phase = segment_phase				then
			null;
--			out.segment_id	:= best_id;						
		end if;

	elsif	work.match_count > 01					then			
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

end	Set_Phase_Results;

--	============================================================================
--	<V>
	procedure	Set_Verify_Code		is

--	The 	 Code indicates -- Trace_what is right and -- Trace_what is wrong with an addr
--	See documentation for meaning of verification codes
--	============================================================================

	major			number;
	minor			number;
	match_count		number;

begin

	major := null;
	minor := 0;

	if	out.verify_code < rule.valid_name	
	and	out.verify_code > rule.non_address		then		
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
		elsif	out.addr_num > '0'			then		
			major := rule.non_garland;
		else
			major	:= rule.non_address;				
		end if;		

	elsif	process_qualifier = 0				then

		null;
	elsif	minor  = 0						then
		minor	:= -1;
	end if;

--	-----------------------------------------------------------------------------

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

--	-----------------------------------------------------------------------------

	verify_id	:= major + minor;							
	if	verify_id >= nvl (out.verify_code, -1)			then
		out.verify_code	:= verify_id;
	end if;

end	Set_Verify_Code;

--	=================================================================
	function	Main_Driver		
	(
		spec_insert		in		number	default 01,
		spec_seq		in		number	default 0
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

	if	out.verify_code < rule.valid_name			
	and	rule.do_alien  * rule.do_parse * rule.do_name = 0	then
		return	decide_return;
	end if;

	parse_method	:= null;			
	alias_method	:= null;			
	alias_result	:= null;
	verify_id		:= null;
	retry			:= 0;
	loop_limit		:= max_phase_loops;

	out.alias_score	:= null;								
	out.name_score	:= null;
	out.qual_score	:= null;

	out.appl_pfx		:= upper (nvl(rtrim(out.appl_pfx), ' '));		
	out.appl_name		:= upper (nvl(rtrim(out.appl_name),' '));
	out.appl_type		:= upper (nvl(rtrim(out.appl_type),' '));
	out.appl_sfx		:= upper (nvl(rtrim(out.appl_sfx), ' '));
	out.appl_code1		:= upper (rtrim(out.appl_code1));
	out.appl_unit1		:= upper (rtrim(out.appl_unit1));
	out.appl_code2		:= upper (rtrim(out.appl_code2));
	out.appl_unit2		:= upper (rtrim(out.appl_unit2));

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

	if	out.verify_code < rule.valid_name		then				
		out.do_name			:= '';
		out.do_qual			:= '';
--		if	out.verify_code = rule.non_address	then				
--			out.form_name	:= '';	
--		end if;
	end if;

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

	read_pfx		:= upper (rtrim(read_pfx));				
	read_name		:= upper (rtrim(read_name));
	read_type		:= upper (rtrim(read_type));
	read_sfx		:= upper (rtrim(read_sfx));
	read_code1		:= upper (rtrim(read_code1));
	read_unit1		:= upper (rtrim(read_unit1));
	read_code2		:= upper (rtrim(read_code2));
	read_unit2		:= upper (rtrim(read_unit2));

--	========================================
--	<20>		Unparsed User Exit	

	if	rule.do_unparsed_exit >= rule.yes	then

		adr_Resolve_Unparsed_Exit
		(read_num,	 read_pfx,	 read_name,	 read_type,	read_sfx,
		 read_code1, read_unit1, read_code2, read_unit2,
		 parse_method, verify_id		);

		if	parse_method > '!'		then	
			out.do_parse := parse_method;
		end if;

		if	verify_id < rule.valid_name	then		
			goto	initialize_output;						
		end if;

		if	parse_method > ' '		then		
			goto	match_alias;
		end if;

	end if;

--	========================================
--	<30>		Match Unparsed Alias (Alien)

	if	rule.do_alien >= rule.yes			then
		alias_method := 'alien';

--	------------------------------------------------
		Match_Alias_Street;						
--	------------------------------------------------

		if	verify_id < rule.valid_name		then	
			goto	initialize_output;
		elsif	alias_result > ' '			then
			goto	match_alias;
		end if;
	end if;

--	========================================
--	<40>		Parse Address

	if	rule.do_parse > 0			then

		parse_method := rule.parse_options;					

		TST_parse_address
--		ADR_parse_address
	(	read_num,   read_pfx,   read_name,	read_type,  read_sfx,
		read_code1, read_unit1, read_code2,	read_unit2,	
		parse_method	);

		out.do_parse := parse_method;

		if	parse_method like like_parse_error		then
			verify_id	:= rule.non_address;
--			goto	initialize_output;					

		elsif	rule.do_parse = rule.safe_parse				
		and	substr(parse_method, 05) > '.........'	then		
			verify_id	:= rule.non_address;
			goto	initialize_output;	

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

	end if;

	if	parse_method like like_parse_error		then			
		verify_id	:= rule.non_address;

--	else											
--			out.form_pfx	:= nvl(rtrim(read_pfx ),  ' ');
--			out.form_name	:= nvl(rtrim(read_name),  ' ');
--			out.form_type	:= nvl(rtrim(read_type),  ' ');
--			out.form_sfx	:= nvl(rtrim(read_sfx ),  ' ');
--			out.form_code1	:= nvl(rtrim(read_code1), ' ');
--			out.form_unit1	:= nvl(rtrim(read_unit1), ' ');
--			out.form_code2	:= nvl(rtrim(read_code2), ' ');
--			out.form_unit2	:= nvl(rtrim(read_unit2), ' ');
	end if;


--	========================================
--	<50>		Parsed User Exit

	if	rule.do_parsed_exit >= rule.yes	then

		adr_Resolve_Parsed_Exit
		(read_num,	read_pfx,	read_name,	read_type,	read_sfx,
		 read_code1,read_unit1, read_code2, read_unit2,
		 parse_method, test_count1	);					
--		 parse_method, verify_id	);

		if	parse_method > '!'		then
--			out.do_parse := out.do_parse ||' '|| parse_method;	
			out.do_parse := parse_method;					
		end if;

--		if	verify_id < rule.valid_name	then				
--			goto	initialize_output;						
--		end if;

	end if;

--	========================================
--	<60>
<<match_alias>>

	if	rule.do_alias >= rule.yes	then
		alias_method := 'alias';
--	------------------------------------------------
		Match_Alias_Street;					
--	------------------------------------------------
	end if;

--	========================================
--	<70>
<<initialize_output>>

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

--	if	verify_id is not null				then	
		out.verify_code := verify_id;
--	end if;

--	========================================
--	<80>

	if	out.verify_code	  < rule.valid_name				
	or	lower(alias_method) = 'part'						
	or	rule.do_name + process_qualifier = 0	then	
		return	decide_insert;
	end if;

--	========================================
--	<100>
<<process_phase>>

	phase			:= null;
	street_count	:= 00;
	name_count		:= 00;							

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

	if	alias_result like like_verify_only	then			
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
		goto	end_phase_loop;
	end if;

	if	alias_result = rule.mark_verify_only	then		
		work.rule_type	:= forbid_weight;
		work.rule_pfx	:= forbid_weight;
		work.rule_sfx	:= forbid_weight;
	end if;

	if	nvl (out.addr_num, '0') = '0'
	and	phase <> street_phase					then
		exit;
	end if;			


/*
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
*/


--	------------------------------------------------
--	<120>
		PHASE_INITIALIZE;					
--	------------------------------------------------

--	========================================
--	<130>

	if	step		= rule.do_street				
	and	step - 1	= rule.do_name
	and	0		< rule.do_name 		then
		goto	alter_street_qualifiers;
	end if;

--	========================================
--	<200>		Fetch GIS Records

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

--	------------------------------------------------
--	<220>
	decision := PHASE_FILTER;				
--	------------------------------------------------

	if	decision = decide_loop			then
		goto	end_fetch_loop;
	end if;

--	========================================
--	<230>		Get Fetch

	if	work.fetch_count > 0			then
		qualifier (work.fetch_count).addr_type	:= read_type;
		qualifier (work.fetch_count).addr_pfx	:= read_pfx;
		qualifier (work.fetch_count).addr_sfx	:= read_sfx;
		qualifier (work.fetch_count).record_id	:= read_id;
		qualifier (work.fetch_count).mslink		:= read_mslink;		

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
		read_mslink	:= addr.mslink;							

	end if;

--	========================================
--	<240>

	if	phase = street_phase			then
--	------------------------------------------------
		FIND_UNIQUE_INVALID;					
--	------------------------------------------------
	end if;

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

<<end_fetch_loop>>
	null;

end loop;

--	========================================
--	<250>

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
		APPLY_UNIQUE_INVALID;					
--	------------------------------------------------
	end if;

--	========================================
--	<400>		Match Against GIS table

	best_weight	:= - 999999;
	prev_best	:= 0;							

for	q in reverse 01..work.fetch_count 			loop

	recd := q;

	if	q < work.fetch_count				then
		read_type	:= qualifier (q).addr_type;
		read_pfx	:= qualifier (q).addr_pfx;
		read_sfx	:= qualifier (q).addr_sfx;
		read_id	:= qualifier (q).record_id;
		read_mslink	:= qualifier (q).mslink;		
	end if;

--	------------------------------------
--	<410>
		MATCH_QUALIFIERS;						
--	------------------------------------

	if	best_weight < this_weight	
	and	rule.accept_weight < this_weight		then	
		prev_best		:= best_weight;			
		best_weight		:= this_weight;
		best_type		:= read_type;
		best_pfx		:= read_pfx;
		best_sfx		:= read_sfx;
		best_id		:= read_id;
		best_mslink		:= read_mslink;			
		best_audit		:= audit_prefix||audit_type||audit_suffix;
		work.match_count	:= 0;
		out.qual_score	:= best_weight;			
	end if;

	if	this_weight = best_weight			then
		work.match_count := work.match_count + 01;	

		if	work.match_count = 01			then	
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

<<end_match_loop>>
	null;
end loop;


--	========================================
--	<500>
<<reconsider>>

	if	alias_result > '0'			then
		retry	:= -3;
	end if;

	if	step = rule.do_street			then
		accept_count := accept_prefix + accept_type + accept_suffix;

	elsif	step = rule.do_name			then
--	------------------------------------------------
--	<510>
		decision := FINAL_NAME_RESOLVE;			
--	------------------------------------------------

		if	decision = decide_exit		then
			exit;
		elsif	decision = decide_insert	then
			return	decide_insert;
		end if;
	end if;

--	------------------------------------------------
--	<510>	
		Set_Phase_Results;					
--	------------------------------------------------

<<end_phase_loop>>

--	========================================
--	<600>	

	if	phase = street_phase
	and	name_count <> 01				then
		exit;

	elsif	step <> rule.do_name
	and	out.addr_name < '0'			then		
--	and	out.addr_name = '0'			then
		exit;
	end if;

end loop;

--	========================================
--	<610>

	if	retry  = 11						then
		retry := 12;
		if	rule.do_alias = rule.alias_fuzzy		then			
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
		SET_VERIFY_CODE;						
--	------------------------------------------------

	if	out.verify_code = rule.non_address			then	
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
	procedure	Batch_Driver
(
	spec_insert	in		number	default 01,
	spec_seq	in		number	default 0
)
	is
--	=================================================================

	read_rowid			number := 0;
	read_app			number := 0;

	param_insert		number;			
	param_seq			number;

begin

	param_insert	:= spec_insert;
	param_seq		:= spec_seq;

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

	out.rec_rowid	:= appl.rec_rowid;		
--	out.rec_rowid	:= row.row_id;			

	out.rec_seq		:= row.row_seq;
	out.rec_key		:= rtrim(rpad(appl.rec_key, max_key_length));				

	out.parcel_id	:= appl.parcel_id;
	out.segment_id	:= appl.segment_id;

--	========================================

--	decision := MAIN_DRIVER (spec_insert, spec_seq);	
--	decision := MAIN_DRIVER (param_insert, param_seq);	
	decision := MAIN_DRIVER;					

	if	decision = decide_loop		then
		goto	end_record_loop;
	end if;	

--	========================================
<<insert_result>>

	out.do_parse	:= nvl(out.do_parse, ' ');			
	out.do_alias	:= nvl(out.do_alias, ' ');
	out.do_name		:= nvl(out.do_name,  ' ');
	out.do_qual		:= nvl(out.do_qual,  ' ');

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
			out.rec_rowid,				
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
			out.appl_num,

			out.alias_score,				
			out.name_score,	
			out.qual_score	

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

end loop;	

	if	read_rowid > 0			then
		close read_rowid_table;
	end if;

	if	read_app > 0			then
		close read_app_table;
	end if;

	commit;

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'GIS ADDRESS RESOLVE  '||to_char (sysdate, 'mon dd,yyyy'));
	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'read  = '   	||lpad(total_read		,6));
	dbms_output.put_line ( 'input = '   	||lpad(total_input	,6));
	dbms_output.put_line ( 'insert     = '   	||lpad(total_output	,6));
	dbms_output.put_line ( 'total = '   	||lpad(total_record	,6));
	dbms_output.put_line ( 'alias = '   	||lpad(total_alias	,6));
	dbms_output.put_line ( 'fuzzy = '   	||lpad(total_fuzzy	,6));

--	dbms_output.put_line ( ' ' );
--	dbms_output.put_line ( 'test1	     = '   	||lpad(test_count1	,6));
--	dbms_output.put_line ( 'test2	     = '   	||lpad(test_count2	,6));
--	dbms_output.put_line ( 'test3	     = '   	||lpad(test_count3	,6));

	return;

end	Batch_Driver;


--	=================================================================
--	<QD>

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

	spec_insert	in		number	default 01,
	spec_seq	in		number	default 0

	,Tracker_Mode	in	number	default 0
	,Tracker_Focus	in	varchar2 	default null
	,Tracked_Focus	in	varchar2 	default null
)

is
begin

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

	decision := MAIN_DRIVER (0, spec_seq);	

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
	gis_key		:= out.rec_key;		
--	gis_key		:= nvl(out.parcel_id, out.segment_id);

	out.do_parse	:= nvl(out.do_parse, ' ');			
	out.do_alias	:= nvl(out.do_alias, ' ');
	out.do_name		:= nvl(out.do_name,  ' ');
	out.do_qual		:= nvl(out.do_qual,  ' ');

	audit			:=	' '
					||'  parse=' || out.do_parse
					||'  alias=' || out.do_alias
					||'  name='	 || out.do_name
					||'  qual='	 || out.do_qual

					||' scores=' || 	nvl(out.alias_score,0) ||';'||
								nvl(out.name_score, 0) ||';'||
								nvl(out.qual_score, 0)
					;

	return;
	
end	Query_Driver;

END;
