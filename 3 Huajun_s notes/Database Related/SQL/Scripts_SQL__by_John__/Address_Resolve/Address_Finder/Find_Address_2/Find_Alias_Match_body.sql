	set echo	on;
--	================================================================ 
--	Correct and/or Verify Street
--	Based on Alias table match
--	================================================================ 

	Create or replace	package body   garland.Find_Alias_Match	  as 	

--	================================================================ 
--	TASKS
--		weight determines acceptability
--		unacceptable means reject revised street
--	================================================================ 
    
Function	Find_Qualifier (qualifier  in  varchar2)	 
 		return varchar2  
IS 

 	this_qualifier	varchar2(20);
 	that_qualifier	varchar2(20);
    
begin      
    
	this_qualifier := qualifier;					
 	this_qualifier := upper(ltrim(rtrim(this_qualifier,' .')));

	if	this_qualifier is null		then			
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
--	=========================================================================       
  
 procedure	Main
( 
	pass_num		in		number,
	pass_pfx		in out	varchar2,   
	pass_name		in out	varchar2,  
	pass_type		in out	varchar2,  
	pass_sfx		in out	varchar2,   
    
	pass_exact		   out	varchar2,	-- reduced name match
	pass_close		   out	varchar2,	-- compact name
	pass_also		   out	varchar2,	-- transpose & rhyme

	pass_match		   out	number,	-- alias match
	pass_count		   out	number,	-- match count
	pass_method		   out	varchar2,	-- alias method    
	pass_weight		   out	varchar2	-- alias weight      
) 
 IS 

--	=========================================================================       
    
  	do_trace			binary_integer	:= 0;

 	this_name			varchar2(40);
 	this_type			varchar2(10);
 	this_pfx			varchar2(10);
 	this_sfx			varchar2(10);
 	this_num			binary_integer;
    
 	compact_name		varchar2(40);
 	reduced_name		varchar2(40);
 	exact_name			varchar2(40);

 	also_list1			varchar2(80);
 	also_list2			varchar2(80);
    
 	one_method			binary_integer;
 	one_name			binary_integer;
 	read_count			binary_integer;

--	----------------------------------------------------------------------  
 	  
cursor	Read_Alias_Match		is        

	select 	all *		from
    (
 	select	alias_pfx, alias_name,  alias_type,  alias_sfx,
 			addr_pfx,  addr_name,   addr_type,   addr_sfx,
			alias_how, alias_match, alias_weight,
			decode (alias_reduced, reduced_name, 1, 2)	alias_class

 	from		garland.adrAlias    

	where		alias_how > 'A'
    
 	and	(	alias_compact  =  compact_name  
 	or	(	alias_name	between '% ' and '%z'
 	and		this_name	like	alias_name	)	)        
    
 	and		alias_type		in ('*', this_type)      
 	and		alias_pfx		in ('*', this_pfx)        
 	and		alias_sfx		in ('*', this_sfx)        
 	and	(	this_num	between alias_lo and alias_hi       
	or		this_num = 0	)
    )
 	order by	alias_class,   
 			alias_match		desc;
    
 	FIRST		Read_Alias_Match%rowtype;

--	----------------------------------------------------------------------  
begin      
    
 	this_num		:= pass_num;
 	this_name		:= upper(pass_name);
 	this_pfx		:= upper(nvl(pass_pfx, ' '));
 	this_type		:= upper(nvl(pass_type,' '));
 	this_sfx		:= upper(nvl(pass_sfx, ' '));

	this_type		:= FIND_QUALIFIER (this_type);
	this_pfx		:= FIND_QUALIFIER (this_pfx);
	this_sfx		:= FIND_QUALIFIER (this_sfx);

 	reduced_name 	:= garland.MAKE_COMPRESS_NAME (this_name, '2');
 	compact_name 	:= garland.MAKE_COMPRESS_NAME (this_name, '4');

	FIRST			:= null;
	also_list1		:= null;
	also_list2		:= null;
 	read_count		:= 0;
 	one_name		:= 0;
 	one_method		:= 0;
    
 	if	do_trace > 0			then     
 	dbms_output.put_line ( 'INITIAL' ); 
	dbms_output.put_line ( 'this name   ' ||this_name||'/'||this_type||'/'||this_pfx||'/'||this_sfx||'/'||this_num);
 	dbms_output.put_line ( 'compress    ' ||reduced_name ||'/'|| compact_name );
 	null;
 	end if;
    
for look in Read_Alias_Match		loop 
    
     	if	do_trace > 0		then     
 	dbms_output.put_line ( 'LOOK' ); 
 	dbms_output.put_line ( 'look alias /' || look.alias_pfx||'/'||look.alias_name||'/'||look.alias_type||'/'||look.alias_sfx   );
 	dbms_output.put_line ( 'look addr  /' || look.addr_pfx ||'/'||look.addr_name ||'/'||look.addr_type ||'/'||look.addr_sfx    );
 	dbms_output.put_line ( 'look match /' || look.alias_match ||'/'|| look.alias_weight ||'/'|| look.alias_how );
 	null;
 	end if;

 	if	look.alias_class = 01				then
		exact_name	:= look.addr_name;
 	end if;

 	if	look.alias_weight = also_class   		then
		if	look.alias_how = 'transpose'		then
			also_list1	:= also_list1 || look.addr_name ||' ';
		else	
			also_list2	:= also_list2 || look.addr_name ||' ';
		end if;
 		goto	end_look;
	end if;
    
 	if  (	look.alias_class	> first.alias_class
 	or	look.alias_match	< first.alias_match )		then       
		exit;
 	end if;
    
 	read_count	:= read_count + 01;

 	if	read_count = 1						then
 		first		:= look;
		one_name	:= 1;
		one_method	:= 1;
	else
	 	if	look.addr_name <> first.addr_name		then
			one_name	:= 0;
		end if;

	 	if	look.alias_how <> first.alias_how	then
			one_method	:= 0;
		end if;
 	end if;
	
     	if	do_trace > 0			then     
 	dbms_output.put_line ( 'LOOKED' ); 
 	dbms_output.put_line('first  /'|| first.addr_pfx ||'/'|| first.addr_name ||'/'|| first.addr_type );
 	dbms_output.put_line('read   /'|| read_count	 ||'/'|| read_count);
 	null;
 	end if;

<<end_look>>       
 	null;
end loop;
    
--	====================================================================    
--	revise street

	if	one_name = 1				then
		this_name	:= first.addr_name;
	end if;

	if	read_count = 1				then
		this_type	:= nvl(first.addr_type, this_type);		
		this_pfx	:= nvl(first.addr_pfx,  this_pfx);
		this_sfx	:= nvl(first.addr_sfx,  this_sfx);
	end if;

--	====================================================================    
    
 	if	do_trace > 0			then     
 	dbms_output.put_line ( 'PASS' ); 
 	dbms_output.put_line ( 'that       /'|| this_pfx	||'/'|| this_name   ||'/'|| this_type ||'/'|| this_sfx);
 	dbms_output.put_line ( 'method     /'|| one_method	||'/'|| one_name	);
 	dbms_output.put_line ( 'read       /'|| read_count	||'/' );
 	dbms_output.put_line ( 'name       /'|| first.addr_name  );
 	dbms_output.put_line ( 'also       /'|| also_list1	||'/'|| also_list2 ||'/');
	dbms_output.put_line ( ' ' );
 	null;
 	end if;
    
	pass_pfx		:= this_pfx;
	pass_name		:= this_name;
	pass_type		:= this_type;
	pass_sfx		:= this_sfx;
    
	pass_exact		:= exact_name;
	pass_close		:= compact_name;
	pass_match		:= first.alias_match;
	pass_count		:= read_count;

	pass_also		:= also_list1;
	if	also_list2 is not null		then
		pass_also	:= pass_also ||' ; '|| also_list2;
	end if;

	if	one_method = 1			then
		pass_method		:= first.alias_how;
		pass_weight		:= first.alias_weight;
	else
		pass_method		:= null;
		pass_weight		:= null;
	end if;

	if	do_trace > 0			then
	dbms_output.put_line ( '*******************************************************' );
	null;
	end if;
    
end	Main;
    
--	================================================================        

end	Find_Alias_Match;

--	================================================================        
