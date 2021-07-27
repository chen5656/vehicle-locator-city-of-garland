
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
			'|| A='|| rule.do_alias		||'\L='|| rule.do_like_alias	||'\M='|| rule.do_more_alias; 
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

	show	:=	'Street='|| street_name ||'\ Name#='|| lpad(name_count,3,'0');
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
		trace_whox		:= ltrim(who, trace_NewLine);
		trace_who	:= who;
		trace_whom	:= whom;
	elsif	whom >= '!'				then
		trace_who	:= trace_whox;
		trace_whom	:= whom;
	end if;

	trace_who := ltrim(trace_who, trace_NewLine);

	if	trace_what1 >= '!'
	and	trace_what1 <> trace_whatx			then
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

	trace_work1	:= 0;			

	if	trace_data = 0							--	if scope failed
	and 	trace_focus	 = 0							--	and not in focus mode
	and	tr_trace	 > 0					then		--	and not in basic mode
		null;									--	then data tracking = off

	elsif	trace_option like trace_of_pick_only			--	if tracing only special items
	and	trace_level > 0							--	and not "pick"  step
	and	trace_lines	> 0							--	and not "basic" item
	and	trace_focus	= 0					then		--	and not "focus" item
		null;									--	then data tracking = off

--	elsif	tr_focus not like '%'|| lower(trace_whox) ||'%'	then
--		null;									--	then data tracking = off
		
	elsif	trace_who || show is not null					--	if there is something to show
	and	tr_show   <> 0							--	and data tracking is active
	and	trace_done = 1							--	and this display is being done
	and 	trace_put < abs(trace_lines)					--	and displayed lines < spec lines

	and ((tr_trace  > 0  and trace_lines <> 0)			--	and display = all   & spec = on
	or   (tr_trace  < 0  and trace_lines <  0))			--	or  display = basic & spec = basic

	and ((tr_show > 0	and	trace_level <= tr_show)			--	and valid scope for tr_show
	or   (tr_show < 0	and	trace_level >= tr_show
				and	trace_level < 0	))

	then	trace_work1 := 1;							--	then data tracking = on
	end if;

	if	trace_focus > 0
	and	tr_focus like '%'|| lower(trace_whox) ||'%'	then
		trace_work1 := 1;							
	end if;

	if	trace_work1 > 0					then

		if	trace_who >= '!'				then
			dbms_output.put_line (' ');
		end if;

		trace_who	:= nvl(trace_who  ,' ');
		trace_what1		:= nvl(trace_what1,' ');
		trace_what2		:= nvl(trace_what2,' ');

		if	trace_whom >= '!'				then
			trace_who := trace_who || '=' || trace_whom;
		end if;

		if	show is null
		and	tr_show < 0					then
			null;
		else
			trace_count1 := trace_count1 + 01;
			trace_work := rpad(trace_who, trace_who_leng);
			trace_work := trace_work 				||' ' ||
					rpad(trace_what1, trace_what1_leng)	||' ' ||
					rpad(trace_what2, trace_what2_leng)	||' |'|| 
					show ||'|';

			if	trace_option not like trace_print_off 		then
				dbms_output.put_line (trace_work);
				if	length (trace_work) > trace_line_leng		then
					dbms_output.put_line (rpad('`',trace_line_leng,'`'));
				end if;
			end if;
			
			if	trace_option like trace_file_on 		then
				insert into gis_objects (item01, item02, item03, item04,item05)	values
				( 'data' ||'.'|| lpad(trace_count1,3,'0'), trace_work, who, trace_what1, trace_what2);
			end if;
		end if;

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

		if 	who like trace_NewLine || '%'
		or	trace_flow_leng + trace_who_leng > trace_line_leng	then	
			trace_flown		:= rtrim(trace_flown) || chr(03);
			trace_flow_leng	:= 0;
		end if;

		if	whom >= '!'					then
			who	:= who || '=' || whom;
		end if;

		if	who <> trace_NewLine			then
			who			:= rpad (ltrim(who, trace_NewLine), trace_who_leng);
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

	if	who || whom >= '!'	then		--	always trace the logic flow ("who")
		trace_done	 := 0;
		trace_data := 0;
		show		 := null;
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
