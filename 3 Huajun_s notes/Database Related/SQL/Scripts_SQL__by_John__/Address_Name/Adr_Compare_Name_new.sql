	set echo on;
--	==================================================================
--	measure the difference in spelling of two names
--	==================================================================

--	testing
--		vowel processing		revise
--		final s			look for 's ' in pass name
--		final e			look for 'e ' in pass name
--		revector			0,1,2

--		wunlat/walnut		transpose + unequal = stop = new wrong = no transplace
--		cavlere/cavalier		a / final e / ie
--		cablier/chablis		h & s / ie

--	to do 
--		orphan			use had.weight

--		show				text

--		scan				full adrstreet
--		rating			see doc
--		trace				
--		document 			

--	=============================================================================

	create or replace	procedure	ADR_compare_name

--	create or replace	procedure 	TST_compare_name

(
	pass_name1		in 		varchar2,		--	invalid name
	pass_name2		in 		varchar2,		--	valid name  	
	pass_score		in out	number,		--	error weight
	pass_errors		in out	number		--	error count	
)
as

--	===============================================================

	base_weight			number	:= 100;		--	standard error weight

	weight_wrong		number	:= base_weight;	--	wrong letter			
	weight_transpose		number	:= 60;		--	adjacent  transpose	
	weight_transplace		number	:= 20;		--	separated transpose 	
	weight_misplace		number	:= 00;		--	misplaced letter
	weight_dipthong		number	:= 10;		--	vowel dipthong
	weight_ending		number	:= 10;		--	mismatch ending e or s
	weight_orphan		number	:= 100;		--	remaining letters

	factor_vowel		number	:= 1.00;		--	mis-matched vowel
	factor_vowels		number	:= 0.50;		--	mis-matched vowels
 
--	===============================================================

	error_stop				number	:= 100;
 	error_mistake			number	:= 104;
 	error_transplace			number	:= 108;

 	error_extra				number	:= 110;
 	error_extra_misplace		number	:= 115;
 	error_missing			number	:= 120;
 	error_missing_misplace		number	:= 125;

 	error_transpose			number	:= 130;

	orphan_trigger			binary_integer	:= 50;			-- jan 2004

--	===============================================================

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

	error			number	:= 0,
	stops			number	:= 0,
	was_weight		number	:= 0,
	was_vowel1		number	:= 0,
	was_vowel2		number	:= 0,
	is_vowel1		number	:= 0,
	is_vowel2		number	:= 0
);

	have			step_info;
	had			step_info;
	hold			step_info;

--	===============================================================

	score			number	:= 0;
	errors		number	:= 0;

	finish		number	:= 0;
	loops			number	:= 0;

	series		number	:= 0;
	step			number	:= 0;
	vector		number	:= 0;
	revector		number	:= 0;

	weight		number;
	factor		number;

	orphan_score	number;			
	orphan_length	number;

	front1		number;
	front2		number;
	back1			number;
	back2			number;

	back1_adjust	number;
	back2_adjust	number;

	adjust1		number;
	adjust2		number;

	here1x		number;
	here2x		number;
	next1x		number;
	next2x		number;

	is_vowels		number;
	was_vowels		number;
	vowel_product	number;

	name1_length	number;
	name2_length	number;

	name			varchar2(400);
	name1			varchar2(400);
	name2			varchar2(400);

	is_looping		number		:= 111111;
	removals		varchar2(32)	:= 'x $()-.,"''';

--	------------------------------------------------------------------

	do_test		number		:= 0;
	do_trace		number		:= 0;

	show1			varchar2(01);
	show2			varchar2(01);
	show3			varchar2(01);
	show4			varchar2(01);

--	==================================================================

begin

--	==============================================
--	set job parameters

	if	pass_errors = -100		then
		do_trace := 01;
	end if;

--	==============================================
--	initialize

	name1		:= upper (pass_name1);
	name2		:= upper (pass_name2);

	name1		:= replace (name1, 'CK', 'K');					
	name2		:= replace (name2, 'CK', 'K');

	name1		:= translate (name1, removals, 'x');
	name2		:= translate (name2, removals, 'x');

	name1_length := length (name1);
	name2_length := length (name2);

	name1		:= name1 || '  ';
	name2		:= name2 || '  ';

	front1	:= 01;
	front2	:= 01;
	back1		:= name1_length;
	back2		:= name2_length;
	here1x	:= back1;						--	new
	here2x	:= back2;	
	vector	:= -1;

--	===========================================================

loop

	step	 	 := step + 01;		
	factor	 := 1;
	back1_adjust := 0;
	back2_adjust := 0;

--	------------------------------
	<<get_letters>> 
--	------------------------------

	next1x 	:= here1x + vector;
	next2x 	:= here2x + vector;

	have.here1	:= substr (name1, here1x, 01);
	have.here2	:= substr (name2, here2x, 01);
	have.next1	:= substr (name1, next1x, 01);
	have.next2	:= substr (name2, next2x, 01);

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

	is_vowels	  := have.is_vowel1  + have.is_vowel2;
	was_vowels	  := have.was_vowel1 + have.was_vowel2;
	vowel_product := was_vowels * is_vowels;


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

--	==============================================
--	double letter

	if	have.here1 = have.next1			then
		here1x  := next1x;
		adjust1 := 1;
	else
		adjust1 := 0;
	end if; 

	if	have.here2 = have.next2			then
		here2x  := next2x;
		adjust2 := 1;
	else
		adjust2 := 0;
	end if;

	if	vector = -1					then
		back1_adjust := back1_adjust + adjust1;
		back2_adjust := back2_adjust + adjust2;
	end if;

	if	adjust1 + adjust2 > 0			then
		goto	get_letters;
	end if;


--	==============================================
--	match letters

	if	have.here1 = have.here2			then	
		have.error	:= 000;							
		weight	:= 0;									
		here1x 	:= next1x;
		here2x 	:= next2x;
		goto	post_process;
--		goto	process_vowels;							--	new
	end if;

--	==============================================
--	diagnose error

	have.error := 100;

	if	have.here2  = have.next1  			then
		have.error := have.error + 10;
	end if;

	if	have.here1  = have.next2  			then
		have.error := have.error + 20;
	end if;

--	==============================================

	if	have.error  = error_stop				
	and	have.next1  = have.next2			then
		have.error := error_mistake;	
	end if;

	if	have.error <= error_mistake			then				
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
	and	have.extra1 = have.here2			then
		have.error := error_missing_misplace;

	elsif	have.error = error_transpose					
	and	substr (name1, next1x + vector, 01) <> substr (name2, next2x + vector, 01)	then
		have.error := error_stop;
	end if;

--	===========================================================
--	decide whether to continue or revector 

	if	have.error  = error_stop				then
		have.stops := have.stops + 01;
	else
		have.stops := 0;
	end if;

	if  (	series = 00 and	have.error < 200		)		--	initial  backward scan
	or  (	series = 01	and 	have.stops >  had.stops ) 		--	initial  forward  scan
	or  (	series = 02	and	have.stops >= had.stops )		--	continue backward scan at error
	or  (	series = 03	and 	have.stops >  had.stops ) 	then	--	continue forward  scan at error
		revector := 01;
		goto	post_process;
	end if;

--	------------------------------
	<<process_error>>
--	------------------------------

--	wrong letter

	weight := weight_wrong;

	if	have.error <= error_mistake			then
		here1x	:= next1x;
		here2x	:= next2x;

--	==============================================
--	extra or missing letter 				

	elsif	have.error   = error_extra			then						
		here1x  	:= next1x;
		have.extra1 := have.here1;

	elsif	have.error   = error_missing			then						
		here2x	:= next2x;
		have.extra2 := have.here2;

--	==============================================
--	misplaced extra or missing letter

	elsif	have.error = error_extra_misplace		then	
		here1x  	:= next1x;
		weight   	:= weight_misplace;
		have.extra2 := null;

	elsif	have.error = error_missing_misplace		then	
		here2x	:= next2x;
		weight   	:= weight_misplace;
		have.extra1 := null;

--	==============================================
--	adjacent transposed letters					

	elsif	have.error = error_transpose			then					
		here1x  	:= next1x + vector;
		here2x  	:= next2x + vector;
		weight   	:= weight_transpose;

--	==============================================
--	separated transposed letters (transplace)

	elsif	have.error = error_transplace			then
		here1x  	:= next1x;
		here2x  	:= next2x;
		weight	:= weight_transplace;
	end if;

--	==============================================

	if	have.error = error_transplace			then			
		have.wrong1	:= null;
		have.wrong2	:= null;
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

	if	series + step = 1					then
		if	(have.error = error_extra    and have.here1 in ('E', 'S') )
		or	(have.error = error_missing  and have.here2 in ('E', 'S') )	then
			 weight := weight_ending;
		end if;
	end if;

--	==============================================
--	update score & error count

	weight := round (factor * weight);			
	score	 := score + weight;

	if	weight > 0						then
		errors := errors + 01;
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

--	==============================================
--	detect finish & orphan

	orphan_length	:= 0;

	if	front1 > back1 + back1_adjust			then
		finish	  := finish + 01;
		orphan_length := back2 - front2 + 01;	
	end if;

	if	front2 > back2 + back2_adjust			then
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
			orphan_length := 1;
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

		elsif	have.wrong1 = had.wrong2
		and	have.wrong2 = had.wrong1					then
			score := score - weight_wrong + weight_transplace;
		end if;
	end if;

	if	orphan_length >= 03									-- jan 2004
	and	score <= orphan_trigger
	and	finish = 1									then		-- may 2004
		orphan_length := 01;
	end if;

	orphan_score := orphan_length * weight_orphan;			
	score		 := score  + orphan_score;
	errors	 := errors + 01;							--	new

	finish := 9;

--	------------------------------
	<<end_of_step>>
--	------------------------------

--	==============================================
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
			||'   '|| have.stops ||' '|| had.stops
			||'				error stop/stop' );

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

		series := series + 01;
		step	 := 0;
		if	series  = 04		then			
			series := 02;
		end if;	

		if	series = 01			then
			revector := 0;								
		end if;
	end if;

--	==============================================
--	exit tests

	exit when	finish > 2;								

	loops := loops + 01; if loops > 100 then score := is_looping; return; end if;

end loop;

--	====================================================================

	pass_score	:= score;				
	pass_errors	:= errors;

end;



/*
--	==================================================================

--	==================================================================
*/

