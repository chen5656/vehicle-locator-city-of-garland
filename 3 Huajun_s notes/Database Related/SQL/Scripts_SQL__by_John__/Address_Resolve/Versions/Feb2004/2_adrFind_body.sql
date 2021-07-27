	set echo	off;

--	JAN 2005

--	================================================================ 
--	Address Finder / Verification modules    
--	================================================================ 

	Create or replace	package body	ADR_FIND		as 	--  perm     

--	Create or replace	package body	ADR_FIND_01		as 	--  test     

--	================================================================ 
--	TASKS
--		user object type = alias pass parameters
--		build adrAlias using Block table

--	================================================================ 
/*	modifications

	jan 2005		exact name match takes precedence of reduced name match

*/
--	================================================================        
    
Function	Find_Qualifier (qualifier  in  varchar2)	 
 		return varchar2  

is 
 	this_qualifier	varchar2(20);
 	that_qualifier	varchar2(20);
    
begin      
    
	this_qualifier := qualifier;						-- nov 2003
 	this_qualifier := upper(ltrim(rtrim(this_qualifier,' .')));

	if	this_qualifier is null		then				-- nov 2003
		that_qualifier := ' ';	
		goto	eoj;
	end if;
    
begin      
 	select standard	  
 	into  that_qualifier      
 	from  adrItem	    
 	where class	in  ('D', 'T')        
 	and	possible = this_qualifier;
exception  
 	when others then	that_qualifier := this_qualifier;	
end;
    
<<eoj>>

 	return	nvl(that_qualifier,' ');
    
end	Find_Qualifier;
    
--	=========================================================================       
--	tasks   
--		pass_second, pass_list			merge
--	=========================================================================       
  
 procedure	Find_Alias	      
( 
	pass_num		in		number,
	pass_pfx		in out	varchar2,   
	pass_name		in out	varchar2,  
	pass_type		in out	varchar2,  
	pass_sfx		in out	varchar2,   
    
	pass_second		   out	varchar2,	-- additional best match
	pass_list		   out	varchar$v,	-- "also" list (transpose, rhyme, etc)

	pass_method		   out	varchar2,	-- alias method    
	pass_match		   out	varchar2,	-- match score = name + qualifiers + best count
	pass_weight		   out	varchar2	-- alias weight      
) 
is 
    
  	do_trace			binary_integer	:= 01;

	spec_asis			varchar2(10)	:= 'asis';		-- jan 2005
    
 	what_match			binary_integer;	
 	what_weight			binary_integer;
 	what_class			binary_integer;
 	what_priority		binary_integer;				-- nov 2004
 	what_count			binary_integer;

 	best_match			binary_integer;
 	best_weight			binary_integer;
 	best_priority		binary_integer;				-- nov 2004
 	best_count			binary_integer;
	best_method			varchar2(10);
    
 	compact_name		varchar2(40);
 	reduced_name		varchar2(40);

 	this_name			varchar2(40);
 	this_type			varchar2(10);
 	this_pfx			varchar2(10);
 	this_sfx			varchar2(10);
 	this_num			binary_integer;

	also_count			binary_integer;
	list_array			varchar$v;
    
--	----------------------------------------------------------------------  
 	  
cursor	Read_Alias_Match		is        
    
 	select	all *
 	from		garland.adrAlias    
    
 	where	(	alias_compact  =  compact_name  
 	or	(	alias_name	between '% ' and '%z'
 	and		this_name	like	alias_name	)	)        
    
 	and		alias_type		in ('*', this_type)      
 	and		alias_pfx		in ('*', this_pfx)        
 	and		alias_sfx		in ('*', this_sfx)        
 	and	(	this_num	between alias_lo and alias_hi       
	or		nvl(this_num,0) = 0			)			-- nov 2004
    
 	order by	decode (alias_reduced, reduced_name, 1,2),   
 			alias_match		desc,
 			alias_priority	asc,						-- dec 2004
 			alias_weight	desc;
    
 	FIRST		read_alias_match%rowtype;
     	SECOND	read_alias_match%rowtype;

--	----------------------------------------------------------------------  
begin      

	if	do_trace > 0				then
	-- dbms_output.put_line ( '*********** adrFind ***********' );
	null;
	end if;
    
 	this_num		:= pass_num;
 	this_name		:= upper(pass_name);
 	this_pfx		:= upper(nvl(pass_pfx, ' '));
 	this_type		:= upper(nvl(pass_type,' '));
 	this_sfx		:= upper(nvl(pass_sfx, ' '));

	list_array		:= varchar$v (' ',' ',' ',' ',' ',' ',' ',' ',' ',' ');	
    
 	reduced_name 	:= garland.ADR_COMPRESS_NAME (this_name, '1');
 	compact_name 	:= garland.ADR_COMPRESS_NAME (this_name, '4');
	first			:= null;
	second		:= null;

	best_method		:= null;
	best_weight		:= null;
	best_match		:= null;					-- dec 2003
	best_priority	:= null;					-- dec 2004
 	best_count		:= 0;
 	what_count		:= 0;
	also_count		:= 0;
    
 	if	do_trace > 0			then     
	-- dbms_output.put_line ( 'this name   ' ||this_name||'/'||this_type||'/'||this_pfx||'/'||this_sfx||'/'||this_num);
 	-- dbms_output.put_line ( 'compress    ' ||reduced_name ||'/'|| compact_name );
 	null;
 	end if;
    
for look in read_alias_match		loop 
    
     	if	do_trace > 0			then     
 	-- dbms_output.put_line ( ' ');
 	-- dbms_output.put_line ( 'look name  /' || look.addr_pfx||'/'||look.addr_name||'/'||look.addr_type||'/'||look.addr_sfx    );
 	-- dbms_output.put_line ( 'look match /' || look.alias_match ||'/'|| look.alias_priority ||'/'|| look.alias_weight ||'/'|| look.alias_how );
 	null;
 	end if;

	what_weight		:= look.alias_weight;
 	what_class		:= trunc(look.alias_weight, -2);	     
	what_priority	:= look.alias_priority;					-- dec 2004

 	if	look.alias_reduced = reduced_name			then
 		what_match	:= reduced_score + look.alias_match;
 	else
 		what_match	:= compact_score + look.alias_match;
 	end if;

 	if	what_class = also_class   
	and	also_count < also_max					then
		list_array (list_also_start + also_count)	:= look.addr_name;
		also_count	:= also_count + 01;
--		if do_trace > 0 then -- dbms_output.put_line ('also   ' || look.addr_name); end if;
 		goto	end_look;

	elsif	lower(look.alias_how) like partial_method		then
		second.addr_name := look.addr_name || '%';
	end if;

--	if	look.alias_how  = spec_asis						-- jan 2005
--	and	look.alias_name = this_name			then
--		what_count	:= 0;
--	end if;
    
 	what_count	:= what_count + 01;
    
 	if	what_count   = 1					then
 		best_count	:= 0;
 	elsif	what_match	  < best_match
 	or	what_priority > best_priority			then       		-- dec 2004
		exit;
 	end if;

	if	what_count = 1								-- dec 2003
	or	what_weight  = best_weight			then
		best_count	:= best_count + 01;
	end if;

 	if	what_count = 1					then			-- dec 2003
 		first		  := look;
		best_method   := look.alias_how;
 		best_match	  := what_match;
 		best_priority := what_priority;					-- dec 2004
 		best_weight	  := what_weight;

 	elsif	what_count = 2					then			-- dec 2003
 		second	:= look;
 	end if;
	
     	if	do_trace > 0			then     
 	-- dbms_output.put_line('first  '|| first.addr_pfx   ||'/'|| first.addr_name  ||'/'|| first.addr_type  );
 	-- dbms_output.put_line('second '|| second.addr_pfx  ||'/'|| second.addr_name ||'/'|| second.addr_type );
 	-- dbms_output.put_line('what;best   '||what_match ||';'||best_match||' '||what_weight||';'||best_weight||' '||what_count||';'||best_count);
 	null;
 	end if;

<<end_look>>       
 	null;
end loop;
    
--	====================================================================    

 	if	best_count in (1,2)		then							-- dec 2003

		if	best_count = 1
		or	second.addr_name	= first.addr_name 		then
			this_name	:= first.addr_name;

			if	best_count = 1	
			or	second.addr_type = first.addr_type 		then

				if	first.alias_type <> '*'			then
					this_type	:= ' ';
				end if;

				this_type	:= nvl(first.addr_type, this_type);			-- dec 2003

			end if;

			if	best_count = 1
			or	second.addr_pfx = first.addr_pfx	 	then

				if	first.alias_pfx <> '*'			then
					this_pfx	:= ' ';
				end if;

				this_pfx	:= nvl(first.addr_pfx, this_pfx);
			end if;

			if	best_count = 1
			or	second.addr_sfx = first.addr_sfx	 	then

				if	first.alias_sfx <> '*'			then
					this_sfx	:= ' ';
				end if;

				this_sfx	:= nvl(first.addr_sfx, this_sfx);
			end if;

		end if;

	end if;

--	====================================================================    
    
 	if	do_trace > 0			then     
 	-- dbms_output.put_line ( 'that        '|| this_pfx	||'/'|| this_name   ||'/'|| this_type ||'/'|| this_sfx);
 	-- dbms_output.put_line ( 'method      '|| best_method	||'/'|| best_weight				);
 	-- dbms_output.put_line ( 'match       '|| best_match	||'/'|| best_count  ||'/'|| also_count	);
 	-- dbms_output.put_line ( '1st/2nd     '|| first.addr_name  ||'/'|| second.addr_name			);
 	-- dbms_output.put_line ( 'also        '|| list_array(1)	||';'|| list_array(2) ||';'||list_array(3));
	-- dbms_output.put_line ( ' ' );
 	null;
 	end if;
    
	pass_name		:= this_name;
	pass_type		:= this_type;
	pass_pfx		:= this_pfx;
	pass_sfx		:= this_sfx;
    
	pass_second		:= second.addr_name;
	pass_list		:= list_array;

	pass_match		:= rtrim(best_match);
--	pass_match		:= best_match ||'.'|| best_count || also_count;

	if	best_count = 1		then
		pass_method		:= best_method;
		pass_weight		:= best_weight;
	else
		pass_method		:= null;
		pass_weight		:= null;
	end if;

	if	do_trace > 0			then
	-- dbms_output.put_line ( '*******************************************************' );
	null;
	end if;
    
end	Find_Alias;
    
--	================================================================        

end;

