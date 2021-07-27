	set echo	on;
--	==================================================================
--	fuzzy name match driver
--	==================================================================

--	TASKS
--		Review Errors usage
--	==================================================================

	drop procedure			garland.Find_Fuzzy_Names;
	create or replace procedure	garland.Find_Fuzzy_Names	
(
	pass_best_names	in out	varchar2,		-- should be varchar2(1000)
	pass_good_names	in out	varchar2,		-- should be varchar2(1000)
	pass_best_score	in out	number,
	pass_good_score	in out	number
)
	As
--	==================================================================

	spec_prefix			binary_integer	:= 1;		--  near or far search
	spec_merge			binary_integer	:= 0;		--  merge all scores <= good score
	spec_differ			binary_integer	:= 2;		--  names differing by 2 consonants

	spec_good_score		binary_integer	:= 120;	--  preferred score
	spec_good_alias		binary_integer	:= 120;	--  preferred score
	spec_alias_num		binary_integer	:= 888888;	--  alias_hi filter value
	spec_score_limit		binary_integer	:= 250;	--  highest acceptable name  score
	spec_alias_limit		binary_integer	:= 250;	--  highest acceptable alias score 

	score				binary_integer;
	errors			binary_integer;
	best_score			binary_integer;
	good_score			binary_integer;
	array_size			binary_integer;
	idx				binary_integer;
	ndx				binary_integer;

	best_names			varchar2(1000);
	good_names			varchar2(1000);

	gis_name			varchar2(40);
	user_name			varchar2(40);
	prev_name			varchar2(40);
	compress_name		varchar2(40);

	name_prefix			varchar2(10);
	first_letter		varchar2(01);
	text				varchar2(80);

--	==================================================================
	type	bucket_entry	is record
(
		score			integer,
		names			varchar2(800)
);

	type	bucket_table 	is table of bucket_entry
		index by 		binary_integer;

	BUCKET	bucket_table;

--	==================================================================
	cursor	Read_Street_Names		is

--	truncate table	plan_table		reuse storage;
--	explain plan set statement_id = 'fuzzy'   for

	select	addr_name, flag, addr_reduced, addr_compress
	from
(
	select	addr_name, 
			's'	flag, 
			addr_reduced,
			addr_compress
	from		garland.adrStreets
	where		addr_reduced between name_prefix and name_prefix || 'z'

	union all

	select	addr_name, 
			'a'	flag, 
			alias_reduced		addr_reduced,
			alias_compress		addr_compress
	from		garland.adrAlias	
	where		alias_reduced between name_prefix and name_prefix || 'z'
	and		alias_hi   = spec_alias_num
)
	where		nvl (length (translate (addr_compress,  'x' || compress_name,  'x')), 0)  +
			nvl (length (translate (compress_name,  'x' || addr_compress,  'x')), 0) <= spec_differ
	order by	1;

--	select * from explain_plan;
	
--	==================================================================
begin

	user_name := upper(pass_best_names);

	if	pass_best_score < 0		then
		spec_prefix		:= 0;			-- search all street names ("far")
		if	pass_best_score < -1	then
			spec_merge	:= 1;			-- gather all scores <= good score
		end if;
	end if;

	if	pass_good_score < 0		then
		spec_good_score	:= - pass_good_score;
	end if;

--	-----------------------------------------------------------------------------

	first_letter := rpad(user_name, 01);

	if	spec_prefix = 1			then
		name_prefix	:= first_letter;
	else
		name_prefix := null;
	end if;

	user_name		:= ADR_COMPRESS_NAME (user_name, 'D');	-- remove doubles but see orphans (via spacing)
	compress_name	:= ADR_COMPRESS_NAME (user_name, '6');

--	-----------------------------------------------------------------------------
--	scan Street table for fuzzy name matches with acceptable scores

	array_size	:= 0;

for	look in read_street_names		loop

	if	look.addr_name = prev_name	then
		goto	end_loop;
	else
		prev_name := look.addr_name;
	end if;

	gis_name := look.addr_name;

	garland.TST_COMPARE_NAME (user_name, gis_name, score, errors);	-- score single name pair

--	cast a wide net to begin with (high scores)
--	but once a good score is found, do not consider anything worse

	if (	look.flag = 's'  and  score > spec_score_limit	)
	or (	look.flag = 'a'  and  score > spec_alias_limit  )	then
		goto	end_loop;
	end if;

--	-----------------------------------------------------------------------------
--	Array scores are stored in increasing size
--	Should this score be added to the array ?
--	Does this score already exist in the array ?

	if	gis_name like first_letter || '%'	then
		text	:= ' ';							--  near name
	else
		text	:= '+';							--  far name
	end if;
	gis_name	:= rpad(gis_name,20) || text;
	
	idx	:= 01;
	while idx <= array_size		loop

		if	score < bucket(idx).score	then			--  push better score above existing score
			exit;

		elsif	score = bucket(idx).score	then			--  more names for existing score
			bucket(idx).names	:= bucket(idx).names || gis_name;
			idx			:= null;
			exit;
		end if;

		idx	:= idx + 01;						-- append high score to bottom
	end loop;

--	-----------------------------------------------------------------------------
--	push down all buckets with higher scores to make room for better score
--	if appending a higher score then no push-down will take place (idx > array_size)

	if	idx > 0						then
		for	x in reverse idx..array_size		loop
			ndx		:= x + 01;
			bucket(ndx)	:= bucket(x);
		end loop;
	end if;

--	-----------------------------------------------------------------------------
--	revise bucket with better score & name
--	append new bucket with higher score 
--	either case will entail a positive idx

	if	idx > 0					then
		bucket(idx).score	:= score;
		bucket(idx).names	:= gis_name;
		array_size		:= array_size + 01;
	end if;

--	-----------------------------------------------------------------------------

	if	look.flag = 's'	
	and	score <= spec_good_score		then
		spec_score_limit	:= spec_good_score;
		spec_alias_limit	:= spec_good_alias;
	end if;

<<end_loop>>
	null;
end loop;

--	-----------------------------------------------------------------------------
--	build best & good name lists

	if	array_size > 0					then
		best_score	:= bucket(1).score;
		best_names	:= bucket(1).names;
	end if;

	if	array_size > 1
	and	bucket(2).score <= spec_good_score		then
		good_score	:= bucket(2).score;
		good_names	:= bucket(2).names;
		if	spec_merge = 0				then
			array_size	:= null;
		end if;
	else
		array_size		:= null;
	end if;

	idx := 3;

	while	idx <= array_size
	and	bucket(idx).score <= spec_good_score	loop
		good_score	:= bucket(idx).score;
		good_names	:= good_names || bucket(idx).names;
		idx		:= idx + 01;
	end loop;

--	------------------------------------------------------------------------------
--	return final results

	pass_best_names	:= best_names;
	pass_good_names	:= good_names;
	pass_best_score	:= best_score;
	pass_good_score	:= good_score;

	return;
end;

--	------------------------------------------------------------------------------
/*
	dbms_output.put_line (	'compare1=' || compress_name ||' pfx='|| name_prefix ||' dif='|| spec_differ || 
					' do='|| spec_do_alias ||' num='||spec_alias_num);

	dbms_output.put_line (	'compare2=' || look.flag ||' '|| look.addr_compress ||' '|| look.addr_name ||
					' do='|| spec_do_alias ||' num='|| spec_alias_num);

	dbms_output.put_line (	'compare3=' || score ||' '|| spec_score_limit ||' '|| spec_alias_limit);
*/
--	------------------------------------------------------------------------------
