
--	===========================
--	current working version
--	obtained  Oct 1 2004
--	from user_source
--	===========================
	
	drop procedure			Compare_Names;
	create or replace procedure	Compare_Names			
 
( 
	pass_best_names	in out	varchar2,  
	pass_good_names	in out	varchar2,  
	pass_best_score	in out	number, 
	pass_good_score	in out	number  
) 
  
	as  
  
--	==================================================================  
  
	spec_prefix			binary_integer	:= 1;		--  scan names with same 1st letter  
	spec_differ			binary_integer	:= 2;		--  scan names differing by 1 consonant 
  
	spec_tolerance		binary_integer	:= 1;		--  scores w/in 1 of best score 
	spec_limit			binary_integer	:= 900;	--  highest acceptable score   
  
	array_limit			binary_integer	:= 200;	--  max bucket size  
  
	array_size			binary_integer;   
	idx				binary_integer;   
	ndx				binary_integer;   
	score				binary_integer;    
	best_score			binary_integer;   
	bucket_length		binary_integer; 
	errors			binary_integer;    
  
	user_name			varchar2(400);  
	show_name			varchar2(400);  
	name_prefix			varchar2(80); 
	compress_name		varchar2(80);   
  
--	==================================================================  
	type	bucket_entry	is record 
( 
		score			integer,  
		names			varchar2(800)   
);   
  
	type	bucket_table 	is table of bucket_entry   
		index by binary_integer;   
  
	bucket	bucket_table;  
  
--	==================================================================  
	cursor	read_street_names		is   
  
	select	--+	full (s)	cache (s)  
			distinct	  
			addr_name,    
			addr_reduced  
	from		garland.adrStreets	s  
  
	where		s.addr_name	like name_prefix  
	and		nvl (length (translate (s.addr_compress,  'x' || compress_name,  'x')), 0)  +   
			nvl (length (translate (  compress_name,  'x' || s.addr_compress,'x')), 0) <= spec_differ;  
	 
--	==================================================================  
begin   
  
	user_name	:= upper(pass_best_names); 
  
	if	pass_good_names like '$$%'			then 
		spec_prefix		:= substr(pass_good_names, 03, 01);   
		spec_differ		:= substr(pass_good_names, 04, 01);   
	end if;   
  
	if	pass_best_score < 0				then 
		spec_tolerance	:= abs(pass_best_score);   
	end if;   
  
	if	pass_good_score < 0				then 
		spec_limit		:= abs(pass_good_score);   
	end if;   
  
	name_prefix		:= rpad(user_name, spec_prefix) || '%';   
	compress_name	:= ADR_COMPRESS_NAME (user_name, '9');   
  
--	-----------------------------------------------------------------------------   
--	scan Street table for fuzzy name matches with acceptable scores  
  
	array_size	:= 0;   
  
for	look in read_street_names	loop 
  
	garland.ADR_COMPARE_NAME (user_name, look.addr_reduced, score, errors);  
  
	if	score > spec_limit	then  
		goto	end_loop; 
	end if;   
  
--	-----------------------------------------------------------------------------   
--	Array scores are stored in increasing size  
--	Should this score be added to the array ?   
--	Does this score already exist in the array ?   
  
	idx		:= 01;  
	show_name	:= rpad(look.addr_name, 20);  
	 
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
	exit when	bucket_length > array_limit;  
  
--	"best" names must have scores within a "tolerant" distance of the best score    
  
	if	bucket(x).score - best_score <= spec_tolerance		then   
		pass_best_score	:= bucket(x).score; 
		pass_best_names	:= pass_best_names || bucket(x).names;   
	else   
		pass_good_score	:= bucket(x).score; 
		pass_good_names	:= pass_good_names || bucket(x).names;   
	end if;   
  
end loop;  
  
--	------------------------------------------------------------------------------  
  
end; 
  
