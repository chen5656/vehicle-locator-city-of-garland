
--	=================================================================
--	TRACE AREA

	do_track			number	:= 0;
	trace_count			number	:= 0;
	trace_show			number	:= 0;
	trace_spec			number	:= 0;
	trace_put			number	:= 0;
	trace_id			number	:= 0;
	trace				varchar2(200);
	show				varchar2(80); 
	show_who			varchar2(20); 
	show_whom			varchar2(20); 
	who				varchar2(20); 
	whom				varchar2(20); 
	who1				varchar2(20); 
	what1				varchar2(20); 
	what2				varchar2(20); 
	shown				varchar$v;
	trace_spec1			number;
	trace_spec2			number;

	procedure	Prepare_Trace (spec_trace number, spec_show number);
	procedure	Finish_Trace;
	procedure	show_Break;
	procedure	show_Trace	(spec_lines number);
	procedure	show_		(spec_lines number);


--	========================================
	procedure	Prepare_Trace	(spec_trace number, spec_show number)		is
--	========================================
begin
--	do_trace = 0		suppress trace & track (allow do_show)
--	do_trace > 0		show trace flow only
--	do_track > 0		track data whenever spec <> 0
--	do_trace < 0		track data only if  spec <  0
--	do_show  > 0		track specific data group every time

	trace_spec1		:= spec_trace;
	trace_spec2		:= spec_show;

	do_show := trace_spec2;
	if	trace_spec1  = trace_only		then
		do_trace	:= trace_spec1;
		do_track	:= 0;
	else
		do_trace	:= 0;
		do_track	:= trace_spec1;
	end if;

	shown	:= varchar$v (0,0,0,0,0,0,0,0,0,0,	0,0,0,0,0,0,0,0,0,0,	0,0,0,0,0,0,0,0,0,0,	0);

	who		:= trace_NewLine;	
	whom		:= null;
	show_who	:= ' ';
	show_whom	:= null;
	what1		:= ' ';
	what2		:= ' ';
	show		:= null;
	trace		:= null;
	trace_count	:= 0;
	trace_put	:= 0;

	show_Break;		

end	Prepare_Trace;

--	========================================
	procedure	Trace_Flow			is
--	========================================
begin
	trace_count	:= trace_count + 01;
	if	trace_count > trace_max		then
		dbms_output.put_line ('ERROR - Trace maximum exceeded');
		return;
	end if;

	who	:= nvl(who, show_who);

	if	do_trace > 0	
	and	who >= '!'						then

		if 	who like trace_NewLine || '%'
		or	length (trace) > trace_line_leng 	then
			dbms_output.put_line (trace );
			trace	:= null;
		end if;

		if	whom >= '!'					then
			who	:= who || '=' || whom;
		end if;

		if	who <> trace_NewLine			then
			trace	:= rtrim(trace ||' '|| ltrim(who, trace_NewLine));
		end if;
	end if;

	who	:= ' ';
	whom	:= null;
end	Trace_Flow;


--	========================================
	procedure	Track_Data			is
--	========================================
begin

	if	who >= '!'				then
		who1		:= who;
		show_who	:= who;
		show_whom	:= whom;
		trace_put	:= 0;
		if	do_trace <> trace_only	then
			dbms_output.put_line (' ');
		end if;

	elsif	whom >= '!'				then
		show_who	:= who1;
		show_whom	:= whom;
		trace_put	:= 0;
	end if;

	if	do_show <> 0
	and	what1 >=  '!'
	and	trace_id > 0
	and	shown (trace_id) = 01		then
		show := null;
	end if;

--	T E S T
--	if	show is null	then
--		dbms_output.put_line ('show is null');
--	end if;
--	dbms_output.put_line ('pt='|| trace_put||' sp='||trace_spec ||' tk='|| do_track||' sh='||do_show ||','|| trace_show);

	if	show is not null
	and 	trace_put < abs(trace_spec)

	and ((do_track > 0	and trace_spec <> 0)
	or   (do_show  > 0	and trace_spec <> 0	and trace_show > 0)
	or   (do_track < 0	and trace_spec <  0)	
	or   (do_show  < 0	and trace_spec <  0	and trace_show > 0))		then

		show_who	:= nvl(ltrim(show_who, trace_NewLine),' ');
		what1		:= nvl(what1,' ');
		what2		:= nvl(what2,' ');

		if	show_whom >= '!'					then
			show_who := show_who || '=' || show_whom;
		end if;

		dbms_output.put_line (	rpad(show_who,trace_who_leng) ||' ' || 
						rpad(what1,trace_what1_leng)	||' ' ||
						rpad(what2,trace_what2_leng)	||' |'|| 
						show ||'|'	);

		what1		:= ' ';
		show_who	:= ' ';
		show_whom	:= null;

		trace_put		:= trace_put + 01;
		if	trace_id > 0				then
			shown (trace_id)	:= 01;
		end if;
	end if;

	what2		:= ' ';
	show		:= null;

	Trace_Flow;

end	Track_Data;

--	========================================
	procedure	Finish_Trace		is
--	========================================
begin
	who := trace_NewLine; Trace_Flow; show_Break;	
end	Finish_Trace;

--	========================================
	procedure	show_Trace	(spec_lines number)	is
--	========================================
begin
	Trace_Flow;
end	show_Trace;

--	========================================
	procedure	show_Break			is
--	========================================
begin
	if	abs(do_track) + abs(do_trace) + abs(do_show) > 0		then
		dbms_output.put_line (' ');
		dbms_output.put_line (rpad('*',70,'*'));
	end if;
end	show_Break;

--	========================================
	procedure	Show_	(spec_lines number) is
--	========================================
begin
	trace_spec	:= spec_lines;

	show		:= ' ';
	trace_put	:= 0;
	Track_Data;

	if	trace_spec * do_show = 0
	or	do_trace = trace_only		then
		return;
	end if;

	shown	:= varchar$v (0,0,0,0,0,0,0,0,0,0,	0,0,0,0,0,0,0,0,0,0,	0,0,0,0,0,0,0,0,0,0,	0);

	trace_show := abs(do_show);

	if	trace_show = 01			then
		show_Block(9);
		show_Side(-1);
	elsif	trace_show = 02			then
		null;
	end if;

	trace_show := 00;
end	Show_;

--	========================================

/*
--	================================================================================================
	TEMPLATES
--	================================================================================================

	who:=''; whom:=''; Show_(1); show_(0); show_(0); show_(0); show_(0); show_(0);

	who:=''; whom:=''; Show_(0);

	who:= trace_NewLine;	Show_(0); 
	who:= 'LOOP'; whom:=''; Show_(1); 

	who:=''; whom:=''; Prepare_Trace (do_trace, do_show);
	who:=''; whom:=''; Finish_Trace;


--	========================================
	procedure	Show_	(spec_lines number) is
--	========================================
begin	
	what1	:= 	'';	trace_spec := spec_lines;	trace_id := ;

	show	:= 	''|| () ||'\'|| () ||'\'|| () ||'\'|| () ||'\'||  () ||'\'|| () 
			||'\'|| () ||'\'|| () ||'\'|| () ||'\'|| () ||'\'||  () ||'\'|| () 
	what2 :=	'';	Track_Data;


	show	:=	''|| lpad(,,'0') ||'\'|| lpad(,,'0') ||'\'|| lpad(,,'0') ||'\'|| lpad(,,'0') 
			||'\'|| lpad(,,'0') ||'\'|| lpad(,,'0') ||'\'|| lpad(,,'0') ||'\'|| lpad(,,'0')
	what2 :=	'';	Track_Data;


	show	:=	''|| rpad(,,'.') ||'\'|| rpad(,,'.') ||'\'|| rpad(,,'.') ||'\'|| rpad(,,'.') 
			||'\'|| rpad(,,'.') ||'\'|| rpad(,,'.') ||'\'|| rpad(,,'.') ||'\'|| rpad(,,'.')
	what2 :=	'';	Track_Data;

end;

--	================================================================================================

*/
