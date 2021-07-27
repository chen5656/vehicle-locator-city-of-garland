	set echo		off;
	select '*** address resolve ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;
	set serveroutput	on		size	99999;	
	set timing		on;

--	==================================================================================================

--	truncate table	gis_verify_addr;		--	adrResult table

declare

	stop_count			number		 := 99;	
	do_insert			number		 := 0;
	do_compile_only		number		 := 01;

	start_seq			number		 := 000000;
	stop_seq			number		 := 999999;
	start_name			varchar2(10)	 := ' ';
	stop_name			varchar2(10)	 := 'zzzzz';

--	start_seq			number		 := 7318;
--	stop_seq			number		 := start_seq + 0;
--	start_name			varchar2(80)	 := '';
--	stop_name			varchar2(80)	 := start_name || 'zzz';

	prev_seq			number		:= start_seq - 01; 

	trace_count			number 		:= 0;
	do_trace			number		:= 0;	
	do_test			number		:= 0;
	do_sample			number		:= 0;	

	test_count1			number	 	:= 0;
	test_count2			number	 	:= 0;
	test_count3			number	 	:= 0;
	show1				varchar2(80); 
	show2				varchar2(80); 
	show3				varchar2(80); 
	show4				varchar2(80); 

--	========================================
--	control constants

	street_phase		char		:= 'S';
	block_phase			char		:= 'B';
	segment_phase		char		:= 'R';
	address_phase		char		:= 'A';

	match_weight		number	:= 20;
	append_weight		number	:= 05;
	change_weight		number	:= 01;
	forbid_weight		number	:= -100;
	empty_weight		number	:= append_weight;

	same_weight			number	:= 3000;
	reduced_weight		number	:= 2000;
	compact_weight		number	:= 1000;

	max_phase_loops		number	:= 02;
	max_key_length		number	:= 20;		
	spec_hi_range		number	:= 999999;

	like_non_address		varchar2(3)	:= '%'||rule.symbol_non_address||'%';
	like_non_garland		varchar2(3)	:= '%'||rule.symbol_non_garland||'%';
	like_non_correct		varchar2(3)	:= '%'||rule.symbol_non_correct||'%';

	delimiters			varchar2(20) := ',.;:`''' || chr(09);	
	dividers			varchar2(20) := '()[]{}<>"';
	signals			varchar2(20) := '&@%#/\';
	heiroglyphs			varchar2(20) := '~!?$%^*_+=|-';
	spaces			char(40)	 := ' ';
	parse_default		varchar2(10) := '......';

--	========================================
--	PHASE RECORD

	type phase_rec	is record
(
	rule_type		char(01),
	rule_pfx		char(01),
	rule_sfx		char(01),
	fetch_count		number,	
	match_count		number	
);
	work			phase_rec;
	str			phase_rec;
	blk			phase_rec;
	seg			phase_rec;
	adr			phase_rec;

--	STREET QUALIFIERS

	type qualifier_record	is record
(
	addr_type		varchar2(04),
	addr_pfx		varchar2(02),
	addr_sfx		varchar2(02),
	record_id		varchar2(12)
);

--	QUALIFIER  TABLE

	type qualifier_table	is table of		qualifier_record
		index by	binary_integer;
	qualifier		qualifier_table;


--	AUDIT

	append_type		char(04) := '/at ';
	append_pfx		char(04) := '/ap ';
	append_sfx		char(04) := '/as ';
	remove_type		char(04) := '/rt ';
	remove_pfx		char(04) := '/rp ';
	remove_sfx		char(04) := '/rs ';
	change_type		char(04) := '/ct ';
	change_pfx		char(04) := '/cp ';
	change_sfx		char(04) := '/cs ';

--	========================================

	total_read			number := 0;
	total_input			number := 0;
	total_output		number := 0;

	phase				char;
	retry				number;
	loop_limit			number;

	name_count			number;
	street_count		number;

	range_lo			number;
	range_hi			number;

	parse_method		varchar2(10);
	alien_method		varchar2(10);
	alias_method		varchar2(10);

	begin_name			varchar2(40);
	end_name			varchar2(40);

--	========================================
--	qualifier match 

	accept_count		number;	
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

--	========================================
--	qualifier correction

	str_score			number;
	blk_score			number;
	seg_score			number;
	adr_score			number;
	prev_score			number;

	forbid_append		number;
	forbid_remove		number;
	forbid_change		number;

--	========================================

	read_name			varchar2(80);
	read_type			adrResult.addr_type%type;
	read_pfx			adrResult.addr_pfx%type;
	read_sfx			adrResult.addr_sfx%type;
	read_code			adrResult.addr_code%type;
	read_unit			adrResult.addr_unit%type;
	read_num			adrResult.addr_num%type;
	read_id			varchar2(12);

	best_name			varchar2(80);
	best_type			adrResult.addr_type%type;
	best_pfx			adrResult.addr_pfx%type;
	best_sfx			adrResult.addr_sfx%type;
	best_id			varchar2(12);

	best_weight			number;
	best_name_chg		varchar2(01);
	best_audit			varchar2(40);

	this_weight			number;
	this_name_chg		char;
	this_audit			varchar2(40);
	this_bldg			adrResult.addr_unit%type;

	reduced_name		varchar(80);
	compact_name		varchar(80);
	compare_best		char(80);
	compare_good		char(80);
	count1			number;
	count2			number;

--	========================================

	ALIEN 	adrAlien%rowtype;	
	NEW 		adrResult%rowtype;	

--	========================================
cursor	read_rowid_table		is

	select row_id,	 row_seq
	from	 gis_app_rowid
	where	 row_seq > prev_seq
	and	rownum < 2;

	ROW	read_rowid_table%rowtype;		

--	========================================
cursor	read_app_table		is

	select *
	from	gis_app_addr
	where	rowid	= row.row_id;

	APPL	read_app_table%rowtype;	

--	========================================
cursor	read_street			is

	select	*
	from		adrStreet_syn
	where		addr_compact = compact_name;

	STRT		read_street%rowtype;	

--	========================================
cursor	read_block			is

	select	--+	index_asc ( adrBlock  adrBlock_pkey)
			all *
	from		adrBlock
	where		addr_name	= new.addr_name
	and		addr_block	= trunc (new.addr_num, -2);

	BLOK		read_block%rowtype;	

--	========================================
cursor	read_segment		is

	select	--+	index_asc ( trvehrcl  trvehrcl_x_name_num)
			distinct
			addr_name, addr_type, addr_pfx, addr_sfx, addr_lo, addr_hi,	segment_id
	from		trvehrcl
	where		addr_name	 = new.addr_name
	and		addr_lo	>= range_lo
	and		addr_hi	<= range_hi
	order by	1,2,3,4,5,6,7;

	SEGM		read_segment%rowtype;	


--	========================================
cursor	read_address		is

	select	distinct
			addr_name, addr_type, addr_pfx, addr_sfx, addr_num, addr_bldg, unit_num, parcel_id
	from		cdreladr
	where		new.addr_name	= addr_name
	and		new.addr_num	= addr_num
	order by	1,2,3,4,5,6,7,8;

	ADDR		read_address%rowtype;		

--	======================================================================
begin

	if	do_compile_only > 0			then
		return;
	end if;

	if	do_insert  > 0		
	or	stop_count > 10				then
		do_trace	:= 0;	
		do_test	:= 0;	
		do_sample	:= 0;	
	end if;

--	========================================
--	read application table

loop

	if	do_trace + do_test > 0		
	or	do_sample 	> 0				then 
		exit when trace_count <= 0;
--		show1	 := '(no exit1)'; show2	 := '(no alien)';	show3	 := '(no parse)';	show4	 := '(no exit2)';
	end if;

	open	read_rowid_table;
	fetch	read_rowid_table		into row;
	exit when	read_rowid_table%notfound		
		or 	read_rowid_table%notfound is null
		or	row.row_seq > stop_seq;
	close	read_rowid_table;
		
	open	read_app_table;
	fetch	read_app_table		into appl;
	exit when	read_app_table%notfound		
		or 	read_app_table%notfound is null;
	close	read_app_table;

	prev_seq	:= row.row_seq;
	total_read	:= total_read + 01;

	if	appl.addr_name	 between start_name and stop_name		then
		if	total_input < stop_count					then
			total_input	:= total_input + 01;
		else
			exit;
		end if;
	else
		goto	end_record_loop;
	end if;

	end_name := appl.addr_name;
	if	begin_name is null			then
		begin_name := appl.addr_name;
	end if;

--	========================================

	read_num	:= ltrim(appl.addr_num,'0');
	read_name	:= nvl(rtrim(upper(appl.addr_name)), ' ');
	read_type	:= nvl(rtrim(upper(appl.addr_type)), ' ');
	read_pfx	:= nvl(rtrim(upper(appl.addr_pfx )), ' ');
	read_sfx	:= nvl(rtrim(upper(appl.addr_sfx )), ' ');
	read_code	:= nvl(rtrim(upper(appl.addr_code)), ' ');
	read_unit	:= nvl(rtrim(upper(appl.addr_unit)), ' ');

	read_name 	:= translate (read_name, delimiters, spaces); 		
	read_type 	:= translate (read_type, delimiters, spaces); 		
	read_pfx 	:= translate (read_pfx,  delimiters, spaces); 		
	read_sfx 	:= translate (read_sfx,  delimiters, spaces); 		
	read_code 	:= translate (read_code, delimiters, spaces); 		
	read_unit 	:= translate (read_unit, delimiters, spaces); 		

	read_name	:= replace   (read_name, rpad(' ',3), ' ');	
	read_name	:= replace   (read_name, rpad(' ',2), ' ');
	read_name	:= replace   (read_name, rpad(' ',2), ' ');

	if	rule.do_unparsed_exit >= rule.yes		then
		adr_Resolve_Unparsed_Exit (read_num, read_pfx, read_name, read_type, read_sfx, read_code, read_unit);

		if	do_trace > 0		then
			show1 := '$do exit1	/'||read_num ||'/'||
					read_pfx  ||'/'||read_name||'/'||read_type||'/'||read_sfx||'/'||
					read_code ||'/'||read_unit||'/'||' ';
			dbms_output.put_line (show1);
		end if;
	end if;

--	========================================
--	process unparsed address

	alias_method := 'alien';

	if	rule.do_alien = rule.no		then
		goto	parse_address;
	end if;

--	TST_alias_match
	ADR_alias_match
	( alias_method, read_num, read_pfx, read_name, read_type, read_sfx );	

	alias_method := rtrim(alias_method);
	alien_method := rtrim(rpad (alias_method,3));

	if	do_trace > 0			
	and	alias_method is not null			
	then
		show2 :=  '$alien		/'||read_pfx||'/'||read_name||'/'||
				read_type ||'/'||read_sfx||'/'||alien_method||'/'||alias_method||'/';
		dbms_output.put_line (show2);
	end if;

--	if	alias_method like '11%'		
--	or	alias_method like like_non_address		then
	if	alias_method > ' '				then	
		goto	initialize_output;
	end if;

--	========================================
<<parse_address>>

	if	rule.do_parse = rule.no			then
		goto end_parse ;
	end if;

	read_name	:=	read_num ||' '||read_pfx||' '||read_name||' '||
				read_type||' '||read_sfx||' '||
				read_code||' '||read_unit;

	read_name	:=	translate (read_name, 'x,.', 'x  ');		--	stop gap

	read_num	:= '';
	read_pfx	:= ' ';
	read_type	:= ' ';	
	read_sfx	:= ' ';	
	read_unit	:= ' ';	
	read_code	:= ' ';	

	TST_parse_address 
--	ADR_parse_address 
	(read_num,  read_pfx,  read_name,  read_type,  read_sfx, read_code, read_unit, parse_method);

--	if	read_code = 'DPLX'			then				--	stop gap
--		read_name := replace (read_name, read_num);
--	end if;

	if	do_trace > 0			then
		show3 := '$parse	/'||read_num ||'/'||
					read_pfx ||'/'||read_name||'/'||read_type||'/'||read_sfx||'/'||
					read_code||'/'||read_unit||'/'||' ';
		dbms_output.put_line (show3);
	end if;

<<end_parse>>

--	========================================

	read_name 	:= translate (read_name, dividers, spaces); 		
	read_type 	:= translate (read_type, dividers, spaces); 		
	read_pfx 	:= translate (read_pfx,  dividers, spaces); 		
	read_sfx 	:= translate (read_sfx,  dividers, spaces); 		
	read_code 	:= translate (read_code, dividers, spaces); 		
	read_unit 	:= translate (read_unit, dividers, spaces); 		

--	========================================
<<initialize_output>>

	read_name	:= replace   (read_name, rpad(' ',3), ' ');	
	read_name	:= replace   (read_name, rpad(' ',2), ' ');
	read_name	:= replace   (read_name, rpad(' ',2), ' ');

	read_num	:= ltrim (read_num, '0');		
	read_name	:= nvl(ltrim (rtrim (read_name)),' ');
	read_type	:= nvl(ltrim (rtrim (read_type)),' ');
	read_pfx	:= nvl(ltrim (rtrim (read_pfx )),' ');
	read_sfx	:= nvl(ltrim (rtrim (read_sfx )),' ');
	read_code	:= 	 ltrim (rtrim (read_code));
	read_unit	:= 	 ltrim (rtrim (read_unit));

--	========================================

	if	rule.do_parsed_exit >= rule.yes		then
		adr_Resolve_Parsed_Exit ( read_num, read_pfx, read_name, read_type, read_sfx, read_code, read_unit );

		if	do_trace > 0		then
			show4 := '$do exit2	/'||read_num ||'/'||
					read_pfx  ||'/'||read_name||'/'||read_type||'/'||read_sfx||'/'||
					read_code ||'/'||read_unit||'/'||' ';
			dbms_output.put_line (show4);
		end if;
	end if;

--	========================================

	new.do_alias	:= '';
	new.do_name		:= '';
	new.do_qual		:= '';
	new.parcel_id	:= null;
	new.segment_id	:= null;
	new.verify_code	:= null;		
	new.addr_name	:= read_name;				
	new.addr_type	:= read_type;
	new.addr_pfx	:= read_pfx;
	new.addr_sfx	:= read_sfx;
	new.addr_num	:= read_num;
	new.addr_code	:= read_code;
	new.addr_unit	:= read_unit;				
	new.do_parse	:= parse_method;
	new.rec_rowid	:= row.row_id;			
	new.rec_key		:= rtrim(rpad(appl.rec_key, max_key_length));				

	if	rule.keep_parsed = rule.yes		then
		new.old_name	:= read_name;
		new.old_type	:= read_type;
		new.old_pfx		:= read_pfx;
 		new.old_sfx		:= read_sfx;
 		new.old_code	:= read_code;
		new.old_unit	:= read_unit;
	else
		new.old_name	:= null;
		new.old_type	:= null;
		new.old_pfx		:= null;
		new.old_sfx		:= null;
		new.old_code	:= null;
		new.old_unit	:= null;
	end if;

	if	rule.keep_unparsed = rule.yes		then
		new.app_name	:= appl.addr_name;
		new.app_type	:= appl.addr_type;
		new.app_pfx		:= appl.addr_pfx;
		new.app_sfx		:= appl.addr_sfx;
		new.app_code	:= appl.addr_code;
		new.app_unit	:= appl.addr_unit;
	else
		new.app_name	:= null;
		new.app_type	:= null;
		new.app_pfx		:= null;
		new.app_sfx		:= null;
		new.app_code	:= null;
		new.app_unit	:= null;
	end if;

	retry			:= 0;
	loop_limit		:= max_phase_loops;

--	========================================
--	street name is non-address if it contains intersection
--	street name is non-address if it contains a business key word

	if	alien_method is not null		then
		goto process_alias;
	end if;	

	if	new.addr_name <> translate (new.addr_name, 'x' || signals, 'x')	
--	or	instr (new.addr_name, '%') > 0 				
	then
		new.verify_code := rule.non_address;
	end if;

	if	rule.do_business >= rule.yes		then
		read_name	:= ' '||appl.addr_name||' ';
		for busi in (select possible from adrItem where class in ('B', 'K') )	loop
			if	read_name	like '% ' ||busi.possible|| ' %'			then
				new.verify_code	:= rule.non_address;
				exit;
			end if;
		end loop;
	end if;

	if	new.verify_code is not null		then
		goto	insert_result;						
	end if;

--	========================================
<<match_alias>>

	if	do_test > 0			then
	dbms_output.put_line ('alias start');
	end if;

	if	rule.do_alias = rule.no		then
		goto	end_alias;
	end if;

	alias_method := 'alias';

--	TST_alias_match
	ADR_alias_match
	( alias_method, new.addr_num, new.addr_pfx, new.addr_name, new.addr_type, new.addr_sfx );	
	
	if (	lower(alias_method) like  'more%'  and   rule.do_more_alias = rule.no	)
	or (	lower(alias_method) like  'like%'  and   rule.do_like_alias = rule.no	)
	then
		alias_method 	:= ' ';
		new.addr_pfx	:= read_pfx;
		new.addr_name	:= read_name;
		new.addr_type	:= read_type;
		new.addr_sfx	:= read_sfx;
	end if;

<<process_alias>>

    	if	alien_method like	   '__0%'		
    	or	alias_method like	   '__0%'		
	or	alias_method like    like_non_address 		then		
		new.verify_code	 := rule.non_address;

    	elsif	alien_method like	   '__1%' 
    	or	alias_method like	   '__1%'		
    	or	alias_method like    like_non_garland  		then		
		new.verify_code	 := rule.non_garland;

	elsif	alien_method like	   '__2%'
    	or	alias_method like	   '__2%'		
	or	alias_method like    like_non_correct 		then		
		new.verify_code	 := rule.non_correct;

	elsif	alien_method	   is null
	and	rtrim (alias_method) is not null				
	and	new.addr_name	 = upper (appl.addr_name)
	and	new.addr_type	 = upper (appl.addr_type)
	and	new.addr_pfx	 = upper (appl.addr_pfx)
	and	new.addr_sfx	 = upper (appl.addr_sfx)	then
		alias_method	:= rule.symbol_no_change;
	end if;

	new.do_alias := rtrim (new.do_alias||alias_method);
	
	if	do_trace > 0		then
	dbms_output.put_line ( '$alias	' ||new.addr_pfx ||'/'||new.addr_name||'/'|| new.addr_type||'/'||
								new.addr_sfx||'/'||alien_method||':'||alias_method||'/');
	end if;

<<end_alias>>
--	========================================

	if	new.verify_code is null					then
		if	instr (new.addr_name, ' ', 1,3) > 0							
		or	new.addr_name <> translate (new.addr_name, 'x' || heiroglyphs, 'x')	
		then
			new.verify_code := rule.non_address;
		end if;
	end if;

	if	new.verify_code is not null		then
		goto	insert_result;						
	end if;

--	========================================
<<process_phase>>

	loop_limit	:= loop_limit - 01;
	if	loop_limit < 0				then
		dbms_output.put_line ('adrResolve is looping');
		return;
	end if;

	phase			:= null;					--	new

	name_count		:= 0;
	street_count	:= 0;

	str.fetch_count	:= 0;
	str.match_count	:= 0;
	blk.fetch_count	:= 0;
	blk.match_count	:= 0;
	seg.fetch_count	:= 0;
	seg.match_count	:= 0;
	adr.fetch_count	:= 0;
	adr.match_count	:= 0;

	str_score		:= 0;
	blk_score		:= 0;
	seg_score		:= 0;
	adr_score		:= 0;
	
<<phase_loop>>

for step in 1..4					loop

	work.fetch_count	:= 0;
	work.match_count	:= 0;
	this_audit		:= null;

	if	step = rule.do_street			then
		phase		:= street_phase;
		str.rule_type	:= rule.str_type;
		str.rule_pfx	:= rule.str_pfx;
		str.rule_sfx	:= rule.str_sfx;
		work		:= str;

	elsif	step = rule.do_block			then
		phase		:= block_phase;
		blk.rule_type	:= rule.blk_type;
		blk.rule_pfx	:= rule.blk_pfx;
		blk.rule_sfx	:= rule.blk_sfx;
		work		:= blk;

	elsif	step = rule.do_range			then
		phase		:= segment_phase;
		seg.rule_type	:= rule.rng_type;
		seg.rule_pfx	:= rule.rng_pfx;
		seg.rule_sfx	:= rule.rng_sfx;
		work		:= seg;

	elsif	step = rule.do_address			then
		phase		:= address_phase;
		adr.rule_type	:= rule.adr_type;
		adr.rule_pfx	:= rule.adr_pfx;
		adr.rule_sfx	:= rule.adr_sfx;
		work		:= adr;

	else	
		goto	end_phase_loop;
	end if;

	exit when	nvl (new.addr_num, 0) = 0
		and	phase <> street_phase;				--	new

	if	phase = address_phase					then
		prev_score		:= rule.forbid_adr;
		forbid_append	:= rule.forbid_adr_append;
		forbid_remove	:= rule.forbid_adr_remove;
		forbid_change	:= rule.forbid_adr_change;

	elsif	phase = segment_phase					then
		prev_score		:= rule.forbid_rng;
		forbid_append	:= rule.forbid_rng_append;
		forbid_remove	:= rule.forbid_rng_remove;
		forbid_change	:= rule.forbid_rng_change;

	elsif	phase = block_phase					then
		prev_score		:= rule.forbid_blk;
		forbid_append	:= rule.forbid_blk_append;
		forbid_remove	:= rule.forbid_blk_remove;
		forbid_change	:= rule.forbid_blk_change;

	else
		prev_score		:= 0;
		forbid_append	:= rule.permit;
		forbid_remove	:= rule.permit;
		forbid_change	:= rule.permit;
	end if;

	if	prev_score	= rule.do_address		then
		prev_score := adr_score;
	elsif	prev_score	= rule.do_range		then
		prev_score := seg_score;
	elsif	prev_score	= rule.do_block		then
		prev_score := blk_score;
	elsif	prev_score	= rule.do_street		then
		prev_score := str_score;
	else
		prev_score	:= 0;
	end if;

	if	phase = street_phase			then
		if	new.addr_type = ' '		then
			accept_type  := 1;	
		else
			accept_type  := 0;	
		end if;

		if	new.addr_pfx = ' '		then
			accept_prefix := 1;	
		else
			accept_prefix := 0;	
		end if;

		if	new.addr_sfx = ' '		then
			accept_suffix := 1;	
		else
			accept_suffix := 0;	
		end if;

		reduced_name	:= adr_compress_name (new.addr_name, 02);
		compact_name	:= adr_compress_name (new.addr_name, 04);
		best_name	:= new.addr_name;
		best_name_chg	:= ' ';
		best_weight		:= 0;

	elsif	phase = segment_phase			then
		if	blk.fetch_count = 01		then
			range_lo		:= blok.start_lo;
			range_hi		:= blok.stop_lo + 99;
		else
			range_lo		:= 0000;
			range_hi		:= spec_hi_range;
		end if;

	elsif	phase = address_phase			then
		this_bldg		:= ' ';

		read_type	:= null;
		read_pfx	:= null;
		read_sfx	:= null;
	end if;

	if	do_trace > 0		then
	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( '$work		'||phase||'/'||work.rule_type||'/'||
							work.rule_pfx||'/'||work.rule_sfx||'/' ); 
	end if;

--	========================================
--	fetch gis records

	if	phase = street_phase		then
		open	read_street;
	elsif	phase = block_phase		then
		open	read_block;
	elsif	phase = segment_phase		then
		open	read_segment;
	else
		open	read_address;
	end if;

--	========================================

loop

	if	phase = street_phase			then
		fetch	read_street							into strt;
		exit when	read_street%notfound		
			or 	read_street%notfound is null;
	elsif	phase = block_phase			then
		fetch	read_block							into blok;
		exit when	read_block%notfound		
			or 	read_block%notfound is null;
	elsif	phase = segment_phase			then
		fetch	read_segment						into segm;
		exit when	read_segment%notfound		
			or 	read_segment%notfound is null;
	else
		fetch	read_address						into addr;
		exit when	read_address%notfound		
			or 	read_address%notfound is null;
	end if;

--	========================================
--	find unique best street name match 
--	find valid segment match 

	if	phase = street_phase						then

		if	strt.addr_name	 = new.addr_name			then
			this_weight		:= same_weight;	
			this_name_chg	:= ' ';
		elsif	strt.addr_reduced  = reduced_name		
		and	rule.do_similar_name >= rule.reduced_name		then
			this_weight		:= reduced_weight;
			this_name_chg	:= 'A';
		elsif	rule.do_similar_name >= rule.compact_name		then
			this_weight		:= compact_weight;
			this_name_chg	:= 'B';
		else
			goto	end_fetch_loop;
		end if;
		
		if	this_weight > best_weight				then
			best_weight		:= this_weight;
			best_name	:= strt.addr_name;
			best_name_chg	:= this_name_chg;
			name_count		:= 1;
			work.fetch_count	:= 0;

		elsif	this_weight < best_weight			
		or	name_count	  > 1						then
			goto	end_fetch_loop;

		elsif	strt.addr_name <> best_name			then
			name_count		:= 9;				--	many best match names exist
			goto	end_fetch_loop;
		end if;

	elsif	phase = segment_phase						then

		if	new.addr_num < segm.addr_lo
		or	new.addr_num > segm.addr_hi				then
			goto	end_fetch_loop;									--	new
		end if;

	elsif	phase = address_phase						then

		if	addr.addr_type = read_type
		and	addr.addr_pfx  = read_pfx
		and	addr.addr_sfx  = read_sfx				then
			goto	end_fetch_loop;
		end if;

		if	addr.addr_bldg >= '0'					then
			if	this_bldg = ' '					then
				this_bldg := addr.addr_bldg;
			else
				goto	end_fetch_loop;
			end if;

		elsif	addr.unit_num >= '0'					then 
			goto	end_fetch_loop;
		end if;

	end if;

	if	do_test > 099 		then
	dbms_output.put_line ( 'name		' ||phase ||'/'||best_name  ||'/'||best_name_chg	||'/'||
					 		    this_weight||'/'||best_weight||'/'||name_count	||'/'	); 
	end if;

--	========================================
--	hold previous street qualifiers
--	get  current qualifiers

	if	work.fetch_count > 0				then
		qualifier (work.fetch_count).addr_type	:= read_type;
		qualifier (work.fetch_count).addr_pfx	:= read_pfx;
		qualifier (work.fetch_count).addr_sfx	:= read_sfx;
		qualifier (work.fetch_count).record_id	:= read_id;

	end if;

	work.fetch_count := work.fetch_count + 01;	

	if	phase = street_phase				then
		read_type	:= strt.addr_type;
		read_pfx	:= strt.addr_pfx;
		read_sfx	:= strt.addr_sfx;
	elsif	phase = block_phase				then
		read_type	:= blok.addr_type;
		read_pfx	:= blok.addr_pfx;
		read_sfx	:= blok.addr_sfx;
	elsif	phase = segment_phase				then
		read_type	:= segm.addr_type;
		read_pfx	:= segm.addr_pfx;
		read_sfx	:= segm.addr_sfx;
		read_id	:= segm.segment_id;
	else
		read_type	:= addr.addr_type;
		read_pfx	:= addr.addr_pfx;
		read_sfx	:= addr.addr_sfx;
		read_id	:= addr.parcel_id;
	end if;

--	========================================
--	find street qualifiers unique to name & number
--	find invalid user qualifiers for name & number 

	if	work.fetch_count = 01				then
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

	if	read_type = new.addr_type		then
		match_type   := 1;
	end if;

	if	read_pfx  = new.addr_pfx			then
		match_prefix := 1;
	end if;

	if	read_sfx  = new.addr_sfx			then
		match_suffix := 1;
	end if;

	if	do_trace > 0		then
	dbms_output.put_line ('$unique1	' ||read_pfx ||'/'||read_type||'/'||read_sfx ||'/' );
	dbms_output.put_line ('$unique2	' ||unique_type||'/'||unique_prefix||'/'||unique_suffix ||'/'||
						  	      match_type ||'/'||match_prefix ||'/'||match_suffix  ||'/');
	end if;

<<end_fetch_loop>>
	null;

end loop;

--	========================================

	if	phase = street_phase		then
		close	read_street;
	elsif	phase = block_phase		then
		close	read_block;
	elsif	phase = segment_phase		then
		close	read_segment;
	else
		close	read_address;
	end if;	

	if	phase = street_phase		
	and	name_count <> 01			then
		goto	reconsider;
	end if;

	if	work.fetch_count  = 0		then
		goto	save_phase_results;
	end if;

--	========================================
--	remove irrelevant street qualifiers
--	set unique street qualifiers

	this_audit := null;

	if	work.rule_pfx >= rule.change
	and	prev_score	  <  forbid_change
	and	unique_prefix <> new.addr_pfx
	and	unique_prefix > ' '					
	and	new.addr_pfx  > ' '					then
		new.addr_pfx := unique_prefix;
		this_audit	 := this_audit||change_pfx;

	elsif	work.rule_pfx >= rule.remove
	and	prev_score	  <  forbid_remove
	and	match_prefix   = 0					
	and	new.addr_pfx   > ' '					then
		new.addr_pfx := ' ';
		this_audit	 := this_audit||remove_pfx;	
	end if;

	if	work.rule_pfx >= rule.append
	and	prev_score	  <  forbid_append
	and	unique_prefix > ' '					
	and	new.addr_pfx  = ' '					then
		new.addr_pfx := unique_prefix;
		this_audit	 := this_audit||append_pfx;
	end if;


	if	work.rule_type >= rule.change
	and	prev_score	   <  forbid_change
	and	unique_type	  <> new.addr_type
	and	unique_type    > ' '					
	and	new.addr_type  > ' '					then
		new.addr_type := unique_type;
		this_audit	  := this_audit||change_type;	

	elsif	work.rule_type >= rule.remove
	and	prev_score	   <  forbid_remove
	and	match_type = 0					
	and	new.addr_type  > ' '					then
		new.addr_type := ' ';
		this_audit	  := this_audit||remove_type;	
	end if;

	if	work.rule_type >= rule.append
	and	prev_score	   <  forbid_append
	and	unique_type    > ' '					
	and	new.addr_type  = ' '					then
		new.addr_type := unique_type;
		this_audit	  := this_audit||append_type;
	end if;


	if	work.rule_sfx >= rule.change
	and	prev_score	  <  forbid_change
	and	unique_suffix <> new.addr_sfx
	and	unique_suffix > ' '					
	and	new.addr_sfx  > ' '					then
		new.addr_sfx  := unique_suffix;
		this_audit	  := this_audit||change_sfx;

	elsif	work.rule_sfx >= rule.remove
	and	prev_score	  <  forbid_remove
	and	match_suffix   = 0					
	and	new.addr_sfx   > ' '					then
		new.addr_sfx  := ' ';
		this_audit	  := this_audit||remove_sfx;	
	end if;

	if	work.rule_sfx >= rule.append
	and	prev_score	  <  forbid_append
	and	unique_suffix > ' '					
	and	new.addr_sfx  = ' '					then
		new.addr_sfx  := unique_suffix;
		this_audit	  := this_audit||append_sfx;
	end if;

--	this_audit := translate (this_audit, ' ', ';');

	if	do_trace > 0		then
	dbms_output.put_line ( '$audit1	'	||this_audit );
	dbms_output.put_line ( '$audit2	'	||new.addr_num ||'/'||new.addr_pfx||'/'||new.addr_name||'/'||
								   new.addr_type||'/'||new.addr_sfx||'/'	);
	end if;

--	========================================
--	match user address against gis 

<<match_routine>>

	best_weight	:= 0;

for	q in reverse 01..work.fetch_count 					loop

	if	q < work.fetch_count						then
		read_type	:= qualifier (q).addr_type;
		read_pfx	:= qualifier (q).addr_pfx;
		read_sfx	:= qualifier (q).addr_sfx;
		read_id		:= qualifier (q).record_id;

	end if;

	this_weight := 0;

	if	new.addr_pfx   = read_pfx				then
		accept_prefix	:= 01;
		audit_prefix	:= null;
		if	new.addr_pfx = ' '					then
			this_weight := this_weight + empty_weight;	
		else
			this_weight := this_weight + match_weight;	
		end if;

	elsif	new.addr_pfx   < '0'					
	and	work.rule_pfx >= rule.append					
	and	prev_score	  <  forbid_append				then
		audit_prefix	:= append_pfx;
		this_weight 	:= this_weight + append_weight;

	elsif	new.addr_pfx  > '0'					
	and	work.rule_pfx >= rule.change					
	and	prev_score	  <  forbid_change				then
		audit_prefix	:= change_pfx;
		this_weight		:= this_weight + change_weight;
	else
		this_weight		:= this_weight + forbid_weight;
	end if;


	if	new.addr_type   = read_type				then
		accept_type		:= 01;
		audit_type	  	:= null;
		if	new.addr_type = ' '					then
			this_weight := this_weight + empty_weight;	
		else
			this_weight := this_weight + match_weight;	
		end if;

	elsif	new.addr_type   < '0'					
	and	work.rule_type >= rule.append					
	and	prev_score	   <  forbid_append				then
		audit_type		:= append_type;
		this_weight 	:= this_weight + append_weight;

	elsif	new.addr_type  > '0'					
	and	work.rule_type >= rule.change					
	and	prev_score	   <  forbid_change				then
		audit_type		:= change_type;
		this_weight		:= this_weight + change_weight;
	else
		this_weight		:= this_weight + forbid_weight;
	end if;

	if	new.addr_sfx   = read_sfx				then
		accept_suffix	:= 01;
		audit_suffix	:= null;
		if	new.addr_sfx = ' '					then
			this_weight := this_weight + empty_weight;	
		else
			this_weight := this_weight + match_weight;	
		end if;

	elsif	new.addr_sfx   < '0'					
	and	work.rule_sfx >= rule.append					
	and	prev_score    <  forbid_append				then
		audit_suffix	:= append_sfx;
		this_weight 	:= this_weight + append_weight;

	elsif	new.addr_sfx  > '0'					
	and	work.rule_sfx >= rule.change					
	and	prev_score    <  forbid_change				then
		audit_suffix	:= change_sfx;
		this_weight		:= this_weight + change_weight;
	else
		this_weight		:= this_weight + forbid_weight;
	end if;


	if	best_weight < this_weight					then
		best_weight		:= this_weight;
		best_type		:= read_type;
		best_pfx		:= read_pfx;
		best_sfx		:= read_sfx;
		best_id		:= read_id;
		best_audit		:= audit_prefix||audit_type||audit_suffix;
		work.match_count	:= 0;

	if	do_test > 099		then
	dbms_output.put_line ('$best	' || best_audit ||' '|| phase );
	end if;


	end if;

	if	this_weight = best_weight					then
		work.match_count := work.match_count + 01;	
	end if;

	if	do_trace > 0		then
	dbms_output.put_line ('$match1	' ||read_pfx ||'/'||read_type||'/'||read_sfx ||'/'||
								this_weight   ||'/'||best_weight	 ||'/' );
	dbms_output.put_line ('$match2	' ||best_pfx ||'/'||best_name||'/'||
							      best_type||'/'||best_sfx ||'/'	);
	end if;

<<end_match_loop>>
	null;
end loop;

--	========================================
--	if compressed street name was not found then try a fuzzy name match
--	if limited address range was used then expand range to maximum
--	insure fuzzy match does not remove trailing unit number

<<reconsider>>

	if	phase = street_phase			then	
		accept_count := accept_prefix + accept_type + accept_suffix;

		if	new.verify_code >= '0'		then
			retry			:= -1;
		elsif	name_count = 1 			then
			new.addr_name	:= best_name;
			new.do_name		:= rtrim (new.do_name || best_name_chg);
			retry			:= -2;
		end if;
	end if;

	if	phase = street_phase			
	and	retry = 0
	and	rule.do_fuzzy_name >= rule.yes	then
		compare_best := best_name;			
--		TST_compare_names (compare_best, compare_good, count1, count2);
		ADR_compare_names (compare_best, compare_good, count1, count2);

		if	count1 = 01			
		and	(rtrim(new.addr_name, '0123456789') = new.addr_name) 
		  =	(rtrim(compare_best,  '0123456789') = compare_best)		then

	if	do_trace > 0	
	and	name_count = 01		then
	dbms_output.put_line ('$fuzzy		' ||best_name||'/'||compare_best  ||'/'||count1 ||'/');
	end if;

			name_count		:= 01;
			new.addr_name	:= rtrim (compare_best);
			new.do_name		:= 'C';			
			retry			:= 11;
			exit;
		end if;
	end if;

	if	phase = street_phase			
	and	retry = 0				
	and	nvl(new.addr_code,' ') <> 'DPLX'	then

--	test for oversize name
		if	length(new.addr_name) > 20
--	test for initials
		or	instr (new.addr_name, ' ') between 2 and 3				
--	test for 3 or more words
		or	instr (new.addr_name, ' ', 1,2) > 0						
--	test for trailing unit number
--		or	translate (new.addr_name, '#123456789','0000000000') like '% 0%'	
		or	rtrim(new.addr_name,'0123456789') <> new.addr_name					--	new
		then	
			new.verify_code := rule.non_address;
			goto	insert_result;
		end if;
	end if;

--	========================================
--	return partial address

	if	work.match_count = 01					then
		new.addr_type	:= best_type;
		new.addr_pfx	:= best_pfx;
		new.addr_sfx	:= best_sfx;
		best_audit		:= translate (best_audit, ' ', ';');
		this_audit		:= this_audit||best_audit;
	
		if	phase = segment_phase				then
			new.segment_id	:= best_id;
		elsif	phase = address_phase				then
			new.parcel_id	:= best_id;
		end if;
	end if;

<<save_phase_results>>

	this_audit := translate (this_audit, '/', phase);
	new.do_qual := new.do_qual || this_audit;							--	new

	if	phase = street_phase					then
		str.fetch_count	:= work.fetch_count;
		str.match_count	:= work.match_count;
	elsif	phase = block_phase					then
		blk.fetch_count	:= work.fetch_count;
		blk.match_count	:= work.match_count;
	elsif	phase = segment_phase					then
		seg.fetch_count	:= work.fetch_count;
		seg.match_count	:= work.match_count;
	else
		adr.fetch_count	:= work.fetch_count;
		adr.match_count	:= work.match_count;
	end if;

--	===========================================================================================
--	set match scores

	if	work.match_count > 0				then
		if	phase = address_phase			then
			adr_score	:= rule.if_part_match;
		elsif	phase = segment_phase			then
			seg_score	:= rule.if_part_match;
		elsif	phase = block_phase			then
			blk_score	:= rule.if_part_match;
		elsif	phase = street_phase			then
			str_score	:= rule.if_part_match;
		end if;
	elsif	work.fetch_count > 0				then
		if	phase = address_phase			then
			adr_score	:= rule.if_base_match;
		elsif	phase = segment_phase			then
			seg_score	:= rule.if_base_match;
		elsif	phase = block_phase			then
			blk_score	:= rule.if_base_match;
		elsif	phase = street_phase			then
			str_score	:= rule.if_base_match;
		end if;
	end if;
--	===========================================================================================

	if	do_trace > 0		then
	dbms_output.put_line ('$phase1	' ||new.addr_num  ||'/'||new.addr_pfx||'/'||new.addr_name||'/'||
							      new.addr_type ||'/'||new.addr_sfx||'/'	);
	dbms_output.put_line ('$phase2	' ||work.fetch_count  ||'/'||work.match_count||'/'||
								this_audit  ||'/'||		  	
							      work.rule_type||'/'||work.rule_pfx||'/'||work.rule_sfx||'/' );
	end if;

<<end_phase_loop>>

	exit when	name_count	<> 1
		or	new.addr_num = 0;

end loop;

--	========================================

	if	retry  = 11							then
		retry := 12;
		if	rule.do_alias_rename >= rule.yes		then
			goto	match_alias;
		else
			goto	process_phase;
		end if;
	end if;

--	========================================
<<set_verify_code>>

	if	adr.match_count = 0						then
		select count(*)
		into	street_count
		from	adrStreet_syn
		where	new.addr_name	in ( addr_name 	 )
		and	new.addr_type	in ( addr_type, ' ')
		and	new.addr_pfx	in ( addr_pfx,  ' ')
		and	new.addr_sfx	in ( addr_sfx,  ' ');
	end if;

	if	adr.fetch_count > 0						then
		if	adr.match_count = 1					then
			new.verify_code		:= rule.full_address;	
		elsif	adr.match_count > 1					then
			new.verify_code		:= rule.part_address;
		elsif	street_count > 0						then
			new.verify_code		:= rule.wrong_address;
		else
			if	accept_count = 3					then		
				new.verify_code	:= rule.mixed_address;
			else
				new.verify_code	:= rule.poor_address;
			end if;
		end if;

	elsif	seg.fetch_count > 0						then
		if	seg.match_count = 1					then
			new.verify_code		:= rule.full_range;
		elsif	seg.match_count > 1					then
			new.verify_code		:= rule.part_range;
		elsif	street_count > 0						then
			new.verify_code		:= rule.wrong_range;
		else
			if	accept_count = 3					then		
				new.verify_code	:= rule.mixed_range;
			else
				new.verify_code	:= rule.poor_range;
			end if;
		end if;

	elsif	blk.fetch_count > 0						then
		if	blk.match_count = 1					then
			new.verify_code		:= rule.full_block;
		elsif	blk.match_count > 1					then
			new.verify_code		:= rule.part_block;
		elsif	street_count > 0						then
			new.verify_code		:= rule.wrong_block;
		else
			if	accept_count = 3					then		
				new.verify_code	:= rule.mixed_block;
			else
				new.verify_code	:= rule.poor_block;
			end if;
		end if;


	elsif name_count = 1							then
		if	str.match_count = 1					then
			new.verify_code		:= rule.full_orphan;
		elsif	str.match_count > 1					then
			new.verify_code		:= rule.part_orphan;
		elsif	street_count > 0						then
			new.verify_code		:= rule.wrong_orphan;
		else
			if	accept_count = 3					then		
				new.verify_code	:= rule.mixed_orphan;
			else
				new.verify_code	:= rule.poor_orphan;
			end if;
		end if;

		if	nvl (new.addr_num, 0) = 0				then
			new.verify_code		:= new.verify_code - 10;
		end if;

	else

			new.verify_code		:= rule.non_garland;
	end if;

	if	do_trace > 0		then
	dbms_output.put_line ( '$verify1	'|| adr.match_count||'/'||adr.fetch_count	||'/'||seg.match_count||'/'||
						seg.fetch_count||'/'||str.match_count	||'/'||str.fetch_count||'/'	);
	dbms_output.put_line ( '$verify2	'|| street_count   ||'/'|| accept_count	||'/'	);
	end if;

--	========================================
<<insert_result>>

	if	new.verify_code = rule.non_address		then
		new.addr_name	:= appl.addr_name;
		new.addr_type	:= appl.addr_type;
		new.addr_pfx	:= appl.addr_pfx;
		new.addr_sfx	:= appl.addr_sfx;
		new.addr_code	:= appl.addr_code;
		new.addr_unit	:= appl.addr_unit;
		new.do_alias	:= null;
	end if;

	if	do_trace > 0		
	or	do_trace = -1		then
	dbms_output.put_line ( '$insert0	/'  ||new.app_pfx  ||'/'||new.app_name ||'/'||
								new.app_type ||'/'||new.app_sfx  ||'/'||
								new.app_code ||'/'||new.app_unit ||'/'		);
	dbms_output.put_line ( '$insert1	/'  ||new.old_pfx  ||'/'||new.old_name ||'/'||
								new.old_type ||'/'||new.old_sfx  ||'/'||
								new.old_code ||'/'||new.old_unit ||'/'		);
	dbms_output.put_line ( '$insert2	/'  ||new.addr_num ||'/'||new.addr_pfx ||'/'||new.addr_name||'/'||
								new.addr_type||'/'||new.addr_sfx ||'/'||
								new.addr_code||'/'||new.addr_unit||'/'	);
	dbms_output.put_line ( '$insert3	/'  ||new.verify_code ||'/'||new.do_parse||'/'||new.do_alias||'/'||
								new.do_name	||'/'||new.do_qual ||'/'	);
	end if;

	if	do_insert > 0			then

		insert into	adrResult		
		select			
			new.addr_num,	
			nvl(new.addr_pfx,  ' '),	
			new.addr_name,	
			nvl(new.addr_type, ' '),	
			nvl(new.addr_sfx,  ' '),	
			new.addr_code,	
			new.addr_unit,	
			new.verify_code,
			nvl(new.do_parse,' '),
			nvl(new.do_alias,' '),
			nvl(new.do_name, ' '),
			nvl(new.do_qual, ' '),
			new.parcel_id,
			new.segment_id,	
			new.old_pfx,			
			new.old_name,	
			new.old_type,	
			new.old_sfx,	
--			new.old_code,
			new.old_unit,	
			new.rec_key,
			row.row_seq,	
			row.row_id,

			new.old_code,

			new.app_pfx,
			new.app_name,
			new.app_type,
			new.app_sfx,
			new.app_code,
			new.app_unit,
			null					--	new.region_id
		from dual;

		total_output := total_output + sql%rowcount;
		commit;
	end if;

--	========================================
<<end_record_loop>>
	null;
end loop;	

	commit;

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'GIS ADDRESS RESOLVE  '||to_char (sysdate, 'mon dd,yyyy hh24:mi.ss' ));
	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'start name = '   	||rpad(begin_name,20) ||'   stop name = ' ||end_name);
	dbms_output.put_line ( 'read       = '   	||lpad(total_read		,5));
	dbms_output.put_line ( 'input      = '   	||lpad(total_input	,5));
	dbms_output.put_line ( 'insert     = '   	||lpad(total_output	,5));

--	dbms_output.put_line ( ' ' );
--	dbms_output.put_line ( 'test1	     = '   	||lpad(test_count1	,5));
--	dbms_output.put_line ( 'test2	     = '   	||lpad(test_count2	,5));
--	dbms_output.put_line ( 'test3	     = '   	||lpad(test_count3	,5));
--	dbms_output.put_line ( 'test4	     = '   	||lpad(test_count4	,5));


exception

	when program_error then		dbms_output.put_line ( 'program error at	' || row.row_seq );
	when storage_error then		dbms_output.put_line ( 'storage error at	' || row.row_seq );
	when others		 then		dbms_output.put_line ( 'other error at	' || row.row_seq );

end;


--	========================================
/*
	modifications	jan 2
		new.do_qual		incrementally at <save_phase_results>
		work.audit		work_audit
		phase			char		
		scores		set to part_match at <save_phase_results>

	modifications	jan 4
		scores	set base/part <save_phase_results> per fetch/match
		alien		process for any alias_method
		rules		revise forbid constants

		scoring	remove
		sample	remove
		no-op		remove

--	========================================
tasks
=====	

	alien_method		revise
	DPLX				remove addr_num from addr_name when addr_code = 'dplx'

	2726 S 5th Street Cir	prefix removed by block because not forbid by street
	S Fifth Cir			unchanged due to rules
	N Shiloh Rd			vc = 14 due to possible suffix
	264 E Avenue B		vc = 34 due to multiple segments (dupes)
	Kingsbridge			Pfx = ' ' & 'E' (randomly)

	translates			review
	unparsed user exit	reject user keys 
	segment_id			mslink

	anonymous procedure	adrResult_View (excludes appl info)
	named procedure		adrResolve (adrResult)

	rules				document strategies
	adrResult			recreate
	adrResult			phase / hi range
	adrResult			addr_ / form_ / appl_

	non address			"/"		does not belong
	non garland			"="		other city street is acceptable
	non correct			"*"		incomplete name (wild card)
	verify only			"?"		how good is it w/out correction ?

--	========================================
--	time trials	 (MLS = 12,221) (jan 3 2002)

	all functions			211

	minus insert			195		08%
	minus	seg, adr, blk		177		09%

	minus rename
	minus fuzzy				176
	minus alias				109		32%
	minus business			 91		09%
	minus alien				 76		08%
	minus str				 60		08%

	minus parse				 18		20%

	remainder				(18)		09%
						----------------
								103%

	others
		read
		user exits
		translates
		keeps

*/
--	========================================


