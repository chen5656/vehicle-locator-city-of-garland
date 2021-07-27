--	09 12 02

	set echo	off;
--	====================================================================================================
--	drop package body				BUILD_INTERSECTION;

	create or replace package body	BUILD_INTERSECTION	is
--	====================================================================================================

--	====================================================================================================
--	tasks

--		intersection type & id
--		unique id = min street id, min block id = fifo

--	====================================================================================================
--	modifications

--	this_lo_pfx
--		pfx = 2 if prefixes are different & NON-blank
--		sfx = 2 if suffixes are different & NON_blank
--		cursor = node, sid, street, bid, etc

--	====================================================================================================
--	a  street intersection occurs at a "hub" node 
--	a "street" is the name & type portion of a full street (example: Country Club Rd)
--	a "street" may have 1 or 2 "spoke" segments attached to the "hub" node
--	an "intersection" contains 2 "spokes" of 2 different "streets" (primary & secondary)
--	the generated intersection may or may not include a prefix or suffix
--	the generated intersection may or may not include hundred blocks

--	"full street"	includes prefix &  suffix
--	"partial street"	excludes prefix or suffix
--	"block"		includes "full street" plus 100 block

--	the cursor reads all "spokes" (segments) attached to a "hub" (node)	
--	the spokes are stored in an array (PL/SQL table)
--	each street has a sequence of spokes within the array
--	where does each street begin in the spoke array 	(street1, street2, street3)

--	process all combinations of street spokes 		(build_intersection_records procedure)
--	each combination involves 2 spoke indexes 		(idx1, idx2)
--	each index corresponds to a street sequence		(seq1, seq2)
--	each street has 1 or 2 distinct prefixes 			(pfx1, pfx2)
--	a "partial" spoke has a prefix removed			(off1, off2)
--	a "partial" spoke is used if it is  the 1st spoke	(use1, use2)
--	a "partial" spoke is used if it has the 2nd prefix	(use1, use2)

--	a spoke may have a suffix removed when
--		the user parameter = 2   (except for block-block)
--		the suffix is non-blank
--		such a record has not been created already
--	see procedure "insert_intersection_record"

--	there are many combinations of "spokes" at a "hub" node
--	each combination may generate different types of intersections (see below)

--	=============================================================================
--	"build intersection table" parameters	(see \\90_Execute_Intersection.sql)

	do_street_street		number;		--	A

	do_block_block		number;		--	B

	do_block_street		number;		--	C
	do_street_block		number;		--	D
	
	do_block_part		number;		--	E
	do_part_block		number;		--	F
	
	do_block_partial		number;		--	G
	do_partial_block		number;		--	H
	
	do_street_part		number;		--	I
	do_part_street		number;		--	J

	do_street_partial		number;		--	K
	do_partial_street		number;		--	L

	do_partial_partial	number;		--	M
	do_part_part		number;		--	N

	do_report			number;
	do_inserts			number;


	is_one_per_node		number	:= 01;
	is_many_per_node		number	:= 02;


--	======================================================================
--	"build intersection record" steps

	at_street_street		number	:= 01;		--	A

	at_block_block		number	:= 02;		--	B

	at_block_street		number	:= 03;		--	C
	at_street_block		number	:= 04;		--	D

	at_block_part		number	:= 05;		--	E
	at_part_block		number	:= 06;		--	F

	at_block_partial		number	:= 07;		--	G
	at_partial_block		number	:= 08;		--	H

	at_street_part		number	:= 09;		--	I
	at_part_street		number	:= 10;		--	J

	at_street_partial		number	:= 11;		--	K
	at_partial_street		number	:= 12;		--	L

	at_partial_partial	number	:= 13;		--	M
	at_part_part		number	:= 14;		--	N


	lo_block_step		number	:= 2;
	lo_partial_step		number	:= 5;
	hi_block_step		number	:= 10;
	hi_step			number	:= 14;

--	======================================================================
--	kinds of intersections	

	is_street_street		char		:= 'A';

	is_block_block		char		:= 'B';

	is_block_street		char		:= 'C';
	is_street_block		char		:= 'D';

	is_block_part		char		:= 'E';
	is_part_block		char		:= 'F';

	is_block_partial		char		:= 'G';
	is_partial_block		char		:= 'H';

	is_street_part		char		:= 'I';
	is_part_street		char		:= 'J';

	is_street_partial		char		:= 'K';
	is_partial_street		char		:= 'L';

	is_partial_partial	char		:= 'M';
	is_part_part		char		:= 'N';	

	has_suffix1_removed	char		:= 'X';
	has_suffix2_removed	char		:= 'Y';
	has_suffix12_removed	char		:= 'Z';

--	======================================================================
--	initialize

	do_trace			number;
	test_node			number;

	max_batch			number;
	max_node			number;

	lo_node			number;
	hi_node			number;
	last_node			number;
	final_node			number;

	ttl_load			number;
	ttl_record			number;
	ttl_insert			number;
	ttl_batch			number;
	ttl_node			number;
	ttl_spoke			number;

	ttl_triple			number;
	ttl_dead_end		number;
	ttl_dupe_spoke		number;
	ttl_dupe_block		number;

	ttl_suffix1			number;
	ttl_suffix2			number;
	ttl_suffix12		number;

--	======================================================================

	this_intersect_id		varchar2(20);	--	intersection id
	this_node_id		varchar2(20);	--	node id
	this_intersect_rowid	rowid;

	this_kind			char(2);		--	type of intersection
	this_kind1			char(1);		--	major  type
	this_kind2			char(1);		--	suffix type

	this_name			varchar2(30);	--	current "street"
	this_type			varchar2(04);
	this_lo_pfx			varchar2(02);	--	lowest prefix in "street"

	this_pfx			varchar2(02);	--	street qualifiers
	prev_pfx			varchar2(02);
	this_sfx			varchar2(02);
	prev_sfx			varchar2(02);
	this_block			number;
	prev_block			number;

	this1_addr_pfx		varchar2(02);	--	actual or removed (off) prefix
	this2_addr_pfx		varchar2(02);
	this1_addr_sfx		varchar2(02);	
	this2_addr_sfx		varchar2(02);
	this1_addr_block		number;
	this2_addr_block		number;

	work1_block			number;	
	work1_name			varchar2(30);	
	work1_type			varchar2(04);	
	work1_pfx			varchar2(02);	
	work1_sfx			varchar2(02);
	work1_terminal		varchar2(02);
	work1_road_id		number;	

	work2_block			number;	
	work2_pfx			varchar2(02);
	work2_sfx			varchar2(02);

	this1_id			number;	--	primary   id
	this2_id			number;	--	secondary id
	this1_street_id		number;	--	adrStreet street_id
	this2_street_id		number;
	this1_block_id		number;	--	trvehrcl mslink
	this2_block_id		number;

--	======================================================================

	hub_node		number;		--	current node
	step			number;		--	current intersection type

	street#		number;		--	how many streets at hub 
							--	(1 hub <=> 1 to 4 streets)

	spoke#		number;		--	how many spokes  at hub 
							--	(1 hub <=> 1 to 5 spokes)

	street1		number;		--	street1 starting index
	street2		number;		--	street2
	street3		number;		--	street3
	street4		number;		--	street4

	prefix#		number;		--	how many distinct prefixes on street
	prefix1#		number;		--						street1
	prefix2#		number;		--						street2
	prefix3#		number;		--						street3
	prefix4#		number;		--						street4

	a1			number;		--	primary   spoke positions
	a2			number;
	b1			number;		--	secondary spoke positions
	b2			number;

	cnt1			number;		--	spoke sequence of streets
	cnt2			number;

	seq1			number;		--	spoke sequence of primary   street
	seq2			number;		--				secondary street

	idx1			number;		--	primary   spoke index 
	idx2			number;		--	secondary spoke index  

	pfx1			number;		--	primary   distinct prefixes
	pfx2			number;		--	secondary distinct prefixes
	pfx01			number;		--	
	pfx02			number;		--	

	off1			number;		--	primary   has prefix removed
	off2			number;		--	secondary has prefix removed

	use1			number;		--	primary   usage flag
	use2			number;		--	secondary usage flag

	ignore		number;
	found_count		number;
	do_block		number;
	do_partial		number;
	has_id_error	number;

--	======================================================================
cursor	read_hub_spoke		is

--	truncate table	plan_table;
--	explain plan	set statement_id = 'spoke'		for

		select
			s.esri_node,
			s.street_id,
			r.addr_name,
			r.addr_type,
			r.addr_pfx,
			r.addr_sfx,
			s.block_id,
			trunc(r.addr_lo, -2)	addr_block,
			s.terminal,
			trunc(r.addr_hi, -2)	addr_block2,
			r.mslink			road_id,
			s.rowid			spoke_rowid,
			r.rowid			road_rowid

		from	trvehrcl	r,
			spoke		s

		where	s.road_id	= rtrim(r.mslink)
		and	s.terminal	= 'F'
		and	r.addr_lo	>  0

		and	s.esri_node	between lo_node and hi_node
		and	test_node	in (0, s.esri_node)

	union

		select
			s.esri_node,
			s.street_id,
			r.addr_name,
			r.addr_type,
			r.addr_pfx,
			r.addr_sfx,
			s.block_id,
			trunc(r.addr_hi, -2)	addr_block,
			s.terminal,
			trunc(r.addr_lo, -2)	addr_block2,
			r.mslink			road_id,
			s.rowid			spoke_rowid,
			r.rowid			road_rowid

		from	trvehrcl	r,
			spoke		s

		where	s.road_id	= rtrim(r.mslink)
		and	s.terminal	= 'T'
		and	r.addr_hi	>  0

		and	s.esri_node	between lo_node and hi_node
		and	test_node	in (0, s.esri_node)	
	;

--	======================================================================
--	select * from explain_plan;
--	select * from explain_indexed;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_analyze;
--	select * from explain_cost;
--	======================================================================

	SEGM		read_hub_spoke%rowtype;
	SEGM_		read_hub_spoke%rowtype;
	SEGM1		read_hub_spoke%rowtype;
	SEGM2		read_hub_spoke%rowtype;

--	======================================================================
/*
cursor	read_block			is	
		select rowid	row_id
		from	adrBlock
		where	addr_name	= segm.addr_name
		and	addr_type	= segm.addr_type
		and	addr_pfx	= segm.addr_pfx
		and	addr_sfx	= segm.addr_sfx
		and	addr_block	= segm.addr_block;

	BLOK1		read_block%rowtype;
	BLOK2		read_block%rowtype;
*/
--	======================================================================

	abort_run	exception;

type	spoke_table is table of		read_hub_spoke%rowtype
	index by	binary_integer;

	SPOKE			spoke_table;


type	step_table is table of		number
	index by	binary_integer;

	do_step		step_table;


type	total_table is table of		number
	index by	binary_integer;

	total		total_table;

--	======================================================================
--	======================================================================

	procedure	build_intersection_records;
	procedure	display_trace;
	
	procedure	BUILD_INTERSECTION_TABLE
	(	
		street_street		number,		--	1	A

		block_block			number,		--	2	B

		block_street		number,		--	3	C
		street_block		number,		--	4	D

		block_part			number,		--	5	E
		part_block			number,		--	6	F

		block_partial		number,		--	7	G
		partial_block		number,		--	8	H

		street_part			number,		--	9	I
		part_street			number,		--	10	J

		street_partial		number,		--	11	K
		partial_street		number,		--	12	L

		partial_partial		number,		--	13	M
		part_part			number		--	14	N
		
		,report			number		default 	0

		,inserts			number		default 	max_load

	)	is
--	======================================================================
--	Read spoke segments around each hub node into an array
--	Build intersection records for each pair of spokes
--	======================================================================

begin

	do_trace	:= 0;
	test_node	:= 0;
	final_node	:= 0;
	lo_node	:= 0;	
	hi_node	:= 0;

	msg		:= null;
	msg_info1	:= null;
	msg_info2	:= null;
	msg_info3	:= null;

	segm		:= null;					-- TEMP
	
	do_inserts	:= inserts;
	do_report	:= report;

	if	do_report < 0			then
		do_report := abs(do_report);
		do_trace  := do_report;
	end if;


	if	do_inserts < 0			then
		test_node	:= abs(do_inserts);
		do_inserts	:= 0;
	end if;

	if	do_report = 999			then
		do_inserts := max_sample;
	end if;

	if	do_report = 0
	and	test_node > 0			then
		do_report := max_sample;
	end if;

	if	do_report   > 0
	and	do_inserts  > max_sample	then
		do_inserts := max_sample;
	end if;

	do_street_street			:= street_street;
	do_block_block			:= block_block;
	do_block_street			:= block_street;
	do_street_block			:= street_block;
	do_block_part			:= block_part;
	do_part_block			:= part_block;
	do_block_partial			:= block_partial;
	do_partial_block			:= partial_block;
	do_street_part			:= street_part;
	do_part_street			:= part_street;
	do_street_partial			:= street_partial;
	do_partial_street			:= partial_street;
	do_partial_partial		:= partial_partial;
	do_part_part			:= part_part;

	do_step (at_street_street)	:= do_street_street;
	do_step (at_block_block)	:= do_block_block;
	do_step (at_block_street)	:= do_block_street;
	do_step (at_street_block)	:= do_street_block;
	do_step (at_block_part)		:= do_block_part;
	do_step (at_part_block)		:= do_part_block;
	do_step (at_block_partial)	:= do_block_partial;
	do_step (at_partial_block)	:= do_partial_block;
	do_step (at_street_part)	:= do_street_part;
	do_step (at_part_street)	:= do_part_street;
	do_step (at_street_partial)	:= do_street_partial;
	do_step (at_partial_street)	:= do_partial_street;
	do_step (at_partial_partial)	:= do_partial_partial;
	do_step (at_part_part)		:= do_part_part;

	total	(at_street_street)	:= 0;
	total (at_block_block)		:= 0;
	total (at_block_street)		:= 0;
	total (at_street_block)		:= 0;
	total (at_block_part)		:= 0;
	total (at_part_block)		:= 0;
	total (at_block_partial)	:= 0;
	total (at_partial_block)	:= 0;
	total (at_street_part)		:= 0;
	total (at_part_street)		:= 0;
	total (at_street_partial)	:= 0;
	total (at_partial_street)	:= 0;
	total (at_partial_partial)	:= 0;
	total (at_part_part)		:= 0;

	if	final_node = 0				then
		select	max (to_number(esri_node))
		into		final_node
		from		spoke;	
	end if;

	if	max_node = 0				then
		select count(distinct esri_node)
		into	 max_node
		from	 spoke;
	end if;

	if	max_batch = 0				then
		max_batch := ceil (final_node / commit_size);	
	end if;

	select count(*)
	into	ttl_load
	from	intersection;

	ttl_record			:= 0;	
	ttl_insert			:= 0;	
	ttl_batch			:= 0;
	ttl_node			:= 0;
	ttl_spoke			:= 0;	
	ttl_triple			:= 0;
	ttl_dead_end		:= 0;
	ttl_dupe_spoke		:= 0;
	ttl_dupe_block		:= 0;

	ttl_suffix1			:= 0;	
	ttl_suffix2			:= 0;	
	ttl_suffix12		:= 0;	

	do_block  :=
		do_block_block	 +
		do_block_part	 +
		do_part_block	 +	
		do_block_partial	 +
		do_partial_block   +
		do_street_part	 +
		do_part_street	 +	
		do_block_street	 +
		do_street_block	 +
		do_part_part;

	do_partial :=
		do_block_part	 +	
		do_part_block	 +	
		do_block_partial	 +
		do_partial_block	 +	
		do_street_part	 +	
		do_part_street	 +	
		do_street_partial  +
		do_partial_street  +
		do_partial_partial +
		do_part_part;

	dbms_output.put_line (' ');	
	dbms_output.put_line (	'nodes:  ' || final_node	 );
	dbms_output.put_line (	'commit: ' || commit_size);
	dbms_output.put_line (	'insert: ' || do_inserts );
	dbms_output.put_line (	'report: ' || do_report   ||' '|| do_trace );

	dbms_output.put_line (	'steps:  ' ||	
					do_street_street	||
					do_block_block	||
					do_block_street	||
					do_street_block	||
					do_block_part     ||
					do_part_block     ||
					do_block_partial  ||
					do_partial_block  ||
					do_street_part    ||
					do_part_street	||
					do_partial_street ||
					do_street_partial	||
					do_partial_partial||
					do_part_part     		);
	dbms_output.put_line (' ');


begin

<<batch_loop>>				--	process each hub range
while hi_node <= final_node		loop

	if	test_node > '0'		then
		display_trace;		--	TRACE
	end if;

   msg := msg || 'bBatch ';

	lo_node := hi_node + 01;
	hi_node := hi_node + commit_size;
	
	open	read_hub_spoke;
	fetch	read_hub_spoke	into segm;

	if	read_hub_spoke%notfound
	or	read_hub_spoke%notfound is null	then
		goto	batch_finish;
	end if;

   msg := msg || 'b1rd ';
   msg_info1 := 'b1rd	' || segm.addr_block ||' '|| segm.addr_name ||' '|| segm.addr_type;	

	segm_	:= segm;

	if	ttl_record < do_report			then
		dbms_output.put_line (' ');	
		dbms_output.put_line ('batch: ' || lo_node ||'-'|| hi_node);	
	end if;


<<hub_loop>>					--	process each hub

while	segm_.esri_node <= hi_node
and	read_hub_spoke%found			loop

   msg := msg || 'cHub ';

	if	ttl_record < do_report	then
		dbms_output.put_line (' ');	
	end if;

	segm		:= segm_;			--	restore next hub block
	hub_node	:= segm.esri_node;
	last_node	:= segm.esri_node;
	ttl_node	:= ttl_node + 01;

	spoke#	:= 0;			
	street#	:= 0;			
	street1	:= 0;
	street2	:= 0;
	street3	:= 0;
	street4	:= 0;
	prefix1#	:= 0;
	prefix2#	:= 0;
	prefix3#	:= 0;
	prefix4#	:= 0;
	has_id_error:= 0;
	this_lo_pfx	:= null;
	this_name	:= null;

<<spoke_loop>>					--	process each hub spoke
while	segm.esri_node = hub_node			loop

   msg := msg || 'dSpoke ';

	if	segm.street_id > 0
	and	segm.block_id  > 0		then
		null;
	else
		has_id_error	:= 01;
	end if;

	if	ttl_record < do_trace		then
		dbms_output.put_line (	  'spoke: '		|| lpad(segm.esri_node,      4,0) 
						||'    street: '	|| lpad(segm.street_id, 4,0) 
						||'    block: '	|| lpad(segm.block_id,  4,0) 
						||'    segment: '	|| lpad(segm.road_id,4,0) 

						||'    // '		|| segm.terminal
						||'   '		|| lpad(segm.addr_block,5)
						||' '			|| segm.addr_pfx
						||' '			|| segm.addr_name
						||' '			|| segm.addr_type
						||' '			|| segm.addr_sfx
					);	
	end if;

	ttl_spoke	:= ttl_spoke + 01;

	if	segm.addr_name = this_name
	and	segm.addr_type = this_type		then
		prev_pfx	:= this_pfx;
		prev_sfx	:= this_sfx;
		prev_block	:= this_block;
	else
		prev_pfx	:= null;
		prev_sfx	:= null;
		prev_block	:= null;
		prefix#	:= 0;
	end if;

	this_name	:= segm.addr_name;
	this_type	:= segm.addr_type;
	this_pfx	:= segm.addr_pfx;
	this_sfx	:= segm.addr_sfx;
	this_block	:= segm.addr_block;

	if	prev_pfx	= this_pfx
	and	prev_sfx	= this_sfx	
	and	prev_block	= this_block		then
		null;
	else
		spoke#		:= spoke# + 01;
		spoke (spoke#) 	:= segm;
	end if;

	if	prev_block is null			then
		street# := street# + 01;
		if	street# = 1				then
			street1	:= spoke#;
			this_lo_pfx := this_pfx;
		elsif	street# = 2				then
			street2	:= spoke#;
			this_lo_pfx := this_pfx;
		elsif	street# = 3				then
			street3	:= spoke#;
			this_lo_pfx := this_pfx;
			ttl_triple	:= ttl_triple + 01;
		elsif	street# = 4				then
			street4	:= spoke#;
			this_lo_pfx := this_pfx;
		else
			dbms_output.put_line ('too many streets at node ' || hub_node);
			raise abort_run;
		end if;
	end if;

--	a street is considered to have different prefixes only if ALL of them are non_blank
--	otherwise partial intersections are not desired, so prefix# > 1 is not desired

	if	prefix#  =  0
	or  (	this_pfx <> prev_pfx
	and	this_lo_pfx > ' '		)		then
		prefix#  := prefix# + 01;
		if	street# = 1				then
			prefix1# := prefix#;
		elsif	street# = 2				then
			prefix2# := prefix#;
		elsif	street# = 3				then
			prefix3# := prefix#;
		elsif	street# = 4				then
			prefix4# := prefix#;
		end if;
	end if;	

<<fetch_spoke>>

   msg := msg || 'eFetch ';

	work1_name		:= segm.addr_name;
	work1_type		:= segm.addr_type;
	work1_pfx		:= segm.addr_pfx;
	work1_sfx		:= segm.addr_sfx;
	work1_block		:= segm.addr_block;
	work1_road_id	:= segm.road_id;
	work1_terminal	:= segm.terminal;
	
	fetch	read_hub_spoke			into segm;
	exit when	read_hub_spoke%notfound
		or	read_hub_spoke%notfound is null;

	if	test_node > '0'		then
		display_trace;		--	TRACE
	end if;

   msg := msg || 'e1rd ';
   msg_info2 := 'e1rd	' || segm.addr_block ||' '|| segm.addr_name ||' '|| segm.addr_type;	

	if	hub_node		= segm.esri_node
	and	work1_road_id	= segm.road_id
	and	work1_terminal	= segm.terminal				then
		ttl_dupe_spoke   := ttl_dupe_spoke + 01;
		goto	fetch_spoke;
	end if;

	if	hub_node		= segm.esri_node
	and	work1_name		= segm.addr_name
	and	work1_type		= segm.addr_type
	and	work1_pfx		= segm.addr_pfx
	and	work1_sfx		= segm.addr_sfx
	and	work1_block		in (segm.addr_block, segm.addr_block2)	then
		ttl_dupe_block   := ttl_dupe_block + 01;
		goto	fetch_spoke;
	end if;

<<end_spoke_loop>>

   msg := msg || 'eEnd ';

	if	has_id_error > 0			then
		dbms_output.put_line (	'     ' 
						|| hub_node 
						|| ',		-- node with missing street/block id in spoke');
		goto	end_hub_loop;
	end if;

	if	spoke# > max_spoke		then
		dbms_output.put_line ('too many spokes at node ' || hub_node);
		raise abort_run;
	end if;

end loop	spoke_loop;

	segm_	  := segm;							--	save next hub block

<<spoke_combinations>>

   msg := msg || 'fCombo ';

	if	street# < 2				then
		ttl_dead_end := ttl_dead_end + 01;
		goto	end_hub_loop;
	end if;

	if	street3  = 0			then
		street3 := spoke# + 01;
	end if;

	if	street4  = 0			then
		street4 := spoke# + 01;
	end if;

	if	ttl_record < do_trace		then
		dbms_output.put_line ('spokes:' || spoke# );	
		dbms_output.put_line ('starts:' || street1 ||' '|| street2 ||' '|| street3 ||' '|| street4);	
	end if;

for	n in 1..6					loop

	if	n = 1					then			--	1 / 2
		a1	:= street1;
		a2	:= street2 - 1;
		pfx01	:= prefix1#;

		b1	:= street2;
		b2	:= street3 - 1;
		pfx02	:= prefix2#;

	elsif	street# < 3				then			--	only 2 streets
		exit;

	elsif	n = 2					then			--	1 / 3
		b1	:= street3;
		b2	:= street4 - 1;
		pfx02	:= prefix3#;

	elsif	n = 3					then			--	1 / 4
		b1	:= street4;
		b2	:= spoke#;
		pfx02	:= prefix4#;

	elsif	n = 4					then			--	2 / 3
		a1	:= street2;
		a2	:= street3 - 1;
		pfx01	:= prefix2#;

		b1	:= street3;
		b2	:= street4 - 1;
		pfx02	:= prefix3#;

	elsif	n = 5					then			--	2 / 4
		b1	:= street4;
		b2	:= spoke#;
		pfx02	:= prefix4#;

	else									--	3 / 4
		a1	:= street3;
		a2	:= street4 - 1;
		pfx01	:= prefix3#;

	end if;


	cnt1	:= 0;

for	a in a1..a2					loop

	cnt1	:= cnt1 + 01;

	cnt2	:= 0;

for	b in b1..b2					loop

	cnt2	:= cnt2 + 01;

	idx1	:= a;
	idx2	:= b;
	seq1	:= cnt1;
	seq2	:= cnt2;
	pfx1	:= pfx01;
	pfx2	:= pfx02;
	Build_Intersection_Records;

	idx1	:= b;
	idx2	:= a;
	seq1	:= cnt2;
	seq2	:= cnt1;
	pfx1	:= pfx02;
	pfx2	:= pfx01;
	Build_Intersection_Records;

end loop;			--	a loop
end loop;			--	b loop
end loop;			--	n loop

<<end_hub_loop>>

	if	ttl_node > max_node		then
		dbms_output.put_line ('*** hub loop ***');
		raise abort_run;
	end if;

end loop	hub_loop;	


<<batch_finish>>

   msg := msg || 'gFinish ';

	commit;
	close	read_hub_spoke;

<<end_batch_loop>>


	ttl_batch := ttl_batch + 01;
	if	ttl_batch > max_batch		then
		dbms_output.put_line ('*** batch loop ***');
		raise abort_run;
	end if;

	if	do_report > 0
	and	do_report <= ttl_record		then
		final_node := 0;
	end if;

	if	do_inserts > 0
	and	do_inserts <= ttl_insert	then
		final_node := 0;
	end if;

end loop	batch_loop;	

exception
	when abort_run then	
		dbms_output.put_line ('node    ' || hub_node); 
		for x in 1..spoke#	loop
			dbms_output.put_line ('road_id  ' || spoke(x).road_id    
							  ||':  '|| spoke(x).addr_block 
							  ||' '  ||	spoke(x).addr_name 
							  ||' '  || spoke(x).addr_type );
		end loop;
		dbms_output.put_line ('*** ABORT RUN ***'); 
		close	read_hub_spoke;
end;

	if	test_node > '0'				then
		display_trace;							--	TRACE
	end if;

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'Build Intersection Table ' || to_char( sysdate, 'Mon dd,yyyy  hh24:mi') );

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'batches               ' || lpad(ttl_batch			,6)	
									||' * '||	
								   	   rpad(commit_size		,3));

	dbms_output.put_line ( 'nodes                 ' || lpad(ttl_node			,6));
	dbms_output.put_line ( 'spokes		    ' || lpad(ttl_spoke			,6));
	dbms_output.put_line ( 'records		    ' || lpad(ttl_record		,6));
	dbms_output.put_line ( 'inserts		    ' || lpad(ttl_insert		,6));
	dbms_output.put_line ( 'load    		    ' || lpad(ttl_load			,6));
	dbms_output.put_line ( 'max load              ' || lpad(max_load			,6));

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'A  street  - street   ' || lpad(total (at_street_street)	,6));
	dbms_output.put_line ( 'B  block   - block    ' || lpad(total (at_block_block)	,6));
	dbms_output.put_line ( 'C  block   - street   ' || lpad(total (at_block_street)	,6));
	dbms_output.put_line ( 'D  street  - block    ' || lpad(total (at_street_block)	,6));
	dbms_output.put_line ( 'E  block   - part     ' || lpad(total (at_block_part)		,6));
	dbms_output.put_line ( 'F  part    - block    ' || lpad(total (at_part_block)		,6));
	dbms_output.put_line ( 'G  block   - partial  ' || lpad(total (at_block_partial)	,6));
	dbms_output.put_line ( 'H  partial - block    ' || lpad(total (at_partial_block)	,6));
	dbms_output.put_line ( 'I  street  - part     ' || lpad(total (at_street_part)	,6));
	dbms_output.put_line ( 'J  part    - street   ' || lpad(total (at_part_street)	,6));
	dbms_output.put_line ( 'K  street  - partial  ' || lpad(total (at_street_partial)	,6));
	dbms_output.put_line ( 'L  partial - street   ' || lpad(total (at_partial_street)	,6));
	dbms_output.put_line ( 'M  partial - partial  ' || lpad(total (at_partial_partial)	,6));
	dbms_output.put_line ( 'N  part    - part	    ' || lpad(total (at_part_part)		,6));

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( '   suffix 1   removed ' || lpad(ttl_suffix1	,6));
	dbms_output.put_line ( '   suffix 2   removed ' || lpad(ttl_suffix2	,6));
	dbms_output.put_line ( '   suffix 1&2 removed ' || lpad(ttl_suffix12	,6));
	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'dupe spoke            ' || lpad(ttl_dupe_spoke	,6));
	dbms_output.put_line ( 'dupe block (trvehrcl) ' || lpad(ttl_dupe_block	,6));
	dbms_output.put_line ( 'dead end              ' || lpad(ttl_dead_end	,6));
	dbms_output.put_line ( 'triple intersect      ' || lpad(ttl_triple	,6));
	dbms_output.put_line ( 'last node processed   ' || lpad(last_node		,6));
	dbms_output.put_line (' ');

end	build_intersection_table;


--	======================================================================
--	======================================================================
	procedure	insert_intersection_record;

	procedure	BUILD_INTERSECTION_RECORDS	is
--	======================================================================
--	Use pair of segment spokes to produce all requested intersection types
--	An intersection may contain streets and/or 100 blocks
--	Produce partial intersections only at N-S & E-W boundaries
--	======================================================================

begin

   msg := msg || 'mRecord ';

	segm1	:= spoke (idx1);
	segm2	:= spoke (idx2);

	if	seq1 > 2
	or	seq2 > 2
	or	pfx1 > 2
	or	pfx2 > 2	then
		dbms_output.put_line ('seq/pfx ' || seq1 ||','|| seq2 ||'/'|| pfx1 ||','|| pfx2);
		raise abort_run;
	end if;

	if	ttl_record < do_trace		then
		dbms_output.put_line (' ');
		dbms_output.put_line ('node:  ' || segm1.esri_node ||' / '|| segm1.road_id ||','|| segm2.road_id);
	end if;


for kind in 1..hi_step 				loop

	step	:= kind;

	if	step = at_street_street		then
		null;

	elsif	step >= lo_partial_step
	and (	do_partial  = 0
	or	pfx1 * pfx2 = 1	)		then
		exit;

	elsif	do_block = 0
	and (	step between lo_block_step and hi_block_step
	or	step = hi_step )			then
		goto	end_step_loop;

	end if;

	this1_addr_pfx	:= segm1.addr_pfx;
	this2_addr_pfx	:= segm2.addr_pfx;
	this1_addr_sfx	:= segm1.addr_sfx;
	this2_addr_sfx	:= segm2.addr_sfx;
	this1_addr_block	:= 0;
	this2_addr_block	:= 0;

	this1_block_id	:= 0;
	this2_block_id	:= 0;
	this1_street_id	:= segm1.street_id;
	this2_street_id	:= segm2.street_id;

	if	step in (at_block_street,  at_block_partial, at_part_street)		then
		this1_addr_block	:= segm1.addr_block;
		this1_block_id	:= segm1.block_id;
	elsif step in (at_street_block,  at_partial_block, at_street_part)		then
		this2_addr_block	:= segm2.addr_block;
		this2_block_id	:= segm2.block_id;
	elsif step in (at_block_block, at_block_part, at_part_block, at_part_part)	then	
		this1_addr_block	:= segm1.addr_block;
		this1_block_id	:= segm1.block_id;
		this2_addr_block	:= segm2.addr_block;
		this2_block_id	:= segm2.block_id;
	end if;

	if	seq1 = 1  				--	if first spoke of street
	or	pfx1 = 2 		then		--	or street has 2 distinct prefixes
		use1	:= 1;				--	then using spoke won't cause duplicate
	else
		use1	:= 0;
	end if;

	if	seq2 = 1  
	or	pfx2 = 2 		then
		use2	:= 1;
	else
		use2	:= 0;
	end if;

--	=================================================================================
--	prepare full street or partial street depending on the "step"
--	prepare partial intersection only for street with 2 distinct prefixes at node

	ignore := 0;
	off1	 := 0;
	off2	 := 0;

	if	step in (	at_part_block,	at_partial_block,	 at_part_part,	 
				at_part_street,	at_partial_street, at_partial_partial  )	then
		if	pfx1 = 2			
		and	segm1.addr_pfx  > ' '	then
			this1_addr_pfx := ' ';
			off1	 := 1;
		else
			ignore := ignore + 01;
		end if;
	end if;

	if	step in (	at_block_part,	at_block_partial,	 at_part_part, 
				at_street_part,	at_street_partial, at_partial_partial  )	then
		if	pfx2 = 2			
		and	segm2.addr_pfx  > ' '	then
			this2_addr_pfx := ' ';
			off2	 := 1;
		else
			ignore := ignore + 01;
		end if;
	end if;

	if	ttl_record < do_trace		then
		dbms_output.put_line (' ');
		dbms_output.put_line
		(	'step:  '	||step  
		||	'  idx:'	||idx1||','||idx2 
		||	'  seq:'	||seq1||','||seq2 
		||	'  pfx:'	||pfx1||','||pfx2 
		||	'  off:'	||off1||','||off2 
		||	'  use:'	||use1||','||use2 
		);
	end if;

	if	ignore = 2				then
		goto	end_step_loop;
	end if;

--	======================================================================
--	street / street

	if	at_street_street = step
	and	do_street_street > 0
	and	use1 * use2 = 1				then
		this_kind1 := is_street_street;
		Insert_Intersection_Record;

--	======================================================================
--	block & street

	elsif	at_block_block = step
	and	do_block_block > 0			then
		this_kind1 := is_block_block;
		Insert_Intersection_Record;

	elsif	at_block_street = step
	and	do_block_street > 0
	and 	use2 = 1  					then
		this_kind1 := is_block_street;
		Insert_Intersection_Record;

	elsif	at_street_block = step
	and	do_street_block > 0
	and 	use1 = 1  					then
		this_kind1 := is_street_block;
		Insert_Intersection_Record;
	end if;

--	======================================================================
--	partial / street 
--	process only first "spoke" of primary street			(seq1 = 1)
--	process only if primary   street has prefix removed		(off1 = 1)
--	process only if secondary street has unchanged prefix 	(off2 = 0)

	if	seq1 = 1	
	and	off1 = 1
	and	off2 = 0						then

		if	at_part_block = step	
		and	do_part_block > 0				then
			this_kind1 := is_part_block;
			Insert_Intersection_Record;

		elsif	at_partial_block = step	
		and	do_partial_block > 0			then
			this_kind1 := is_partial_block;
			Insert_Intersection_Record;

		elsif	at_part_street = step	
		and	do_part_street > 0
		and	use2 = 1					then	
			this_kind1 := is_part_street;
			Insert_Intersection_Record;

		elsif	at_partial_street = step
		and	do_partial_street > 0
		and	use2 = 1					then	
			this_kind1 := is_partial_street;
			Insert_Intersection_Record;
		end if;

	end if;

--	======================================================================
--	street / partial
--	process only first "spoke" of secondary street 			(seq2 = 1)
--	process only if primary   street has unchanged prefix 	(off1 = 0)
--	process only if secondary street has prefix removed		(off2 = 1)

	if	seq2 = 1
	and	off2 = 1	
	and	off1 = 0						then

		if	at_block_part = step	
		and	do_block_part > 0				then
			this_kind1 := is_block_part;
			Insert_Intersection_Record;

		elsif	at_block_partial = step
		and	do_block_partial > 0			then
			this_kind1 := is_block_partial;
			Insert_Intersection_Record;

		elsif	at_street_part = step	
		and	do_street_part > 0
		and	use1 = 1					then	
			this_kind1 := is_street_part;
			Insert_Intersection_Record;

		elsif	at_street_partial = step
		and	do_street_partial > 0
		and	use1 = 1					then	
			this_kind1 := is_street_partial;
			Insert_Intersection_Record;

		end if;

	end if;

--	======================================================================
--	partial / partial
--	does not occur in Garland

	if	seq1 * seq2 = 1			
	and	pfx1 * pfx2 = 4
	and	off1 * off2 = 1					then

		if	at_part_part = step
		and	do_part_part > 0 				then
			this_kind1 := is_part_part;
			Insert_Intersection_Record;

		elsif	at_partial_partial = step
		and	do_partial_partial > 0 			then
			this_kind1 := is_partial_partial;
			Insert_Intersection_Record;
		end if;

	end if;

<<end_step_loop>>
	null;
end loop;


exception
	when abort_run then raise;

end	build_intersection_records;	


--	======================================================================
--	======================================================================
	procedure	INSERT_INTERSECTION_RECORD	is
--	======================================================================
--	======================================================================
begin

   msg := msg || 'zInsert ';

	work1_pfx	:= this1_addr_pfx;
	work1_sfx	:= this1_addr_sfx;
	work1_block	:= this1_addr_block;
	work2_pfx	:= this2_addr_pfx;
	work2_sfx	:= this2_addr_sfx;
	work2_block	:= this2_addr_block;

	this_kind2	:= this_kind1;

<<insert_record>>

	if	this1_block_id = 0				then
		this1_id	:= this1_street_id;	
	else
		this1_id	:= this1_block_id;	
	end if;

	if	this2_block_id = 0				then
		this2_id	:= this2_street_id;	
	else
		this2_id	:= this2_block_id;	
	end if;

	this_kind := this_kind1 || this_kind2;

	this_intersect_id :=	
		this_kind			||	
		lpad(this1_id, 4,'0')	||'.'|| 
		lpad(this2_id, 4,'0');

	this_node_id :=
		lpad(least	   (segm1.street_id, segm2.street_id), 4,'0')  ||'.'||	
		lpad(greatest  (segm1.street_id, segm2.street_id), 4,'0');	

	ttl_record	:= ttl_record  + 01;
	total(step)	:= total(step) + 01;

	if	ttl_load >= max_load				then
		dbms_output.put_line ('*** load ***');
		raise abort_run;
	end if;

	if	ttl_insert < do_inserts				then
		ttl_insert	:= ttl_insert + 01;
		ttl_load	:= ttl_load   + 01;

		insert	--+	append
		into		intersection	
	(
		addr1_block,
		addr1_pfx,
		addr1_name,
		addr1_type,
		addr1_sfx,

		addr2_block,
		addr2_pfx,
		addr2_name,
		addr2_type,
		addr2_sfx,

		node_id,
		intersect_id
	)
		values
	(
		this1_addr_block,
		this1_addr_pfx,
		segm1.addr_name,
		segm1.addr_type,
		this1_addr_sfx,

		this2_addr_block,
		this2_addr_pfx,
		segm2.addr_name,
		segm2.addr_type,
		this2_addr_sfx,

		this_node_id,
		this_intersect_id					--	intersection id
	)
		returning rowid	into this_intersect_rowid;

	if	this_intersect_id like 'BB%'			then
		insert	--+ append
		into		corner_view
		values
	(
		this_intersect_id,
		this_intersect_rowid,
		0,				--	block1_rowid
		0,				--	block2_rowid
		segm1.spoke_rowid,	--	spoke1_rowid
		segm2.spoke_rowid,	--	spoke2_rowid
		segm1.road_rowid,		--	road1_rowid
		segm2.road_rowid,		--	road2_rowid
		null, null			--	corner & twin compass
	)
		returning rowid	into this_intersect_rowid;
	end if;

	end if;


	if	ttl_record < do_report				then
		dbms_output.put_line (' ');
		dbms_output.put_line ('record ' || rpad(ttl_record,04)	||
						'     ' || rpad(this_intersect_id,   13)	||
						'     ' || this_kind			);
	end if;

	if	ttl_record < do_trace				then

		dbms_output.put_line 
		(
		rpad(' ',7)				||
		lpad(segm1.esri_node ,4) 		||'     '	||
		lpad(segm1.street_id ,4,0)	||','		||
		lpad(segm1.block_id  ,4,0)	||','		||
		lpad(segm1.road_id   ,4,0)	||'     '	||
		lpad(segm2.street_id ,4,0)	||','		||
		lpad(segm2.block_id  ,4,0)	||','		||
		lpad(segm2.road_id,   4,0)
		);
	end if;


	if	ttl_record < do_report				then

		dbms_output.put_line 
		(
		rpad(' ',7)			 	||
		rpad(this1_addr_block,05)	||' '||
		rpad(this1_addr_pfx,  02)	||' '||
		rpad(segm1.addr_name, 30)	||' '||
		rpad(segm1.addr_type, 04)	||' '||
		rpad(this1_addr_sfx,  02)	||
	
		chr(10)			 	||
		rpad(' ',7)			 	||
		rpad(this2_addr_block,05)	||' '||	
		rpad(this2_addr_pfx,  02)	||' '||
		rpad(segm2.addr_name, 30)	||' '||
		rpad(segm2.addr_type, 04)	||' '||
		rpad(this2_addr_sfx,  02)	 
		);
	end if;


--	remove street suffix

	if	do_step (step) > 1				then
		this_kind2 := null;

		this1_addr_sfx := segm1.addr_sfx;
		this2_addr_sfx := segm2.addr_sfx;

		if	segm1.addr_sfx > '0'
		and	work1_sfx > '0'				then
			work1_sfx	   := ' ';
			ttl_suffix1	   := ttl_suffix1 + 01;
			this1_addr_sfx := ' ';
			this_kind2	   := has_suffix1_removed;
			goto	insert_record;			

		elsif	segm2.addr_sfx > '0'
		and	work2_sfx  > '0'				then
			work2_sfx	   := ' ';
			ttl_suffix2	   := ttl_suffix2 + 01;
			this2_addr_sfx := ' ';
			this_kind2	   := has_suffix2_removed;
			goto	insert_record;			

		elsif	segm1.addr_sfx  > '0'	
		and	segm2.addr_sfx  > '0'
		and	work1_sfx = ' '
		and	work2_sfx = ' '				then
			work1_sfx	   := null;
			work2_sfx	   := null;
			ttl_suffix12   := ttl_suffix12 + 01;
			this1_addr_sfx := ' ';
			this2_addr_sfx := ' ';
			this_kind2	   := has_suffix12_removed;
			goto	insert_record;			
		end if;
	end if;

exception
	when abort_run then raise;

end	insert_intersection_record;

--	====================================================================================================

	procedure	DISPLAY_TRACE			is

begin

	dbms_output.put_line ( ' ' );

	dbms_output.put_line ( msg );

	if	msg_info1 is not null		then
		dbms_output.put_line ( '<1>	' || msg_info1 );
	end if;

	if	msg_info2 is not null		then
		dbms_output.put_line ( '<2>	' || msg_info2 );
	end if;

	if	msg_info3 is not null		then
		dbms_output.put_line ( '<3>	' || msg_info3 );
	end if;

	dbms_output.put_line ( ' ' );

	msg		:= null;
	msg_info1	:= null;
	msg_info2	:= null;
	msg_info3	:= null;

end	display_trace;

--	====================================================================================================

end	build_intersection;


--	====================================================================================================
/*	before fetch_spoke

--	begin insert_intersection_record
	segm	:= segm1;
	if	do_block > 0			then
		open	read_block;
		fetch	read_block	into blok1;
		close	read_block;
	end if;


--	before fetch_spoke
	if	ttl_record < do_trace		then
		dbms_output.put_line 
		(
			'this: '	|| this_name	  ||' '|| this_type 
		||	'       block: '	|| prev_block ||'/'|| this_block
		||	'       prefix '	|| prev_pfx	  ||'/'|| this_pfx
		||	'  '		|| prefix1#   ||'/'|| prefix2# ||'/'|| prefix3# ||'/'|| prefix4#
		||	'                 	spoke	'|| spoke#
		); 
	end if;
*/
--	====================================================================================================

