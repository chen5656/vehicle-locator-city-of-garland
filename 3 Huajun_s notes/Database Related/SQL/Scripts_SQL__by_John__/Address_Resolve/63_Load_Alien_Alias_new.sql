
--	populate adrAlien & adrAlias from adrAlter

	set echo		on;
	set timing		off;
	set serveroutput	on;
--	================================================================

	delete from garland.adrAlien	where alias_how < '9';
	delete from garland.adrAlias	where alias_how < '9';
	commit;

--	================================================================
--	tasks
--		process addr_min
--		check field lengths
--		check spec format
--		test  alien asis target
--	================================================================

declare

	do_insert				number	:= 01;
	do_trace				number	:= 0;
	do_compile_only			number	:= 0;

	input_total				number	:= 0;
	output_total			number	:= 0;
	dupe_total				number	:= 0;
	reject_total			number	:= 0;

	alien_input				number	:= 0;
	alias_input				number	:= 0;
	alien_output			number	:= 0;
	alias_output			number	:= 0;

	mark_how				char		:= '@';
	size_how				number	:=  3;

	spec_count				number;
	spec_is_valid			number;
	spec_object				char;
	spec_before				char;
	spec_after				char;
	spec_verify				char;
	spec_how				varchar2(10);

	posn					number;
	target_count			number;
	why_reject				varchar2(80);

	is_name		constant	char(1)	:= 'N';
	is_street		constant	char(1)	:= 'S';
	like_name		constant	char(3)	:= 'N%';
	like_street		constant	char(3)	:= 'S%';

	is_non_address	constant	char(1)	:= rule.mark_non_address;
	is_non_garland	constant	char(1)	:= rule.mark_non_garland;
	is_non_correct	constant	char(1)	:= rule.mark_non_correct;
	is_verify_only	constant	char(1)	:= rule.mark_just_verify;
	is_target		constant	char(1)	:= '9';
	is_empty		constant	char(1)	:= ' ';

	like_non_address	constant	char(3)	:= '%' || rule.mark_non_address || '%';
	like_non_garland	constant	char(3)	:= '%' || rule.mark_non_garland || '%';
	like_non_correct	constant	char(3)	:= '%' || rule.mark_non_correct || '%';
	like_verify_only	constant	char(3)	:= '%' || rule.mark_just_verify || '%';
	like_target		constant	char(3)	:= '%9%';

	marks			constant	char(4)	:= 	rule.mark_non_address	||
									rule.mark_non_garland	||
									rule.mark_non_correct	||
									rule.mark_just_verify;

	delimiters		constant	varchar2(8)	:= '.,;:''';  
	spaces		constant	char(20)	:= ' ';  

--	================================================================

	Init			garland.adrAlias%rowtype;
	Out			garland.adrAlias%rowtype;

--	================================================================

cursor	read_adrAlter		is

		select * from garland.adrAlter;

Spec		read_adrAlter%rowtype;

--	================================================================

begin

	if	do_compile_only	> 0		then
		return;
	end if;

	init.alias_pfx		:= '*';
	init.alias_name		:= '*';
	init.alias_type		:= '*';
	init.alias_sfx		:= '*';
	init.addr_pfx		:= '';
	init.addr_name		:= '';
	init.addr_type		:= '';
	init.addr_sfx		:= '';
	init.alias_lo		:= 0;
	init.alias_hi		:= 999999;
	init.addr_min		:= 0;
	init.alias_how		:= '';
	init.alias_reduced	:= '';
	init.alias_compact	:= '';
	init.alias_compress	:= '';

--	dbms_transaction.use_rollback_segment ('rb1');
	dbms_output.put_line (' ');

	open	read_adrAlter;

loop

	fetch	read_adrAlter				into Spec;
	exit when	read_adrAlter%notfound
	or		read_adrAlter%notfound is null;

	input_total	:= input_total + 01;
	out		:= init;

--	set default specs
	spec_before	:= 2;
	spec_after	:= 3;
	spec_object	:= is_street;
	spec_verify	:= is_empty;

	spec_count	:= 0;
	target_count:= 0;
	why_reject	:= null;

--	================================================================

	spec.flag1	:= translate (upper(spec.flag1), '0129 ', marks);
	spec.flag2	:= translate (upper(spec.flag2), '0129 ', marks);
	spec.flag3	:= translate (upper(spec.flag3), '0129 ', marks);
	spec.notes	:= rtrim(spec.notes);

	spec.name1	:= upper (spec.name1);
	spec.type1	:= upper (spec.type1);
	spec.pfx1	:= upper (spec.pfx1);
	spec.sfx1	:= upper (spec.sfx1);
	spec.name2	:= upper (spec.name2);
	spec.type2	:= upper (spec.type2);
	spec.pfx2	:= upper (spec.pfx2);
	spec.sfx2	:= upper (spec.sfx2);
	spec.name3	:= upper (spec.name3);
	spec.type3	:= upper (spec.type3);
	spec.pfx3	:= upper (spec.pfx3);
	spec.sfx3	:= upper (spec.sfx3);

--	feb 28
	spec.type1 	:= translate (spec.type1, 'x'||delimiters, 'x'); 		
	spec.pfx1 	:= translate (spec.pfx1,  'x'||delimiters, 'x'); 		
	spec.sfx1 	:= translate (spec.sfx1,  'x'||delimiters, 'x'); 		

--	spec.name1 	:= translate (spec.name1, delimiters, spaces); 		
--	spec.name1	:= replace   (spec.name1, rpad(' ',3), ' ');	
--	spec.name1	:= replace   (spec.name1, rpad(' ',2), ' ');
--	spec.name1	:= replace   (spec.name1, rpad(' ',2), ' ');

--	================================================================
--	process line 1	(unparsed street)

	if	spec.flag1 > ' '						then
		spec_count := spec_count + 01;

		if	spec.flag1 like	like_name			then
			spec_object := 	is_name;
		else
			spec_object := 	is_street;
		end if;

		if	spec.flag1 like	like_non_address		then
			spec_verify	:= 	is_non_address;
		elsif	spec.flag1 like	like_non_garland		then
			spec_verify	:= 	is_non_garland;
		elsif	spec.flag1 like	like_non_correct		then
			spec_verify	:= 	is_non_correct;
		elsif	spec.flag1 like	like_verify_only		then
			spec_verify	:= 	is_verify_only;
		elsif	spec.flag1 like	like_target			then
			spec_verify	:= 	is_target;
		end if;

		spec_before := 1;
		if	spec_verify	> is_empty				then
			spec_after	 := 1;
			target_count := target_count + 01;
		end if;

		out.alias_name := spec.name1;

		if	spec_object	= is_street				then
			if	spec.type1 is not null			then
				out.alias_type := spec.type1;
			end if;

			if	spec.pfx1 is not null			then
				out.alias_pfx := spec.pfx1;
			end if;

			if	spec.sfx1 is not null			then
				out.alias_sfx := spec.sfx1;
			end if;
		end if;
	end if;

	if	spec.flag1 like like_non_address			then		--	may 2002

		spec_after	 :=  1;

--		if	spec.flag1 not like like_non_address	then	
--			target_count := target_count + 01;
--		end if;

		out.addr_name := spec.name1;

		if	spec_object	= is_street				then
			if	spec.type1 is not null			then
				out.addr_type := spec.type1;
			end if;

			if	spec.pfx1 is not null			then
				out.addr_pfx := spec.pfx1;
			end if;

			if	spec.sfx1 is not null			then
				out.addr_sfx := spec.sfx1;
			end if;
		end if;
	end if;

--	================================================================
--	process line 2	(parsed street)

	if	spec.flag2 > ' '						then
		spec_count := spec_count + 01;

		if	spec.flag2 like	like_non_address		then
			spec_verify	:= 	is_non_address;
		elsif	spec.flag2 like	like_non_garland		then
			spec_verify	:= 	is_non_garland;
		elsif	spec.flag2 like	like_non_correct		then
			spec_verify	:= 	is_non_correct;
		elsif	spec.flag2 like	like_verify_only		then
			spec_verify	:= 	is_verify_only;
		elsif	spec.flag2 like	like_target			then
			spec_verify	:= 	is_target;
		end if;
	end if;

	if	spec.flag2 like	like_name				then
		spec_object := is_name;
	else
		spec_object := is_street;
	end if;

	if (	spec.flag2  > ' '	and	spec_count = 1	)
	or	spec_before = 2						then

		spec_before := 2;
		if	spec_verify	> is_empty				then
			spec_after	 := 2;
			target_count := target_count + 01;
		end if;

		out.alias_name := spec.name2;

		if	spec_object	= is_street				then
			if	spec.type2 is not null			then
				out.alias_type := spec.type2;
			end if;

			if	spec.pfx2 is not null			then
				out.alias_pfx := spec.pfx2;
			end if;

			if	spec.sfx2 is not null			then
				out.alias_sfx := spec.sfx2;
			end if;
		end if;
	end if;

	if	spec.flag2 >  ' '	
	and (	spec_count =  2	
	or	spec.flag2 like like_non_address 					--	may 2002
	or	spec.flag2 like like_non_garland )			then		--	may 2002

		spec_after	 :=  2;

		if	spec.flag2 not like like_non_address			--	may 2002
		and	spec.flag2 not like like_non_garland	then		--	may 2002
			target_count := target_count + 01;
		end if;

		out.addr_name := spec.name2;

		if	spec_object	= is_street				then
			if	spec.type2 is not null			then
				out.addr_type := spec.type2;
			end if;

			if	spec.pfx2 is not null			then
				out.addr_pfx := spec.pfx2;
			end if;

			if	spec.sfx2 is not null			then
				out.addr_sfx := spec.sfx2;
			end if;
		end if;
	end if;

--	================================================================
--	process line 3	(final street)

	if	spec.flag3 > ' '						then
		spec_count := spec_count + 01;
	end if;

	if	spec_count > 0						
	and (	spec.flag3 > ' '
	or	spec_after = 3 )						then 	

		spec_after	 :=  3;
		target_count := target_count + 01;

		if	spec.flag3 like	like_name			then
			spec_object := is_name;
		else
			spec_object := is_street;
		end if;

		if	spec.flag3 like	like_non_address		then
			spec_verify	:= 	is_non_address;
		elsif	spec.flag3 like	like_non_garland		then
			spec_verify	:= 	is_non_garland;
		elsif	spec.flag3 like	like_non_correct		then
			spec_verify	:= 	is_non_correct;
		elsif	spec.flag3 like	like_verify_only		then
			spec_verify	:= 	is_verify_only;
		elsif	spec.flag3 like	like_target			then
			spec_verify	:= 	is_target;
		end if;

		out.addr_name := spec.name3;

		if	spec_object	= is_street				then
			if	spec.type3 is not null			then
				out.addr_type := spec.type3;
			end if;

			if	spec.pfx3 is not null			then
				out.addr_pfx := spec.pfx3;
			end if;

			if	spec.sfx3 is not null			then
				out.addr_sfx := spec.sfx3;
			end if;
		end if;
	end if;

--	================================================================
--	process number range
--	validate specifications

	spec_is_valid := 1;

	if	spec.lo_range > '0'				then
		if	translate (spec.lo_range, 'x1234567890', 'x') is null		then
			out.alias_lo  := spec.lo_range;		
		else
			spec_is_valid := 0;
			why_reject	  := why_reject || ' bad low /';
		end if;
	end if;

	if	spec.hi_range > '0'				then
		if	translate (spec.hi_range, 'x1234567890', 'x') is null		then
			out.alias_hi  := spec.hi_range;		
		else
			spec_is_valid := 0;
			why_reject	  := why_reject || ' bad high /';
		end if;
	end if;

	if	out.alias_lo > out.alias_hi			then
		spec_is_valid := 0;
		why_reject := why_reject || ' reversed range /';
	end if;

	if	spec_count	> 2					then
		spec_is_valid := 0;
		why_reject := why_reject || ' three specs /';
	end if;

	if	target_count > 1					then
		spec_is_valid := 0;
		why_reject := why_reject || ' two targets /';
	end if;

	if	spec_is_valid = 0				then
		reject_total := reject_total + 01;
		dbms_output.put_line ( 'reject	'  ||
			spec.flag1||'/'||spec.pfx1||'/'||spec.name1||'/'||spec.type1||'/'||spec.sfx1
			||'//	 '  || why_reject	);
	end if;

--	================================================================
--	complete the output record

	if	spec_verify  = is_target	then
		spec_verify := null;
	end if;

	posn	:= instr (spec.notes, mark_how);
	if	posn > 0
	and	length(spec.notes) - posn <= size_how	then
		spec_how := substr (spec.notes, posn + 01);
	else
		spec_how := null;
	end if;

	out.alias_how := rtrim (spec_before || spec_after || spec_verify || spec_how);

	if	spec_count > 0
	and	spec_is_valid > 0					then
		if	spec_before = 1				then
			alien_input		 := alien_input + 01;
		else
			alias_input		 := alias_input + 01;
			out.alias_reduced	 := adr_compress_name (out.alias_name, 3);
			out.alias_compact	 := adr_compress_name (out.alias_name, 4);
			out.alias_compress := adr_compress_name (out.alias_name, 9);
		end if;
	end if;

--	================================================================
--	insert the output record into either adrAlien or adrAlias

begin

	if	do_trace > 0		then	
		dbms_output.put_line ('insert	' || out.alias_name ||'/'|| out.addr_name||'/'|| 
								out.alias_how);
	end if;

	if	do_insert  > 0
	and	spec_count > 0
	and	spec_is_valid = 1					then
	
		if	spec_before = 1				then
			insert into garland.adrAlien		values
			(
				out.alias_pfx,		
				out.alias_name,		
				out.alias_type,		
				out.alias_sfx,		
	
				out.alias_lo,
				out.alias_hi,
				out.addr_min,
	
				out.addr_pfx,		
				out.addr_name,		
				out.addr_type,		
				out.addr_sfx,
	
				out.alias_how
			);
			alien_output := alien_output + 01;
		
		else
			insert into garland.adrAlias		values
			(
				out.alias_pfx,		
				out.alias_name,		
				out.alias_type,		
				out.alias_sfx,		
	
				out.alias_lo,
				out.alias_hi,
				out.addr_min,
	
				out.addr_pfx,		
				out.addr_name,		
				out.addr_type,		
				out.addr_sfx,
	
				out.alias_how,
				out.alias_reduced,		
				out.alias_compact,		
				out.alias_compress		
			);
			alias_output := alias_output + 01;
		end if;

		output_total := output_total + 01;
	end if;
 
exception

	when dup_val_on_index	then 
		dupe_total := dupe_total + 01;
		dbms_output.put_line ( 'duplicate		' 
		|| out.alias_pfx||'/'||out.alias_name||'/'||out.alias_type||'/'||out.alias_sfx||'/'
		|| out.alias_lo	);

	when others then	dbms_output.put_line ( 'others error	'
		|| out.alias_pfx||'/'||out.alias_name||'/'||out.alias_type||'/'||out.alias_sfx||'/'
		|| out.alias_lo ||'/'
		|| out.addr_pfx ||'/'||out.addr_name ||'/'||out.addr_type ||'/'||out.addr_sfx ||'/'
		);

end;

end loop;

	close	read_adrAlter;
	commit;

	dbms_output.put_line (' ');
	dbms_output.put_line ('total  input 	' || input_total	);
	dbms_output.put_line ('total  output	' || output_total	);
	dbms_output.put_line ('total  dupes	' 	  || dupe_total	);
	dbms_output.put_line ('total  reject	' || reject_total	);

	dbms_output.put_line (' ');
	dbms_output.put_line ('input  alien	 ' 	  || alien_input	);
	dbms_output.put_line ('output alien	 '	  || alien_output	);
	dbms_output.put_line (' ');
	dbms_output.put_line ('input  alias	 '	  || alias_input	);
	dbms_output.put_line ('output alias	 '	  || alias_output	);
	dbms_output.put_line (' ');
end;


--	================================================================
/*
	
feb 28,2002		do not remove extra spaces & punctuation from name1 
			user searches for alias_name like %spec_name%

*/
--	================================================================


