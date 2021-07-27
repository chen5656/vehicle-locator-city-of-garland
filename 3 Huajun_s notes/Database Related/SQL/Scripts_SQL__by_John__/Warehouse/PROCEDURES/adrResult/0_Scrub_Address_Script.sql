

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     1  package          SCRUB_ADDRESSES   AS
     2
     3  --	=============================================================
     4
     5  	procedure	Batch_Driver
     6  (
     7  	spec_insert		in		number	default 01,
     8  	spec_seq		in		number	default 0
     9  );
    10
    11  --	=============================================================
    12  	procedure	Query_Driver
    13  (
    14  	addr_num		in out	varchar2,
    15  	addr_pfx		in out	varchar2,
    16  	addr_name		in out	varchar2,
    17  	addr_type		in out	varchar2,
    18  	addr_sfx		in out	varchar2,
    19
    20  	addr_code1		in out	varchar2,
    21  	addr_unit1		in out	varchar2,
    22  	addr_code2		in out	varchar2,
    23  	addr_unit2		in out	varchar2,
    24
    25  	form_pfx		in out	varchar2,
    26  	form_name		in out	varchar2,
    27  	form_type		in out	varchar2,
    28  	form_sfx		in out	varchar2,
    29
    30  	form_code1		in out	varchar2,
    31  	form_unit1		in out	varchar2,
    32  	form_code2		in out	varchar2,
    33  	form_unit2		in out	varchar2,
    34
    35  	verify_code		out		number,
    36  	gis_key		out		varchar2,
    37  	audit			out		varchar2,
    38
    39  	spec_insert		in		number	default 01,
    40  	spec_seq		in		number	default 0
    41
    42  	,Tracker_Mode	in		number	default 0
    43  	,Tracker_Focus	in		varchar2	default null
    44  	,Tracked_Focus	in		varchar2	default null
    45  );
    46  --	=============================================================
    47
    48  end;

48 rows selected.



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     1  package body          SCRUB_ADDRESSES	AS
     2  --	=====================================================================
     3
     4  --	=====================================================================
     5  --	TASKS
     6  --	=====================================================================
     7  --	MODIFICATIONS
     8  --	=====================================================================
     9
    10  	do_insert			binary_integer		:= 0;
    11
    12  	start_seq			binary_integer		:= 01;
    13  	stop_seq			binary_integer		:= scrub_rule.capacity;
    14  	stop_count			binary_integer		:= scrub_rule.capacity;
    15  	choose_name			varchar2(80)		:= '';
    16  	choose_num			varchar2(80)		:= '';
    17
    18  --	========================================
    19  --	control constants
    20
    21  	prev_seq			binary_integer	:= start_seq - 01;
    22  	max_key_length		binary_integer	:= 20;
    23  	max_phase_loops		binary_integer	:= 02;
    24  	loop_limit			binary_integer	:= 02;
    25
    26  --	commit_size			binary_integer	:= 1000;
    27  	commit_size			binary_integer	:= 01;
    28
    29  	street_phase		char		:= 'S';
    30  	block_phase			char		:= 'B';
    31  	segment_phase		char		:= 'R';
    32  	address_phase		char		:= 'A';
    33  	intersect_phase		char		:= 'X';
    34
    35  	spec_reduced		char		:= '1';
    36  	spec_compact		char		:= '4';
    37  	spec_hi_range		binary_integer	:= 999999;
    38
    39  	decide_loop			binary_integer 	:= 10;
    40  	decide_exit			binary_integer 	:= 20;
    41  	decide_insert		binary_integer	:= 70;
    42  	decide_return		binary_integer	:= 80;
    43  	decide_error		binary_integer	:= 90;
    44
    45  	same_weight			binary_integer	:= 30;
    46  	reduced_weight		binary_integer	:= 20;
    47  	compact_weight		binary_integer	:= 10;
    48
    49  	reduced_alias		binary_integer	:= ADR_find.reduced_score;
    50  	compact_alias		binary_integer	:= ADR_find.compact_score;
    51
    52  	match_weight		binary_integer	:= scrub_rule.match;
    53  	blank_weight		binary_integer	:= scrub_rule.blank;
    54  	append_weight		binary_integer	:= scrub_rule.append;
    55  	change_weight		binary_integer	:= scrub_rule.change;
    56  	remove_weight		binary_integer	:= scrub_rule.remove;
    57  	forbid_weight		binary_integer	:= scrub_rule.match * - 10;
    58
    59  	like_non_address		varchar2(3)	:= '%'|| scrub_rule.mark_non_address;
    60  	like_non_garland		varchar2(3)	:= '%'|| scrub_rule.mark_non_garland;
    61  	like_non_complete		varchar2(3)	:= '%'|| scrub_rule.mark_non_complete;
    62  	like_verify_only		varchar2(3)	:= '%'|| scrub_rule.mark_verify_only;
    63  	like_parse_error		varchar2(3) := 	   scrub_rule.mark_parse_error || '%';
    64
    65  	parse_default		varchar2(90) := scrub_rule.parse_default;
    66  	signals			varchar2(20) := '&@%#\/' || chr(47);
    67  --	chr(47) = ampersand
    68
    69  	process_qualifier		binary_integer	:= scrub_rule.do_street + scrub_rule.do_block	+
    70  							   scrub_rule.do_range  + scrub_rule.do_address;
    71
    72  --	========================================
    73  --	AUDIT
    74
    75  	append_type		char(04) := '/at ';
    76  	append_pfx		char(04) := '/ap ';
    77  	append_sfx		char(04) := '/as ';
    78  	change_type		char(04) := '/ct ';
    79  	change_pfx		char(04) := '/cp ';
    80  	change_sfx		char(04) := '/cs ';
    81  	remove_type		char(04) := '/rt ';
    82  	remove_pfx		char(04) := '/rp ';
    83  	remove_sfx		char(04) := '/rs ';
    84
    85  --	========================================
    86  --	PHASE RECORD
    87
    88  	type phase_rec	is record
    89  (
    90  	rule_unq_type	binary_integer,
    91  	rule_unq_pfx	binary_integer,
    92  	rule_unq_sfx	binary_integer,
    93  	rule_type		binary_integer,
    94  	rule_pfx		binary_integer,
    95  	rule_sfx		binary_integer,
    96  	fetch_count		binary_integer,
    97  	match_count		binary_integer,
    98  	match_score		binary_integer
    99  );
   100
   101  	work			phase_rec;
   102  	str			phase_rec;
   103  	blk			phase_rec;
   104  	seg			phase_rec;
   105  	adr			phase_rec;
   106
   107  --	========================================
   108  --	STREET QUALIFIERS
   109
   110  	type qualifier_record	is record
   111  (
   112  	addr_type		varchar2(04),
   113  	addr_pfx		varchar2(02),
   114  	addr_sfx		varchar2(02),
   115  	record_id		varchar2(12),
   116  	mslink		binary_integer
   117  );
   118
   119  --	QUALIFIER  TABLE
   120
   121  	type qualifier_table	is table of		qualifier_record
   122  		index by	binary_integer;
   123  	qualifier		qualifier_table;
   124
   125  --	========================================
   126
   127  	total_read			binary_integer := 0;
   128  	total_input			binary_integer := 0;
   129  	total_output		binary_integer := 0;
   130  	total_record		binary_integer := 0;
   131  	total_fuzzy			binary_integer := 0;
   132  	total_alias			binary_integer := 0;
   133  	commit_count		binary_integer := 0;
   134
   135  	phase				char;
   136  	retry				binary_integer;
   137  	step				binary_integer;
   138  	recd				binary_integer;
   139  	decision			binary_integer;
   140  	verify_id			binary_integer;
   141
   142  	name_count			binary_integer;
   143  	street_count		binary_integer;
   144
   145  	street_weight		binary_integer;
   146  	block_weight		binary_integer;
   147  	segment_weight		binary_integer;
   148  	address_weight		binary_integer;
   149  	final_weight		binary_integer;
   150
   151  	range_lo			binary_integer;
   152  	range_hi			binary_integer;
   153
   154  --	========================================
   155  --	qualifier match
   156
   157  	accept_count		binary_integer;
   158  	accept_initial		binary_integer;
   159  	accept_type			binary_integer;
   160  	accept_prefix		binary_integer;
   161  	accept_suffix		binary_integer;
   162
   163  	match_type			binary_integer;
   164  	match_prefix		binary_integer;
   165  	match_suffix		binary_integer;
   166
   167  	unique_type			varchar2(04);
   168  	unique_prefix		varchar2(02);
   169  	unique_suffix		varchar2(02);
   170
   171  	audit_type			char(04);
   172  	audit_prefix		char(04);
   173  	audit_suffix		char(04);
   174
   175  --	permit_append		binary_integer;
   176  --	permit_remove		binary_integer;
   177  --	permit_change		binary_integer;
   178
   179  	prev_score			binary_integer;
   180  	best_score			binary_integer;
   181
   182  --	========================================
   183
   184  	read_num			scrub_result.appl_num%type;
   185  	read_pfx			scrub_result.appl_pfx%type;
   186  	read_name			scrub_result.appl_name%type;
   187  	read_type			scrub_result.appl_type%type;
   188  	read_sfx			scrub_result.appl_sfx%type;
   189  	read_code1			scrub_result.appl_code1%type;
   190  	read_unit1			scrub_result.appl_unit1%type;
   191  	read_code2			scrub_result.appl_code2%type;
   192  	read_unit2			scrub_result.appl_unit2%type;
   193  	read_id			varchar2(20);
   194  	read_mslink			binary_integer;
   195
   196  	this_num			scrub_result.addr_num%type;
   197  	this_pfx			scrub_result.addr_pfx%type;
   198  	this_name			scrub_result.addr_name%type;
   199  	this_type			scrub_result.addr_type%type;
   200  	this_sfx			scrub_result.addr_sfx%type;
   201  	this_bldg			scrub_result.addr_unit1%type;
   202
   203  	best_pfx			scrub_result.addr_pfx%type;
   204  	best_name			scrub_result.addr_name%type;
   205  	best_type			scrub_result.addr_type%type;
   206  	best_sfx			scrub_result.addr_sfx%type;
   207  	best_id			varchar2(20);
   208  	best_mslink			binary_integer;
   209
   210  	prev_best			binary_integer;
   211  	best_weight			binary_integer;
   212  	best_name_chg		char(01);
   213  	best_audit			varchar2(80);
   214
   215  	this_weight			binary_integer;
   216  	this_name_chg		char;
   217  	this_audit			varchar2(80);
   218
   219  	parse_method		varchar2(80);
   220  	alias_table			varchar2(08);
   221  	alias_method		varchar2(08);
   222  	alias_result		varchar2(08);
   223
   224  	alias_weight		binary_integer;
   225  	alias_match			binary_integer;
   226  	alias_second		varchar2(40);
   227  	alias_also			varchar$v	:= varchar$v ('', '', '', '','');
   228
   229  	street_name			varchar2(80);
   230  	reduced_name		varchar2(80);
   231  	compact_name		varchar2(80);
   232
   233  	test_count1			binary_integer := 0;
   234  	test_count2			binary_integer := 0;
   235  	test_count3			binary_integer := 0;
   236
   237  --	========================================
   238
   239  	OUT 	garland.SCRUB_RESULT%rowtype;
   240
   241  --	========================================
   242  cursor	read_rowid_table		is
   243
   244  	select row_id, row_seq
   245  	from	 garland.gis_app_rowid
   246  	where	 row_seq > prev_seq
   247  	and	 rownum < 2;
   248
   249  	ROW	read_rowid_table%rowtype;
   250
   251  --	========================================
   252  cursor	read_app_table		is
   253
   254  	select *
   255  	from	garland.SCRUB_RESULT_Input
   256  	where	rowid = row.row_id;
   257
   258  	APPL	read_app_table%rowtype;
   259
   260  --	========================================
   261  cursor	read_street			is
   262
   263  	select	*
   264  	from		garland.adrStreet_syn
   265  	where		addr_compact = compact_name;
   266
   267  	STRT		read_street%rowtype;
   268
   269  --	========================================
   270  cursor	read_block			is
   271
   272  	select	--+	index_asc ( adrBlock  adrBlock_pkey)
   273  			all *
   274  	from		garland.adrBlock
   275  	where		addr_name	= out.addr_name
   276  	and		addr_block	= trunc (out.addr_num, -2);
   277
   278  	BLOK		read_block%rowtype;
   279
   280  --	========================================
   281  cursor	read_segment		is
   282
   283  	select	--+	index_asc ( trvehrcl  trvehrcl_x_name_num)
   284  			distinct
   285  			addr_name, addr_type, addr_pfx, addr_sfx, addr_lo, addr_hi, mslink
   286  	from		garland.trvehrcl
   287  	where		addr_name	 = out.addr_name
   288  	and		addr_lo	>= range_lo
   289  	and		addr_hi	<= range_hi
   290  	order by	1,2,3,4,5,6,7;
   291
   292  	SEGM		read_segment%rowtype;
   293
   294  --	========================================
   295  cursor	read_address		is
   296
   297  	select	distinct
   298  			addr_name, addr_type, addr_pfx, addr_sfx, addr_num,
   299  			addr_bldg, unit_num,
   300  			parcel_id, mslink
   301  	from		garland.cdreladr
   302  	where		addr_name	= out.addr_name
   303  	and		addr_num	= out.addr_num
   304  	order by	1,2,3,4,5,6,7,8;
   305
   306  	ADDR		read_address%rowtype;
   307
   308  --	=================================================================
   309  --	<A>
   310  	procedure	Match_Alias_Street	is
   311
   312  begin
   313
   314  	alias_table	:= alias_method;
   315
   316  	if	street_name <> read_name		then
   317  		street_name  := read_name;
   318  		reduced_name := ADR_compress_name (read_name, spec_reduced);
   319  		compact_name := ADR_compress_name (read_name, spec_compact);
   320  	end if;
   321
   322  	this_num	:= read_num;
   323  	this_pfx	:= read_pfx;
   324  	this_name	:= read_name;
   325  	this_type	:= read_type;
   326  	this_sfx	:= read_sfx;
   327
   328  	if	alias_table = 'alien'			then
   329  	ADR_alias_match
   330  --	TST_alias_match
   331  	( 	alias_method,
   332  		read_num, read_pfx, read_name, read_type, read_sfx,
   333  	 	reduced_name, compact_name );
   334
   335  	else
   336  	garland.ADR_FIND.FIND_ALIAS
   337  --	garland.ADR_FIND_01.FIND_ALIAS
   338  	(
   339  		read_num,
   340  		read_pfx,
   341  		read_name,
   342  		read_type,
   343  		read_sfx,
   344
   345  		alias_second,
   346  		alias_also,
   347  		alias_method,
   348  		alias_match,
   349  		alias_weight
   350  	);
   351  	end if;
   352
   353  	alias_method := rtrim (alias_method);
   354
   355  	if	alias_method  = ADR_Find.asis_method
   356  	and	read_name <> this_name					then
   357  		if	alias_match >= reduced_alias			then
   358  			out.do_name	 := 'A';
   359  		elsif	alias_match >= compact_alias			then
   360  			out.do_name	 := 'B';
   361  		end if;
   362  	end if;
   363
   364  --	if	alias_method in ( 'a', 'b', 'c')			then
   365  --		out.do_name	 := alias_method;
   366  --	end if;
   367
   368  	if  (	out.do_name = 'A'	 and	scrub_rule.do_type_A = scrub_rule.no )
   369  	or  (	out.do_name = 'B'	 and	scrub_rule.do_type_B = scrub_rule.no )
   370
   371  	or	alias_weight < scrub_rule.do_alias_weight			then
   372
   373  		alias_method := null;
   374  		out.do_name	 := null;
   375
   376  		read_name	:= this_name;
   377  		read_type	:= this_type;
   378  		read_pfx	:= this_pfx;
   379  		read_sfx	:= this_sfx;
   380  		read_num	:= this_num;
   381  	end if;
   382
   383  	if	alias_method >= 'A'
   384  	and	lower(alias_method) <> 'part'
   385  	and	read_name	= this_name
   386  	and	read_type	= this_type
   387  	and	read_pfx	= this_pfx
   388  	and	read_sfx	= this_sfx
   389  	and	read_num	= this_num					then
   390  		alias_method := null;
   391  	end if;
   392
   393  	if	alias_method > ' '					then
   394  		verify_id	:= scrub_rule.valid_name;
   395  	end if;
   396
   397      	if	alias_method like	   like_non_address		then
   398  		verify_id	 := scrub_rule.non_address;
   399
   400      	elsif	alias_method like	   like_non_garland		then
   401  		verify_id	 := scrub_rule.non_garland;
   402
   403      	elsif	alias_method like	   like_non_complete		then
   404  		verify_id	 := scrub_rule.non_complete;
   405
   406  	elsif	alias_method like '%pull%'
   407  	and		replace (upper(out.appl_name), ' ')
   408  	like	'%'|| replace (read_name, ' ') ||'%'		then
   409  		alias_method	:= scrub_rule.mark_parse_undo;
   410
   411  	end if;
   412
   413  -- ****
   414  	if	alias_method  = ADR_Find.asis_method		then
   415  		alias_method := null;
   416  	end if;
   417
   418  	if	alias_table  = 'alien'
   419  	and	alias_method > ' '
   420  	and	nvl(verify_id,0)	> scrub_rule.non_address		then
   421  		out.form_name	:= read_name;
   422  		out.form_type	:= read_type;
   423  		out.form_pfx	:= read_pfx;
   424  		out.form_sfx	:= read_sfx;
   425  	end if;
   426
   427  	if	alias_method > ' '					then
   428  		out.do_alias	:= alias_method;
   429  		out.alias_score	:= alias_weight;
   430  		alias_result	:= alias_method;
   431  		total_alias		:= total_alias + 01;
   432  	end if;
   433
   434  	if	alias_table	= 'alien'
   435  	and	alias_result > ' '					then
   436  		alias_match		:= 0;
   437  		alias_weight	:= 9;
   438  	end if;
   439
   440  end	Match_Alias_Street;
   441
   442  --	===========================================================================
   443  --	<I>
   444  	procedure	Phase_Initialize		is
   445
   446  --	Accept_Type = 1	when user street type = GIS type or space
   447  --	Initialize valid name search parameters
   448  --	===========================================================================
   449
   450  begin
   451
   452  	if	phase = street_phase
   453  	and	street_name  <> out.addr_name		then
   454  		street_name  := out.addr_name;
   455  		reduced_name := adr_compress_name (out.addr_name, spec_reduced);
   456  		compact_name := adr_compress_name (out.addr_name, spec_compact);
   457  	end if;
   458
   459  	if	step	= scrub_rule.do_street			then
   460
   461  		if	out.addr_type = ' '		then
   462  			accept_type  := 1;
   463  		else
   464  			accept_type  := 0;
   465  		end if;
   466
   467  		if	out.addr_pfx = ' '		then
   468  			accept_prefix := 1;
   469  		else
   470  			accept_prefix := 0;
   471  		end if;
   472
   473  		if	out.addr_sfx = ' '		then
   474  			accept_suffix := 1;
   475  		else
   476  			accept_suffix := 0;
   477  		end if;
   478
   479  		accept_initial	:= accept_type + accept_prefix + accept_suffix;
   480
   481  	end if;
   482
   483  	if	phase = street_phase			then
   484
   485  		best_name		:= out.addr_name;
   486  		best_name_chg	:= ' ';
   487  		best_weight		:= 0;
   488
   489  	elsif	phase = segment_phase			then
   490
   491  		select	min(start_lo),	max(stop_lo) + 99
   492  		into		range_lo,		range_hi
   493  		from		garland.block
   494  		where		addr_name	= out.addr_name
   495  		and		addr_block	= trunc(out.addr_num, -2);
   496
   497  	elsif	phase = address_phase			then
   498  		this_bldg	:= ' ';
   499  	end if;
   500
   501  end	Phase_Initialize;
   502
   503  --	=================================================================
   504  --	<F>
   505  	function	Phase_Filter	return number	is
   506
   507  --	Evaluate current adrStreet name for best street name match
   508  --	Filter out duplicate or non-matching TRVEHRCL records
   509  --	Filter out duplicate or non-matching CDRELADR records
   510  --	=================================================================
   511
   512  begin
   513
   514  		-- dbms_output.put_line ( 'phase filter' );
   515
   516  	if	phase = street_phase					then
   517
   518  		if	strt.addr_name	 = out.addr_name		then
   519  			this_weight		:= same_weight;
   520  			this_name_chg	:= ' ';
   521
   522  		elsif	alias_result	= scrub_rule.mark_verify_only		then
   523
   524  			return decide_loop;
   525
   526  		elsif	scrub_rule.do_type_A    >= scrub_rule.yes
   527  		and	strt.addr_reduced  = reduced_name
   528  		and	alias_result is null				then
   529  			this_weight		:= reduced_weight;
   530  			this_name_chg	:= 'A';
   531
   532  		elsif	scrub_rule.do_type_B    >= scrub_rule.yes
   533  		and	alias_result is null				then
   534  			this_weight		:= compact_weight;
   535  			this_name_chg	:= 'B';
   536
   537  		else
   538  			return decide_loop;
   539  		end if;
   540
   541  		if	this_weight > best_weight			then
   542  			best_weight		:= this_weight;
   543  			best_name		:= strt.addr_name;
   544  			best_name_chg	:= this_name_chg;
   545  			name_count		:= 1;
   546  			work.fetch_count	:= 0;
   547
   548  		elsif	this_weight < best_weight
   549
   550  		or	name_count  > 1					then
   551  			return decide_loop;
   552
   553  		elsif	strt.addr_name <> best_name			then
   554  			name_count		:= 9;
   555  			return	decide_loop;
   556  		end if;
   557
   558
   559  	elsif	phase = segment_phase					then
   560
   561  		if	segm.addr_type = read_type
   562  		and	segm.addr_pfx  = read_pfx
   563  		and	segm.addr_sfx  = read_sfx			then
   564  			return decide_loop;
   565
   566  		elsif	out.addr_num < segm.addr_lo
   567  		or	out.addr_num > segm.addr_hi			then
   568  			return decide_loop;
   569  		end if;
   570
   571
   572  	elsif	phase = address_phase					then
   573
   574  		if	addr.addr_type = read_type
   575  		and	addr.addr_pfx  = read_pfx
   576  		and	addr.addr_sfx  = read_sfx			then
   577  			return decide_loop;
   578
   579  		elsif	addr.addr_bldg >= '0'				then
   580  			if	this_bldg = ' '				then
   581  				this_bldg := addr.addr_bldg;
   582  			else
   583  				return decide_loop;
   584  			end if;
   585
   586  		elsif	addr.unit_num >= '0'				then
   587  			return decide_loop;
   588  		end if;
   589
   590  	end if;
   591
   592  	return 00;
   593
   594  end	Phase_Filter;
   595
   596  --	=================================================================
   597  --	<U1>
   598  	procedure	Find_Unique_Invalid	is
   599
   600  --	Look for unique and invalid street name qualifiers
   601  --	Example:	Street name "AUSTIN" has unique prefix, suffix, and type
   602  --	Example:	"DR" is an invalid street type for "Country Club"
   603  --	=================================================================
   604
   605  begin
   606
   607  	if	work.fetch_count = 01			then
   608  		match_type		:= 0;
   609  		match_prefix	:= 0;
   610  		match_suffix	:= 0;
   611
   612  		unique_type		:= read_type;
   613  		unique_prefix	:= read_pfx;
   614  		unique_suffix	:= read_sfx;
   615  	else
   616  		if	unique_type   <> read_type	then
   617  			unique_type	  := null;
   618  		end if;
   619  		if	unique_prefix <> read_pfx	then
   620  			unique_prefix := null;
   621  		end if;
   622  		if	unique_suffix <> read_sfx	then
   623  			unique_suffix := null;
   624  		end if;
   625  	end if;
   626
   627  	if	read_type = out.addr_type		then
   628  		match_type   := 1;
   629  	end if;
   630  	if	read_pfx  = out.addr_pfx		then
   631  		match_prefix := 1;
   632  	end if;
   633  	if	read_sfx  = out.addr_sfx		then
   634  		match_suffix := 1;
   635  	end if;
   636
   637  end	Find_Unique_Invalid;
   638
   639  --	==========================================================================
   640  --	<U2>
   641  	procedure	Apply_Unique_Invalid	is
   642
   643  --	Apply results of unique and invalid qualifier determinations (from above)
   644  --	This may result in adding, changing, or removing a qualifier
   645  --	==========================================================================
   646
   647  begin
   648
   649  	if	out.addr_pfx  > ' '
   650  	and	unique_prefix > ' '
   651  	and	unique_prefix <> out.addr_pfx
   652  --	and	prev_score		<= permit_change
   653  	and	work.rule_unq_pfx <= scrub_rule.change_unq		then
   654  		accept_prefix := 01;
   655  		out.addr_pfx := unique_prefix;
   656  		this_audit	 := this_audit||change_pfx;
   657
   658  	elsif	out.addr_pfx   > ' '
   659  	and	match_prefix   = 0
   660  --	and	prev_score		<= permit_remove
   661  	and	work.rule_unq_pfx <= scrub_rule.remove_unq		then
   662  		accept_prefix := 01;
   663  		out.addr_pfx := ' ';
   664  		this_audit	 := this_audit||remove_pfx;
   665  	end if;
   666
   667  	if	out.addr_pfx  = ' '
   668  	and	unique_prefix > ' '
   669  --	and	prev_score		<= permit_append
   670  	and	work.rule_unq_pfx <= scrub_rule.append_unq		then
   671  		accept_prefix := 01;
   672  		out.addr_pfx := unique_prefix;
   673  		this_audit	 := this_audit||append_pfx;
   674  	end if;
   675
   676
   677  	if	out.addr_type  > ' '
   678  	and	unique_type    > ' '
   679  	and	unique_type	   <> out.addr_type
   680  --	and	prev_score		 <= permit_change
   681  	and	work.rule_unq_type <= scrub_rule.change_unq		then
   682  		accept_type	  := 01;
   683  		out.addr_type := unique_type;
   684  		this_audit	  := this_audit||change_type;
   685
   686  	elsif	out.addr_type  > ' '
   687  	and	match_type 	   = 0
   688  --	and	prev_score		 <= permit_remove
   689  	and	work.rule_unq_type <= scrub_rule.remove_unq		then
   690  		accept_type	  := 01;
   691  		out.addr_type := ' ';
   692  		this_audit	  := this_audit||remove_type;
   693  	end if;
   694
   695  	if	out.addr_type  = ' '
   696  	and	unique_type    > ' '
   697  --	and	prev_score		 <= permit_append
   698  	and	work.rule_unq_type <= scrub_rule.append_unq		then
   699  		accept_type	  := 01;
   700  		out.addr_type := unique_type;
   701  		this_audit	  := this_audit||append_type;
   702  	end if;
   703
   704
   705  	if	out.addr_sfx  > ' '
   706  	and	unique_suffix > ' '
   707  	and	unique_suffix <> out.addr_sfx
   708  --	and	prev_score		<= permit_change
   709  	and	work.rule_unq_sfx <= scrub_rule.change_unq		then
   710  		accept_suffix := 01;
   711  		out.addr_sfx  := unique_suffix;
   712  		this_audit	  := this_audit||change_sfx;
   713
   714  	elsif	out.addr_sfx   > ' '
   715  	and	match_suffix   = 0
   716  --	and	prev_score		<= permit_remove
   717  	and	work.rule_unq_sfx <= scrub_rule.remove_unq		then
   718  		accept_suffix := 01;
   719  		out.addr_sfx  := ' ';
   720  		this_audit	  := this_audit||remove_sfx;
   721  	end if;
   722
   723  	if	out.addr_sfx  = ' '
   724  	and	unique_suffix > ' '
   725  --	and	prev_score		<= permit_append
   726  	and	work.rule_unq_sfx <= scrub_rule.append_unq		then
   727  		accept_suffix := 01;
   728  		out.addr_sfx  := unique_suffix;
   729  		this_audit	  := this_audit||append_sfx;
   730  	end if;
   731
   732  end	Apply_Unique_Invalid;
   733
   734  --	=============================================================================
   735  --	<Q>
   736  	procedure	Match_Qualifiers		is
   737
   738  --	Look for the closest matching street
   739  --	Use weighted match scores to determine closest match
   740  --	Consider which operations (append, change, remove) are permitted
   741  --	Consider match scores obtained from matching a previous GIS table,
   742  --	Example:	Should '217 S Fifth Cir' be "corrected" if the 200 block of Fifth Ci
   743  --	=============================================================================
   744
   745  begin
   746
   747  	this_weight := 0;
   748
   749  	if	out.addr_pfx   = read_pfx					then
   750  		accept_prefix	:= 01;
   751  		audit_prefix	:= null;
   752  		if	out.addr_pfx = ' '					then
   753  			this_weight := this_weight + blank_weight;
   754  		else
   755  			this_weight := this_weight + match_weight;
   756  		end if;
   757
   758  	elsif	out.addr_pfx  < '0'						then
   759  		if	work.rule_pfx <= scrub_rule.append				then
   760  --		and	prev_score	  <= permit_append			then
   761  			audit_prefix	:= append_pfx;
   762  			this_weight 	:= this_weight + append_weight;
   763  		else
   764  			this_weight		:= this_weight + forbid_weight;
   765  		end if;
   766
   767  	elsif	out.addr_pfx  > '0'
   768  	and	read_pfx	  < '0'						then
   769  		if	work.rule_pfx <= scrub_rule.remove				then
   770  --		and	prev_score	  <= permit_remove			then
   771  			audit_prefix	:= remove_pfx;
   772  			this_weight		:= this_weight + remove_weight;
   773  		else
   774  			this_weight		:= this_weight + forbid_weight;
   775  		end if;
   776
   777  	elsif	out.addr_pfx  > '0'
   778  	and	read_pfx	  > '0'						then
   779  		if	work.rule_pfx <= scrub_rule.change				then
   780  --		and	prev_score	  <= permit_change			then
   781  			audit_prefix	:= change_pfx;
   782  			this_weight		:= this_weight + change_weight;
   783  		else
   784  			this_weight		:= this_weight + forbid_weight;
   785  		end if;
   786  	end if;
   787
   788
   789  	if	out.addr_type   = read_type					then
   790  		accept_type		:= 01;
   791  		audit_type	  	:= null;
   792  		if	out.addr_type = ' '					then
   793  			this_weight := this_weight + blank_weight;
   794  		else
   795  			this_weight := this_weight + match_weight;
   796  		end if;
   797
   798  	elsif	out.addr_type  < '0'						then
   799  		if	work.rule_type <= scrub_rule.append				then
   800  --		and	prev_score	   <= permit_append			then
   801  			audit_type		:= append_type;
   802  			this_weight 	:= this_weight + append_weight;
   803  		else
   804  			this_weight		:= this_weight + forbid_weight;
   805  		end if;
   806
   807  	elsif	out.addr_type  > '0'
   808  	and	read_type	   < '0'						then
   809  		if	work.rule_type <= scrub_rule.remove				then
   810  --		and	prev_score	   <= permit_remove			then
   811  			audit_type		:= remove_type;
   812  			this_weight		:= this_weight + remove_weight;
   813  		else
   814  			this_weight		:= this_weight + forbid_weight;
   815  		end if;
   816
   817  	elsif	out.addr_type  > '0'
   818  	and	read_type	   > '0'						then
   819  		if	work.rule_type <= scrub_rule.change				then
   820  --		and	prev_score	   <= permit_change			then
   821  			audit_type		:= change_type;
   822  			this_weight		:= this_weight + change_weight;
   823  		else
   824  			this_weight		:= this_weight + forbid_weight;
   825  		end if;
   826  	end if;
   827
   828  	if	out.addr_sfx   = read_sfx					then
   829  		accept_suffix	:= 01;
   830  		audit_suffix	:= null;
   831  		if	out.addr_sfx = ' '					then
   832  			this_weight := this_weight + blank_weight;
   833  		else
   834  			this_weight := this_weight + match_weight;
   835  		end if;
   836
   837  	elsif	out.addr_sfx  < '0'						then
   838  		if	work.rule_sfx <= scrub_rule.append				then
   839  --		and	prev_score    <= permit_append			then
   840  			audit_suffix	:= append_sfx;
   841  			this_weight 	:= this_weight + append_weight;
   842  		else
   843  			this_weight		:= this_weight + forbid_weight;
   844  		end if;
   845
   846  	elsif	out.addr_sfx  > '0'
   847  	and	read_sfx	  < '0'						then
   848  		if	work.rule_sfx <= scrub_rule.remove				then
   849  --		and	prev_score	  <= permit_remove			then
   850  			audit_suffix	:= remove_sfx;
   851  			this_weight		:= this_weight + remove_weight;
   852  		else
   853  			this_weight		:= this_weight + forbid_weight;
   854  		end if;
   855
   856  	elsif	out.addr_sfx  > '0'
   857  	and	read_sfx	  > '0'						then
   858  		if	work.rule_sfx <= scrub_rule.change				then
   859  --		and	prev_score    <= permit_change			then
   860  			audit_suffix	:= change_sfx;
   861  			this_weight		:= this_weight + change_weight;
   862  		else
   863  			this_weight		:= this_weight + forbid_weight;
   864  		end if;
   865  	end if;
   866
   867  end	Match_Qualifiers;
   868
   869  --	==========================================================================
   870  --	<N>
   871  	function	Final_Name_Resolve	return number	is
   872
   873  --	If a street name is not resolved, consider other possible resolutions
   874  --	For example, try a fuzzy name match
   875  --	For example, see whether it is a non-address location
   876  --	==========================================================================
   877
   878  	compare_best		varchar2(2000);
   879  	compare_good		varchar2(2000);
   880  	count_best			number;
   881  	count_good			number;
   882
   883  begin
   884
   885  	if	retry = 0							then
   886  		if	length(best_name) in (2,3)			then
   887  			out.verify_code := scrub_rule.non_address;
   888  		end if;
   889  	end if;
   890
   891  	if	out.verify_code >= scrub_rule.non_address
   892  	or	alias_result	 = scrub_rule.mark_verify_only	then
   893  		retry			:= -1;
   894
   895  	elsif	name_count = 1 						then
   896  		retry			:= -2;
   897  		out.addr_name	:= best_name;
   898  		if	best_name_chg > ' '				then
   899  			out.do_name	:= best_name_chg;
   900  		end if;
   901
   902  	elsif	out.do_alias > '0'					then
   903  		retry			:= -3;
   904
   905  	end if;
   906
   907
   908  	if	retry = 0
   909  	and	scrub_rule.do_type_C >= scrub_rule.yes				then
   910  		total_fuzzy := total_fuzzy + 01;
   911
   912  		compare_best := adr_compress_name (best_name, spec_reduced);
   913  --		compare_best := best_name;
   914  --		ADR_compare_names (compare_best, compare_good, count_best, count_good);
   915  		Compare_Names (compare_best, compare_good, count_best, count_good);
   916
   917  --		if	count_best = 01
   918  		if	count_best <= scrub_rule.do_type_C
   919  		and	length(compare_best) = 20
   920  		and	(rtrim(out.addr_name, '0123456789') = out.addr_name)
   921  		  =	(rtrim(compare_best,  '0123456789') = compare_best)		then
   922
   923  			name_count		:= 01;
   924  			retry			:= 11;
   925  			out.do_name		:= 'C';
   926  			out.name_score	:= count_best;
   927  			out.addr_name	:= rtrim (compare_best);
   928  			reduced_name 	:= null;
   929  			compact_name 	:= null;
   930  			return		decide_exit;
   931  		end if;
   932  	end if;
   933
   934  	if	out.addr_num > '0'				then
   935  		null;
   936
   937  	elsif	retry = 0
   938  	and	scrub_rule.do_type_C >= scrub_rule.yes			then
   939
   940  --	test for duplex
   941  		if	out.addr_code1 = 'DPLX'			then
   942  			null;
   943  --	test for oversize name
   944  		elsif	length(out.addr_name) > 20
   945  --	test for initials
   946  		or	instr (out.addr_name, ' ') between 2 and 3
   947  --	test for 3 or more words
   948  		or	instr (out.addr_name, ' ', 1,2) > 0
   949  --	test for trailing unit number
   950  		or	rtrim(out.addr_name,'0123456789') <> out.addr_name
   951  														then
   952  			out.verify_code := scrub_rule.non_address;
   953
   954  --	test for persons initials
   955  --	test for location symbols
   956  		elsif	alias_result is null
   957  		and	out.verify_code is null					then
   958  			if	rtrim (out.addr_name) is null
   959  			or	instr (out.addr_name, ' ', 1,3) > 0
   960  			or	out.addr_name  <>
   961  				translate (out.addr_name, 'x'||signals, 'x')
   962  											then
   963  				out.verify_code := scrub_rule.non_address;
   964  			end if;
   965
   966  --	test for trailing numbers
   967  		elsif	ltrim (out.addr_num, '0123456789') is not null	then
   968  			out.verify_code := scrub_rule.non_address;
   969
   970  		end if;
   971
   972  		if	out.verify_code = scrub_rule.non_address			then
   973  			return	decide_insert;
   974  		end if;
   975
   976  	end if;
   977
   978  	return	00;
   979
   980  end	Final_Name_Resolve;
   981
   982  --	============================================================================
   983  --	<R>
   984  	procedure	Set_Phase_Results		is
   985  --	============================================================================
   986
   987  begin
   988
   989  	if	best_weight < 0						then
   990  		work.match_count := 0;
   991  	end if;
   992
   993  --	if best_weight exceeds prev_best by blank_weight alone, then multiple match_c
   994
   995  	this_weight := best_weight - prev_best;
   996
   997  	if	step  = scrub_rule.do_street
   998  	and	work.match_count = 01
   999  	and	prev_best > 0
  1000  	and	this_weight < match_weight
  1001  	and	mod(this_weight, blank_weight) = 0				then
  1002  		work.match_count := 02;
  1003
  1004  --	do not use best match if all qualifiers are blank
  1005
  1006  --	elsif	phase = street_phase
  1007  	elsif	step  = scrub_rule.do_street
  1008  	and	accept_initial	= 3
  1009  	and	work.fetch_count	> 1					then
  1010  		work.match_count := 02;
  1011
  1012  	elsif	work.match_count = 01					then
  1013  		out.addr_type	:= best_type;
  1014  		out.addr_pfx	:= best_pfx;
  1015  		out.addr_sfx	:= best_sfx;
  1016
  1017  		best_audit		:= translate (best_audit, ' ', ';');
  1018  		this_audit		:= this_audit||best_audit;
  1019
  1020  		if	phase = address_phase				then
  1021  			out.parcel_id	:= best_id;
  1022  			out.segment_id	:= best_mslink;
  1023  		elsif	phase = segment_phase				then
  1024  			null;
  1025  --			out.segment_id	:= best_id;
  1026  		end if;
  1027
  1028  	elsif	work.match_count > 01					then
  1029  		if	unique_type <> out.addr_type			then
  1030  			if	unique_type = ' '				then
  1031  				this_audit := this_audit || remove_type;
  1032  			elsif	out.addr_type > ' '			then
  1033  				this_audit := this_audit || change_type;
  1034  			else
  1035  				this_audit := this_audit || append_type;
  1036  			end if;
  1037
  1038  			out.addr_type	:= unique_type;
  1039  		end if;
  1040
  1041  		if	unique_prefix <> out.addr_pfx			then
  1042  			if	unique_prefix = ' '			then
  1043  				this_audit := this_audit || remove_pfx;
  1044  			elsif	out.addr_pfx > ' '			then
  1045  				this_audit := this_audit || change_pfx;
  1046  			else
  1047  				this_audit := this_audit || append_pfx;
  1048  			end if;
  1049
  1050  			out.addr_pfx	:= unique_prefix;
  1051  		end if;
  1052
  1053  		if	unique_suffix <> out.addr_sfx			then
  1054  			if	unique_suffix = ' '			then
  1055  				this_audit := this_audit || remove_sfx;
  1056  			elsif	out.addr_sfx > ' '			then
  1057  				this_audit := this_audit || change_sfx;
  1058  			else
  1059  				this_audit := this_audit || append_sfx;
  1060  			end if;
  1061
  1062  			out.addr_sfx	:= unique_suffix;
  1063  		end if;
  1064
  1065  	end if;
  1066
  1067  	out.do_qual		:= out.do_qual || translate (this_audit, '/', phase);
  1068  	work.match_score	:= best_score;
  1069
  1070  	if	step  = scrub_rule.do_street					then
  1071  		str.fetch_count	:= work.fetch_count;
  1072  		str.match_count	:= work.match_count;
  1073  		str.match_score	:= work.match_score;
  1074  		street_weight	:= best_weight;
  1075  	elsif	phase = address_phase					then
  1076  		adr.fetch_count	:= work.fetch_count;
  1077  		adr.match_count	:= work.match_count;
  1078  		adr.match_score	:= work.match_score;
  1079  		address_weight	:= best_weight;
  1080  	elsif	phase = block_phase					then
  1081  		blk.fetch_count	:= work.fetch_count;
  1082  		blk.match_count	:= work.match_count;
  1083  		blk.match_score	:= work.match_score;
  1084  		block_weight	:= best_weight;
  1085  	elsif	phase = segment_phase					then
  1086  		seg.fetch_count	:= work.fetch_count;
  1087  		seg.match_count	:= work.match_count;
  1088  		seg.match_score	:= work.match_score;
  1089  		segment_weight	:= best_weight;
  1090  	end if;
  1091
  1092  end	Set_Phase_Results;
  1093
  1094  --	============================================================================
  1095  --	<V>
  1096  	procedure	Set_Verify_Code		is
  1097
  1098  --	The 	 Code indicates -- Trace_what is right and -- Trace_what is wrong with an addr
  1099  --	See documentation for meaning of verification codes
  1100  --	============================================================================
  1101
  1102  	major			number;
  1103  	minor			number;
  1104  	match_count		number;
  1105
  1106  begin
  1107
  1108  	major := null;
  1109  	minor := 0;
  1110
  1111  	if	out.verify_code < scrub_rule.valid_name
  1112  	and	out.verify_code > scrub_rule.non_address		then
  1113  		major		:= out.verify_code;
  1114
  1115  	elsif	adr.fetch_count > 0				then
  1116  		major 		:= scrub_rule.address_match;
  1117  		if	adr.match_count = 1			then
  1118  			minor	:= scrub_rule.full_match;
  1119  		elsif	adr.match_count > 1			then
  1120  			minor	:= scrub_rule.partial_match;
  1121  		end if;
  1122  		final_weight	:= address_weight;
  1123
  1124  	elsif	seg.fetch_count > 0				then
  1125  		major 		:= scrub_rule.segment_match;
  1126  		if	seg.match_count = 1			then
  1127  			minor	:= scrub_rule.full_match;
  1128  		elsif	seg.match_count > 1			then
  1129  			minor	:= scrub_rule.partial_match;
  1130  		end if;
  1131  		final_weight	:= segment_weight;
  1132
  1133  	elsif	blk.fetch_count > 0				then
  1134  		major 		:= scrub_rule.block_match;
  1135  		if	blk.match_count = 1			then
  1136  			minor	:= scrub_rule.full_match;
  1137  		elsif	blk.match_count > 1			then
  1138
  1139
  1140  			minor	:= scrub_rule.partial_match;
  1141  		end if;
  1142  		final_weight	:= block_weight;
  1143
  1144  	elsif str.fetch_count > 0				then
  1145  		if	nvl (out.addr_num, '0') > '0'		then
  1146  			major 	:= scrub_rule.orphan_match;
  1147  		else
  1148
  1149  			major 	:= scrub_rule.street_match;
  1150  		end if;
  1151
  1152  		if	str.match_count = 1			then
  1153  			minor	:= scrub_rule.full_match;
  1154  		elsif	str.match_count > 1			then
  1155  			minor	:= scrub_rule.partial_match;
  1156  		end if;
  1157  		final_weight	:= street_weight;
  1158
  1159  	end if;
  1160
  1161  	if	major < scrub_rule.valid_name				then
  1162  		null;
  1163
  1164  	elsif	major is null					then
  1165  		if	name_count = 01				then
  1166  			major	:= scrub_rule.valid_name;
  1167  		elsif	out.addr_num > '0'			then
  1168  			major := scrub_rule.non_garland;
  1169  		else
  1170  			major	:= scrub_rule.non_address;
  1171  		end if;
  1172
  1173  	elsif	process_qualifier = 0				then
  1174
  1175  		null;
  1176  	elsif	minor  = 0						then
  1177  		minor	:= -1;
  1178  	end if;
  1179
  1180  --	-----------------------------------------------------------------------------
  1181
  1182  if	minor < 0						then
  1183
  1184  	accept_type		:= 0;
  1185  	accept_prefix	:= 0;
  1186  	accept_suffix	:= 0;
  1187  	best_weight		:= 0;
  1188  --	match_count		:= 0;
  1189
  1190  for	look in (select * from adrStreets where addr_name = out.addr_name)	loop
  1191
  1192  	if	out.addr_type = look.addr_type
  1193  	or	out.addr_type < '0'		then
  1194  		accept_type		:= 1;
  1195  		match_type		:= 1;
  1196  	else
  1197  		match_type		:= 0;
  1198  	end if;
  1199
  1200  	if	out.addr_pfx = look.addr_pfx
  1201  	or	out.addr_pfx < '0'		then
  1202  		accept_prefix	:= 1;
  1203  		match_prefix	:= 1;
  1204  	else
  1205  		match_prefix	:= 0;
  1206  	end if;
  1207
  1208  	if	out.addr_sfx = look.addr_sfx
  1209  	or	out.addr_sfx < '0'		then
  1210  		accept_suffix	:= 1;
  1211  		match_suffix	:= 1;
  1212  	else
  1213  		match_suffix	:= 0;
  1214  	end if;
  1215
  1216  	this_weight	:= match_type + match_prefix + match_suffix;
  1217
  1218  	if	this_weight  = 3				then
  1219  		best_weight := 3;
  1220  --		match_count	:= match_count + 01;
  1221  --	elsif	best_weight  < this_weight		then
  1222  --		best_weight := this_weight;
  1223  	end if;
  1224
  1225  end loop;
  1226
  1227  	this_weight := accept_type + accept_prefix + accept_suffix;
  1228
  1229  	if	this_weight < 3				then
  1230  		minor	:= scrub_rule.poor_match;
  1231
  1232  	elsif	best_weight < 3				then
  1233  		minor	:= scrub_rule.mixed_match;
  1234
  1235  --	elsif	major < scrub_rule.block_match
  1236  --	and	match_count > 1				then
  1237  --		minor	:= scrub_rule.partial_match;
  1238
  1239  	else
  1240  		minor	:= scrub_rule.wrong_match;
  1241  	end if;
  1242
  1243  end if;
  1244
  1245  --	-----------------------------------------------------------------------------
  1246
  1247  	verify_id	:= major + minor;
  1248  	if	verify_id >= nvl (out.verify_code, -1)			then
  1249  		out.verify_code	:= verify_id;
  1250  	end if;
  1251
  1252  end	Set_Verify_Code;
  1253
  1254  --	=================================================================
  1255  	function	Main_Driver
  1256  	(
  1257  		spec_insert		in		number	default 01,
  1258  		spec_seq		in		number	default 0
  1259  	)
  1260  		return number	is
  1261  --	=================================================================
  1262
  1263  begin
  1264
  1265  	if	spec_insert > 0			then
  1266  		do_insert	:= spec_insert;
  1267  	end if;
  1268  	if	spec_seq   > 0			then
  1269  		start_seq	:= spec_seq;
  1270  		stop_seq	:= spec_seq;
  1271  	end if;
  1272
  1273  --	========================================
  1274  --	<10>		Initialize Input
  1275
  1276  	if	out.verify_code < scrub_rule.valid_name
  1277  	and	scrub_rule.do_alien  * scrub_rule.do_parse * scrub_rule.do_name = 0	then
  1278  		return	decide_return;
  1279  	end if;
  1280
  1281  	parse_method	:= null;
  1282  	alias_method	:= null;
  1283  	alias_result	:= null;
  1284  	verify_id		:= null;
  1285  	retry			:= 0;
  1286  	loop_limit		:= max_phase_loops;
  1287
  1288  	out.alias_score	:= null;
  1289  	out.name_score	:= null;
  1290  	out.qual_score	:= null;
  1291
  1292  	out.appl_pfx		:= upper (nvl(rtrim(out.appl_pfx), ' '));
  1293  	out.appl_name		:= upper (nvl(rtrim(out.appl_name),' '));
  1294  	out.appl_type		:= upper (nvl(rtrim(out.appl_type),' '));
  1295  	out.appl_sfx		:= upper (nvl(rtrim(out.appl_sfx), ' '));
  1296  	out.appl_code1		:= upper (rtrim(out.appl_code1));
  1297  	out.appl_unit1		:= upper (rtrim(out.appl_unit1));
  1298  	out.appl_code2		:= upper (rtrim(out.appl_code2));
  1299  	out.appl_unit2		:= upper (rtrim(out.appl_unit2));
  1300
  1301  	if	scrub_rule.do_parse > 0					then
  1302  		out.form_name	:= null;
  1303  		out.addr_name	:= null;
  1304  		out.do_parse	:= '';
  1305  		out.do_alias	:= '';
  1306  		out.do_name		:= '';
  1307  		out.do_qual		:= '';
  1308  		out.verify_code 	:= null;
  1309
  1310  	elsif	scrub_rule.do_reset = scrub_rule.reset_to_parsed	then
  1311  		out.addr_name	:= null;
  1312  		out.do_alias	:= '';
  1313  		out.do_name		:= '';
  1314  		out.do_qual		:= '';
  1315  		out.verify_code 	:= null;
  1316
  1317  	elsif	scrub_rule.do_name  > 0					then
  1318  		out.do_name		:= '';
  1319  		out.do_qual		:= '';
  1320
  1321  	elsif	scrub_rule.do_street > 0				then
  1322  		out.do_qual		:= '';
  1323  	end if;
  1324
  1325  	if	out.verify_code < scrub_rule.valid_name		then
  1326  		out.do_name			:= '';
  1327  		out.do_qual			:= '';
  1328  --		if	out.verify_code = scrub_rule.non_address	then
  1329  --			out.form_name	:= '';
  1330  --		end if;
  1331  	end if;
  1332
  1333  --	---------
  1334
  1335  	if	out.addr_name > ' '			then
  1336  		read_num	:= out.addr_num;
  1337  		read_pfx	:= out.addr_pfx;
  1338  		read_name	:= out.addr_name;
  1339  		read_type	:= out.addr_type;
  1340  		read_sfx	:= out.addr_sfx;
  1341  		read_code1	:= out.addr_code1;
  1342  		read_unit1	:= out.addr_unit1;
  1343  		read_code2	:= out.addr_code2;
  1344  	 	read_unit2	:= out.addr_unit2;
  1345
  1346  	elsif	out.form_name > ' '			then
  1347  		read_num	:= out.addr_num;
  1348  		read_pfx	:= out.form_pfx;
  1349  		read_name	:= out.form_name;
  1350  		read_type	:= out.form_type;
  1351  		read_sfx	:= out.form_sfx;
  1352  		read_code1	:= out.form_code1;
  1353  		read_unit1	:= out.form_unit1;
  1354  		read_code2	:= out.form_code2;
  1355  	 	read_unit2	:= out.form_unit2;
  1356  		out.addr_name  := null;
  1357
  1358  	else
  1359  		read_num	:= out.appl_num;
  1360  		read_pfx	:= out.appl_pfx;
  1361  		read_name	:= out.appl_name;
  1362  		read_type	:= out.appl_type;
  1363  		read_sfx	:= out.appl_sfx;
  1364  		read_code1	:= out.appl_code1;
  1365  		read_unit1	:= out.appl_unit1;
  1366  		read_code2	:= out.appl_code2;
  1367  	 	read_unit2	:= out.appl_unit2;
  1368  		out.form_name  := null;
  1369  		out.addr_name  := null;
  1370  	end if;
  1371
  1372  	if	out.form_name is null			then
  1373  		out.form_pfx	:= null;
  1374  		out.form_type	:= null;
  1375  		out.form_sfx	:= null;
  1376  		out.form_code1	:= null;
  1377  		out.form_unit1	:= null;
  1378  		out.form_code2	:= null;
  1379  		out.form_unit2	:= null;
  1380  	end if;
  1381
  1382  	if	out.addr_name is null			then
  1383  		out.addr_num	:= null;
  1384  		out.addr_pfx	:= null;
  1385  		out.addr_type	:= null;
  1386  		out.addr_sfx	:= null;
  1387  		out.addr_code1	:= null;
  1388  		out.addr_unit1	:= null;
  1389  		out.addr_code2	:= null;
  1390  		out.addr_unit2	:= null;
  1391  	end if;
  1392
  1393  	read_pfx		:= upper (rtrim(read_pfx));
  1394  	read_name		:= upper (rtrim(read_name));
  1395  	read_type		:= upper (rtrim(read_type));
  1396  	read_sfx		:= upper (rtrim(read_sfx));
  1397  	read_code1		:= upper (rtrim(read_code1));
  1398  	read_unit1		:= upper (rtrim(read_unit1));
  1399  	read_code2		:= upper (rtrim(read_code2));
  1400  	read_unit2		:= upper (rtrim(read_unit2));
  1401
  1402  --	========================================
  1403  --	<20>		Unparsed User Exit
  1404
  1405  	if	scrub_rule.do_unparsed_exit >= scrub_rule.yes	then
  1406
  1407  		garland.SCRUB_ADDRESS_UNPARSED
  1408  		(read_num,	 read_pfx,	 read_name,	 read_type,	read_sfx,
  1409  		 read_code1, read_unit1, read_code2, read_unit2,
  1410  		 parse_method, verify_id		);
  1411
  1412  		if	parse_method > '!'		then
  1413  			out.do_parse := parse_method;
  1414  		end if;
  1415
  1416  		if	verify_id < scrub_rule.valid_name	then
  1417  			goto	initialize_output;
  1418  		end if;
  1419
  1420  		if	parse_method > ' '		then
  1421  			goto	match_alias;
  1422  		end if;
  1423
  1424  	end if;
  1425
  1426  --	========================================
  1427  --	<30>		Match Unparsed Alias (Alien)
  1428
  1429  	if	scrub_rule.do_alien >= scrub_rule.yes			then
  1430  		alias_method := 'alien';
  1431
  1432  --	------------------------------------------------
  1433  		Match_Alias_Street;
  1434  --	------------------------------------------------
  1435
  1436  		if	verify_id < scrub_rule.valid_name		then
  1437  			goto	initialize_output;
  1438  		elsif	alias_result > ' '			then
  1439  			goto	match_alias;
  1440  		end if;
  1441  	end if;
  1442
  1443  --	========================================
  1444  --	<40>		Parse Address
  1445
  1446  	if	scrub_rule.do_parse > 0			then
  1447
  1448  		parse_method := scrub_rule.parse_options;
  1449
  1450  		TST_parse_address
  1451  --		ADR_parse_address
  1452  	(	read_num,   read_pfx,   read_name,	read_type,  read_sfx,
  1453  		read_code1, read_unit1, read_code2,	read_unit2,
  1454  		parse_method	);
  1455
  1456  		out.do_parse := parse_method;
  1457
  1458  		if	parse_method like like_parse_error		then
  1459  			verify_id	:= scrub_rule.non_address;
  1460  --			goto	initialize_output;
  1461
  1462  		elsif	scrub_rule.do_parse = scrub_rule.safe_parse
  1463  		and	substr(parse_method, 05) > '.........'	then
  1464  			verify_id	:= scrub_rule.non_address;
  1465  			goto	initialize_output;
  1466
  1467  		else
  1468  			out.form_pfx	:= nvl(rtrim(read_pfx ),  ' ');
  1469  			out.form_name	:= nvl(rtrim(read_name),  ' ');
  1470  			out.form_type	:= nvl(rtrim(read_type),  ' ');
  1471  			out.form_sfx	:= nvl(rtrim(read_sfx ),  ' ');
  1472  			out.form_code1	:= nvl(rtrim(read_code1), ' ');
  1473  			out.form_unit1	:= nvl(rtrim(read_unit1), ' ');
  1474  			out.form_code2	:= nvl(rtrim(read_code2), ' ');
  1475  			out.form_unit2	:= nvl(rtrim(read_unit2), ' ');
  1476  		end if;
  1477
  1478  	end if;
  1479
  1480  	if	parse_method like like_parse_error		then
  1481  		verify_id	:= scrub_rule.non_address;
  1482
  1483  --	else
  1484  --			out.form_pfx	:= nvl(rtrim(read_pfx ),  ' ');
  1485  --			out.form_name	:= nvl(rtrim(read_name),  ' ');
  1486  --			out.form_type	:= nvl(rtrim(read_type),  ' ');
  1487  --			out.form_sfx	:= nvl(rtrim(read_sfx ),  ' ');
  1488  --			out.form_code1	:= nvl(rtrim(read_code1), ' ');
  1489  --			out.form_unit1	:= nvl(rtrim(read_unit1), ' ');
  1490  --			out.form_code2	:= nvl(rtrim(read_code2), ' ');
  1491  --			out.form_unit2	:= nvl(rtrim(read_unit2), ' ');
  1492  	end if;
  1493
  1494
  1495  --	========================================
  1496  --	<50>		Parsed User Exit
  1497
  1498  	if	scrub_rule.do_parsed_exit >= scrub_rule.yes	then
  1499
  1500  		garland.SCRUB_ADDRESS_PARSED
  1501  		(read_num,	read_pfx,	read_name,	read_type,	read_sfx,
  1502  		 read_code1,read_unit1, read_code2, read_unit2,
  1503  		 parse_method, test_count1	);
  1504  --		 parse_method, verify_id	);
  1505
  1506  		if	parse_method > '!'		then
  1507  --			out.do_parse := out.do_parse ||' '|| parse_method;
  1508  			out.do_parse := parse_method;
  1509  		end if;
  1510
  1511  --		if	verify_id < scrub_rule.valid_name	then
  1512  --			goto	initialize_output;
  1513  --		end if;
  1514
  1515  	end if;
  1516
  1517  --	========================================
  1518  --	<60>
  1519  <<match_alias>>
  1520
  1521  	if	scrub_rule.do_alias >= scrub_rule.yes	then
  1522  		alias_method := 'alias';
  1523  --	------------------------------------------------
  1524  		Match_Alias_Street;
  1525  --	------------------------------------------------
  1526  	end if;
  1527
  1528  --	========================================
  1529  --	<70>
  1530  <<initialize_output>>
  1531
  1532  	out.addr_num	:= read_num;
  1533  	out.addr_name	:= read_name;
  1534  	out.addr_type	:= read_type;
  1535  	out.addr_pfx	:= read_pfx;
  1536  	out.addr_sfx	:= read_sfx;
  1537  	out.addr_code1	:= read_code1;
  1538  	out.addr_unit1	:= read_unit1;
  1539  	out.addr_code2	:= read_code2;
  1540  	out.addr_unit2	:= read_unit2;
  1541
  1542  	out.parcel_id	:= null;
  1543  	out.segment_id	:= null;
  1544
  1545  --	if	verify_id is not null				then
  1546  		out.verify_code := verify_id;
  1547  --	end if;
  1548
  1549  --	========================================
  1550  --	<80>
  1551
  1552  	if	out.verify_code	  < scrub_rule.valid_name
  1553  	or	lower(alias_method) = 'part'
  1554  	or	scrub_rule.do_name + process_qualifier = 0	then
  1555  		return	decide_insert;
  1556  	end if;
  1557
  1558  --	========================================
  1559  --	<100>
  1560  <<process_phase>>
  1561
  1562  	phase			:= null;
  1563  	street_count	:= 00;
  1564  	name_count		:= 00;
  1565
  1566  	if	out.verify_code >= scrub_rule.valid_name	then
  1567  		name_count	:= 01;
  1568  	else
  1569  		name_count	:= 00;
  1570  	end if;
  1571
  1572  	str.fetch_count	:= 0;
  1573  	str.match_count	:= 0;
  1574  	str.match_score	:= 0;
  1575  	blk.fetch_count	:= 0;
  1576  	blk.match_count	:= 0;
  1577  	blk.match_score	:= 0;
  1578  	seg.fetch_count	:= 0;
  1579  	seg.match_count	:= 0;
  1580  	seg.match_score	:= 0;
  1581  	adr.fetch_count	:= 0;
  1582  	adr.match_count	:= 0;
  1583  	adr.match_score	:= 0;
  1584
  1585  	this_type		:= out.addr_type;
  1586  	this_pfx		:= out.addr_pfx;
  1587  	this_sfx		:= out.addr_sfx;
  1588
  1589  	this_audit 		:= null;
  1590
  1591  	if	alias_result like like_verify_only	then
  1592  		append_weight	:= forbid_weight;
  1593  		remove_weight	:= forbid_weight;
  1594  		change_weight	:= forbid_weight;
  1595  	else
  1596  		append_weight	:= scrub_rule.append;
  1597  		remove_weight	:= scrub_rule.remove;
  1598  		change_weight	:= scrub_rule.change;
  1599  	end if;
  1600
  1601  --	========================================
  1602  --	<110>
  1603  <<phase_loop>>
  1604
  1605  for steps in 1..5						loop
  1606
  1607  	step	:= steps;
  1608
  1609  	if	step in (scrub_rule.do_name, scrub_rule.do_street)	then
  1610  		phase				:= street_phase;
  1611  		work.rule_unq_type	:= scrub_rule.str_unq_type;
  1612  		work.rule_unq_pfx		:= scrub_rule.str_unq_pfx;
  1613  		work.rule_unq_sfx		:= scrub_rule.str_unq_sfx;
  1614  		work.rule_type		:= scrub_rule.str_type;
  1615  		work.rule_pfx		:= scrub_rule.str_pfx;
  1616  		work.rule_sfx		:= scrub_rule.str_sfx;
  1617
  1618  	elsif	step = scrub_rule.do_block				then
  1619  		phase			:= block_phase;
  1620  		work.rule_type	:= scrub_rule.blk_type;
  1621  		work.rule_pfx	:= scrub_rule.blk_pfx;
  1622  		work.rule_sfx	:= scrub_rule.blk_sfx;
  1623
  1624  	elsif	step = scrub_rule.do_range				then
  1625  		phase			:= segment_phase;
  1626  		work.rule_type	:= scrub_rule.rng_type;
  1627  		work.rule_pfx	:= scrub_rule.rng_pfx;
  1628  		work.rule_sfx	:= scrub_rule.rng_sfx;
  1629
  1630  	elsif	step = scrub_rule.do_address				then
  1631  		phase			:= address_phase;
  1632  		work.rule_type	:= scrub_rule.adr_type;
  1633  		work.rule_pfx	:= scrub_rule.adr_pfx;
  1634  		work.rule_sfx	:= scrub_rule.adr_sfx;
  1635  	else
  1636  		goto	end_phase_loop;
  1637  	end if;
  1638
  1639  	if	alias_result = scrub_rule.mark_verify_only	then
  1640  		work.rule_type	:= forbid_weight;
  1641  		work.rule_pfx	:= forbid_weight;
  1642  		work.rule_sfx	:= forbid_weight;
  1643  	end if;
  1644
  1645  	if	nvl (out.addr_num, '0') = '0'
  1646  	and	phase <> street_phase					then
  1647  		exit;
  1648  	end if;
  1649
  1650
  1651  /*
  1652  	if	phase = address_phase					then
  1653  		prev_score		:= scrub_rule.permit_adr_basis;
  1654  		permit_append	:= scrub_rule.permit_adr_append;
  1655  		permit_remove	:= scrub_rule.permit_adr_remove;
  1656  		permit_change	:= scrub_rule.permit_adr_change;
  1657     	elsif	phase = segment_phase					then
  1658  		prev_score		:= scrub_rule.permit_rng_basis;
  1659  		permit_append	:= scrub_rule.permit_rng_append;
  1660  		permit_remove	:= scrub_rule.permit_rng_remove;
  1661  		permit_change	:= scrub_rule.permit_rng_change;
  1662     	elsif	phase = block_phase					then
  1663  		prev_score		:= scrub_rule.permit_blk_basis;
  1664  		permit_append	:= scrub_rule.permit_blk_append;
  1665  		permit_remove	:= scrub_rule.permit_blk_remove;
  1666  		permit_change	:= scrub_rule.permit_blk_change;
  1667     	elsif	phase = street_phase					then
  1668  		prev_score		:= 0;
  1669  		permit_append	:= scrub_rule.permit;
  1670  		permit_remove	:= scrub_rule.permit;
  1671  		permit_change	:= scrub_rule.permit;
  1672  	end if;
  1673     	if	prev_score	= scrub_rule.do_street		then
  1674  		prev_score := str.match_score;
  1675  	elsif	prev_score	= scrub_rule.do_block		then
  1676  		prev_score := blk.match_score;
  1677  	elsif	prev_score	= scrub_rule.do_range		then
  1678  		prev_score := seg.match_score;
  1679  	elsif	prev_score	= scrub_rule.do_address		then
  1680  		prev_score := adr.match_score;
  1681  	else
  1682  		prev_score	:= scrub_rule.permit;
  1683  	end if;
  1684  */
  1685
  1686
  1687  --	------------------------------------------------
  1688  --	<120>
  1689  		PHASE_INITIALIZE;
  1690  --	------------------------------------------------
  1691
  1692  --	========================================
  1693  --	<130>
  1694
  1695  	if	step		= scrub_rule.do_street
  1696  	and	step - 1	= scrub_rule.do_name
  1697  	and	0		< scrub_rule.do_name 		then
  1698  		goto	alter_street_qualifiers;
  1699  	end if;
  1700
  1701  --	========================================
  1702  --	<200>		Fetch GIS Records
  1703
  1704  	this_audit		:= null;
  1705  	read_type		:= null;
  1706  	read_pfx		:= null;
  1707  	read_sfx		:= null;
  1708  	this_weight		:= 0;
  1709  	best_score		:= 0;
  1710
  1711  	work.fetch_count	:= 0;
  1712  	work.match_count	:= 0;
  1713  	work.match_score	:= 0;
  1714
  1715  	if	phase = street_phase		then
  1716  		open	read_street;
  1717  	elsif	phase = block_phase		then
  1718  		open	read_block;
  1719  	elsif	phase = segment_phase		then
  1720  		open	read_segment;
  1721  	elsif	phase = address_phase		then
  1722  		open	read_address;
  1723  	end if;
  1724
  1725  --	========================================
  1726  --	<210>
  1727  loop
  1728
  1729  	if	phase = street_phase				then
  1730  		fetch	read_street					into strt;
  1731  		exit when	read_street%notfound
  1732  			or 	read_street%notfound is null;
  1733  	elsif	phase = address_phase				then
  1734  		fetch	read_address				into addr;
  1735  		exit when	read_address%notfound
  1736  			or 	read_address%notfound is null;
  1737  	elsif	phase = block_phase				then
  1738  		fetch	read_block					into blok;
  1739  		exit when	read_block%notfound
  1740  			or 	read_block%notfound is null;
  1741  	elsif	phase = segment_phase				then
  1742  		fetch	read_segment				into segm;
  1743  		exit when	read_segment%notfound
  1744  			or 	read_segment%notfound is null;
  1745  	end if;
  1746
  1747  --	------------------------------------------------
  1748  --	<220>
  1749  	decision := PHASE_FILTER;
  1750  --	------------------------------------------------
  1751
  1752  	if	decision = decide_loop			then
  1753  		goto	end_fetch_loop;
  1754  	end if;
  1755
  1756  --	========================================
  1757  --	<230>		Get Fetch
  1758
  1759  	if	work.fetch_count > 0			then
  1760  		qualifier (work.fetch_count).addr_type	:= read_type;
  1761  		qualifier (work.fetch_count).addr_pfx	:= read_pfx;
  1762  		qualifier (work.fetch_count).addr_sfx	:= read_sfx;
  1763  		qualifier (work.fetch_count).record_id	:= read_id;
  1764  		qualifier (work.fetch_count).mslink		:= read_mslink;
  1765
  1766  	end if;
  1767
  1768  	work.fetch_count := work.fetch_count + 01;
  1769  	recd := work.fetch_count;
  1770
  1771  	if	phase = street_phase			then
  1772  		read_type	:= strt.addr_type;
  1773  		read_pfx	:= strt.addr_pfx;
  1774  		read_sfx	:= strt.addr_sfx;
  1775  	elsif	phase = block_phase			then
  1776  		read_type	:= blok.addr_type;
  1777  		read_pfx	:= blok.addr_pfx;
  1778  		read_sfx	:= blok.addr_sfx;
  1779  	elsif	phase = segment_phase			then
  1780  		read_type	:= segm.addr_type;
  1781  		read_pfx	:= segm.addr_pfx;
  1782  		read_sfx	:= segm.addr_sfx;
  1783  		read_id	:= segm.mslink;
  1784  --		read_id	:= segm.segment_id;
  1785  	elsif	phase = address_phase			then
  1786  		read_type	:= addr.addr_type;
  1787  		read_pfx	:= addr.addr_pfx;
  1788  		read_sfx	:= addr.addr_sfx;
  1789  		read_id	:= addr.parcel_id;
  1790  		read_mslink	:= addr.mslink;
  1791
  1792  	end if;
  1793
  1794  --	========================================
  1795  --	<240>
  1796
  1797  	if	phase = street_phase			then
  1798  --	------------------------------------------------
  1799  		FIND_UNIQUE_INVALID;
  1800  --	------------------------------------------------
  1801  	end if;
  1802
  1803  	if	best_score  <  scrub_rule.full_match
  1804  	and	this_type	= read_type
  1805  	and	this_pfx	= read_pfx
  1806  	and	this_sfx	= read_sfx			then
  1807  		best_score	:= scrub_rule.full_match;
  1808
  1809  	elsif	best_score  <  scrub_rule.part_match
  1810  	and	this_type	in (' ', read_type)
  1811  	and	this_pfx	in (' ', read_pfx)
  1812  	and	this_sfx	in (' ', read_sfx)	then
  1813  		best_score	:= scrub_rule.part_match;
  1814
  1815  	elsif	best_score  <  scrub_rule.base_match	then
  1816  		best_score	:= scrub_rule.base_match;
  1817  	end if;
  1818
  1819  <<end_fetch_loop>>
  1820  	null;
  1821
  1822  end loop;
  1823
  1824  --	========================================
  1825  --	<250>
  1826
  1827  	if	phase = street_phase		then
  1828  		close	read_street;
  1829  	elsif	phase = address_phase		then
  1830  		close	read_address;
  1831  	elsif	phase = block_phase		then
  1832  		close	read_block;
  1833  	elsif	phase = segment_phase		then
  1834  		close	read_segment;
  1835  	end if;
  1836
  1837  --	========================================
  1838  --	<300>
  1839  	<<alter_street_qualifiers>>
  1840
  1841  	if	step  = scrub_rule.do_name
  1842  	or	work.fetch_count  = 0		then
  1843  		goto	reconsider;
  1844  	end if;
  1845
  1846  --	========================================
  1847  --	<310>
  1848
  1849  	if	step	= scrub_rule.do_street	then
  1850  --	------------------------------------------------
  1851  		APPLY_UNIQUE_INVALID;
  1852  --	------------------------------------------------
  1853  	end if;
  1854
  1855  --	========================================
  1856  --	<400>		Match Against GIS table
  1857
  1858  	best_weight	:= - 999999;
  1859  	prev_best	:= 0;
  1860
  1861  for	q in reverse 01..work.fetch_count 			loop
  1862
  1863  	recd := q;
  1864
  1865  	if	q < work.fetch_count				then
  1866  		read_type	:= qualifier (q).addr_type;
  1867  		read_pfx	:= qualifier (q).addr_pfx;
  1868  		read_sfx	:= qualifier (q).addr_sfx;
  1869  		read_id	:= qualifier (q).record_id;
  1870  		read_mslink	:= qualifier (q).mslink;
  1871  	end if;
  1872
  1873  --	------------------------------------
  1874  --	<410>
  1875  		MATCH_QUALIFIERS;
  1876  --	------------------------------------
  1877
  1878  	if	best_weight < this_weight
  1879  	and	scrub_rule.accept_weight < this_weight		then
  1880  		prev_best		:= best_weight;
  1881  		best_weight		:= this_weight;
  1882  		best_type		:= read_type;
  1883  		best_pfx		:= read_pfx;
  1884  		best_sfx		:= read_sfx;
  1885  		best_id		:= read_id;
  1886  		best_mslink		:= read_mslink;
  1887  		best_audit		:= audit_prefix||audit_type||audit_suffix;
  1888  		work.match_count	:= 0;
  1889  		out.qual_score	:= best_weight;
  1890  	end if;
  1891
  1892  	if	this_weight = best_weight			then
  1893  		work.match_count := work.match_count + 01;
  1894
  1895  		if	work.match_count = 01			then
  1896  			unique_type		:= read_type;
  1897  			unique_prefix	:= read_pfx;
  1898  			unique_suffix	:= read_sfx;
  1899  		else
  1900  			if	unique_type <> read_type	then
  1901  				unique_type	:= null;
  1902  			end if;
  1903
  1904  			if	unique_prefix <> read_pfx	then
  1905  				unique_prefix := null;
  1906  			end if;
  1907
  1908  			if	unique_suffix <> read_sfx	then
  1909  				unique_suffix := null;
  1910  			end if;
  1911  		end if;
  1912
  1913  	end if;
  1914
  1915  <<end_match_loop>>
  1916  	null;
  1917  end loop;
  1918
  1919
  1920  --	========================================
  1921  --	<500>
  1922  <<reconsider>>
  1923
  1924  	if	alias_result > '0'			then
  1925  		retry	:= -3;
  1926  	end if;
  1927
  1928  	if	step = scrub_rule.do_street			then
  1929  		accept_count := accept_prefix + accept_type + accept_suffix;
  1930
  1931  	elsif	step = scrub_rule.do_name			then
  1932  --	------------------------------------------------
  1933  --	<510>
  1934  		decision := FINAL_NAME_RESOLVE;
  1935  --	------------------------------------------------
  1936
  1937  		if	decision = decide_exit		then
  1938  			exit;
  1939  		elsif	decision = decide_insert	then
  1940  			return	decide_insert;
  1941  		end if;
  1942  	end if;
  1943
  1944  --	------------------------------------------------
  1945  --	<510>
  1946  		Set_Phase_Results;
  1947  --	------------------------------------------------
  1948
  1949  <<end_phase_loop>>
  1950
  1951  --	========================================
  1952  --	<600>
  1953
  1954  	if	phase = street_phase
  1955  	and	name_count <> 01				then
  1956  		exit;
  1957
  1958  	elsif	step <> scrub_rule.do_name
  1959  	and	out.addr_name < '0'			then
  1960  --	and	out.addr_name = '0'			then
  1961  		exit;
  1962  	end if;
  1963
  1964  end loop;
  1965
  1966  --	========================================
  1967  --	<610>
  1968
  1969  	if	retry  = 11						then
  1970  		retry := 12;
  1971  		if	scrub_rule.do_alias = scrub_rule.alias_fuzzy		then
  1972  			read_num	:= out.addr_num;
  1973  			read_pfx	:= out.addr_pfx;
  1974  			read_name	:= out.addr_name;
  1975  			read_type	:= out.addr_type;
  1976  			read_sfx	:= out.addr_sfx;
  1977  			read_code1	:= out.addr_code1;
  1978  			read_unit1	:= out.addr_unit1;
  1979  			read_code2	:= out.addr_code2;
  1980  			read_unit2	:= out.addr_unit2;
  1981  			alias_result	:= null;
  1982  			goto	match_alias;
  1983  		else
  1984  			goto	process_phase;
  1985  		end if;
  1986  	end if;
  1987
  1988  --	------------------------------------------------
  1989  --	<620>
  1990  		SET_VERIFY_CODE;
  1991  --	------------------------------------------------
  1992
  1993  	if	out.verify_code = scrub_rule.non_address			then
  1994  		out.addr_num	:= out.appl_num;
  1995  		out.addr_pfx	:= out.appl_pfx;
  1996  		out.addr_name	:= out.appl_name;
  1997  		out.addr_type	:= out.appl_type;
  1998  		out.addr_sfx	:= out.appl_sfx;
  1999  		out.addr_code1	:= out.appl_code1;
  2000  		out.addr_unit1	:= out.appl_unit1;
  2001  		out.addr_code2	:= out.appl_code2;
  2002  		out.addr_unit2	:= out.appl_unit2;
  2003  		out.form_pfx	:= null;
  2004  		out.form_name	:= null;
  2005  		out.form_type	:= null;
  2006  		out.form_sfx	:= null;
  2007  		out.form_code1	:= null;
  2008  		out.form_unit1	:= null;
  2009  		out.form_code2	:= null;
  2010  		out.form_unit2	:= null;
  2011  	end if;
  2012
  2013  	return	00;
  2014
  2015  end	Main_Driver;
  2016
  2017
  2018  --	=================================================================
  2019  	procedure	Batch_Driver
  2020  (
  2021  	spec_insert	in		number	default 01,
  2022  	spec_seq	in		number	default 0
  2023  )
  2024  	is
  2025  --	=================================================================
  2026
  2027  	read_rowid			number := 0;
  2028  	read_app			number := 0;
  2029
  2030  	param_insert		number;
  2031  	param_seq			number;
  2032
  2033  begin
  2034
  2035  	param_insert	:= spec_insert;
  2036  	param_seq		:= spec_seq;
  2037
  2038  	select count(*)
  2039  	into	total_record
  2040  	from  garland.scrub_result.;
  2041
  2042  	street_name		:= ' ';
  2043  	total_read		:= 0;
  2044  	total_input		:= 0;
  2045  	total_output	:= 0;
  2046  	total_record	:= 0;
  2047  	total_fuzzy		:= 0;
  2048  	commit_count	:= 0;
  2049
  2050  loop
  2051
  2052  	read_rowid := 1;
  2053  	open	read_rowid_table;
  2054  	fetch	read_rowid_table		into row;
  2055  	exit when	read_rowid_table%notfound
  2056  		or 	read_rowid_table%notfound is null
  2057  		or	row.row_seq > stop_seq;
  2058  	close	read_rowid_table;
  2059  	read_rowid := 0;
  2060
  2061  	read_app := 1;
  2062  	open	read_app_table;
  2063  	fetch	read_app_table		into appl;
  2064  	exit when	read_app_table%notfound
  2065  		or 	read_app_table%notfound is null;
  2066  	close	read_app_table;
  2067  	read_app := 0;
  2068
  2069  	prev_seq	:= row.row_seq;
  2070  	total_read	:= total_read + 01;
  2071
  2072  	if	choose_name > '0'		then
  2073  		if	appl.addr_name like '%'|| choose_name ||'%'	then
  2074  			null;
  2075  		else
  2076  			goto	end_record_loop;
  2077  		end if;
  2078  	end if;
  2079
  2080  	if	total_input < stop_count					then
  2081  		total_input	:= total_input + 01;
  2082  	else
  2083  		dbms_output.put_line ('ERROR - Input Record Limit Exceeded');
  2084  		exit;
  2085  	end if;
  2086
  2087  	out.appl_num	:= appl.appl_num;
  2088  	out.appl_name	:= appl.appl_name;
  2089  	out.appl_type	:= appl.appl_type;
  2090  	out.appl_pfx	:= appl.appl_pfx ;
  2091  	out.appl_sfx	:= appl.appl_sfx ;
  2092  	out.appl_code1	:= appl.appl_code1;
  2093  	out.appl_unit1	:= appl.appl_unit1;
  2094  	out.appl_code2	:= appl.appl_code2;
  2095   	out.appl_unit2	:= appl.appl_unit2;
  2096
  2097  	out.form_name	:= appl.form_name;
  2098  	out.form_type	:= appl.form_type;
  2099  	out.form_pfx	:= appl.form_pfx ;
  2100  	out.form_sfx	:= appl.form_sfx ;
  2101  	out.form_code1	:= appl.form_code1;
  2102  	out.form_unit1	:= appl.form_unit1;
  2103  	out.form_code2	:= appl.form_code2;
  2104   	out.form_unit2	:= appl.form_unit2;
  2105
  2106  	out.addr_num	:= appl.addr_num;
  2107  	out.addr_name	:= appl.addr_name;
  2108  	out.addr_type	:= appl.addr_type;
  2109  	out.addr_pfx	:= appl.addr_pfx ;
  2110  	out.addr_sfx	:= appl.addr_sfx ;
  2111  	out.addr_code1	:= appl.addr_code1;
  2112  	out.addr_unit1	:= appl.addr_unit1;
  2113  	out.addr_code2	:= appl.addr_code2;
  2114   	out.addr_unit2	:= appl.addr_unit2;
  2115
  2116  	out.verify_code	:= appl.verify_code;
  2117  	out.do_parse	:= appl.do_parse;
  2118  	out.do_alias	:= appl.do_alias;
  2119  	out.do_name		:= appl.do_name;
  2120  	out.do_qual		:= appl.do_qual;
  2121
  2122  	out.rec_rowid	:= appl.rec_rowid;
  2123  --	out.rec_rowid	:= row.row_id;
  2124
  2125  	out.rec_seq		:= row.row_seq;
  2126  	out.rec_key		:= rtrim(rpad(appl.rec_key, max_key_length));
  2127
  2128  	out.parcel_id	:= appl.parcel_id;
  2129  	out.segment_id	:= appl.segment_id;
  2130
  2131  --	========================================
  2132
  2133  --	decision := MAIN_DRIVER (spec_insert, spec_seq);
  2134  --	decision := MAIN_DRIVER (param_insert, param_seq);
  2135  	decision := MAIN_DRIVER;
  2136
  2137  	if	decision = decide_loop		then
  2138  		goto	end_record_loop;
  2139  	end if;
  2140
  2141  --	========================================
  2142  <<insert_result>>
  2143
  2144  	out.do_parse	:= nvl(out.do_parse, ' ');
  2145  	out.do_alias	:= nvl(out.do_alias, ' ');
  2146  	out.do_name		:= nvl(out.do_name,  ' ');
  2147  	out.do_qual		:= nvl(out.do_qual,  ' ');
  2148
  2149  	if	scrub_rule.keep_unparsed = scrub_rule.no			then
  2150  		out.appl_name	:= null;
  2151  		out.appl_type	:= null;
  2152  		out.appl_pfx	:= null;
  2153  		out.appl_sfx	:= null;
  2154  		out.appl_code1	:= null;
  2155  		out.appl_unit1	:= null;
  2156  		out.appl_code2	:= null;
  2157  		out.appl_unit2	:= null;
  2158  		out.appl_num	:= null;
  2159  	end if;
  2160
  2161  	if	scrub_rule.keep_parsed = scrub_rule.no			then
  2162  		out.form_name	:= null;
  2163  		out.form_type	:= null;
  2164  		out.form_pfx	:= null;
  2165  		out.form_sfx	:= null;
  2166  		out.form_code1	:= null;
  2167  		out.form_unit1	:= null;
  2168  		out.form_code2	:= null;
  2169  		out.form_unit2	:= null;
  2170  	end if;
  2171
  2172  	if	scrub_rule.keep_unparsed = scrub_rule.yes
  2173  	and	out.verify_code = scrub_rule.non_address		then
  2174  		out.addr_name	:= out.appl_name;
  2175  		out.addr_type	:= out.appl_type;
  2176  		out.addr_pfx	:= out.appl_pfx;
  2177  		out.addr_sfx	:= out.appl_sfx;
  2178  		out.addr_code1	:= out.appl_code1;
  2179  		out.addr_unit1	:= out.appl_unit1;
  2180  		out.addr_code2	:= out.appl_code2;
  2181  		out.addr_unit2	:= out.appl_unit2;
  2182  --		out.do_alias	:= null;
  2183  	end if;
  2184
  2185  	if	do_insert > 0					then
  2186
  2187  		insert into	garland.SCRUB_RESULT
  2188  		select
  2189
  2190  			out.addr_num,
  2191  			out.addr_pfx,
  2192  			out.addr_name,
  2193  			out.addr_type,
  2194  			out.addr_sfx,
  2195  			out.addr_code1,
  2196  			out.addr_unit1,
  2197  			out.addr_code2,
  2198  			out.addr_unit2,
  2199
  2200  			out.verify_code,
  2201  			out.do_parse,
  2202  			out.do_alias,
  2203  			out.do_name,
  2204  			out.do_qual,
  2205
  2206  			row.row_seq,
  2207  --			row.row_id,
  2208  			out.rec_rowid,
  2209  			out.rec_key,
  2210
  2211  			out.parcel_id,
  2212  			out.segment_id,
  2213
  2214  			out.form_pfx,
  2215  			out.form_name,
  2216  			out.form_type,
  2217  			out.form_sfx,
  2218  			out.form_code1,
  2219  			out.form_unit1,
  2220  			out.form_code2,
  2221  			out.form_unit2,
  2222
  2223  			out.appl_pfx,
  2224  			out.appl_name,
  2225  			out.appl_type,
  2226  			out.appl_sfx,
  2227  			out.appl_code1,
  2228  			out.appl_unit1,
  2229  			out.appl_code2,
  2230  			out.appl_unit2,
  2231  			out.appl_num,
  2232
  2233  			out.alias_score,
  2234  			out.name_score,
  2235  			out.qual_score
  2236
  2237  		from dual;
  2238
  2239  		total_output := total_output + sql%rowcount;
  2240
  2241  		commit_count := commit_count + 01;
  2242  		if	commit_count >= commit_size		then
  2243  			commit_count := 0;
  2244  			commit;
  2245  		end if;
  2246
  2247  		if	total_record  < scrub_rule.capacity		then
  2248  			total_record := total_record + 01;
  2249  		else
  2250  			dbms_output.put_line ('ERROR - Output Record Limit Exceeded');
  2251  			exit;
  2252  		end if;
  2253
  2254  	end if;
  2255
  2256  --	========================================
  2257  <<end_record_loop>>
  2258
  2259  	null;
  2260
  2261  end loop;
  2262
  2263  	if	read_rowid > 0			then
  2264  		close read_rowid_table;
  2265  	end if;
  2266
  2267  	if	read_app > 0			then
  2268  		close read_app_table;
  2269  	end if;
  2270
  2271  	commit;
  2272
  2273  	dbms_output.put_line ( ' ' );
  2274  	dbms_output.put_line ( 'GIS ADDRESS RESOLVE  '||to_char (sysdate, 'mon dd,yyyy'));
  2275  	dbms_output.put_line ( ' ' );
  2276  	dbms_output.put_line ( 'read  = '   	||lpad(total_read		,6));
  2277  	dbms_output.put_line ( 'input = '   	||lpad(total_input	,6));
  2278  	dbms_output.put_line ( 'insert     = '   	||lpad(total_output	,6));
  2279  	dbms_output.put_line ( 'total = '   	||lpad(total_record	,6));
  2280  	dbms_output.put_line ( 'alias = '   	||lpad(total_alias	,6));
  2281  	dbms_output.put_line ( 'fuzzy = '   	||lpad(total_fuzzy	,6));
  2282
  2283  --	dbms_output.put_line ( ' ' );
  2284  --	dbms_output.put_line ( 'test1	     = '   	||lpad(test_count1	,6));
  2285  --	dbms_output.put_line ( 'test2	     = '   	||lpad(test_count2	,6));
  2286  --	dbms_output.put_line ( 'test3	     = '   	||lpad(test_count3	,6));
  2287
  2288  	return;
  2289
  2290  end	Batch_Driver;
  2291
  2292
  2293  --	=================================================================
  2294  --	<QD>
  2295
  2296  	procedure	Query_Driver
  2297  --	=================================================================
  2298
  2299  (
  2300  	addr_num	in out	varchar2,
  2301  	addr_pfx	in out	varchar2,
  2302  	addr_name	in out	varchar2,
  2303  	addr_type	in out	varchar2,
  2304  	addr_sfx	in out	varchar2,
  2305
  2306  	addr_code1	in out	varchar2,
  2307  	addr_unit1	in out	varchar2,
  2308  	addr_code2	in out	varchar2,
  2309  	addr_unit2	in out	varchar2,
  2310
  2311  	form_pfx	in out	varchar2,
  2312  	form_name	in out	varchar2,
  2313  	form_type	in out	varchar2,
  2314  	form_sfx	in out	varchar2,
  2315
  2316  	form_code1	in out	varchar2,
  2317  	form_unit1	in out	varchar2,
  2318  	form_code2	in out	varchar2,
  2319  	form_unit2	in out	varchar2,
  2320
  2321  	verify_code	out		number,
  2322  	gis_key	out		varchar2,
  2323  	audit		out		varchar2,
  2324
  2325  	spec_insert	in		number	default 01,
  2326  	spec_seq	in		number	default 0
  2327
  2328  	,Tracker_Mode	in	number	default 0
  2329  	,Tracker_Focus	in	varchar2 	default null
  2330  	,Tracked_Focus	in	varchar2 	default null
  2331  )
  2332
  2333  is
  2334  begin
  2335
  2336  	total_read		:= 0;
  2337  	total_input		:= 0;
  2338  	total_output	:= 0;
  2339  	total_record	:= 0;
  2340  	total_fuzzy		:= 0;
  2341  	commit_count	:= 0;
  2342
  2343  	street_name		:= ' ';
  2344
  2345  	out.appl_num	:= addr_num;
  2346  	out.appl_pfx	:= addr_pfx;
  2347  	out.appl_name	:= addr_name;
  2348  	out.appl_type	:= addr_type;
  2349  	out.appl_sfx	:= addr_sfx;
  2350  	out.appl_code1	:= addr_code1;
  2351  	out.appl_unit1	:= addr_unit1;
  2352  	out.appl_code2	:= addr_code2;
  2353  	out.appl_unit2	:= addr_unit2;
  2354  	out.form_name	:= null;
  2355  	out.addr_name	:= null;
  2356
  2357  	decision := MAIN_DRIVER (0, spec_seq);
  2358
  2359  	addr_num		:= out.addr_num;
  2360  	addr_pfx		:= out.addr_pfx;
  2361  	addr_name		:= out.addr_name;
  2362  	addr_type		:= out.addr_type;
  2363  	addr_sfx		:= out.addr_sfx;
  2364  	addr_code1		:= out.addr_code1;
  2365  	addr_unit1		:= out.addr_unit1;
  2366  	addr_code2		:= out.addr_code2;
  2367  	addr_unit2		:= out.addr_unit2;
  2368
  2369  	form_pfx		:= out.form_pfx;
  2370  	form_name		:= out.form_name;
  2371  	form_type		:= out.form_type;
  2372  	form_sfx		:= out.form_sfx;
  2373  	form_code1		:= out.form_code1;
  2374  	form_unit1		:= out.form_unit1;
  2375  	form_code2		:= out.form_code2;
  2376  	form_unit2		:= out.form_unit2;
  2377
  2378  	verify_code		:= out.verify_code;
  2379  	gis_key		:= out.rec_key;
  2380  --	gis_key		:= nvl(out.parcel_id, out.segment_id);
  2381
  2382  	out.do_parse	:= nvl(out.do_parse, ' ');
  2383  	out.do_alias	:= nvl(out.do_alias, ' ');
  2384  	out.do_name		:= nvl(out.do_name,  ' ');
  2385  	out.do_qual		:= nvl(out.do_qual,  ' ');
  2386
  2387  	audit			:=	' '
  2388  					||'  parse=' || out.do_parse
  2389  					||'  alias=' || out.do_alias
  2390  					||'  name='	 || out.do_name
  2391  					||'  qual='	 || out.do_qual
  2392
  2393  					||' scores=' || 	nvl(out.alias_score,0) ||';'||
  2394  								nvl(out.name_score, 0) ||';'||
  2395  								nvl(out.qual_score, 0)
  2396  					;
  2397
  2398  	return;
  2399
  2400  end	Query_Driver;
  2401
  2402  END;

2402 rows selected.
