--	====================================================================		
x.	cursor	Read_Intersection		is

	select *	from garland.Intersection

	where ( search_key = this_search_key1
	or	  search_key = this_search_key2 )

	and 	this1_name		in (' ', addr1_name)			-- this1 = space or name
	and	this2_name		in (' ', addr2_name)  

	and	this1_name		in (spec1_type, addr1_type)		-- spec1 = space or null
	and	this1_pfx		in (spec1_pfx,  addr1_pfx)		
	and	this1_sfx		in (spec1_sfx,  addr1_sfx)

	and	this2_type		in (spec2_type, addr2_type)		-- spec2 = space or null
	and	this2_pfx		in (spec2_pfx,  addr2_pfx)
	and	this2_sfx		in (spec2_sfx,  addr2_sfx)

	and	this1_block		in (spec1_block, addr1_block)		-- spec1 = zero or null
	and	this2_block		in (spec2_block, addr2_block)		

	and	addr1_block		>= just1_block				-- just = 0,1
	and	addr2_block		>= just2_block

	order by
			decode (addr1_name,  exact1_name, 1,  close1_name, 2,  3)	+
			decode (addr2_name,  exact2_name, 1,  close2_name, 2,  3)

			addr1_name, addr1_type,	
			addr2_name,	addr2_type,	
	
			basic1 + whole1		desc, 		-- basic = 0,2
			basic2 + whole2		desc, 		-- whole = 0,1

			addr1_pfx,	addr1_sfx,	addr1_block,
			addr2_pfx,	addr2_sfx,	addr2_block
	;

--	====================================================================		
x.
	select * 
	from	garland.Intersection	

	where	basic1 + whole1 >= filter_basic_whole 
	and	basic2 + whole2 >= filter_basic_whole 

	and (
	    (	search_key		= search_key1
	and 	search11_name	in (' ', addr1_name)
	and	search12_name	in (' ', addr2_name)  )

	or  (	search_key		= search_key2
	and 	search21_name	in (' ', addr1_name)
	and	search22_name	in (' ', addr2_name)  )
	    )

	etc

--	====================================================================		
x.
	search11_name	:= this1_name
	search12_name	:= this2_name
	spec1_name		:= this1_name
	spec2_name		:= this2_name
	Construct_Search_Key;
	search1_key		:= text1;

	if	exact1 is null
	and	close1 is not null
	and	rpad(this1_name, 02) <> rpad(input1_name, 02) 	then
		search21_name := input1_name

	elsif	rpad(this1_name, 02) <> rpad(exact1_name, 02) 	then
		search21_name := exact1_name

	else
		search21_name := null
	end if;

	if	exact2 is null
	and	close2 is not null
	and	rpad(this2_name, 02) <> rpad(input2_name, 02) 	then
		search22_name := input2_name

	elsif	rpad(this2_name, 02) <> rpad(exact2_name, 02) 	then
		search22_name := exact2_name

	else
		search22_name := null
	end if;

	spec1_name	:= search21_name;
	spec2_name	:= search22_name;
	Construct_Search_Key;
	search2_key	:= text1;

--	====================================================================		
x.
	if	look.addr1_name	= search11_name
	and	look.addr2_name	= search12_name

		if	close1_name is null
		or	close2_name is null
			class1 := 4;
		else
			class1 := 3;
			if	exact1_name is not null
			or	exact2_name is not null
				class1 := 2;
				if	exact1_name is not null
				and	exact2_name is not null
					class1 := 1;

--	====================================================================		

