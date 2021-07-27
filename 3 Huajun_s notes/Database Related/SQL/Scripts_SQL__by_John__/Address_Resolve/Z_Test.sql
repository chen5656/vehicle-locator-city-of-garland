
--	may 31	good compile

	set echo		off;
	set timing		on;
	set serveroutput	on		size	99999;	
	select '*** address resolve ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;
--	==================================================================================================

--	truncate table	gis_verify_addr;		--	adrResult table

declare

	do_compile			number		 := 01;
	do_insert			number		 := 0;

	start_seq			number		 := 000001;		
	stop_seq			number		 := 999999;
	stop_count			number		 := 999;

--	start_seq			number		 := 0;
--	stop_seq			number		 := start_seq + 0;
--	stop_count			number		 := 1 + 9999;

	commit_size			number		 := 1000;
	choose_name			varchar2(80)	 := '';

	do_trace			number		:= 0;		--	-1=results only	-2=fuzzy
	do_test			number		:= 0;
	trace_count			number 		:= 01;

	test_count1			number	 	:= 0;
	test_count2			number	 	:= 0;
	test_count3			number	 	:= 0;
	show1				varchar2(80); 
	show2				varchar2(80); 
	show3				varchar2(80); 
	show4				varchar2(80); 

--	========================================
--	control constants

	prev_seq			number	:= start_seq - 01; 

	street_phase		char		:= 'S';
	block_phase			char		:= 'B';
	segment_phase		char		:= 'R';
	address_phase		char		:= 'A';

	match_weight		number	:= 10000;				-- apr 2002
	blank_weight		number	:= 1000;
	append_weight		number	:= 100;
	remove_weight		number	:= 10;
	change_weight		number	:= 1;
	forbid_weight		number	:= -100000;

	same_weight			number	:= 3000;
	reduced_weight		number	:= 2000;
	compact_weight		number	:= 1000;

	max_key_length		number	:= 20;		
	max_phase_loops		number	:= 02;
	loop_limit			number	:= 02;
	spec_hi_range		number	:= 999999;
	spec_reduced		char		:= '2';				-- may 2002
	spec_compact		char		:= '4';

	like_non_address		varchar2(3)	:= '%'|| rule.mark_non_address;
	like_non_garland		varchar2(3)	:= '%'|| rule.mark_non_garland;
	like_non_complete		varchar2(3)	:= '%'|| rule.mark_non_complete;
	like_just_verify		varchar2(3)	:= '%'|| rule.mark_just_verify;

	like_parse_error		varchar2(3) := '!%';

	heiroglyphs			varchar2(20) := '~!?$%^*_+=|';
	signals			varchar2(20) := '&@%#/\';
	delimits			varchar2(20) := '-,.;:`''' || chr(09);	
	dividers			varchar2(20) := '()[]{}<>"';
	delimiters			varchar2(40) := delimits || dividers;

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
	match_count		number,
	match_score		number
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
	total_fuzzy			number := 0;
	retry				number := 0;
	commit_count		number := 0;	

	name_count			number;
	street_count		number;

	range_lo			number;
	range_hi			number;

	phase				char;
	parse_method		varchar2(40);
	alias_method		varchar2(10);

--	========================================
--	qualifier match 

	accept_count		number;	
	accept_initial		number;			-- apr 2002
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

	permit_append		number;
	permit_remove		number;
	permit_change		number;

	this_score			number;
	prev_score			number;

	this_type			adrResult.addr_type%type;
	this_pfx			adrResult.addr_pfx%type;
	this_sfx			adrResult.addr_sfx%type;

--	========================================

	read_num			adrResult.addr_num%type;
	read_name			adrResult.appl_name%type;
	read_type			adrResult.appl_type%type;
	read_pfx			adrResult.appl_pfx%type;
	read_sfx			adrResult.appl_sfx%type;
	read_code1			adrResult.appl_code1%type;
	read_unit1			adrResult.appl_unit1%type;
	read_code2			adrResult.appl_code2%type;
	read_unit2			adrResult.appl_unit2%type;
	read_id			varchar2(12);

	best_name			varchar2(80);
	best_type			adrResult.addr_type%type;
	best_pfx			adrResult.addr_pfx%type;
	best_sfx			adrResult.addr_sfx%type;
	best_id			varchar2(12);

	best_weight			number;
	prev_best			number;						-- apr 2002
	best_name_chg		varchar2(01);
	best_audit			varchar2(40);

	this_weight			number;
	this_name_chg		char;
	this_audit			varchar2(40);
	this_bldg			adrResult.addr_unit1%type;

	reduced_name		varchar(80);
	compact_name		varchar(80);

	compare_best		char(100);
	compare_good		char(100);
	count1			number;
	count2			number;

--	========================================

	ALIEN 	adrAlien%rowtype;	

	OUT 		adrResult%rowtype;	

--	========================================
cursor	read_rowid_table		is

	select row_id,	 row_seq
	from	 gis_app_rowid
	where	 row_seq > prev_seq
	and	 rownum < 2;

	ROW	read_rowid_table%rowtype;		

--	========================================
cursor	read_app_table		is

	select *
	from	adrResult_Local
--	from	gis_app_addr
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
	where		addr_name	= out.addr_name
	and		addr_block	= trunc (out.addr_num, -2);

	BLOK		read_block%rowtype;	

--	========================================
cursor	read_segment		is

	select	--+	index_asc ( trvehrcl  trvehrcl_x_name_num)
			distinct
			addr_name, addr_type, addr_pfx, addr_sfx, addr_lo, addr_hi,	
			mslink						--	segment_id	
	from		trvehrcl
	where		addr_name	 = out.addr_name
	and		addr_lo	>= range_lo
	and		addr_hi	<= range_hi;

	SEGM		read_segment%rowtype;	


--	========================================
cursor	read_address		is

	select	distinct
			addr_name, addr_type, addr_pfx, addr_sfx, addr_num, 
			addr_bldg, unit_num,  parcel_id
	from		cdreladr
	where		addr_name	= out.addr_name
	and		addr_num	= out.addr_num;

	ADDR		read_address%rowtype;		

--	========================================
cursor	read_adrItem		is

	select /*+ cache (adrItem) */	
		possible 	
		from adrItem 
		where class in ('B', 'K');

--	========================================
begin

	if	do_compile > 0		then
		return;
	end if;

	if	do_insert  > 0		
	or  	stop_count > 99		then
		do_trace	:= 0;	
		do_test	:= 0;	
	end if;

--	========================================
--	<10>
--	read application table

loop

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
		exit;
	end if;

	if	do_trace <> 0
	or	do_trace + do_test > 0			then
		exit when trace_count <= 0;
		dbms_output.put_line ( ' ' );
		dbms_output.put_line ( '**************************************' );
		dbms_output.put_line ( '$appl		/'||	appl.addr_num  ||'/'|| appl.addr_pfx 
						||'/'|| appl.addr_name ||'/'|| appl.addr_type ||'/'|| appl.addr_sfx 
						||'/'|| appl.addr_code1||'/'|| appl.addr_unit1||'/');
	end if;

	out.appl_num	:= appl.appl_num;				-- may 2002
	out.appl_name	:= appl.appl_name;
	out.appl_type	:= appl.appl_type;
	out.appl_pfx	:= appl.appl_pfx ;
	out.appl_sfx	:= appl.appl_sfx ;
	out.appl_code1	:= appl.appl_code1;
	out.appl_unit1	:= appl.appl_unit1;
	out.appl_code2	:= appl.appl_code2;
 	out.appl_unit2	:= appl.appl_unit2;
	out.form_name	:= appl.form_name;			-- may 2002
	out.form_type	:= appl.form_type;
	out.form_pfx	:= appl.form_pfx ;
	out.form_sfx	:= appl.form_sfx ;
	out.form_code1	:= appl.form_code1;
	out.form_unit1	:= appl.form_unit1;
	out.form_code2	:= appl.form_code2;
 	out.form_unit2	:= appl.form_unit2;

	out.verify_code	:= appl.verify_code;
	out.parcel_id	:= appl.parcel_id;
	out.segment_id	:= appl.segment_id;

--	out.do_parse	:= rtrim(appl.do_parse);		-- may 2002
	out.do_alias	:= rtrim(appl.do_alias);		-- may 2002
	out.do_name		:= rtrim(appl.do_name);
	out.do_qual		:= null;

	if	rule.do_alias = rule.yes	then			-- may 2002
		out.do_alias := null;
	else
		out.do_alias := rtrim(appl.do_alias);	
	end if;

--	========================================
--	<20>
 
	if	rule.do_parse  + rule.do_alien  + rule.do_alias  +
		rule.do_type_A + rule.do_type_B + rule.do_type_C = 0		then
		read_num	:= appl.addr_num;						-- may 2002
		read_name	:= appl.addr_name;
		read_type	:= appl.addr_type;
		read_pfx	:= appl.addr_pfx;
		read_sfx	:= appl.addr_sfx;
		read_code1	:= appl.addr_code1;
		read_unit1	:= appl.addr_unit1;
		read_code2	:= appl.addr_code2;
	 	read_unit2	:= appl.addr_unit2;
	else
		read_num	:= nvl(appl.addr_num,	appl.appl_num  );		-- may 2002
		read_name	:= nvl(appl.form_name,  appl.appl_name );
		read_type	:= nvl(appl.form_type,  appl.appl_type );
		read_pfx	:= nvl(appl.form_pfx,   appl.appl_pfx  );
		read_sfx	:= nvl(appl.form_sfx,   appl.appl_sfx  );
		read_code1	:= nvl(appl.form_code1, appl.appl_code1);
		read_unit1	:= nvl(appl.form_unit1, appl.appl_unit1);
		read_code2	:= nvl(appl.form_code2, appl.appl_code2);
	 	read_unit2	:= nvl(appl.form_unit2, appl.appl_unit2);

		if	out.do_name = 'C'			then				-- may 2002
			out.do_name := null;
		end if;
	end if;

	if	rule.do_unparsed_exit >= rule.yes		then
		adr_Resolve_Unparsed_Exit (	read_num, read_pfx, read_name, read_type, read_sfx, 
							read_code1, read_unit1);


		if	do_trace > 0		then
			show1 := '$do exit1 	/'  ||read_num ||'/'||
					read_pfx   ||'/'||read_name||'/'||read_type||'/'||read_sfx||'/'||
					read_code1 ||'/'||read_unit1||'/'||' ';
			dbms_output.put_line (show1);
		end if;
	else										
		read_name	:= nvl(rtrim(read_name), ' ');
		read_type	:= nvl(rtrim(read_type), ' ');
		read_pfx	:= nvl(rtrim(read_pfx ), ' ');
		read_sfx	:= nvl(rtrim(read_sfx ), ' ');
		read_code1	:= nvl(rtrim(read_code1), ' ');
		read_unit1	:= nvl(rtrim(read_unit1), ' ');
		read_code2	:= nvl(rtrim(read_code2),' ');
		read_unit2	:= nvl(rtrim(read_unit2),' ');
	end if;

	read_name	:= replace (read_name, rpad(' ',3), ' ');	
	read_name	:= replace (read_name, rpad(' ',2), ' ');
	read_name	:= replace (read_name, rpad(' ',2), ' ');

--	========================================
--	<30>
--	process unparsed address

	alias_method := null;

--	if	rule.do_alien = rule.no		then			-- may 2002
	if	rule.do_alias = rule.no		then
		goto	parse_address;
	end if;

	alias_method := 'alien';

	TST_alias_match
	( alias_method, read_num, read_pfx, read_name, read_type, read_sfx, reduced_name, compact_name );	

--	ADR_alias_match
--	( alias_method, read_num, read_pfx, read_name, read_type, read_sfx, reduced_name, compact_name );	

	alias_method := rtrim(alias_method);

	if	do_trace > 0			
	and	alias_method is not null			
	then
		show2 :=  '$alien		/' ||read_pfx||'/'||read_name	  ||'/'||
				read_type ||'/'||read_sfx||'/method=/'||alias_method||'/';
		dbms_output.put_line (show2);
	end if;

	if	alias_method > ' '			then	
		goto	initialize_output;
	end if;

--	========================================
--	<40>
<<parse_address>>

	if	rule.do_parse = rule.no			then
		goto end_parse ;
	end if;

	TST_parse_address 
--	ADR_parse_address 
(	read_num,  read_pfx,  read_name,	read_type,  read_sfx, 
	read_code1,read_unit1,read_code2,	read_unit2,	
	parse_method	);

	if	do_trace > 0		then
		show3 := '$parse	/'  ||read_num ||'/'||
				read_pfx  ||'/'||read_name ||'/'||read_type ||'/'||read_sfx  ||'\'||
				read_code1||'\'||read_unit1||'\'||read_code2||'\'||read_unit2||'\'||
				parse_method  ||'\';
		dbms_output.put_line (show3);
	end if;

	if	parse_method like like_parse_error		then
		out.do_parse	:= parse_method;
		out.verify_code	:= rule.non_address;
		alias_method	:= 'end';
		goto	initialize_output;
	end if;

	read_code1	:= nvl(read_code1,' ');
	read_unit1	:= nvl(read_unit1,' ');
	read_code2	:= nvl(read_code2,' ');
	read_unit2	:= nvl(read_unit2,' ');

<<end_parse>>

--	========================================
--	<50>

	if	rule.do_parsed_exit >= rule.yes		then
		adr_Resolve_Parsed_Exit ( 	read_num, read_pfx, read_name, read_type, read_sfx, 
							read_code1, read_unit1 );

		if	do_trace > 0		then
			show4 := '$do exit2	/' ||read_num ||'/'||


					read_pfx  ||'/'||read_name||'/'||read_type||'/'||read_sfx||'/'||
					read_code1||'/'||read_unit1||'/'||' ';
			dbms_output.put_line (show4);
		end if;
	end if;

--	========================================

	if	rule.do_parsed_exit = rule.no			then		
		read_name 	:= translate (read_name, delimiters, spaces); 		
		read_type 	:= translate (read_type, delimiters, spaces); 		
		read_pfx 	:= translate (read_pfx,  delimiters, spaces); 		
		read_sfx 	:= translate (read_sfx,  delimiters, spaces); 		
		read_code1 	:= translate (read_code1,delimiters, spaces); 		
		read_unit1 	:= translate (read_unit1,delimiters, spaces); 		
		read_code2 	:= translate (read_code2,delimiters, spaces); 		
		read_unit2 	:= translate (read_unit2,delimiters, spaces); 		
	end if;

--	========================================
<<initialize_output>>

	if	rule.do_parsed_exit = rule.no			then		
		read_name	:= replace   (read_name, rpad(' ',3), ' ');	
		read_name	:= replace   (read_name, rpad(' ',2), ' ');
		read_name	:= replace   (read_name, rpad(' ',2), ' ');

		read_name	:= nvl(ltrim (rtrim (read_name)),' ');
		read_type	:= nvl(ltrim (rtrim (read_type)),' ');
		read_pfx	:= nvl(ltrim (rtrim (read_pfx )),' ');
		read_sfx	:= nvl(ltrim (rtrim (read_sfx )),' ');
		read_code1	:= 	 ltrim (rtrim (read_code1));
		read_unit1	:= 	 ltrim (rtrim (read_unit1));
		read_code2	:= 	 ltrim (rtrim (read_code2));
		read_unit2	:= 	 ltrim (rtrim (read_unit2));
	end if;

--	========================================
--	<55>

	out.rec_rowid	:= row.row_id;			
	out.rec_key		:= rtrim(rpad(appl.rec_key, max_key_length));				

	if	parse_method is not null		then			-- may 2002
		out.do_parse	:= parse_method;
	end if;

	out.addr_num	:= read_num;
	out.addr_name	:= read_name;				
	out.addr_type	:= read_type;
	out.addr_pfx	:= read_pfx;
	out.addr_sfx	:= read_sfx;
	out.addr_code1	:= read_code1;
	out.addr_unit1	:= read_unit1;				
	out.addr_code2	:= read_code2;
	out.addr_unit2	:= read_unit2;				
 
	if	rule.do_parse  + rule.do_alien  + rule.do_alias  +		-- may 2002
		rule.do_type_A + rule.do_type_B + rule.do_type_C > 0		then
		out.form_name	:= read_name;
		out.form_type	:= read_type;
		out.form_pfx	:= read_pfx;
		out.form_sfx	:= read_sfx;
		out.form_code1	:= read_code1;
		out.form_unit1	:= read_unit1;
		out.form_code2	:= read_code2;
		out.form_unit2	:= read_unit2;
	end if;

--	========================================

	if	alias_method = 'end'		then
		goto	insert_result;
	end if;

	retry		:= 0;
	loop_limit	:= max_phase_loops;

	if	rule.do_alias  = rule.yes					
	or	rule.do_street > 0		then
		if	alias_method > ' '	then
			null;
		else
			reduced_name := adr_compress_name (out.addr_name, spec_reduced);
			compact_name := adr_compress_name (out.addr_name, spec_compact);
		end if;
	end if;

	if	do_test > 0999		then
	dbms_output.put_line ( '$alias	/method/' ||alias_method ||'/ reduce/'||reduced_name||'/ compact/'|| compact_name ||'/');
	end if;

--	========================================
--	<60>
<<match_alias>>

	if	alias_method > ' '		then
		goto process_alias;
	elsif	rule.do_alias = rule.no		then
		goto	end_alias;
	end if;

	alias_method := 'alias';

--	ADR_alias_match
	TST_alias_match
	( alias_method, out.addr_num, out.addr_pfx, out.addr_name, out.addr_type, out.addr_sfx, 
 	  reduced_name, compact_name );	
	
	if (lower(alias_method) like  'more%'  and   rule.do_more_alias = rule.no)
	or (lower(alias_method) like  'like%'  and   rule.do_like_alias = rule.no)
	then
		alias_method 	:= null;					-- may 2002
		out.addr_pfx	:= read_pfx;
		out.addr_name	:= read_name;
		out.addr_type	:= read_type;
		out.addr_sfx	:= read_sfx;
	end if;

<<process_alias>>

    	if	alias_method like	   like_non_address		then
		out.verify_code	 := rule.non_address;

    	elsif	alias_method like	   like_non_garland		then
		out.verify_code	 := rule.non_garland;

    	elsif	alias_method like	   like_non_complete		then
		out.verify_code	 := rule.non_complete;

    	elsif	alias_method like	   like_just_verify		then
		out.verify_code	 := rule.just_verify;

	elsif	alias_method like '%pull'
	and		replace (upper (out.appl_name), ' ')
	like	'%'|| replace (out.addr_name, ' ') ||'%'		then	
		alias_method	:= rule.mark_parse_undo;
	end if;

	out.do_alias := alias_method;					-- may 2002
--	out.do_alias := rtrim (out.do_alias||alias_method);

	if	out.do_alias > '0'					-- may 2002
	and	retry		 < 11						then
		out.do_name := null;
	end if;

	if	do_trace > 0		then
	dbms_output.put_line ( '$alias	/' ||out.addr_pfx ||'/'||out.addr_name||'/'|| out.addr_type
					||'/'|| out.addr_sfx||'/ method/'||alias_method||'/');
	end if;

	if	out.addr_name <> read_name		then			
		compact_name := adr_compress_name ( out.addr_name , spec_compact);
	end if;

<<end_alias>>

--	out.do_alias := nvl(out.do_alias,' ');						-- may 2002

--	========================================
--	<70>
--	street name is non-address if it contains a business (place) key word

	if	out.do_alias is null							-- may 2002
	and	out.verify_code is null					then	
		if	rtrim (out.addr_name) is null	
		or	instr (out.addr_name, ' ', 1,3) > 0							
		or	out.addr_name  <> 
			translate (out.addr_name, 'x'||signals||heiroglyphs, 'x')		then
			out.verify_code := rule.non_address;
		end if;
	end if;

	if	out.verify_code < rule.just_verify			then
		goto	insert_result;						
	end if;

--	========================================
--	<80>
<<process_phase>>

	loop_limit	:= loop_limit - 01;

	if	loop_limit < 0				then
		dbms_output.put_line ('adrResolve is looping');
		return;
	end if;

	phase			:= null;

	name_count		:= 0;
	street_count	:= 0;

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

	
--	========================================
--	<85>
<<phase_loop>>

for step in 1..4						loop

	this_score		:= 0;
	this_audit		:= null;
	read_type		:= null;
	read_pfx		:= null;
	read_sfx		:= null;

	work.fetch_count	:= 0;
	work.match_count	:= 0;
	work.match_score	:= 0;	

	if	step = 0					then			-- new
		goto	end_phase_loop;

	elsif	step = rule.do_street			then
		phase			:= street_phase;
		work.rule_type	:= rule.str_type;
		work.rule_pfx	:= rule.str_pfx;
		work.rule_sfx	:= rule.str_sfx;
	elsif	step = rule.do_block			then
		phase			:= block_phase;
		work.rule_type	:= rule.blk_type;
		work.rule_pfx	:= rule.blk_pfx;
		work.rule_sfx	:= rule.blk_sfx;

	elsif	step = rule.do_range			then
		phase			:= segment_phase;
		work.rule_type	:= rule.rng_type;
		work.rule_pfx	:= rule.rng_pfx;
		work.rule_sfx	:= rule.rng_sfx;

	elsif	step = rule.do_address			then
		phase			:= address_phase;
		work.rule_type	:= rule.adr_type;
		work.rule_pfx	:= rule.adr_pfx;
		work.rule_sfx	:= rule.adr_sfx;
	else	
		goto	end_phase_loop;
	end if;

	exit when	nvl (out.addr_num, 0) = 0
		and	phase <> street_phase;			

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
		permit_append	:= rule.permit;			-- new
		permit_remove	:= rule.permit;
		permit_change	:= rule.permit;
	end if;

	if	out.verify_code = rule.just_verify	then
		prev_score := 9999;
	elsif	prev_score	= rule.do_street		then
		prev_score := str.match_score;
	elsif	prev_score	= rule.do_address		then
		prev_score := adr.match_score;
	elsif	prev_score	= rule.do_range		then
		prev_score := seg.match_score;
	elsif	prev_score	= rule.do_block		then
		prev_score := blk.match_score;
	else
		prev_score	:= rule.permit;		-- new
	end if;

	if	phase = street_phase			then
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

		accept_initial	:= accept_type + accept_prefix + accept_suffix;		-- apr 2002
		best_name		:= out.addr_name;
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
		this_bldg	:= ' ';
	end if;

	if	do_trace > 0		then
	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( '$work1	/phase/'||phase||'/ rules/'||work.rule_pfx||'/'||
								   work.rule_type ||'/'||work.rule_sfx||'/' ); 
	dbms_output.put_line ( '$work2	/prev/'||prev_score||'/ permits/'
								 ||permit_append||'/'||permit_remove||'/'||permit_change||'/');
	dbms_output.put_line ( '$work3	/compact/'||compact_name||'/');
						
	end if;

--	========================================
--	<90>
--	fetch gis records

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

	if	do_test > 0999 		then
	dbms_output.put_line ( 'fetch		' 
					|| addr.addr_num ||' '|| addr.addr_name
					);
	end if;

--	========================================
--	find unique best street name match 
--	find valid segment match 

	if	phase = street_phase						then

		if	out.verify_code = rule.just_verify			then		-- new
			if	strt.addr_name = out.addr_name		then
				name_count  := 1;
				goto	analyze_fetch;
			else
				goto	end_fetch_loop;
			end if;
		end if;

		if	strt.addr_name	 = out.addr_name			then
			this_weight		:= same_weight;	
			this_name_chg	:= ' ';

		elsif	rule.do_type_A    >= rule.yes	
		and	strt.addr_reduced  = reduced_name
		and	nvl(out.do_alias,' ') = ' '				then		-- may 2002
			this_weight		:= reduced_weight;
			this_name_chg	:= 'A';

		elsif	rule.do_type_B    >= rule.yes	
		and	nvl(out.do_alias,' ') = ' '				then		-- may 2002
			this_weight		:= compact_weight;
			this_name_chg	:= 'B';

		else
			goto	end_fetch_loop;
		end if;
	
		if	this_weight > best_weight				then
			best_weight		:= this_weight;
			best_name		:= strt.addr_name;
			best_name_chg	:= this_name_chg;
			name_count		:= 1;
			work.fetch_count	:= 0;

		elsif	this_weight < best_weight			
		or	name_count	  > 1						then
			goto	end_fetch_loop;

		elsif	strt.addr_name <> best_name				then
			name_count		:= 9;	
			goto	end_fetch_loop;
		end if;

	elsif	phase = segment_phase						then

		if	segm.addr_type = read_type
		and	segm.addr_pfx  = read_pfx
		and	segm.addr_sfx  = read_sfx				then
			goto	end_fetch_loop;

		elsif	out.addr_num < segm.addr_lo
		or	out.addr_num > segm.addr_hi				then
			goto	end_fetch_loop;	
		end if;

	elsif	phase = address_phase						then

		if	addr.addr_type = read_type
		and	addr.addr_pfx  = read_pfx
		and	addr.addr_sfx  = read_sfx				then
			goto	end_fetch_loop;

		elsif	addr.addr_bldg >= '0'					then
			if	this_bldg = ' '					then
				this_bldg := addr.addr_bldg;
			else
				goto	end_fetch_loop;
			end if;

		elsif	addr.unit_num >= '0'					then 
			goto	end_fetch_loop;
		end if;
	end if;

	if	do_trace > 0 		then
		dbms_output.put_line ( '$name		/phase/' ||phase ||'/ best/'||best_name  ||'/'||best_name_chg	
					||'/ this/'|| this_weight||'/ best/'||best_weight||'/ count/'||name_count||'/'	); 
	end if;

--	========================================
--	hold previous street qualifiers
--	get  current qualifiers

<<analyze_fetch>>

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
		read_id	:= segm.mslink;
--		read_id	:= segm.segment_id;
	elsif	phase = address_phase				then
		read_type	:= addr.addr_type;
		read_pfx	:= addr.addr_pfx;
		read_sfx	:= addr.addr_sfx;
		read_id	:= addr.parcel_id;
	end if;

--	========================================
--	<95>
--	find street qualifiers unique to name & number
--	find invalid user qualifiers for name & number 

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

	if	this_score  <  rule.full_match			-- new
	and	this_type	= read_type	
	and	this_pfx	= read_pfx
	and	this_sfx	= read_sfx			then
		this_score	:= rule.full_match;

	elsif	this_score  <  rule.part_match			-- new
	and	this_type	in (' ', read_type)
	and	this_pfx	in (' ', read_pfx)
	and	this_sfx	in (' ', read_sfx)	then
		this_score	:= rule.part_match;

	elsif	this_score  <  rule.base_match	then
		this_score	:= rule.base_match;
	end if;

	if	do_trace > 0		then
	dbms_output.put_line ('$unique1	/read/' ||read_pfx	 ||'/'||read_type	 ||'/'||read_sfx ||'/' );
	dbms_output.put_line ('$unique2	/unique/' ||unique_prefix	||'/'||unique_type||'/'||unique_suffix 
					||'/ match/'|| match_prefix ||'/'||match_type ||'/'||match_suffix  ||'/');
	end if;

<<end_fetch_loop>>
	null;

end loop;

--	========================================

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

	if	phase = street_phase		
	and	name_count <> 01			then
		goto	reconsider;
	end if;

	if	work.fetch_count  = 0		then
		goto	save_phase_results;
	end if;

--	========================================
--	<100>
--	remove irrelevant street qualifiers
--	set unique street qualifiers

	this_audit := null;

	if	phase	= street_phase
	and	out.addr_pfx  > ' '
	and	unique_prefix > ' '					
	and	unique_prefix <> out.addr_pfx
	and	prev_score	  <= permit_change		-- new
	and	work.rule_pfx >= rule.change			then
		out.addr_pfx := unique_prefix;
		this_audit	 := this_audit||change_pfx;

	elsif	out.addr_pfx   > ' '
	and	match_prefix   = 0					
	and	prev_score	  <= permit_remove		-- new
	and	work.rule_pfx >= rule.remove			then
		out.addr_pfx := ' ';
		this_audit	 := this_audit||remove_pfx;	
	end if;

	if	phase	= street_phase
	and	out.addr_pfx  = ' '
	and	unique_prefix > ' '					
	and	prev_score	  <= permit_append		-- new
	and	work.rule_pfx >= rule.append			then
		out.addr_pfx := unique_prefix;
		this_audit	 := this_audit||append_pfx;
	end if;


	if	phase	= street_phase
	and	out.addr_type  > ' '
	and	unique_type    > ' '					
	and	unique_type	   <> out.addr_type
	and	prev_score	   <= permit_change		-- new
	and	work.rule_type >= rule.change			then
		out.addr_type := unique_type;
		this_audit	  := this_audit||change_type;	

	elsif	out.addr_type  > ' '
	and	match_type 	   = 0
	and	prev_score	   <= permit_remove		-- new
	and	work.rule_type >= rule.remove			then
		out.addr_type := ' ';
		this_audit	  := this_audit||remove_type;	
	end if;

	if	phase	= street_phase
	and	out.addr_type  = ' '
	and	unique_type    > ' '					
	and	prev_score	   <= permit_append		-- new
	and	work.rule_type >= rule.append			then
		out.addr_type := unique_type;
		this_audit	  := this_audit||append_type;
	end if;


	if	phase	= street_phase
	and	out.addr_sfx  > ' '
	and	unique_suffix > ' '					
	and	unique_suffix <> out.addr_sfx
	and	prev_score	  <= permit_change		-- new
	and	work.rule_sfx >= rule.change			then
		out.addr_sfx  := unique_suffix;
		this_audit	  := this_audit||change_sfx;

	elsif	out.addr_sfx   > ' '
	and	match_suffix   = 0					
	and	prev_score	  <= permit_remove		-- new
	and	work.rule_sfx >= rule.remove			then
		out.addr_sfx  := ' ';
		this_audit	  := this_audit||remove_sfx;	
	end if;

	if	phase	= street_phase
	and	out.addr_sfx  = ' '
	and	unique_suffix > ' '				
	and	prev_score	  <= permit_append		-- new
	and	work.rule_sfx >= rule.append			then
		out.addr_sfx  := unique_suffix;
		this_audit	  := this_audit||append_sfx;
	end if;

	if	do_trace > 0		then
	dbms_output.put_line ( '$audit1	/out/' ||lpad(out.addr_num,4) ||'/'||out.addr_pfx||'/'||out.addr_name
					||'/'||out.addr_type||'/'||out.addr_sfx||'/ audit/'|| this_audit||'/' );
	end if;

--	========================================
--	<110>
--	match user address against gis 

<<match_routine>>

	best_weight	:= 0;
	prev_best	:= 0;								-- apr 2002

for	q in reverse 01..work.fetch_count 					loop

	if	q < work.fetch_count						then
		read_type	:= qualifier (q).addr_type;
		read_pfx	:= qualifier (q).addr_pfx;
		read_sfx	:= qualifier (q).addr_sfx;
		read_id	:= qualifier (q).record_id;
	end if;

	this_weight := 0;

	if	out.addr_pfx   = read_pfx					then
		accept_prefix	:= 01;
		audit_prefix	:= null;
		if	out.addr_pfx = ' '					then
			this_weight := this_weight + blank_weight;	
		else
			this_weight := this_weight + match_weight;	

		end if;

	elsif	out.addr_pfx  < '0'					
	and	work.rule_pfx >= rule.append					
	and	prev_score	  <= permit_append				then
		audit_prefix	:= append_pfx;
		this_weight 	:= this_weight + append_weight;

	elsif	out.addr_pfx  > '0'						-- apr 2002
	and	read_pfx	  < '0'
	and	work.rule_pfx >= rule.remove					
	and	prev_score	  <= permit_remove				then
		audit_prefix	:= remove_pfx;
		this_weight		:= this_weight + remove_weight;

	elsif	out.addr_pfx  > '0'					
	and	read_pfx	  > '0'
	and	work.rule_pfx >= rule.change					
	and	prev_score	  <= permit_change				then
		audit_prefix	:= change_pfx;
		this_weight		:= this_weight + change_weight;

	else
		this_weight		:= this_weight + forbid_weight;
	end if;


	if	out.addr_type   = read_type					then
		accept_type		:= 01;
		audit_type	  	:= null;
		if	out.addr_type = ' '					then
			this_weight := this_weight + blank_weight;	
		else
			this_weight := this_weight + match_weight;	
		end if;

	elsif	out.addr_type  < '0'					
	and	work.rule_type >= rule.append					
	and	prev_score	   <= permit_append				then
		audit_type		:= append_type;
		this_weight 	:= this_weight + append_weight;

	elsif	out.addr_type  > '0'						-- apr 2002
	and	read_type	   < '0'	
	and	work.rule_type >= rule.remove					
	and	prev_score	   <= permit_remove				then		
		audit_type		:= remove_type;
		this_weight		:= this_weight + remove_weight;

	elsif	out.addr_type  > '0'					
	and	read_type	   > '0'	
	and	work.rule_type >= rule.change					
	and	prev_score	   <= permit_change				then
		audit_type		:= change_type;
		this_weight		:= this_weight + change_weight;

	else
		this_weight		:= this_weight + forbid_weight;
	end if;

	if	out.addr_sfx   = read_sfx					then
		accept_suffix	:= 01;
		audit_suffix	:= null;
		if	out.addr_sfx = ' '					then
			this_weight := this_weight + blank_weight;	
		else
			this_weight := this_weight + match_weight;	
		end if;

	elsif	out.addr_sfx  < '0'					
	and	work.rule_sfx >= rule.append					
	and	prev_score    <= permit_append				then
		audit_suffix	:= append_sfx;
		this_weight 	:= this_weight + append_weight;

	elsif	out.addr_sfx  > '0'						-- apr 2002
	and	read_sfx	  < '0'
	and	work.rule_sfx >= rule.remove					
	and	prev_score	  <= permit_remove				then
		audit_suffix	:= remove_sfx;
		this_weight		:= this_weight + remove_weight;

	elsif	out.addr_sfx  > '0'					
	and	read_sfx	  > '0'
	and	work.rule_sfx >= rule.change					
	and	prev_score    <= permit_change				then
		audit_suffix	:= change_sfx;
		this_weight		:= this_weight + change_weight;

	else
		this_weight		:= this_weight + forbid_weight;
	end if;

	if	best_weight < this_weight					then
		prev_best		:= best_weight;				-- apr 2002
		best_weight		:= this_weight;
		best_type		:= read_type;
		best_pfx		:= read_pfx;
		best_sfx		:= read_sfx;
		best_id		:= read_id;
		best_audit		:= audit_prefix||audit_type||audit_suffix;
		work.match_count	:= 0;
	end if;

	if	this_weight = best_weight					then
		work.match_count := work.match_count + 01;	
	end if;

	if	do_trace > 0		then
	dbms_output.put_line ('$match1	/this wgt/'||this_weight ||' / read/'|| read_pfx ||'/'||read_type
							 ||'/'|| read_sfx ||'/');
	dbms_output.put_line ('$match2	/best wgt/'||best_weight ||' / strt/'|| best_pfx ||'/'||best_name
							 ||'/'||best_type||'/'|| best_sfx ||'/ audit/'|| best_audit||'/');
	end if;

<<end_match_loop>>
	null;
end loop;

--	========================================
--	<120>
--	if compressed street name was not found then try a fuzzy name match

--	if limited address range was used then expand range to maximum
--	insure fuzzy match does not remove trailing unit number

<<reconsider>>

	if	phase <> street_phase			then	
		goto	save_match_results;
	end if;

	accept_count := accept_prefix + accept_type + accept_suffix;

	if	out.verify_code >= '0'			then
		retry			:= -1;

	elsif	name_count = 1 				then
		out.addr_name	:= best_name;
		out.do_name		:= rtrim (out.do_name || best_name_chg);
		retry			:= -2;

	elsif	out.do_alias > '0'			then	
		retry			:= -3;

	elsif	rule.do_business >= rule.yes		then
		read_name	:= ' '||out.appl_name||' ';

		for busi in  read_adrItem		loop
			if	read_name	like '% ' ||busi.possible|| ' %'			then

				out.verify_code	:= rule.non_address;
				retry			:= -4;

				if	do_trace > 0	then
					dbms_output.put_line ('$place		' || busi.possible);
				end if;
				exit;
			end if;
		end loop;
	end if;

	if	retry = 0
	and	rule.do_type_C >= rule.yes		then
		total_fuzzy := total_fuzzy + 01;

		compare_best := best_name;			
--		TST_compare_names (compare_best, compare_good, count1, count2);
		ADR_compare_names (compare_best, compare_good, count1, count2);

		if	do_trace < -1	then
		dbms_output.put_line ('$fuzzy	/best/' ||best_name||'/ compare/'
								  ||compare_best  ||'/ count/'||count1 ||'/');
		end if;


		if	count1 = 01			
		and	(rtrim(out.addr_name, '0123456789') = out.addr_name) 
		  =	(rtrim(compare_best,  '0123456789') = compare_best)		then

		if	do_trace > 0	
		and	count1 = 01		then
		dbms_output.put_line ('$fuzzy	/best/' ||best_name||'/ compare/'
								  ||compare_best  ||'/ count/'||count1 ||'/');
		end if;

			name_count		:= 01;
			out.addr_name	:= rtrim (compare_best);
			compact_name 	:= adr_compress_name (out.addr_name , '4');
			out.do_name		:= 'C';			
			retry			:= 11;
			exit;
		end if;
	end if;

	if	retry = 0					then

--	test for duplex
		if	out.addr_code1 = 'DPLX'		then
			null;

--	test for oversize name
		elsif	length(out.addr_name) > 20
--	test for initials
		or	instr (out.addr_name, ' ') between 2 and 3				
--	test for 3 or more words
		or	instr (out.addr_name, ' ', 1,2) > 0						
--	test for trailing unit number
		or	rtrim(out.addr_name,'0123456789') <> out.addr_name

		then	out.verify_code := rule.non_address;
			goto	insert_result;
		end if;
	end if;

--	========================================
--	<130>
<<save_match_results>>

--	if best_weight exceeds prev_best by blank_weight alone, then multiple match_count
	count1:= best_weight - prev_best;
	if	phase = street_phase
	and	work.match_count = 01							-- apr 2002
	and	prev_best > 0
	and	count1 < match_weight
	and	mod(count1, blank_weight) = 0				then  
		work.match_count := 02;

--	do not use best match if all qualifiers are blank
	elsif	phase = street_phase							-- apr 2002
	and	accept_initial	= 3

	and	work.fetch_count	> 1					then
		work.match_count :=02;

	elsif	work.match_count = 01
	and	nvl(out.verify_code, 99) <> rule.just_verify	then		-- new
		out.addr_type	:= best_type;
		out.addr_pfx	:= best_pfx;
		out.addr_sfx	:= best_sfx;
		best_audit		:= translate (best_audit, ' ', ';');
		this_audit		:= this_audit||best_audit;
	
		if	phase = address_phase				then
			out.parcel_id	:= best_id;
		elsif	phase = segment_phase				then
			out.segment_id	:= best_id;
		end if;
	end if;

<<save_phase_results>>

	this_audit		:= translate (this_audit, '/', phase);
	out.do_qual		:= out.do_qual || this_audit;	
	work.match_score	:= this_score;

	if	phase = street_phase					then
		str.fetch_count	:= work.fetch_count;
		str.match_count	:= work.match_count;
		str.match_score	:= work.match_score;
	elsif	phase = address_phase					then
		adr.fetch_count	:= work.fetch_count;
		adr.match_count	:= work.match_count;
		adr.match_score	:= work.match_score;
	elsif	phase = block_phase					then
		blk.fetch_count	:= work.fetch_count;
		blk.match_count	:= work.match_count;
		blk.match_score	:= work.match_score;
	elsif	phase = segment_phase					then
		seg.fetch_count	:= work.fetch_count;

		seg.match_count	:= work.match_count;
		seg.match_score	:= work.match_score;
	end if;

--	========================================

	if	do_trace > 0		then
	dbms_output.put_line ('$phase1	/out/' || lpad(out.addr_num,4)||'/'||out.addr_pfx
					||'/'||out.addr_name||'/'||out.addr_type	||'/'||out.addr_sfx||'/');
	dbms_output.put_line ('$phase2	/work fetch/' || work.fetch_count	||'/ match/'||work.match_count
					||'/ audit/'||this_audit||'/'	
					||'/ work qual/'||work.rule_type||'/'||work.rule_pfx||'/'||work.rule_sfx||'/' );
	dbms_output.put_line ('$phase3	/scores/' || str.match_score  ||'/'||blk.match_score
				 	||'/'||seg.match_score||'/'||adr.match_score||'/');
	end if;


<<end_phase_loop>>

	exit when	name_count	<> 1
		or	out.addr_num = 0;

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
--	<140>

<<set_verify_code>>

	if	adr.match_count = 0						then
		select count(*)
		into	street_count
		from	adrStreet_syn
		where	out.addr_name	in ( addr_name 	 )
		and	out.addr_type	in ( addr_type, ' ')
		and	out.addr_pfx	in ( addr_pfx,  ' ')
		and	out.addr_sfx	in ( addr_sfx,  ' ');
	end if;

	if	name_count = 1										then	
		out.verify_code	:= rule.valid_name;
	elsif	rule.do_street + rule.do_block + rule.do_range + rule.do_address > 0	then
		out.verify_code	:= rule.non_garland;
	end if;

	if	adr.fetch_count > 0						then
		if	adr.match_count = 1					then
			out.verify_code		:= rule.full_address;	
		elsif	adr.match_count > 1					then
			out.verify_code		:= rule.part_address;
		elsif	street_count > 0						then
			out.verify_code		:= rule.wrong_address;
		else
			if	accept_count = 3					then		
				out.verify_code	:= rule.mixed_address;
			else
				out.verify_code	:= rule.poor_address;
			end if;
		end if;

	elsif	seg.fetch_count > 0						then
		if	seg.match_count = 1					then
			out.verify_code		:= rule.full_range;
		elsif	seg.match_count > 1					then
			out.verify_code		:= rule.part_range;
		elsif	street_count > 0						then
			out.verify_code		:= rule.wrong_range;
		else
			if	accept_count = 3					then		
				out.verify_code	:= rule.mixed_range;
			else
				out.verify_code	:= rule.poor_range;
			end if;
		end if;

	elsif	blk.fetch_count > 0						then
		if	blk.match_count = 1					then
			out.verify_code		:= rule.full_block;
		elsif	blk.match_count > 1					then
			out.verify_code		:= rule.part_block;
		elsif	street_count > 0						then
			out.verify_code		:= rule.wrong_block;
		else
			if	accept_count = 3					then		
				out.verify_code	:= rule.mixed_block;
			else
				out.verify_code	:= rule.poor_block;
			end if;
		end if;

	elsif name_count = 1							then
		if	str.match_count = 1					then
			out.verify_code		:= rule.full_orphan;
		elsif	str.match_count > 1					then
			out.verify_code		:= rule.part_orphan;
--		elsif	street_count > 0						then
--			out.verify_code		:= rule.wrong_orphan;
		else
			if	accept_count = 3					then		
				out.verify_code	:= rule.mixed_orphan;
			else
				out.verify_code	:= rule.poor_orphan;
			end if;
		end if;

		if	nvl (out.addr_num, 0) = 0				then
			out.verify_code		:= out.verify_code - 10;
		end if;

--	else	
--			out.verify_code		:= rule.non_garland;
	end if;

	if	do_trace > 0		then
	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( '$verify	 /adr/' ||	adr.fetch_count ||';'|| adr.match_count ||
					'/ seg/'||	seg.fetch_count ||';'|| seg.match_count ||
					'/ blk/'||	blk.fetch_count ||';'|| blk.match_count ||
					'/ str/'||	str.fetch_count ||';'|| str.match_count	);
	dbms_output.put_line ( '$verify	/streets/'||	street_count    ||'/ accepts/'|| accept_count	);
	end if;

--	========================================
--	<190>
<<insert_result>>

	if	do_trace > 0		
	or	do_trace < 0		then
	dbms_output.put_line ( '$insert	/appl/'   || out.appl_pfx  ||'/'||out.appl_name ||'/'||
									 out.appl_type ||'/'||out.appl_sfx  ||'/'||
									 out.appl_code1||'/'||out.appl_unit1||'/'	);
	dbms_output.put_line ( '$insert	/form/'   || out.form_pfx  ||'/'||out.form_name ||'/'||
									 out.form_type ||'/'||out.form_sfx  ||'/'||
									 out.form_code1||'/'||out.form_unit1||'/'	);
	dbms_output.put_line ( '$insert	/addr/'   || out.addr_num  ||'/'||out.addr_pfx  ||'/'||out.addr_name
								    ||'/'||	out.addr_type ||'/'||out.addr_sfx ||'/'||
									 out.addr_code1||'/'||out.addr_unit1    ||'/');
	dbms_output.put_line ( '$insert	/verify/' || out.verify_code ||'/ parse/'||out.do_parse  ||'/ alias/'||out.do_alias

								    ||'/ name/'||	out.do_name	||'/ qual/'||out.do_qual ||'/');
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

	if	rule.keep_unparsed = rule.no			then
		out.appl_name	:= null;
		out.appl_type	:= null;
		out.appl_pfx	:= null;
		out.appl_sfx	:= null;
		out.appl_code1	:= null;
		out.appl_unit1	:= null;
	end if;

	if	rule.keep_unparsed = rule.yes
	and	out.verify_code = rule.non_address		then
		out.addr_name	:= out.appl_name;
		out.addr_type	:= out.appl_type;
		out.addr_pfx	:= out.appl_pfx;
		out.addr_sfx	:= out.appl_sfx;
		out.addr_code1	:= out.appl_code1;
		out.addr_unit1	:= out.appl_unit1;
		out.do_alias	:= null;			-- may 2002
	end if;


	if	do_insert > 0			then

--		if	total_output = 0		then
--			insert into adrResult (addr_name, rec_seq) 
--			select app_id, 0	from gis_app_addr where rownum < 2;
--		end if;	

		insert into	adrResult		
		select			

			out.addr_num,	
			nvl(out.addr_pfx,  ' '),	
			out.addr_name,	
			nvl(out.addr_type, ' '),	
			nvl(out.addr_sfx,  ' '),	
			out.addr_code1,	
			out.addr_unit1,	
			out.addr_code2,	
			out.addr_unit2,	

			out.verify_code,
			nvl(out.do_parse, ' '),
			nvl(out.do_alias, ' '),
			nvl(out.do_name,  ' '),
			nvl(out.do_qual,  ' '),

			row.row_seq,	
			row.row_id,
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

	end if;

--	========================================
<<end_record_loop>>
	null;
end loop;	

	commit;

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'GIS ADDRESS RESOLVE  '||to_char (sysdate, 'mon dd,yyyy hh24:mi.ss' ));
	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'read       = '   	||lpad(total_read		,6));
	dbms_output.put_line ( 'input      = '   	||lpad(total_input	,6));
	dbms_output.put_line ( 'insert     = '   	||lpad(total_output	,6));
	dbms_output.put_line ( 'fuzzy      = '   	||lpad(total_fuzzy	,6));

--	dbms_output.put_line ( ' ' );
--	dbms_output.put_line ( 'test1	     = '   	||lpad(test_count1	,6));
--	dbms_output.put_line ( 'test2	     = '   	||lpad(test_count2	,6));
--	dbms_output.put_line ( 'test3	     = '   	||lpad(test_count3	,6));
--	dbms_output.put_line ( 'test4	     = '   	||lpad(test_count4	,6));

end;


--	========================================
/*


	modifications	mar 06
		reformat gis_verify_addr
		index = adrAlias_compact
		adrAlias_match - relocate adrItem search
		revise test for mark_parse_undo
		remove final exception

		revise initial non_address test
		revise reconsider

	modifications	mar 26
		insert app_id into adrResult
		minor stuff & trace labels
		change forbid rule to permit rule

		keep mslink, not segment id
		if alias correction, then type A,B,C not allowed
		relocate out.do_ initialization to beginning
		insure out.do_alias,is not null after alias match
		commit_size
		ignore step = 0

		reassign a/r/c weights
		if best weight based on blank weight, then partial match
		process per remove weight
		no best match when all qualifiers are blank

	modifications	may 21
		many refinements ...

--	=======================================================================
tasks
=====	

	unparsed user exit	reject user keys 

	named procedure		adrResolve (adrResult)

*/
--	=======================================================================



