
--	========================================

	sample_name			varchar2(40)	:= '';		
	sample_type			varchar2(10)	:= '';		
	sample_pfx			varchar2(10)	:= '';		
	sample_key			varchar2(20)	:= '';
	sample_number 		number 	 	:= 0;


	if	do_sample > 0		then

		if  	appl.rec_key	=	sample_key
		or  
		(
		    ( read_name	like	'%'||sample_name||'%'	
		or	sample_name is null					)

		and (	sample_number	=	read_num
		or	sample_number	=	trunc (read_num)
		or	sample_number	=	0				)

		and	sample_type		in	(' ', read_type)
		and	sample_pfx		in	(' ', read_pfx)
		)
		then		null;
		else
			goto end_record_loop;
		end if;
	end if;

	if	do_trace + do_test > 0		
	or	do_sample 	> 0				then 

	trace_count := trace_count - 01;

	dbms_output.put_line (' ');
	dbms_output.put_line ( '$appl		/'||
					appl.addr_num ||'/'||appl.addr_pfx ||'/'||
					appl.addr_name||'/'||appl.addr_type||'/'||appl.addr_sfx||'/'||
					appl.addr_code||'/'||appl.addr_unit||'/	<'||	
					prev_seq	|| '>');

	dbms_output.put_line (show1);
	dbms_output.put_line (show2);
	dbms_output.put_line (show3);
	dbms_output.put_line (show4);
														
	dbms_output.put_line ( '$read		/'||
					read_num  ||'/'||read_pfx||'/'||read_name||'/'||
					read_type ||'/'||read_sfx||'/'||
					read_code ||'/'||read_unit||'/'			);
	dbms_output.put_line (' ');
	end if;

--	========================================

--	========================================
/*

--	prepare seg or adr score for consideration in next phase step

	part_match := 0;

	if	phase = address_phase						then

		if	new.addr_type	in (' ', addr.addr_type)
		and	new.addr_pfx	in (' ', addr.addr_pfx)
		and	new.addr_sfx	in (' ', addr.addr_sfx)		then
			part_match := 1;
		end if;

		if	part_match > 0						
		and	adr_score  < rule.if_part_address			then	
			adr_score := rule.if_part_address;

		elsif	part_match = 0						
		and	adr_score  < rule.if_base_address			then
			adr_score := rule.if_base_address;
		end if;

	elsif	phase = block_phase						then

		if	new.addr_type	in (' ', blok.addr_type)
		and	new.addr_pfx	in (' ', blok.addr_pfx)
		and	new.addr_sfx	in (' ', blok.addr_sfx)		then
			part_match := 1; 
		end if;

		if	part_match > 0					
		and	blk_score  < rule.if_part_block			then
			blk_score := rule.if_part_block;

		elsif	part_match = 0					
		and	blk_score  < rule.if_base_block			then
			blk_score := rule.if_base_block;
		end if;

	elsif	phase = segment_phase						then

		if	match_range = 0						then
			goto	end_fetch_loop;
		end if;

		if	new.addr_type	in (' ', segm.addr_type)
		and	new.addr_pfx	in (' ', segm.addr_pfx)
		and	new.addr_sfx	in (' ', segm.addr_sfx)		then
			part_match := 1; 
		end if;

		if	part_match > 0					
		and	seg_score  < rule.part_range				then
			seg_score := rule.part_range;

		elsif	part_match = 0				
		and	seg_score  < rule.if_base_range			then
			seg_score := rule.if_base_range;
		end if;

	end if;

	if	do_test > 099		then
	dbms_output.put_line ( 'score		' ||seg_score  ||'/'||adr_score  ||'/'||prev_score||'/'||
		 		      match_range||'/'||part_match||'/'	); 
	end if;

*/
--	========================================
--	========================================
/*						-- jun 2002
	if	rule.do_parsed_exit = rule.no			then		
		read_name 	:= translate (read_name, delimiters, spaces); 		
		read_type 	:= translate (read_type, delimiters, spaces); 		
		read_pfx 	:= translate (read_pfx,  delimiters, spaces); 		
		read_sfx 	:= translate (read_sfx,  delimiters, spaces); 		
		read_code1 	:= translate (read_code1,delimiters, spaces); 		
		read_unit1 	:= translate (read_unit1,delimiters, spaces); 		
		read_code2 	:= translate (read_code2,delimiters, spaces); 		
		read_unit2 	:= translate (read_unit2,delimiters, spaces); 		
	end if;
*/
--	========================================
<<initialize_output>>

/*
	if	rule.do_parsed_exit = rule.no			then		
		read_name	:= replace   (read_name, rpad(' ',3), ' ');	
		read_name	:= replace   (read_name, rpad(' ',2), ' ');
		read_name	:= replace   (read_name, rpad(' ',2), ' ');

		read_name	:= nvl(ltrim (rtrim (read_name)),' ');
		read_type	:= nvl(ltrim (rtrim (read_type)),' ');
		read_pfx	:= nvl(ltrim (rtrim (read_pfx )),' ');
		read_sfx	:= nvl(ltrim (rtrim (read_sfx )),' ');
		read_code1	:= 	 ltrim (rtrim (read_code1));
		read_unit1	:= 	 ltrim (rtrim (read_unit1));
		read_code2	:= 	 ltrim (rtrim (read_code2));
		read_unit2	:= 	 ltrim (rtrim (read_unit2));
	end if;
*/

