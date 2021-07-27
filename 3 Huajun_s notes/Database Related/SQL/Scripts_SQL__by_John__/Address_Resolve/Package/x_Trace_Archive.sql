
--	========================================
--	TRACE BODY

	tr_trace			number;
	tr_show			number;
	tr_focus			varchar2(2000);

	who				varchar2(40); 
	whom				varchar2(40); 
	show				varchar2(400); 

	trace_level			number;
	trace_lines			number;
	trace_focus			number;
	trace_data			number;
	trace_done			number;
	trace_count1		number;
	trace_count2		number;
	trace_put			number;
	trace_flow_leng		number;
	trace_break			char;
	trace_who			varchar2(40); 
	trace_whom			varchar2(40); 
	trace_whox			varchar2(40); 
	trace_whatx			varchar2(40); 
	trace_what1			varchar2(40); 
	trace_what2			varchar2(40); 
	trace_option		varchar2(2000);
	trace_shown			varchar2(2000);
	trace_flown			varchar2(2000);
	trace_work			varchar2(4000);
	trace_work1			number;
	trace_work2			number;

	trace_done_init		number	:= -1;
	trace_done_test		number	:= 0;
	trace_done_show		number	:= 1;
	trace_done_shown		number	:= 2;


	procedure	Start_Trace ( spec_trace	number	default 0, 
					  spec_show		number	default 99, 
					  spec_focus	varchar2	default null );
	procedure	Stop_Trace;
	procedure	Track_Data;
	procedure	Trace_Flow;
	procedure	Show_Break;
	procedure	Show_		(spec_scope number);
	procedure	show_Trace	(spec_lines number);

	procedure	show_Rule	(spec_lines number);
	procedure	show_In	(spec_lines number);
	procedure	show_Out	(spec_lines number);
	procedure	show_Work	(spec_lines number);
	procedure	show_Read	(spec_lines number);
	procedure	show_Fetch	(spec_lines number);
	procedure	show_Best	(spec_lines number);
	procedure	show_Basic	(spec_lines number);
	procedure	show_Name	(spec_lines number);
	procedure	show_Audit	(spec_lines number);
	procedure	show_Accept	(spec_lines number);
	procedure	show_Weight	(spec_lines number);
	procedure	show_Score	(spec_lines number);
	procedure	show_Verify	(spec_lines number);







--	==================================================================================
--	T R A C E   B E G I N
--	==================================================================================

--	========================================
	procedure	Start_Trace	(	spec_trace	number	default 0, 
						spec_show	number	default 99, 
						spec_focus	varchar2	default null	)		
	is
--	========================================
begin

	tr_trace		:= spec_trace;
	tr_show		:= spec_show;
	tr_focus		:= lower(spec_focus);

	if	tr_trace = 0	then
		return;
	end if;

	who			:= trace_new_line;	
	whom			:= null;
	trace_whox		:= null;
	trace_whatx		:= null;
	trace_what1		:= null;
	trace_what2		:= null;
	trace_who		:= null;
	trace_whom		:= null;
	show			:= null;
	trace_shown		:= null;
	trace_flown		:= null;
	trace_break		:= null;
	trace_done		:= 0;
	trace_count1	:= 0;
	trace_count2	:= 0;
	trace_put		:= 0;
	trace_flow_leng	:= 0;
	trace_data	:= 1;
	trace_option	:= '0'|| abs(tr_trace) ||'0';

	show_Break;		

end	Start_Trace;

--	========================================
	procedure	Stop_Trace		is
--	========================================
begin
	if	tr_trace = 0		then
		return;
	end if;

	who := trace_new_line; show_Break;
	Trace_Flow; 

	trace_work1	:= 01;
	trace_work2	:= length(trace_flown);
	trace_put	:= 0;
	while	trace_work2 > 0				loop
		trace_put	:= trace_put + 01;
		trace_work2	:= instr(trace_flown, chr(03), trace_work1);
		if	trace_work2 > 0					then
			trace_work2	:= trace_work2 - trace_work1;
			trace_work	:= substr (trace_flown, trace_work1, trace_work2);
			dbms_output.put_line (trace_work);

			if	trace_option like trace_file_on 	then	
				insert into gis_objects (item01,item02) 
						values	('flow.'||lpad(trace_put,03,'0'), trace_work);
			end if;
		end if;
		trace_work1	:= trace_work1 + trace_work2 + 01;
	end loop;
	Show_Break;	

end	Stop_Trace;

--	========================================
	procedure	Show_Break			is
--	========================================
begin
	trace_break	:= nvl (trace_break, '*');

	if	tr_trace <> 0						then	
		dbms_output.put_line (' ');
		dbms_output.put_line (rpad(trace_break,70,trace_break));
	end if;

	trace_break	:= null;
end	Show_Break;

--	========================================
--	========================================
	procedure	show_Rule	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Rule';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:= 	'N='	 || rule.do_name	||'\S=' || rule.do_street	    ||'\B=' || rule.do_block ||
			'\R='  || rule.do_range	||'\A=' || rule.do_address 	    ||	
			'|| P='|| rule.do_parse	||'\E1='|| rule.do_unparsed_exit  ||'\E2='|| rule.do_parsed_exit; 
	trace_what2 := 'Do';	Track_Data;

	show	:= 	'A='	 || rule.do_type_A	||'\B='|| rule.do_type_B	||'\C='|| rule.do_type_C	||
			'|| A='|| rule.do_alias;
	trace_what2 := 'Name';	Track_Data;

	show	:= 	'S=' 	 || rule.str_pfx ||','|| rule.str_type ||','|| rule.str_sfx ||
			'|B='	 || rule.blk_pfx ||','|| rule.blk_type ||','|| rule.blk_sfx;
	trace_what2 := 'Qual';	Track_Data;

	show	:=	'R='	 || rule.rng_pfx ||','|| rule.rng_type ||','|| rule.rng_sfx ||
			'|A='	 || rule.adr_pfx ||','|| rule.adr_type ||','|| rule.adr_sfx;
	trace_what2 := '';	Track_Data;

	show	:= 	'B\'	  || rule.permit_blk_basis ||','|| rule.permit_blk_append ||','|| rule.permit_blk_remove ||'\'|| rule.permit_blk_change ||
			'|| R\' || rule.permit_rng_basis ||','|| rule.permit_rng_append ||','|| rule.permit_rng_remove ||'\'|| rule.permit_blk_change ||
			'|| A\' || rule.permit_adr_basis ||','|| rule.permit_adr_append ||','|| rule.permit_adr_remove ||'\'|| rule.permit_blk_change;
	trace_what2 :=	'Permit';	Track_Data;
end;

--	========================================
	procedure	show_In	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'In';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:= 	'Seq='|| lpad(out.rec_seq, 5,'0') ||'\ Key='|| rpad(out.rec_key,20,'.');
	trace_what2 := 'Record';	Track_Data;

	show	:= 	''|| lpad(appl.addr_num, 5,'0') ||'\'|| rpad(appl.addr_pfx,2,'.') ||'\'|| rpad(appl.addr_name,15,'.') ||'\'|| 
			rpad(appl.addr_type,5,'.')	  ||'\'|| rpad(appl.addr_sfx,2,'.');
	trace_what2 := 'Addr';	Track_Data;

	show	:= 	''|| lpad(appl.addr_num, 5,'0') ||'\'|| rpad(appl.form_pfx,2,'.') ||'\'|| rpad(appl.form_name,15,'.') ||'\'|| 
			rpad(appl.form_type,5,'.')	  ||'\'|| rpad(appl.form_sfx,2,'.');
	trace_what2 := 'Form';	Track_Data;

	show	:= 	''|| lpad(appl.appl_num, 5,'.') ||'\'|| rpad(appl.appl_pfx,2,'.') ||'\'|| rpad(appl.appl_name,15,'.') ||'\'|| 
			rpad(appl.appl_type,5,'.')	  ||'\'|| rpad(appl.appl_sfx,2,'.');
	trace_what2 := 'Appl';	Track_Data;
end;

--	========================================
	procedure	show_Out	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Out';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:= 	''|| lpad(out.addr_num, 5,'0') ||'\'|| rpad(out.addr_pfx,2,'.') ||'\'|| rpad(out.addr_name,15,'.') ||'\'|| 
			rpad(out.addr_type,5,'.')	 ||'\'|| rpad(out.addr_sfx,2,'.');
	trace_what2 := 'Addr';	Track_Data;

	show	:= 	'verify=' || (out.verify_code)	||'/alias='|| (out.do_alias)  ||'/name='|| (out.do_name) 
			||'/qual='|| (out.do_qual)		||'/parse='|| (out.do_parse);
	trace_what2 := 'Flags';	Track_Data;

	show	:= 	''|| lpad(out.addr_num, 5,'0') ||'\'|| rpad(out.form_pfx,2,'.') ||'\'|| rpad(out.form_name,15,'.') ||'\'|| 
			rpad(out.form_type,5,'.')	 ||'\'|| rpad(out.form_sfx,2,'.');
	trace_what2 := 'Form';	Track_Data;

	show	:= 	''|| lpad(out.appl_num, 5,'.') ||'\'|| rpad(out.appl_pfx,2,'.') ||'\'|| rpad(out.appl_name,15,'.') ||'\'|| 
			rpad(out.appl_type,5,'.')	 ||'\'|| rpad(out.appl_sfx,2,'.');
	trace_what2 := 'Appl';	Track_Data;
end;

--	========================================
	procedure	show_Read	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Read';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:= 	''|| lpad(read_num, 5,'0') ||'\'|| rpad(read_pfx,2,'.') ||'\'|| rpad(read_name,15,'.') ||'\'|| 
			rpad(read_type,5,'.')	   ||'\'|| rpad(read_sfx,2,'.');
	trace_what2 := 'Addr';	Track_Data;

	show	:= 	''|| rpad(read_code1,5,'.')	||'\'|| rpad(read_unit1,10,'.') ||'\'|| 
			rpad(read_code2,5,'.')		||'\'|| rpad(read_unit2,10,'.');
	trace_what2	:= 'Unit';	Track_Data;
end;

--	========================================
	procedure	show_Fetch	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Fetch';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	if	phase = street_phase					then
	trace_what2 := 'STRT';	
	show	:=	rpad(' ',5)	||'\'||
			rpad(strt.addr_pfx, 2,'.') ||'\'|| rpad(strt.addr_name,15,'.') ||'\'|| 
			rpad(strt.addr_type,5,'.') ||'\'|| rpad(strt.addr_sfx,2,'.');

	elsif	phase = block_phase					then
	trace_what2 := 'BLOK';	
	show	:=	 lpad(blok.addr_block, 5,'0') ||'\'|| rpad(blok.addr_pfx, 2,'.') ||'\'|| rpad(blok.addr_name,15,'.')||'\'|| 
			 rpad(blok.addr_type,  5,'.')	||'\'|| rpad(blok.addr_sfx, 2,'.');

	elsif	phase = address_phase					then
	trace_what2 := 'ADDR';	
	show	:=	lpad(addr.addr_num, 5,'0') ||'\'|| rpad(addr.addr_pfx, 2,'.') ||'\'|| rpad(addr.addr_name,15,'.')||'\'|| 
			rpad(addr.addr_type,5,'.') ||'\'|| rpad(addr.addr_sfx, 2,'.');

	elsif	phase = segment_phase					then
	trace_what2 := 'SEGM';	
	show	:=	lpad(segm.addr_lo,  5,'0') ||'\'|| rpad(segm.addr_pfx, 2,'.') ||'\'|| rpad(segm.addr_name,15,'.')||'\'|| 
			rpad(segm.addr_type,5,'.') ||'\'|| rpad(segm.addr_sfx, 2,'.');

	end if;

	Track_Data;


	if	phase = street_phase					then
		show	:=	'Compact='	|| strt.addr_compact || ' Reduce=' || strt.addr_reduced;
		Track_Data;
	end if;

end;

--	========================================
	procedure	show_Best	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Best';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:= 	''||	lpad(this_num, 5,'0') ||'\'|| rpad(this_pfx,2,'.') ||'\'|| rpad(this_name,15,'.') ||'\'|| 
				rpad(this_type,5,'.') ||'\'|| rpad(this_sfx,2,'.');
	trace_what2 := 'This';	Track_Data;

	show	:= 	''||	rpad(' ', 5)		||'\'|| rpad(best_pfx,2,'.') ||'\'|| rpad(best_name,15,'.') ||'\'|| 
				rpad(best_type,5,'.')	||'\'|| rpad(best_sfx,2,'.');
	trace_what2 := 'Best';	Track_Data;
end;

--	========================================
	procedure	show_Basic	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Basic';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:=	'Phase='	|| step ||','|| phase || 
			' Verify='	|| verify_id ||' Decide='|| decision	||' Retry='|| retry;
	trace_what2 := '';	Track_Data;

	show	:=	'NameNum='	|| out.addr_name||','|| out.addr_num;
	trace_what2 := '';	Track_Data;

	show	:=	'Compact='	|| compact_name	|| '\ Reduce=' || reduced_name ||
			'\ Range='	|| range_lo||','	|| range_hi;
	trace_what2 := '';	Track_Data;
end;

--	========================================
	procedure	show_Verify	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Verify';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:=	'Verify='|| out.verify_code ||'\ Str#='|| street_count ||'\ Accept#='|| accept_count;
	trace_what2 := '';	Track_Data;

	show	:=	   'Str=' || str.fetch_count ||','|| str.match_count ||','|| str.match_score
			||' Blk=' || blk.fetch_count ||','|| blk.match_count ||','|| blk.match_score 
			||' Seg=' || seg.fetch_count ||','|| seg.match_count ||','|| seg.match_score
			||' Adr=' || adr.fetch_count ||','|| adr.match_count ||','|| adr.match_score;
	trace_what2 := 'FeMaSc';	Track_Data;
end;

--	========================================
	procedure	show_Name	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Name';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:=	'Street='|| street_name ||'\ Name#='|| name_count;
	trace_what2 := '';	Track_Data;

	show	:=	'Table='	|| alias_table	||'\ Method='|| alias_method ||'\ Result='|| alias_result;
	trace_what2 := 'Alias';	Track_Data;

	show	:=	'This=' || this_name_chg||'\ Best=' || best_name_chg ||'\'|| best_name;
	trace_what2 := 'Chg';	Track_Data;
end;

--	========================================
	procedure	show_Audit	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Audit';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:= 	'Mat='	|| match_prefix ||','|| match_type ||','|| match_suffix 
			||'| Unq='	|| unique_prefix||','|| unique_type||','|| unique_suffix;
	trace_what2 := '';	Track_Data;

	show	:=	'Aud='	|| audit_prefix	||','|| audit_type ||','|| audit_suffix 
			||'| This='	|| this_audit	||'\Best='|| best_audit;
	trace_what2 := '';	Track_Data;
end;

--	========================================
	procedure	show_Accept	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Accept';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:= 	'PTS='		|| accept_prefix ||','||		accept_type ||','|| accept_suffix
			||'| Initial='	|| accept_initial||'\ Accept='||	accept_count; 
	trace_what2 := '';	Track_Data;
end;

--	========================================
	procedure	show_Weight	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Weight';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:= 	'Str='	|| street_weight ||' Blk=' || block_weight 
			||' Seg='	|| segment_weight||' Adr=' || address_weight; 
	trace_what2 := 'SBRA';	Track_Data;

	show	:= 	'Prev='	|| prev_best ||'\This='|| this_weight ||'\Best='|| best_weight; 
	trace_what2 := '';	Track_Data;
end;

--	========================================
	procedure	show_Score	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Score';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;	

	show	:=	'Str='|| str.match_score ||'\ Blk='||  blk.match_score ||'\ Seg='|| seg.match_score ||'\ Adr='|| adr.match_score;
	trace_what2 := 'Match';	Track_Data;

	show	:=	'Prev='|| prev_score	||'\ Best='|| best_score;
	trace_what2 := 'Score';	Track_Data;

	show	:=	'App='||  permit_append	||'\ Rem='||  permit_remove   ||'\ Upd='|| permit_change;
	trace_what2 := 'Permit';	Track_Data;
end;

--	========================================
	procedure	show_Work	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= 'Work';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:= 	'Rule=' || work.rule_pfx	||','|| work.rule_type	 ||','|| work.rule_sfx	||
			'| FMS='|| work.fetch_count	||','|| work.match_count ||','|| work.match_score;
	trace_what2 := '';		Track_Data;
end;
		
--	========================================
	procedure	show_Trace	(spec_lines number)	is
--	========================================
begin	
	trace_lines := spec_lines; if tr_trace = 0 then return; end if;

	show	:=	'	'||
			trace_whox   ||	rpad('='|| whom, sign(length(whom)) * (length(whom) + 01))	|| '  ' ||	
			' trace level=' || trace_level ||' trace focus='|| trace_focus ||' trace button='|| trace_data ||
			' trace done='  || trace_done;
	dbms_output.put_line (show);	

	if	trace_lines > 01		then
		show	:= 'trace lines='	|| trace_lines ||' trace put=' || trace_put ||
			   ' tr trace='	|| tr_trace	   ||' tr show='	 || tr_show	  ||' tr focus='|| tr_focus;
		dbms_output.put_line (show);	
	end if;

	if	trace_lines > 02		then
		dbms_output.put_line (show);	
	end if;

--	if	trace_lines > 0		then
--		show	:= 	''||  ||''||  ||''||  ||''||  ||''||   ||''||  ||
--				''||  ||''||  ||''||  ||''||  ||''||   ||''||  ||
--		dbms_output.put_line (show);	
--	end if;

	dbms_output.put_line (' ');	
	show	:= null;

end;

--	========================================
--	========================================
	procedure	Track_Data			is
--	========================================
begin

	if	tr_trace = 0			then	
		return;
	end if;

	if	who >= '!'				then
		trace_whox		:= ltrim(who, trace_new_line);
		trace_who	:= who;
		trace_whom	:= whom;
	elsif	whom >= '!'				then
		trace_who	:= trace_whox;
		trace_whom	:= whom;
	end if;

	trace_who := ltrim(trace_who, trace_new_line);

	if	trace_what1 >= '!'
	and	trace_what1 <> trace_whatx	then
		trace_put	:= 0;
		trace_done	:= 0;
	end if;
	
	if	trace_done < 1			then		
		trace_work 		:= chr(01) || trace_what1 || chr(01);
		trace_work1		:= instr (trace_shown, trace_work);		-- has data group been shown ?
		if	trace_work1	= 0		then					-- if not
			trace_done	:= 1;							-- then mark for show
			trace_shown	:= trace_shown || trace_work;		
		else
			trace_done	:= 2;							-- else mark as done
		end if;
	end if;

	trace_work1	:= 0;								--	show data ?
	trace_work2	:= 0;								--	show step ?

	if (	tr_trace	> 0  							--	if  trace = all   & spec = on
	or	trace_lines	< 0	)						--	or  trace = basic & spec = basic
	and	trace_level <= tr_show				then		--	and data level is within scope
		trace_work1 := 1;
	elsif	trace_focus > 0					then		--	if  focus data
		trace_work1 := 1;							
	end if;		
	
	if	trace_work1  > 0
	and	trace_who || show is not null					--	if  there is something to show
	and 	trace_put  < abs(trace_lines)					--	and displayed lines < spec lines
	and	trace_done = 1							--	and this display is being done
	and	tr_show   <> 0					then
		null;						
	else
		trace_work1 := 0;
	end if;

	if	trace_work1 > 0					then

		if	trace_who >= '!'				then
			dbms_output.put_line (' ');
		end if;

		trace_who	:= nvl(trace_who  ,' ');
		trace_what1	:= nvl(trace_what1,' ');
		trace_what2	:= nvl(trace_what2,' ');

		if	trace_whom >= '!'				then
			trace_who := trace_who || '=' || trace_whom;
		end if;

--		if	show is null
--		and	tr_show < 0					then
--			null;
--		else

			trace_count1 := trace_count1 + 01;
			trace_work := rpad(trace_who, trace_who_leng);
			trace_work := trace_work 				||' ' ||
					rpad(trace_what1, trace_what1_leng)	||' ' ||
					rpad(trace_what2, trace_what2_leng)	||' |'|| 
					show ||'|';

			if	trace_option not like trace_print_off 		then
				dbms_output.put_line (trace_work);
				if	length (trace_work) > trace_line_leng	then
					dbms_output.put_line (rpad('`',trace_line_leng,'`'));
				end if;
			end if;
			
			if	trace_option like trace_file_on 		then
				insert into gis_objects (item01, item02, item03, item04,item05)	values
				( 'data' ||'.'|| lpad(trace_count1,3,'0'), trace_work, who, trace_what1, trace_what2);
			end if;
--		end if;

		if	trace_what1 >= '!'				then
			trace_whatx		:= trace_what1;
			trace_what1		:= ' ';
		end if;

		trace_who	:= null;
		trace_whom	:= null;
		trace_put	:= trace_put + 01;
	end if;

	trace_what2		:= ' ';
	show		:= null;

	if	trace_option like trace_of_debug1		then			-- DEBUG
		show_Trace (1);
	end if;

	if	trace_count1 > trace_max_data	then
		raise_application_error (-20101 ,'TRACE ERROR - maximum tracking exceeded');
	end if;

	Trace_Flow;

end	Track_Data;

--	========================================
	procedure	Trace_Flow			is
--	========================================
begin

	if	tr_trace = 0		then	
		return;
	end if;

	if	whom >= '!'					then
		who	:= nvl(who, trace_whox);
	end if;

	if	who >= '!'	
	and	trace_option not like trace_flow_off		then
		trace_count2	:= trace_count2 + 01;

		if 	who like trace_new_line || '%'
		or	trace_flow_leng + trace_who_leng > trace_line_leng	then	
			trace_flown		:= rtrim(trace_flown) || chr(03);
			trace_flow_leng	:= 0;
		end if;

		if	whom >= '!'					then
			who	:= who || '=' || whom;
		end if;

		if	who <> trace_new_line			then
			who			:= rpad (ltrim(who, trace_new_line), trace_who_leng);
			trace_flown 	:= trace_flown || who || ' ';
			trace_flow_leng	:= trace_flow_leng + trace_who_leng + 01;	
		end if;

	end if;

	who	:= null;
	whom	:= null;

	if	trace_count2 > trace_max_flow		then
		raise_application_error (-20102 ,'TRACE ERROR - maximum tracing exceeded');
	end if;

end	Trace_Flow;

--	========================================
	procedure	Show_	(spec_scope number) is
--	========================================
begin
	trace_level	:= spec_scope;	

	if	tr_trace = 0		then
		return;
	end if;

	if	who || whom >= '!'	then		--	always show trace flow ("who")
		trace_done	:= 0;
		trace_data	:= 0;
		show		:= null;
		Track_Data;
	end if;

	trace_data := 01;

	trace_what1	:= chr(02);
	trace_whatx	:= chr(02);
	trace_shown	:= chr(01);
	trace_focus	:= 1;

	if	trace_done = -1		then		--	rearrange
		trace_level	:= 0;
	else
		trace_done	:= 0;
	end if;

--	Choose FOCUS data display(s)
	if	trace_level <> 0		then
		trace_put	:= 0;
		if tr_focus is not null	then

		if tr_focus like	'%out%'		then show_Out	(9);	end if;
		if tr_focus like	'%weight%'		then show_Weight	(9);	end if;
		if tr_focus like	'%score%'		then show_Score	(9);	end if;
		if tr_focus like	'%work%'		then show_Work	(9);	end if;
		if tr_focus like	'%read%'		then show_Read	(9);	end if;
		if tr_focus like	'%fetch%'		then show_Fetch	(9);	end if;
		if tr_focus like	'%best%'		then show_Best	(9);	end if;
		if tr_focus like	'%name%'		then show_Name	(9);	end if;
		if tr_focus like	'%audit%'		then show_Audit	(9);	end if;
		if tr_focus like	'%accept%'		then show_Accept	(9);	end if;
		if tr_focus like	'%basic%'		then show_Basic	(9);	end if;
		if tr_focus like	'%verify%'		then show_Verify	(9);	end if;
		if tr_focus like	'%rule%'		then show_Rule	(9);	end if;
		if tr_focus like	'%in%'		then show_In	(9);	end if;

		end if;
	end if;

	trace_focus	:= 0;
	trace_done	:= -1;

end	Show_;


--	========================================
	procedure	Trace_Developer		is
--	========================================
--	--------------------------------------------------------------

	trace_all		number;
	trace_range		number;
	trace_step		number;
	trace_data		number;
	trace_both		number;

--	trace_all		whether to show all or selected steps
--	trace_range		whether within range of steps for display
--	trace_step		whether to show step
--	trace_data		whether to show data
--	trace_both		track only steps with data

--	--------------------------------------------------------------

begin

--	Start Trace

	trace_range := 0;

	if	tr_focus like '-%'	then
		trace_all := 0;
	else
		trace_all := 1;
	end if;

	if	tr_focus like '%=%'	then
		trace_both := 1;
	else
		trace_both := 0;
	end if;

--	Show_()

	trace_step := trace_all;

--	is this a non-basic step ?

	if	tr_show	 < 0
	and	trace_level  > 0				then
		trace_step  := 0;
	end if;


--	should all steps be traced 
--	or is this a focus step

	if	trace_step > 0				then
		trace_work1	:= 0;
	else
		trace_work1	:= instr (tr_focus, who);
	end if;
		
	if	trace_work1 > 0			then
		trace_work	:= substr (tr_focus, trace_work1 - 01, 01);
		if	trace_work =  '+'		then
			trace_range	:= trace_range + 01;
		elsif	trace_work =  '-'		then
			trace_range	:= trace_range - 01;
		elsif	trace_work = '.'		then
			trace_range	:= 0;
		elsif	trace_work = ':'		then
			trace_range	:= 1;
		end if;

		if	trace_work  = ' '
		or	trace_range > 0		then
			trace_step := 1;
		else
			trace_step := 0;
		end if;
	end if;
	

--	should data be tracked ?

	if	show is not null
	and	trace_step > 0
	and	trace_put  < abs(trace_lines)		then
		trace_data	:= 1;
	else
		trace_data	:= 0;
	end if;

--	track any data 
--	or trace basic data

	if	tr_trace > 0
	or	trace_lines < 0				then
		null;
	else
		trace_data	:= 0;
	end if;

--	is this a focus step 
--	is data level too high
--	has data already been shown at this step

	if	trace_level = 0				then
		trace_data	:= 1;
	elsif	abs(trace_level) > abs(tr_show)	then
		trace_data	:= 0;
	elsif	trace_done <> 2				then
		trace_data	:= 0;
	end if;

--	========================================
end;

--	==================================================================================
	procedure	Resolve_Developer		is
--	==================================================================================

--	==================================================================================

begin

	null;

end;

--	==================================================================================

--	==================================================================================
--	T R A C E   E N D
--	==================================================================================

end	Resolve_Address;

--	==================================================================================
/*
--	================================================================================================
	DOCUMENT & TEMPLATES
--	================================================================================================

	tr_trace		spec	options
				neg	track basic data only
				zero	suppress trace

	tr_show		spec	priority level
				neg	track only steps w/ data
				zero	trace flow only

	tr_focus		spec	focus steps & focus data

				step	= who
				data	= what1

				stp			do who='stp'		(ignore trace_range)
				[abc ]def		do 'abc' thru 'def'	(nested trace_range)
				+jkl			track on  at 'jkl'	(reset  trace_range = 1)
				-mnp			track off at 'mnp'	(reset  trace_range = 0)

				'...'			show focus data & data levels
				'- ...'		do focus steps only
				'-- ..'		do focus steps and focus data only (no basic data)
				'/....'		ignore tr_focus

	options

			trace_print_only		default
			trace_file_only		varchar2(10)	:= '%0110%';	
			trace_print_file		varchar2(10)	:= '%0120%';	

			trace_debug1		varchar2(10)	:= '%0910%';
			trace_debug2		varchar2(10)	:= '%0920%';



	who & whom		define a "step" in the trace
	Show_()		controls trace_what happens at this "step"
	show_xxxx()		calls a "display" procedure of 1 or more lines

	Show_(...)		does "focus" displays which are shown at every "step"

	Show_(0)		print "focus" displays only
	Show_(s)		print "step" displays if "scope" |s| <= tr_show
	Show_(-s)		"basic step" with "scope" = s

	show_xxxx (0)	suppress this "display" 
	show_xxxx (m)	prints max of m lines of "display" 
	show_xxxx (-m)	"basic item" with max lines = m

	Options		example:  0110120910 = options 11, 12, & 91
				(see package constants)

	tr_trace	
		 0		suppress trace entirely
		+o,-o		activate trace, set options = o
		-o		track "basic items" only

	tr_show
		 0		trace logic flow only
		+s		track all steps	  with scope <= s
		-s		track "basic steps" with scope <= s

	tr_focus		specify focus steps (who)
				specify focus items (trace_what1)

--	========================================
--	Tasks
		trace_data	levels (spec_level in pkg)
		trace_done		named constants
		
--	========================================
	procedure	Show_	(spec_lines number)	is
--	========================================
begin	
	trace_what1	:= '';	trace_lines := spec_lines; if tr_trace = 0 then return; end if;	

	show	:= 	''||  ||''||  ||''||  ||''||  ||''||   ||''||  ||
			''||  ||''||  ||''||  ||''||  ||''||   ||''||  ||
	trace_what2 := '';	Track_Data;

	show	:= 	''||  ||''||  ||''||  ||''||  ||''||   ||''||  ||
			''||  ||''||  ||''||  ||''||  ||''||   ||''||  ||
	trace_what2 := '';	Track_Data;

	show	:= 	''||  ||''||  ||''||  ||''||  ||''||   ||''||  ||
			''||  ||''||  ||''||  ||''||  ||''||   ||''||  ||
	trace_what2 := '';	Track_Data;

	show	:=	''|| rpad(,,'.') ||''|| rpad(,,'.') ||''|| rpad(,,'.') ||''|| rpad(,,'.') ||
			''|| rpad(,,'.') ||''|| rpad(,,'.') ||''|| rpad(,,'.') ||''|| rpad(,,'.') ||
	trace_what2 := '';	Track_Data;
end;
--	================================================================================================

		if tr_focus like	'%%'		then show_	(9);	end if;

	      who:=''; whom:=''; Start_Trace (tr_trace, tr_show, tr_focus);
	      who:=''; whom:=''; Stop_Trace;

	      who:= trace_new_line;	Show_(0); 
	      who:= 'LOOP'; whom:=''; Show_(50); 

	      who:=''; whom:=''; Show_(50); show_(9); show_(9); show_(9); show_(9); show_(9);

--	================================================================================================
*/

