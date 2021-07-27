	set echo	off;
--	oct 2 2003
--	==================================================================
--	fuzzy name match driver
--	==================================================================

--	sample user specification
--		good_names = $$01	means	prefix=0  differ=1 
--	==================================================================

	drop procedure			TST_Compare_Names;
	create or replace procedure	TST_Compare_Names			

--	drop procedure			Compare_Names;
--	create or replace procedure	Compare_Names			

(
	pass_best_names	in out	varchar2,
	pass_good_names	in out	varchar2,
	pass_best_score	in out	number,
	pass_good_score	in out	number
)

	as

--	==================================================================

	spec_prefix			binary_integer	:= 1;		--  scan names with same first letter
	spec_differ			binary_integer	:= 2;		--  scan names differing by 2 consonants
	spec_tolerance		binary_integer	:= 1;		--  scores w/in 1 of best score

	spec_street_limit		binary_integer	:= 250;	--  highest acceptable street score
	spec_alias_limit		binary_integer	:= 250;	--  highest acceptable alias score 

	spec_for_alias		varchar2(10)	:= '%$alias%'; --  alias table scan request
	spec_do_alias		varchar2(10)	:= null;	--  alias table scan trigger
	spec_alias_num		binary_integer	:= 888888;	--  alias_hi filter value

	array_limit			binary_integer	:= 200; 	--  max bucket size (10 namea)

	array_size			binary_integer;
	idx				binary_integer;
	ndx				binary_integer;
	score				binary_integer;
	best_score			binary_integer;
	bucket_length		binary_integer;
	errors			binary_integer;

	user_name			varchar2(2000);
	show_name			varchar2(2000);
	name_prefix			varchar2(80);
	compress_name		varchar2(80);

--	==================================================================
	type	bucket_entry	is record
(
		score			integer,
		names			varchar2(800)
);

	type	bucket_table 	is table of bucket_entry
		index by 		binary_integer;

	bucket	bucket_table;

--	==================================================================
	cursor	read_street_names		is

--	truncate table	plan_table		reuse storage;
--	explain plan set statement_id = 'fuzzy'   for

	select	flag, addr_name, addr_reduced, addr_compress
	from
(
	select	--+	full (s)	cache (s)
			's'	flag, 
			addr_name, 
			addr_reduced,
			addr_compress
	from		garland.adrStreets	s
	where		addr_compress like name_prefix

	union

	select	--+	full (a)	cache (a)
			'a'	flag, 
			addr_name, 
			alias_reduced		addr_reduced,
			alias_compress		addr_compress
	from		garland.adrAlias		a

	where		alias_compress like name_prefix
	and		alias_name > spec_do_alias 
	and		alias_hi   = spec_alias_num
)

	where		nvl (length (translate (addr_compress,  'x' || compress_name,  'x')), 0)  +
			nvl (length (translate (compress_name,  'x' || addr_compress,  'x')), 0) <= spec_differ
	;

--	select * from explain_plan;
	
--	==================================================================
begin

	user_name	:= upper(pass_best_names);

	if	pass_good_names like '$$%'			then		-- at beginning of field
		spec_prefix		:= substr(pass_good_names, 03, 01);
		spec_differ		:= substr(pass_good_names, 04, 01);
	end if;

	if	pass_good_names like spec_for_alias		then
		spec_do_alias := '.';
	end if;

	if	pass_best_score < 0				then
		spec_tolerance	:= abs(pass_best_score);
	end if;

	if	pass_good_score < 0				then
		spec_street_limit	:= abs(pass_good_score);
	end if;

	compress_name	:= ADR_COMPRESS_NAME (user_name, '6');
	name_prefix		:= rpad(compress_name, spec_prefix) || '%';

--	-----------------------------------------------------------------------------
--	scan Street table for fuzzy name matches with acceptable scores

	array_size	:= 0;

for	look in read_street_names		loop

	show_name := adr_compress_name (look.addr_reduced, 'D');

	garland.ADR_COMPARE_NAME (user_name, show_name, score, errors);		-- OCT 2004 (ADR_)

	if	look.flag = 's'
	and	score > spec_street_limit	then
		goto	end_loop;
	elsif	look.flag = 'a'
	and	score > spec_alias_limit	then
		goto	end_loop;
	end if;

--	-----------------------------------------------------------------------------
--	Array scores are stored in increasing size
--	Should this score be added to the array ?
--	Does this score already exist in the array ?

	show_name	:= rpad(look.addr_name, 20);
	
	idx	:= 01;
	while idx <= array_size		loop

		if	score < bucket(idx).score		then		--  better score at index
			exit;

		elsif	score = bucket(idx).score		then		--  existing score
			bucket(idx).names	:= bucket(idx).names || show_name;
			idx			:= null;
			exit;
		end if;

		idx	:= idx + 01;
	end loop;

--	-----------------------------------------------------------------------------
--	push down all buckets with higher scores to make room for better score

	if	idx is not null					then
		for	x in reverse idx..array_size		loop
			ndx		:= x + 01;
			bucket(ndx)	:= bucket(x);
		end loop;
	end if;

--	-----------------------------------------------------------------------------
--	revise bucket with better score & name

	if	idx > 0					then
		bucket(idx).score	:= score;
		bucket(idx).names	:= show_name;
		array_size		:= array_size + 01;
	end if;

<<end_loop>>
	null;
end loop;

--	-----------------------------------------------------------------------------
--	build best name & good name lists

	pass_best_names	:= null;
	pass_best_score	:= null;
	pass_good_names	:= null;
	pass_good_score	:= null;
	bucket_length	:= 0;

	if	array_size > 0		then
		best_score		:= bucket(1).score;
	end if;


for 	x in 1..array_size		loop

--	all names in array are "good" names; all array scores <= spec limit
	
	bucket_length := bucket_length + length(bucket(x).names);

	if	bucket_length <= array_limit					then
		pass_good_score		:= bucket(x).score;
		pass_good_names		:= pass_good_names || bucket(x).names;
	end if;

--	"best" names must have scores within a "tolerant" distance of the best score

	if	bucket(x).score - best_score <= spec_tolerance		then
		pass_best_score	:= bucket(x).score;
		pass_best_names	:= pass_best_names || bucket(x).names;
	end if;

end loop;

--	------------------------------------------------------------------------------

end;


--	------------------------------------------------------------------------------
/*

	dbms_output.put_line (	'compare1=' || compress_name ||' pfx='|| name_prefix ||' dif='|| spec_differ || 
					' do='|| spec_do_alias ||' num='||spec_alias_num);


	dbms_output.put_line (	'compare2=' || look.flag ||' '|| look.addr_compress ||' '|| look.addr_name ||
					' do='|| spec_do_alias ||' num='|| spec_alias_num);

	dbms_output.put_line (	'compare3=' || score ||' '|| spec_street_limit ||' '|| spec_alias_limit);

*/
--	------------------------------------------------------------------------------


