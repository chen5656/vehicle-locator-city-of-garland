
/*
--	============================================================================================
--	enhance:	change view_ names
--	enhance:	replace	sql_ with rec.
--	============================================================================================

	a_space		char	:= ' ';
	a_semi		char	:= ';';
	a_comma		char	:= ',';
	a_bar			char	:= '|';
	a_break		char	:= 'X X';

	translate_old	varchar2(80) :=	'ABCDEFGHIJKLMNOPQRSTUVWYZ)123456789+-/*<>''';
	translate_new	varchar2(80) :=	'XXXXXXXXXXXXXXXXXXXXXXXXX,000000000======"';


[0]

	sql_string	:= replace (sql_string, '  ', ' ');
	sql_string	:= replace (sql_string, '  ', ' ');
	sql_pattern	:= translate (sql_string, translate_old, translate_new);	

	view_show	:= view_show    || sql_string;
	view_pattern:= view_pattern || sql_pattern;

[1]

	view_leng := length (view_show);
	if	view_leng <= max_line_length
		stop_posn := view_leng;
		goto [5];

[2]	"find first quote (if it exists)"

	prev_posn := instr (view_show, '''');
	this_posn := instr (view_show, '"');	 

	if	this_posn > prev_posn			then
		this_quote	:= '"'
		next_posn	:= prev_posn;
	else
		this_quote	:= ''''
		next_posn	:= this_posn;
	end if;

	prev_posn	:= 0;
	this_posn	:= 0;
	this_parity := 0;
	next_occur	:= 1;

	if	next_posn > 0
		goto	[3a];
	else
		goto	[4];


[3]	"look for next quote  (from beginning of text)"

	prev_posn  := this_posn;
	this_posn  := next_posn;
	if	this_parity  = 1
		this_parity := 2;
	else
		this_parity := 1;

	next_occur	:= next_occur + 1;
	next_posn  	:= instr (show_view, this_quote, next_occur);

[3a]	"analyze this quote"

	if	next_posn > 0	
		if	this_parity = 1				-- unmatched quote
		or	this_posn - prev_posn = 1		-- adjacent  quote
		or	next_posn < min_line_length		-- unfinished print line
			goto [3];

	if	this_parity = 1
		start_posn	:= prev_posn + 1;

	elsif	this_parity = 2
		start_posn	:= this_posn + 1;

	else
		start_posn 	:= 1;


[4]	"look for end of line"					

	stop_posn	:= 0;
	semi_posn	:= instr (this_pattern,	a_semi,	01, 		   +1);
	break_posn	:= instr (this_pattern, a_break, 	max_line_leng, -1) + 01;
	comma_posn	:= instr (this_pattern,	a_comma, 	max_line_leng, -1);
	space_posn	:= instr (this_pattern,	a_space,	max_line,leng, -1); 

	if	semi_posn > 0			then
		stop_posn:= semi_posn;
		goto	[5];
	end if;


	stop_posn := 0;

	if	stop_posn < comma_posn		then
		stop_posn:= comma_posn;
	end if;

	if	stop_posn < break_posn		then
		stop_posn:= break_posn;
	end if;

	if	stop_posn = 0			then
		stop_posn:= space_posn;
	end if;

	if	stop_posn > 0			then
		goto	[5];
	end if;


[4a]	"look again for end of line"

	stop_posn	:= instr (this_pattern || ' ',a_space,	max_line_leng, +1);
	break_posn	:= instr (this_pattern, 	a_break, 	max_line_leng, +1) + 01;
	comma_posn	:= instr (this_pattern,		a_comma, 	max_line_leng, +1);

	if	comma_posn > 0
	and	stop_posn  > comma_posn		then
		stop_posn := comma_posn;
	end if;

	if	break_posn > 0
	and	stop_posn  > break_posn		then
		stop_posn := break_posn;
	end if;
	

[5]	"obtain print line"


--	============================================================================================
--	============================================================================================
--	============================================================================================

<<loop1>>		initialize sql process
loop


<<loop2>>		print all sql lines
loop



	prev_posn	:= 0;
	this_posn	:= 0;


--	establish start and stop positions of next pair of quotes

	next_posn := instr (view_pattern, double_quote, start_scan);


	while	next_posn between 01 and max_line_leng		
	loop

		start_scan 		:= next_posn;
		this_posn		:= next_posn;
		quote_seq		:= 1;
		this_parity		:= 0;

		if	next_posn = instr (view_show, double_quote, next_posn) 	then
			this_quote	:= double_quote;
		else
			this_quote	:= single_quote;
		end if;

		loop1	:= 0;
		loop
			prev_posn   := this_posn;
			this_posn   := next_posn;
			if	this_parity  = 1
				this_parity	:= 2;
			else
				this_parity	:= 1;
			end if;

			if	this_parity < 2
			or	this_posn - prev_posn < 2	then
				null;
			else
				stop_posn	:= this_posn;
				exit;
			end if;

			quote_seq  := quote_seq + 01;
			next_posn  := instr (view_show, this_quote, start_scan, quote_seq);
			exit when next_posn = 0;

			loop1	:= loop1 + 1;
			exit when  loop1 > loop1_max;

		end loop;


		[4]	finish out print line
		[4a]

		[5]	print line


	end loop;

--	============================================================================================
*/


--	============================================================================================
/*

	select lpad(sid,04) Sid, rpad(username,10) Username, rpad(osuser,10) Osuser, 
		 rpad(machine,20) Machine, rpad(command,03) cmd,	 Program 
	from	v$session 
	where	osuser not like '%SYSTEM%'	
	order by sid;

*/
--	============================================================================================

