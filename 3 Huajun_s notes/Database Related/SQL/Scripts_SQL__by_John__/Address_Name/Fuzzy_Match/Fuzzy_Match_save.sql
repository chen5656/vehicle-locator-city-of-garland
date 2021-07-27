	set echo	off;
--	===========================================================
--	Measure the difference in spelling of two names
--	===========================================================

--	weight	logjam
--	wrong		elsif		(to account for null letter)	
--	===========================================================

	create or replace	procedure	Fuzzy_Match

--	create or replace	procedure 	Fuzzy_Match_Test

(
	pass_name1		in 		varchar2,		--	invalid name
	pass_name2		in 		varchar2,		--	valid name  	
	pass_score		in out	number,		--	error weight
	pass_errors		in out	number		--	error count	
)
As

	Test_Run	binary_integer := 0;	--	01=errors	02=errors & letters      

--	===========================================================

	weight_wrong		binary_integer	:= 60;		--	wrong letter			
	weight_extra		binary_integer	:= 60;		--	extra letter
	weight_missing		binary_integer	:= 60;		--	missing letter
	weight_transpose		binary_integer	:= 60;		--	adjacent transpose	
	weight_misplace		binary_integer	:= 20;		--	misplaced letter
	weight_transplace		binary_integer	:= 20;		--	disjoint transpose 	

	weight_orphan		binary_integer	:= 60;		--	left over letters
	weight_dipthong		binary_integer	:= 10;		--	vowel dipthong
	weight_ending		binary_integer	:= 10;		--	mismatch ending e or s
 
	orphan_trigger		binary_integer	:= 60;		--	prior score limit

	factor_vowel		binary_integer	:= 1.00;		--	mis-matched vowel  factor
	factor_vowels		binary_integer	:= 0.50;		--	mis-matched vowels factor

--	===========================================================

 	error_wrong				binary_integer	:= 10;	--	may 2004
 	error_transpose			binary_integer	:= 20;
 	error_transplace			binary_integer	:= 25;
 	error_extra				binary_integer	:= 30;
 	error_extra_misplace		binary_integer	:= 35;
 	error_missing			binary_integer	:= 40;
 	error_missing_misplace		binary_integer	:= 45;

--	===========================================================
--	Error Examples		  1				  2

--	Wrong				waknut			walnut		
--	Missing			wanut				walnut			
--	Missing Misplace		wanult			walnut
--	Extra				walanut			walnut
--	Extra  Misplace		waltnu			walnut
--	Transpose			wanlut			walnut		
--	Transplace			jutiper			jupiter		
--	Orphan			crest				crestwood	  (does expand)
--	Orphan			lake ray hubbard		lake hubbard  (does NOT shrink)
--	===========================================================

	removals		varchar2(32)	:= 'x$()-.,"''';		-- may 2004 (keep spaces)
	blanked		char(32)		:= 'x';

--	===========================================================

	type	step_info	is record
(
	here1			char		:= ' ',
	here2			char		:= ' ',
	next1			char		:= ' ',
	next2			char		:= ' ',
	extra1		char,
	extra2		char,
	wrong1		char,
	wrong2		char,

	error			binary_integer	:= 0,
	was_weight		binary_integer	:= 0,
	was_vowel1		binary_integer	:= 0,
	was_vowel2		binary_integer	:= 0,
	is_vowel1		binary_integer	:= 0,
	is_vowel2		binary_integer	:= 0
);

	have			step_info;
	had			step_info;
	hold			step_info;

--	===============================================================

	name1			varchar2(400);
	name2			varchar2(400);

	score			binary_integer	:= 0;
	errors		binary_integer	:= 0;

	finish		binary_integer	:= 0;
	loops			binary_integer	:= 0;

	series		binary_integer	:= 01;
	step			binary_integer	:= 0;

	vector		binary_integer	:= 0;
	revector		binary_integer	:= 0;

	weight		binary_integer	:= 0;
	factor		binary_integer	:= 1;

	orphan_length	binary_integer	:= 0;
	orphan_score	binary_integer	:= 0;			

	name1_length	binary_integer;
	name2_length	binary_integer;

	front1		binary_integer;
	front2		binary_integer;
	back1			binary_integer;
	back2			binary_integer;

	here1x		binary_integer;
	here2x		binary_integer;
	next1x		binary_integer;
	next2x		binary_integer;

	follow1		binary_integer;
	follow2		binary_integer;
	conflict		binary_integer	:= 0;			--  may 2004

	is_vowels		binary_integer;
	was_vowels		binary_integer;
	vowel_product	binary_integer;

	is_looping		binary_integer		:= 111111;

--	----------------------------------------------------------

	do_test		binary_integer		:= 0;
	do_trace		binary_integer		:= 0;

	show1			varchar2(01);
	show2			varchar2(01);
	show3			varchar2(01);
	show4			varchar2(01);

--	===========================================================

begin

--	===========================================================
--	set job parameters

	if	pass_errors = -100		then
		do_trace := 01;
	end if;

--	===========================================================
--	initialize

	name1		:= upper (pass_name1);
	name2		:= upper (pass_name2);

	name1		:= replace (name1, 'CK', 'K');					
	name2		:= replace (name2, 'CK', 'K');

	name1		:= translate (name1, removals, blanked);		-- may 2004
	name2		:= translate (name2, removals, blanked);

	name1_length := length (name1);
	name2_length := length (name2);

	name1		:= name1 || '  ';
	name2		:= name2 || '  ';

	front1	:= 01;
	front2	:= 01;
	back1		:= name1_length;
	back2		:= name2_length;
	here1x	:= back1;
	here2x	:= back2;	
	vector	:= -1;

--	===========================================================

loop

	step	 	 := step + 01;		
	factor	 := 1;

	have.here1	:= substr (name1, here1x, 01);
	have.here2	:= substr (name2, here2x, 01);

	next1x 	:= here1x + vector;
	next2x 	:= here2x + vector;

	<<get_next1>>							-- may 2004
	have.next1	:= substr (name1, next1x, 01);
--	if	have.next1	 = have.here1			then
--		next1x	:= next1x + vector;
--		goto	get_next1;
--	end if;

	<<get_next2>>							-- may 2004
	have.next2	:= substr (name2, next2x, 01);
--	if	have.next2	 = have.here2			then
--		next2x	:= next2x + vector;
--		goto	get_next2;
--	end if;

	if	here1x not between front1 and back1		then
		have.here1 := null;
		have.next1 := null;
	elsif	next1x not between front1 and back1		then
		have.next1 := null;
	end if;

	if	here2x not between front2 and back2		then	-- may 2004
		have.here2 := null;
		have.next2 := null;
	elsif	next2x not between front2 and back2		then
		have.next2 := null;
	end if;

	if	have.here1 in ( 'A','E','I','O','U','Y' )	then
		have.is_vowel1 := 1;
	else
		have.is_vowel1 := 0;
	end if;

	if	have.here2 in ( 'A','E','I','O','U','Y' )	then
		have.is_vowel2 := 1;
	else
		have.is_vowel2 := 0;
	end if;

	is_vowels		:= have.is_vowel1  + have.is_vowel2;
	was_vowels		:= have.was_vowel1 + have.was_vowel2;
	vowel_product	:= was_vowels * is_vowels;


	if	test_run > 01	then
	null;
	DBMS_output.put_line('compare:     '||to_char(vector,'s9')||'    '|| nvl(have.here1,'*')||' - '||nvl(have.here2,'*')||'     '||here1x||' - '||here2x);
	end if;

--	===========================================================
--	display trace

/*

if	do_trace > 0		then

	if	have.was_vowel1 = 1 then show1 := 'v'; else show1 := '_';	end if;
	if	have.is_vowel1  = 1 then show2 := 'v'; else show2 := '_';	end if;
	if	have.was_vowel2 = 1 then show3 := 'v'; else show3 := '_';	end if;
	if	have.is_vowel2  = 1 then show4 := 'v'; else show4 := '_';	end if;

	dbms_output.put_line ( 'name    ' || name1  || '  /  '|| name2 );

	if	have.was_vowel1 = 1 then show1 := 'v'; else show1 := '_';	end if;
	if	have.is_vowel1  = 1 then show2 := 'v'; else show2 := '_';	end if;
	if	have.was_vowel2 = 1 then show3 := 'v'; else show3 := '_';	end if;
	if	have.is_vowel2  = 1 then show4 := 'v'; else show4 := '_';	end if;
	dbms_output.put_line ( 'have    '  
				 || show1 ||' '|| show2 
			||' '  || have.here1 ||' '||have.next1  
			||'  ' || show3 ||' '|| show4 
			||' '  || have.here2 ||' '||have.next2  
			||'		was is here next - was is here next ' );

	if	had.was_vowel1 = 1 then show1 := 'v'; else show1 := '_';	end if;
	if	had.is_vowel1  = 1 then show2 := 'v'; else show2 := '_';	end if;
	if	had.was_vowel2 = 1 then show3 := 'v'; else show3 := '_';	end if;
	if	had.is_vowel2  = 1 then show4 := 'v'; else show4 := '_';	end if;
	dbms_output.put_line ( 'had     '  
				 || show1 ||' '|| show2 
			||' '  || had.here1 ||' '||had.next1  
			||'  ' || show3 ||' '|| show4 
			||' '  || had.here2 ||' '||had.next2  
			||'		was is here next - was is here next ' );

	dbms_output.put_line ( 'posn    ' 
				   || here1x ||' '|| next1x ||' / '|| here2x ||' '|| next2x
			||'				here  next - here  next '	);
end if;

*/
--	===========================================================

	if	finish > 0					then							
		goto	process_orphan;

	elsif	revector  > 0				then
		revector := 0;
		goto	process_error;
	end if;

--	===========================================================
--	matching letters

	have.error	:= 0;
	weight	:= 0;

	if	have.here1 = have.here2			then	
		conflict	:= 0;					--  may 2004
		here1x 	:= next1x;
		here2x 	:= next2x;

		if	have.here1 = have.next1		then	--  may 2004
			here1x:= next1x + vector;
		end if;

		if	have.here2 = have.next2		then
			here2x:= next2x + vector;
		end if;

		goto	post_process;
	end if;

--	===========================================================
--	diagnose error	

	if	have.here1  = have.next2  		then
		follow1	:= next1x;		
		follow2	:= next2x + 01;
		if	have.here2 <> have.next2	then	
			have.error	:= error_missing;	
		end if;

	elsif	have.next1  = have.here2  		then
		follow1	:= next1x + 01;		
		follow2	:= next2x;
		if	have.here1 <> have.next1	then	
			have.error	:= error_extra;	
		end if;

	elsif	have.here1  = have.next2  		
	and	have.next1  = have.here2  		then
 		follow1	:= next1x + 01;		
		follow2	:= next2x + 01;		
		have.error	:= error_transpose;

	elsif	have.here1	<> have.here2		then			-- may 2004
		follow1	:= next1x;		
		follow2	:= next2x;
		have.error	:= error_wrong;
	end if;

--	===========================================================
--	transplace error (separated transpose)

	if	have.error = error_wrong			then		--  may 2004
		if  	have.here1   = have.wrong2
		and	have.here2   = have.wrong1 		then
			have.error  := error_transplace;							
		else													
			have.wrong1 := have.here1;
			have.wrong2 := have.here2;
		end if;

	elsif	have.error  = error_extra			
	and	have.here1  = have.extra2			then
		have.error := error_extra_misplace;

	elsif	have.error  = error_missing			
	and	have.here2  = have.extra1			then
		have.error := error_missing_misplace;

	end if;

--	===========================================================
--	decide whether to continue or revector 		--  may 2004

	if	substr(name1, follow1, 01) <> substr(name2, follow2, 01)	then
		conflict := conflict + 01;
	end if;

	if	test_run > 0	then
	null;
	DBMS_output.put_line( 'error:       '|| have.error   	||'    '|| follow1 ||' - '|| follow2
							 || '     ' || series ||' / '|| conflict );
	end if;


	if 	series   = 01
	or	conflict = 01 					then
		revector := 01;
		goto	post_process;
	else
		conflict := 0;
	end if;

--	------------------------------
	<<process_error>>
--	------------------------------

--	wrong letter

	weight := 0;							--  may 2004

	if	have.error = error_wrong			then
		here1x	:= next1x;
		here2x	:= next2x;
		weight	:= weight_wrong;				--  may 2004		
		if	is_vowels = 02				then
			weight := weight * factor_vowels;
		end if;

--	===========================================================
--	extra or missing letter 				

	elsif	have.error   = error_extra			then						
		have.extra1 := have.here1;
		here1x  	:= next1x;
		weight	:= weight_extra;				--  may 2004

	elsif	have.error   = error_missing			then						
		have.extra2 := have.here2;
		here2x	:= next2x;
		weight	:= weight_missing;			--  may 2004

--	===========================================================
--	misplaced extra or missing letter

	elsif	have.error = error_extra_misplace		then	
		have.extra2 := null;
		here1x  	:= next1x;
		weight   	:= weight_misplace;			--  may 2004

	elsif	have.error = error_missing_misplace		then	
		have.extra1 := null;
		here2x	:= next2x;
		weight   	:= weight_misplace;			--  may 2004

--	===========================================================
--	adjacent transposed letters					

	elsif	have.error = error_transpose			then					
		here1x  	:= next1x + vector;
		here2x  	:= next2x + vector;
		weight   	:= weight_transpose;

--	===========================================================
--	separated transposed letters (transplace)

	elsif	have.error = error_transplace			then
		have.wrong1	:= null;					--  may 2004
		have.wrong2	:= null;
		here1x  	:= next1x;
		here2x  	:= next2x;
		weight	:= weight_transplace;
	end if;


	if	test_run > 0	then
	null;
	DBMS_output.put_line('wrong.extra: ' || have.error||'    '||nvl(have.wrong1,' ')||' - '||nvl(have.wrong2,' ')||'     '||nvl(have.extra1,' ')||' - '||nvl(have.extra2,' '));
	DBMS_output.put_line( 'weight:      '|| have.error   ||'    '|| weight );
	end if;

--	------------------------------
	<<process_vowels>> 
--	------------------------------

	if	vowel_product = 02				then
		if	was_vowels = 02				then
			weight := weight_dipthong;
		else
			weight := weight - have.was_weight + weight_dipthong;
		end if;
	end if;

	if	weight > 0						
	and	is_vowels = 2					then	
		if	was_vowels = 2				then
			factor := 0;				--	reAd/reId	reAd/foUr
		else
			factor := factor_vowels;		--	rEad/rEid	mEd/rUg
		end if;
	end if;

	if	series * step = 1					then		-- may 2004
		if	(have.error = error_extra    and have.here1 in ('E', 'S') )
		or	(have.error = error_missing  and have.here2 in ('E', 'S') )	then
			 weight := weight_ending;
		end if;
	end if;


--	===========================================================
--	update score & error count

	weight := round (factor * weight);			-- factor might be zero
	score	 := score + weight;

	if	weight > 0						then
		errors := errors + 01;
	end if;


	if	test_run > 0	then
	null;
	DBMS_output.put_line( 'score:        ' || factor ||'  = '|| weight || ' = ' || score);
	end if;

--	------------------------------
	<<post_process>>
--	------------------------------

	if	vector =  +1					then
		front1 := here1x;
		front2 := here2x;
	else
		back1  := here1x;
		back2  := here2x;
	end if;

--	===========================================================
--	detect finish & orphan

	orphan_length := 0;

	if	front1 > back1 					then			--  may 2004
		finish	  := finish + 01;
		orphan_length := back2 - front2 + 01;	
	end if;

	if	front2 > back2 					then			--  may 2004
		finish	  := finish + 02;
		orphan_length := back1 - front1 + 01;
	end if;

	if	finish = 0						then
		goto	end_of_step;

	elsif	orphan_length in (01, 02)			then						
		revector := 0;
		goto	end_of_step;
	end if;

--	------------------------------
	<<process_orphan>>
--	------------------------------

--	if orphan is a double letter, then treat it as a single letter

	if	orphan_length = 2								then
		if (	finish = 1  and  have.here2 = have.next2 )
		or (	finish = 2  and  have.here1 = have.next1 )		then
			orphan_length := orphan_length - 1;						-- may 2004
		end if;
	end if;

--	if orphan is 1 letter and it matches an extra letter, then it is misplaced
--	if orphan is 1 vowel  and it is next to a vowel, then it is a vowels error

	if	orphan_length = 1								then
		if	(finish = 1  and  have.here2 in (have.extra1, had.extra1))
		or	(finish = 2  and  have.here1 in (have.extra2, had.extra2))		
		then
			 weight_orphan := weight_misplace;

		elsif	(finish * have.is_vowel2 = 1  and  have.was_vowel2 + had.was_vowel2 >= 1)
		or  	(finish * have.is_vowel1 = 2  and  have.was_vowel1 + had.was_vowel1 >= 1)	
		then
			 weight_orphan := factor_vowels * weight_orphan;	
		end if;
	end if;


--	if no orphans exist, then check for misplaced or transplaced letters (front vs back) 
	if	orphan_length = 0								then
		if	have.extra1 = had.extra2		
		or	have.extra2 = had.extra1					then
			score := score - weight_wrong +  weight_misplace;

	if	test_run > 0	then
	null;
	DBMS_output.put_line( 'misplace:     -'|| weight_wrong ||' + '||weight_misplace ||' = '|| score );
	end if;


		elsif	have.wrong1 = had.wrong2
		and	have.wrong2 = had.wrong1					then
			score := score - weight_wrong + weight_transplace;

	if	test_run > 0	then
	null;
	DBMS_output.put_line( 'transplace:  '|| weight_transplace ||'  - '||weight_wrong ||' = '|| score );
	end if;

		end if;
	end if;

--	test for separate orphan word 
	if	finish in (1,2)
	and	orphan_length  > 02		
--	and	score <= orphan_trigger
	and	' ' in (have.here1, have.here2, have.next1, have.next2)	then
		orphan_length := 01;
	end if;


	orphan_score := orphan_length * weight_orphan;			
	if	orphan_score > 0								then
		score	 := score  + orphan_score;
		errors := errors + 01;	
	end if;


	if	test_run > 0	then
	null;
	DBMS_output.put_line('orphan:       '||orphan_length||'  x '||weight_orphan||' = '|| orphan_score||'        '||finish);
	end if;

	finish := 9;

--	------------------------------
	<<end_of_step>>
--	------------------------------

--	===========================================================
--	display trace

/*

if	do_trace > 0		then

	dbms_output.put_line ( 'posn    ' 
				 || here1x ||' '|| next1x ||' / '|| here2x ||' '|| next2x
			||'				here  next - here  next'	);

	dbms_output.put_line ( 'ends    ' 
				 || front1 ||' '|| back1  ||' / '|| front2 ||' '|| back2 
		 	||'				front back - front back '	);

	dbms_output.put_line ( 'wrong   '  
				 || nvl(have.wrong1,'_') ||' '|| nvl(have.wrong2,'_') 
			||'  ' || nvl(have.extra1,'_') ||' '|| nvl(have.extra2,'_')
			||'    '
			||'  ' || nvl(had.wrong1,'_')  ||' '|| nvl(had.wrong2,'_')
			||' '  || nvl(had.extra1,'_')  ||' '|| nvl(had.extra2,'_')
			||'		wrong12 extra12 / wrong12 extra12'	);

	dbms_output.put_line ( 'step    '  
				 || series ||' '|| step 
			||' '  || to_char (vector, 's9') ||' '  || revector 
			||'				series step  vector revector' );

	if	finish > 0				then
	dbms_output.put_line ( 'orphan '  
				|| to_char (orphan_score,	'099')   
			||' ' || to_char (weight_orphan,	'099')   
			||' ' || to_char (orphan_length,	'99' )  	
			||'			score  weight length' );
	end if;


	dbms_output.put_line ( 'error  '
				 || to_char (have.error,	'099') 
			||'				error ' );

	dbms_output.put_line ( 'weight '
				|| to_char (weight, 		'099' )	
			||' ' || to_char (factor,		'0.99')
			||'				weight factor ' 	);	

	dbms_output.put_line ( 'score  ' 
				 || to_char (score,		's099') 
			||' '  || to_char (errors,		'099')
			||'   '|| finish 
			||'			score  errors finish'	);	

	if	do_test > 0			then
		dbms_output.put_line ( 'test   ' || '');
	end if;

	dbms_output.put_line ( ' ');
end if;

*/
--	====================================================================
--	revector scanning direction

	if	revector = 0						then
		have.was_weight := weight;

		if	have.error between 110 and 119		then
			have.was_vowel1	:= have.is_vowel1;		
			
		elsif	have.error between 120 and 129		then
			have.was_vowel2	:= have.is_vowel2;		

		elsif	have.error = error_transpose			then		--	???
			have.was_vowel1	:= null;
			have.was_vowel2	:= null;
		else
			have.was_vowel1	:= have.is_vowel1;		
			have.was_vowel2	:= have.is_vowel2;
		end if;
	end if;

	if	revector > 0			then
		hold	:= have;						
		have	:= had;
		had	:= hold;

		if	vector =  +1		then
			vector := -1;
			here1x := back1;
			here2x := back2;
		else
			vector := +1;
			here1x := front1;
			here2x := front2;
		end if;	

		series	:= series + 01;	
		step		:= 0;	
		revector	:= 0;			--  may 2004	
	end if;

--	===========================================================
--	exit tests

	exit when	finish > 2;								

	loops := loops + 01; if loops > 100 then score := is_looping; return; end if;

end loop;

--	===========================================================
--	pass back the final score = cumulative difference
--	pass back the number of errors encountered
--	===========================================================

	pass_score	:= score;				
	pass_errors	:= errors;

end;



/*
--	===========================================================

--	===========================================================
*/


