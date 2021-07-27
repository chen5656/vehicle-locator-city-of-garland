	set echo	off;
--	==============================================================================
--	An "alias street" consists of a primary street name with
--	optional street qualifiers (type, prefix, suffix)
--	It corresponds to an actual street name with optional qualifiers.
--	==============================================================================

--	==============================================================================
--	addr_min			employ
--	adrAlias			synonym
--	==============================================================================

--	create or replace procedure	ADR_alias_match
	create or replace procedure	TST_alias_match
	(
		alias_mail		in out	varchar2,
		user_num		in out	number,
		user_pfx		in out	varchar2,
		user_name		in out	varchar2,
		user_type		in out	varchar2,
		user_sfx		in out	varchar2,

		user_reduced	in		varchar2	default null,
		user_compact	in		varchar2	default null
	)
as

--	==========================================================================
--	weights & symbols

	do_trace			number	:= 0;
	do_test			number	:= 0;

	min_compact_ratio		number	:= 0.8;
	min_compress_ratio	number	:= 0.8;

	same_weight			number	:= 4000;
	reduced_weight		number	:= 3000;
	compact_weight		number	:= 2000;
	compress_weight		number	:= 1000;

	non_address_weight	number	:= 900;
	non_garland_weight	number	:= 800;
	capital_weight		number	:= 500;		--	upper case
	common_weight		number	:= 400;		--	lower case
	non_correct_weight	number	:= 300;
	more_weight			number	:= 200;
	like_weight			number	:= 100;
	forbid_weight		number	:= -9999;

	like_non_address		char(4)	:= '__' || rule.mark_non_address ||'%';		
	like_non_garland		char(4)	:= '__' || rule.mark_non_garland ||'%';		
	like_non_correct		char(4)	:= '__' || rule.mark_non_correct ||'%';		

	more_symbol			char(5)	:= 'more%';		
	like_symbol			char(5)	:= 'like%';		

	spec_alias_max		number	:= 999999;
	delimiters	constant	varchar2(8)	:= '-.,;:''';  
	spaces			char(40)	:= ' ';

--	==========================================================================

	return_method	varchar2(05)	:= ' ';

	ignore_count	number;		--	how many adrStreet match
	fetch_count		number;		--	how many cursor records
	fetch_best		number;		--	how many with best match weight

	major_weight	number;		
	minor_weight	number;		
	qualify_weight	number;		
	match_weight	number;		
	best_weight		number;		
	best_minor		number;		

	alias_ratio		number;	

	this_num		number;
	this_name		varchar2(80);
	this_type		varchar2(10);
	this_pfx		varchar2(10);
	this_sfx		varchar2(10);

	this_mail		varchar2(10);
	this_short		varchar2(80);
	this_begin		varchar2(80);
	this_ending		varchar2(80);
	this_reduced	varchar2(80);
	this_compact	varchar2(80);
	this_compress	varchar2(80);
	this_leading	varchar2(02);
	test_name		varchar2(80);
	this_type_name	varchar2(80);

--	======================================================
cursor	read_alien_street		is

--		truncate table	plan_table;
--		explain plan	set statement_id = 'test'	for

		select	all *
		from		adrAlien

		where	(	alias_name	like	this_leading
		or		alias_name	between '%' and '%z'	)
		and		this_name	like	alias_name ||'%'

		and		alias_type	in	('*', this_type)
		and		alias_pfx	in	('*', this_pfx)
		and		alias_sfx	in	('*', this_sfx)

		and		alias_lo				 <= this_num
		and		nvl (alias_hi, spec_alias_max) >= this_num
		;

		find		adrAlien%rowtype;
		alien		adrAlien%rowtype;

--	====================================================================
cursor	read_alias_street		is

--		truncate table	plan_table;
--		explain plan	set statement_id = 'test'	for

		select	all *
		from		adrAlias

		where	(
			(	alias_name	like this_leading
		and		alias_compact = this_compact		)		--	new

		or	(	alias_name	between '% ' and '%z'
		and		this_name	like	alias_name		)
			)

		and		alias_type	in	('*', this_type)
		and		alias_pfx	in	('*', this_pfx)
		and		alias_sfx	in	('*', this_sfx)

		and		alias_lo				 <= this_num
		and		nvl (alias_hi, spec_alias_max) >= this_num
		;

--		select * from explain_plan;
--		select * from explain_indexed;

		look		adrAlias%rowtype;
		alias		adrAlias%rowtype;

--	====================================================================

begin

	this_num	:= nvl  (user_num, 0);						--	feb28
	this_name	:= upper(user_name);
	this_type	:= upper(user_type);
	this_pfx	:= upper(user_pfx);
	this_sfx	:= upper(user_sfx);

	this_reduced:= user_reduced;
	this_compact:= user_compact;

	if	alias_mail = 'alien'		then
		this_mail	:= 'alien';
	else
		this_mail	:= 'alias';
	end if;

	if	this_mail = 'alien'		then					--	feb28
--		this_name	:= translate (this_name, delimiters, spaces);
		this_type	:= translate (this_type, delimiters, spaces);
		this_pfx	:= translate (this_pfx,  delimiters, spaces);
		this_sfx	:= translate (this_sfx,  delimiters, spaces);
	end if; 

	this_name	:= nvl (ltrim (rtrim (this_name)), ' ');	
	this_type	:= nvl (ltrim (rtrim (this_type)), ' ');	
	this_pfx	:= nvl (ltrim (rtrim (this_pfx )), ' ');	
	this_sfx	:= nvl (ltrim (rtrim (this_sfx )), ' ');	

	this_short	:= rtrim(replace (this_name||' ', 'S ', ' '));		--	feb28
/*
	this_ending	:= ADR_name_ending (this_name);
	this_begin	:= rtrim (replace  (this_name, this_ending), ' S');
	test_name	:= this_begin || this_ending;
	if	test_name   > '0'			
	and	this_ending > '0'			then
		this_short	:= test_name;
	else
		this_short	:= this_name;
	end if;
*/

	this_leading  := rpad (this_name, 01) || '%';
--	this_compress := nvl (adr_compress_name (this_short, '9'), ' ');			--	new

	if	this_mail = 'alias'								
	and	this_reduced is null							then		--	feb28
		this_reduced  := nvl(adr_compress_name (this_name, '3'),' ');
		this_compact  := nvl(adr_compress_name (this_short,'4'),' ');
	end if;

	if	do_trace > 0			then
	dbms_output.put_line ( '****************************' );
	dbms_output.put_line ( 'this= /'|| this_pfx ||'/'|| this_name ||'/'|| this_type ||'/'|| this_sfx ||'/');
	dbms_output.put_line ( 'reduced= /'|| this_reduced ||'/ compact= /'|| this_compact ||'/');
	dbms_output.put_line ( 'leading= /'|| this_leading ||'/ mail= /'|| this_mail ||'/');
	end if;

--	==========================================================================
--	if get non-exact match on adrAlias record, and exact match on adrStreet exists (ignore_count),
--	then ignore adrAlias results 			

	fetch_count	:= 0;
	fetch_best	:= 0;
	best_weight	:= 0;

	if	this_mail = 'alien'			then
		open	read_alien_street;	
	else
		open	read_alias_street;	
	end if;

loop

	if	this_mail = 'alien'			then
		fetch	read_alien_street					into find;
		exit when	read_alien_street%notfound
			or	read_alien_street%notfound is null;
	else
		fetch	read_alias_street					into look;
		exit when	read_alias_street%notfound
			or	read_alias_street%notfound is null;
	end if;

	if	do_trace > 0			then
	dbms_output.put_line ( 'alien  '||'/'|| find.alias_pfx ||'/'|| find.alias_name ||'/'|| find.alias_type ||'/'|| find.alias_sfx ||'/');
	dbms_output.put_line ( 'alias  '||'/'|| look.alias_pfx ||'/'|| look.alias_name ||'/'|| look.alias_type ||'/'|| look.alias_sfx ||'/');
	end if;
		
--	==========================================================================

	if	this_mail = 'alien'			then
		look.alias_pfx		:= find.alias_pfx;
		look.alias_name		:= find.alias_name;
		look.alias_type		:= find.alias_type;
		look.alias_sfx		:= find.alias_sfx;
		look.addr_pfx		:= find.addr_pfx;
		look.addr_name		:= find.addr_name;
		look.addr_type		:= find.addr_type;
		look.addr_sfx		:= find.addr_sfx;
		look.alias_lo		:= find.alias_lo;
		look.alias_hi		:= find.alias_hi;
		look.addr_min		:= find.addr_min;
		look.alias_how		:= find.alias_how;
	end if;
		
--	==========================================================================
	
	fetch_count	:= fetch_count + 01;

	if	this_mail = 'alias'								then
		alias_ratio := length (look.addr_name) / length (look.alias_name);	
	end if;

begin

	if	this_mail = 'alias'
	and	look.alias_reduced  <> this_reduced	
	and	this_type > '0'						then
		select	/*+ cache */	name
		into		this_type_name
		from		adrItem
		where		class = 'T'
		and		this_type in (possible, name);	
	else
		this_type_name := null;
	end if;

exception
	when others then	this_type_name := null;
end;

	if	do_trace > 0		then
	dbms_output.put_line ('bb1 ' ||'|'|| look.alias_how ||'|'|| look.alias_name ||'|'|| look.addr_name ||'|');
	dbms_output.put_line ('bb2 ' ||'|'|| this_compress  ||'|'|| this_compact    ||'|'|| this_reduced   ||'|');
	dbms_output.put_line ('bb3 ' ||'|'|| alias_ratio    ||'|'|| this_type_name  ||'|'|| '' );
	end if;

--	==========================================================================
--	set major weight

	if	lower (look.alias_how) like '1%'			then	
		major_weight 	 := same_weight;

	elsif	lower (look.alias_how) like like_symbol		then	
		major_weight	:= 0;

	elsif	look.alias_name	  = this_name			then	
		major_weight 	 := same_weight;

	elsif	look.alias_reduced  = this_reduced		
	or	this_mail		  = 'alien'				then	
		major_weight	 := reduced_weight;

	elsif	look.alias_compact  = this_compact		
	and	alias_ratio >= min_compact_ratio			then
		major_weight	 := compact_weight;

	elsif	look.alias_compress  = this_compress			
	and	alias_ratio >= min_compress_ratio			then
		major_weight	 := compress_weight;

	elsif	this_name	like rtrim(look.addr_name, 'S') || '%'	
	and	this_name	like '%' || this_type_name		then 
		major_weight	 := compact_weight;

	else
		goto	end_loop;
	end if;

	if	do_trace > 0		then
	dbms_output.put_line ('cc1' ||'|'|| major_weight ||'|'|| alias_ratio ||'|');
	end if;

--	==========================================================================
--	set minor weight

	minor_weight := forbid_weight;

	if	look.alias_how like like_non_address		then
--	or	look.alias_how like '__0%'				
		if	major_weight  >= reduced_weight		then	
			minor_weight  := non_address_weight;
		end if; 

	elsif	look.alias_how like like_non_garland		then
--	or	look.alias_how like '__1%'			
		if	major_weight  >= reduced_weight		then	
			minor_weight  := non_garland_weight;
		end if; 

	elsif	look.alias_how like like_non_correct		then	
--	or	look.alias_how like '__2%'				
		if	major_weight  >= reduced_weight		then	
			minor_weight  := non_correct_weight;
		end if; 

	elsif	look.alias_how like more_symbol			then		--	feb28
--	elsif	lower (look.alias_how) like more_symbol		then
		if	major_weight  >= compact_weight		then	
			minor_weight  := more_weight;
		end if; 

	elsif	lower (look.alias_how) like like_symbol		then
			minor_weight  := like_weight;

	elsif	look.alias_how = upper (look.alias_how)		then
		if	major_weight  >= reduced_weight		then	
			minor_weight  := capital_weight;
		end if; 

	else
			minor_weight  := common_weight;
	end if;

	if	do_trace > 0		then
	dbms_output.put_line ('cc2' ||'|'|| minor_weight ||'|'|| alias_ratio ||'|');
	end if;

--	==========================================================================
--	set qualify weight

	qualify_weight	:= 0;

	if	look.alias_type	 = this_type			then
		qualify_weight	:= qualify_weight + 01;
	end if;

	if	look.alias_pfx	 = this_pfx				then
		qualify_weight	:= qualify_weight + 01;
	end if;

	if	look.alias_sfx	 = this_sfx				then
		qualify_weight	:= qualify_weight + 01;
	end if;

	if	look.alias_lo > 0					
	or	nvl(look.alias_hi, 9999) < 9999			then
		qualify_weight	:= qualify_weight + 01;
	end if;

	if	do_trace > 0		then
	dbms_output.put_line ('cc3' ||'|'|| qualify_weight ||'|'|| alias_ratio ||'|');
	end if;

--	==========================================================================
--	keep best weight

	match_weight := major_weight + minor_weight + qualify_weight;

	if	best_weight  < match_weight				then
		best_weight	:= match_weight;
		best_minor	:= minor_weight;
		fetch_best	:= 0;
	end if;

	if	best_weight  = match_weight				then
		fetch_best 	:= fetch_best + 01;
		if	fetch_best = 01					then
			alias	:= look;
		end if;
	end if;

	if	do_trace > 0		then
	dbms_output.put_line ('dd1'	||'|'|| major_weight ||'|'|| minor_weight ||'|'|| qualify_weight ); 
	dbms_output.put_line ('dd2'	||'|'|| match_weight ||'|'|| best_weight  ||'|'|| fetch_best );
	end if;

<<end_loop>>
	null;

end loop;

	if	this_mail	= 'alien'				then
		close	read_alien_street;
	else
		close	read_alias_street;
	end if;

--	==========================================================================
<<set_return_method>>

	if	fetch_count > 0					
	and	best_weight < same_weight			then
		select count(*)
		into	 ignore_count	
		from	 adrStreet_syn
		where	 user_name	= addr_name;
	end if;

	if	do_trace > 0		then
	dbms_output.put_line ('zz1'	||'|'|| user_name ||'|'|| return_method ); 
	end if;

	if	fetch_best   = 0					
	or	ignore_count > 0					then
		return_method  := ' ';

	elsif fetch_best   > 1					then
		return_method  := 'many';

	else
		return_method := alias.alias_how;

		if	best_minor	= non_address_weight	then	
			null;

		elsif	return_method = 'asis'			then	
			return_method  := ' ';

		else
			user_name	:= nvl (alias.addr_name, this_name);
			user_type	:= nvl (alias.addr_type, this_type);
			user_pfx	:= nvl (alias.addr_pfx,  this_pfx );
			user_sfx	:= nvl (alias.addr_sfx,  this_sfx );
		end if;
	end if;

	if	do_trace > 0		then
	dbms_output.put_line ('zz2'	||'|'|| user_name ||'|'|| return_method ); 
	end if;

	alias_mail	:= return_method;
	return;

end;	

--	==============================================================================
/*	modifications

feb 28, 2002	removed use of adr_name_ending; requires far too much time
			do not remove delimiters for alien match
*/
--	==============================================================================



