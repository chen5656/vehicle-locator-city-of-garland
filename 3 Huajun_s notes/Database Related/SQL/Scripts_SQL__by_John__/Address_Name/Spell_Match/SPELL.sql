
--	======================================================================

--	======================================================================
DECLARE
	compile_only		integer	:= 01;

	error_wrong			integer	:= 10;
	error_extra			integer	:= 20;
	error_missing		integer	:= 30;
	error_transpose		integer	:= 40;
	error_transplace		integer	:= 50;

	weight_wrong		integer	:= 100;
	weight_missing		integer	:= 100;
	weight_extra		integer	:= 100;
	weight_transpose		integer	:= 100;
	weight_transplace		integer	:= 100;

	weight_soft_match		integer	:= 20;
	weight_soft_confirm	integer	:= 20;

--	======================================================================

	in_Poor		varchar2(200);
	in_Good		varchar2(200);

	Poor_Name		varchar2(200);
	Good_Name		varchar2(200);
	Poor_Sound		varchar2(200);
	Good_Sound		varchar2(200);

	Name			varchar2(200);
	Sound			varchar2(200);

	Type Slot_Rec	is record
	(
		Alph		char,
		Sond		char,
		Spce		integer,
		Dupe		integer,
		Seqn		integer
	);

	Slot			slot_rec;
	P0			slot_rec;
	P1			slot_rec;
	P2			slot_rec;
	P3			slot_rec;
	G0			slot_rec;
	G1			slot_rec;
	G2			slot_rec;
	G3			slot_rec;

--	======================================================================
	
	phase			integer;
	score			integer;
	vector		integer;
	error			integer;
	
	name#			integer;
	slot#			integer;

	weight		integer;
	weight1		integer;
	weight2		integer;

--	poor-good match
	match11		integer;
	match22		integer;
	match33		integer;
	match12		integer;
	match21		integer;
	match23		integer;
	match32		integer;
	
--	adjacent letters
	poor_01		integer;
	poor_12		integer;
	good_01		integer;
	good_12		integer;

	next			integer;
	next_poor		integer;
	next_good		integer;

	poor_length		integer;
	poor_idx		integer;
	poor_start		integer;
	poor_stop		integer;

	good_length		integer;
	good_idx		integer;
	good_start		integer;
	good_stop		integer;

	poor_char		char;
	good_char		char;
	prev_char		char;

--	======================================================================	
BEGIN	

	if	compile_only > 0		then
		return;
	end if;

	poor_name	:= ' '|| upper(in_poor) ||' ';
	good_name	:= ' '|| upper(in_good) ||' ';

	poor_name	:= translate(poor_name,	'.-_''',
							'    ');

	good_name	:= translate(good_name,	'.-_''',
							'    ');

	poor_sound	:= translate(poor_name,	'AEIOUBPCKQDTFVGJMNSXZ'
							'AAAAABBCCCDDFFGGMMSSS');

	good_sound	:= translate(good_name,	'AEIOUBPCKQDTFVGJMNSXZ'
							'AAAAABBCCCDDFFGGMMSSS');
--	unique sounds = W H Y L R

	poor_length	:= length(poor_name);
	good_length	:= length(good_name);

	phase		:= 1;
	score		:= 0;

--	==================================================================================================
--	narrow the search down to the 1st non-matching letters at the front and back of the names

	loops := 1;
loop

	if	loops = 1		then
		poor_idx	:= poor_length - 1;  	
		good_idx	:= good_length - 1;  
		vector	:= -1;
	else
		poor_idx	:= 2;
		good_idx	:= 2;
		vector	:= +1;
	end if;

	poor_char := ' ';
	good_char := ' ';

	while	poor_idx between 1 and poor_length
	and	good_idx between 1 and good_length
	loop
		poor_prev := poor_char;
		good_prev := good_char;

		poor_idx  := poor_idx + vector;
		poor_char := substr(poor_name, poor_idx, 1);

		good_idx  := good_idx + vector;
		good_char := substr(good_name, good_idx, 1);

		if	' ' not in (poor_char, good_char)		then
			exit when poor_char <> good_char;
		end if;
	end loop;

	if	loops = 1		then
		poor_stop	:= poor_idx;
		good_stop	:= good_idx;
	else
		poor_start	:= poor_idx;
		good_start	:= good_idx;
	end if;

	loops :=  loops + 1;
	exit when loops > 2;

end loop;

--	======================================================================
--	set up slots for the NEXT 
		Name# := 1;
	While name# < 2				loop

--		copy current slots down according to the next confirmed slot
	
		If	name# = 1			then
			Name	:= Poor_Name;
			Sound	:= Poor_Sound;

			If	next_poor = 3	then
				p0	:= p3;
				slot#	:= 0;
			elsIf	next_poor = 2	then
				p0	:= p2;
				p1	:= p3;
				slot#	:= 1;
			end if;
	
		else
			Name	:= Good_Hame;
			Sound	:= Good_Sound;

			If	next_good = 3	then
				g0	:= g3;
			elsIf	next_good = 2	then
				g0	:= g2;
				g1	:= g3;
			end if;
		End if;		


--		the "before" slot is set as either a space or non-space

		if	p0.spce > 0			then
			p0.alph	:= ' ';
			p0.sond	:= ' ';
		end if;

		if	g0.spce > 0			then
			g0.alph	:= ' ';
			g0.sond	:= ' ';
		end if;

	While slot# < 3				loop
	
		slot.seqn	:= this_seqn;
		slot.alph	:= this_alph;
		slot.sond	:= substr(sound, this_seqn, 1);
		slot.spce	:= 0;
		slot.dupe	:= 0;
	
		loop
			prev_alph	:= this_alph;
			this_seqn	:= this_seqn + vector;
			alph		:= substr(name, this_seqn, 1);
			if	this_alph = ' '			then
				slot.spce := 1;	
			elsif	this_alph = prev_alph		then
				slot.dupe := 1;
			else
				Exit;
			End if;
		end loop;
	

--	copy the prepared slot into the appropriate poor or good slot

		If	name# = 1			then
			If	slot# = 0		then
				p0	:= slot;
			elsif	slot# = 1		then
				p1	:= slot;
			elsif	slot# = 2		then
				p2	:= slot;
			elsif	slot# = 3		then
				p3	:= slot;
		else
			If	slot# = 0		then
				g0	:= slot;
			elsif	slot# = 1		then
				g1	:= slot;
			elsif	slot# = 2		then
				g2	:= slot;
			elsif	slot# = 3		then
				g3	:= slot;
		End if;
	
		slot# := slot# + 01;
	
	end loop;
		
		name# := name# + 01;
	
	end loop;

--	======================================================================
/*

	Look for complex dipthongs in Poor Name.	poor_ph = sign(instr(poor_name, 'PH'))
	Look for complex dipthongs in Good Name.	good_ph = sign(instr(good_name, 'PH'))
	If imbalanced then make replacements and add weight.
	Example: Replace 'PH' by 'F'  and add weight_complex_dipthong

	Determine the basic error per exact matching and set hard weight.

	Check for soft or hard confirmation.
	If neither then	look ahead for sound-alike (simple dipthong) 
				check for hard confimation	
	Else have a roadblock.

	Reduce weight if basic non-match letters are sound-alike (soft match).

*/	
--	======================================================================
	
END;	

--	======================================================================
/*
	Poor		An invalid name looking for the closest matching valid name(s).
	Good		A valid name that may or may not be a close match to the invalid name.

	Name		A poor or good name.
	Sound		A poor or good name consisting of sound-alike representives.
			Example: 'C' is the sound-alike representative for 'C' 'K' 'Q'

	Score		The final result is a measure of the difference in spelling between the Poor and Good names.
			A bigger score means a bigger difference. The best matches have less than a "best score".

	Errors	The basic errors are Wrong, Missing, Extra, and Transposed letters (see Compare below).
			Transposed letters are adjacent (eg. Wanlut). Transplaced letters are non-adjacent (eg. Jutiper).

	Weight	The weight associated with a spelling error.  
			A weight is reduced if the error occurs for sound-alike letters or dipthongs.
			The score is the sum of the weights.

	Note		Both letters and numbers are referred to here as a "letter" or "alph".
			Punctuation is treated as spcees.

	Slot		A slot includes a letter (Alph), its sound-alike (Sond), whether it is followed by a spcee (spce),
			whether it is doubled (Dupe), and its sequence (Seq) within the word.

	Slots		The mis-matched letters are recorded in P1 (Poor) and G1 (Good) slots.
			The immediately preceding letters are recorded in P0 and G0 slots.
			The next non-blank, non_dupe letters after P1 and G1 are recorded in P2 and G2 slots.
			The next non-blank, non-dupe letters after P2 and G2 are recorded in P3 and G3 slots.

	Compare	Compare P1 and G2 and compare P2 and G1.  Each compare can be true or false as an exact match.
			True and True	indicates Transposed letters
			True and False	indicates Missing letter
			False and True	indicates Extra letter
			False and False	indicates Wrong letter

	Adjust	Each error implies that an adjustment be made for subsequent comparison.
			Example:  Transposed letters in P1,P2/G1,G2 imply that P3,G3 should be compared next.

	Confirm	An Adjustment should give a subsequent comparison of the same or sound-alike letters.
			If not, then a "roadblock" exists and no further progress is possible in the vector direction.

	Vector	Comparison of letters proceeds in either a forward (vector=+1) direction from the beginning (front)
			or in a backward (vector=-1) direction from the end (back) of the word.

	Fail		The spelling match fails when a maximum reasonable score is exceeded
			or two "roadblocks" occur, one in a forward direction and one in a backward direction.

	Orphan	During comparison one name may run out of letters before the other name.
			If more than one letter remains, and those letters are bounded by at least one spcee,
			then the remainder is an "orphan".
			Example:	Comparing "Lake Hubbard" and "Lake Ray Hubbard" results in the orphan "Ray".
					The orphan is discovered via forward and backward scanning (vector = +1 and -1).

*/
--	======================================================================

