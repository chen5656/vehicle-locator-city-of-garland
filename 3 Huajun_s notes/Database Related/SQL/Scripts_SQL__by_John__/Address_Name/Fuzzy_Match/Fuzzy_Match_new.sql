--	===========================================================
--	soundex matching

	sound1	bp.bv,pb.vb
	sound2	01.01.01.01
	if instr (sound1, here1||here2) > 0 then use sound2 soundex code

	For few dipthongs, use replace command

--	===========================================================

	type	step_info	is record
(
	prev1			char		:= ' ',
	prev2			char		:= ' ',

	here1			char		:= ' ',
	here2			char		:= ' ',

	next1			char		:= ' ',
	next2			char		:= ' ',

	extra1		char,
	extra2		char,
	wrong1		char,
	wrong2		char,

	prev_type1		char,
	here_type1		char,
	next_type1		char,

	prev_type2		char,
	here_type2		char,
	next_type2		char,

	was_weight		binary_integer	:= 0,
	error			binary_integer	:= 0,
);

--	-----------------------------------------------------------

	name1			varchar2(400);
	name2			varchar2(400);

	pattern1		varchar2(400);
	pattern2		varchar2(400);
	pattern_from	varchar2(80)	:= 'AEIOU CQKJGFV';
	pattern_to		varchar2(80)	:= 'aaaaa kkkggvv';

	removals		varchar2(32)	:= '$()-.,"''';

--	-----------------------------------------------------------
--	initialize

	name1		:= ' ' || upper (pass_name1) ||' ';
	name2		:= ' ' || upper (pass_name2) ||' ';

	name1_length := length (name1);
	name2_length := length (name2);

	name1		:= translate (name1||name2, removals, rpad(' ',length(removals));
	name2		:= substr(name1, name1_length + 01);
	name1		:= rpad  (name1, name1_length);

	pattern1	:= translate (name1||name2, pattern_from, pattern_to);
	pattern2	:= substr(pattern1, name1_length + 01);
	pattern1	:= rpad  (pattern1, name1_length);

	front1	:= 01;
	front2	:= 01;
	back1		:= name1_length;
	back2		:= name2_length;

	vector	:= -1;
	next1x	:= back1 + 01;
	next2x	:= back2 + 01;

	call	get_next_letters;
	call	get_next_letters;
	call	get_next_letters;

--	-----------------------------------------------------------

procedure	get_next_letters		is
begin

<<get_next1>>

	prev1x	:= here1x;
	here1x	:= next1x;
	next1x 	:= next1x + vector;

	have.prev1	:= have.here1;
	have.here1	:= have.next1;
	have.next1	:= substr (name1, next1x, 01);

	have.prev_type1	:= have.here_type1;
	have.here_type1	:= have.next_type1;
	have.next_type1	:= substr (pattern1, next1x, 01);

	if	have.next1	 = have.here1			then
		next1x	:= next1x + vector;
		goto	get_next1;
	end if;

	if	next1x not between front1 and back1		then
		have.next1	:= null;
	end if;

<<get_next2>>

	prev2x	:= here2x;
	here2x	:= next2x;
	next2x 	:= next2x + vector;

	have.prev2	:= have.here2;
	have.here2	:= have.next2;
	have.next2	:= substr (name2, next2x, 01);

	have.prev_type2	:= have.here_type2;
	have.here_type2	:= have.next_type2;
	have.next_type2	:= substr (pattern2, next2x, 01);

	if	have.next2	 = have.here2			then
		next2x	:= next2x + vector;
		goto	get_next2;
	end if;

	if	next2x not between front2 and back2		then
		have.next2	:= null;
	end if;

end;

--	===========================================================
