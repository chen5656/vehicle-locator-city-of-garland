--	display street name audit discrepancies

	set echo		off;
	set charwidth	150;
	set serveroutput	on	size 999999;

--	======================================================================================================
--	UNMARKED RENAME

	select count(*)
	/*
	select			   chr(10)		  ||
	rpad(do_qual,40)		|| rpad(verify_code,2) 
					||' | '|| do_name ||' | '|| do_alias  ||' | '|| rpad(rec_seq,10) || chr(10) ||
	rpad(addr_num,5)		|| rpad(form_pfx,3) || rpad(form_name, 21) || rpad(form_type, 5)
					|| rpad(form_sfx,2) || chr(10)		||
	rpad(addr_num,5)		|| rpad(addr_pfx,3) || rpad(addr_name,21) || rpad(addr_type,5)
					|| rpad(addr_sfx,2) || chr(10)
	*/
	"UNMARKED"
	from garland.adrResult	

	where		do_alias not like '%/%'
	and		do_alias not like '%$%'
	and		do_alias not like '%?%'
	and		do_alias not like '%*'

	and	(	rtrim (do_name)  is not null  
	or		lower (do_alias)	like 'more%'	
	or		lower (do_alias)	like 'name%'	
		)

	and	addr_name = form_name;

--	======================================================================================================
--	RENAME ERROR
--	Name correction took place but no indicator was set
/*
--	select count(*)

	select			 
	distinct

	--	chr(10)			  ||
	--	rpad(do_qual,40)		|| rpad(verify_code,2) 
	--					||' / '|| do_name  ||' / '|| rpad(rec_seq,10) || chr(10) ||

	--	rpad(addr_num,5)		|| 

					rpad(form_pfx,3) || rpad(form_name, 21) || rpad(form_type, 5) ||
					rpad(form_sfx,2) || chr(10)		||

	--	rpad(addr_num,5)		|| 
					rpad(nvl(addr_pfx, ' '),3) || rpad(addr_name, 21) || 
					rpad(nvl(addr_type,' '),5) || rpad(nvl(addr_sfx,' '), 2) || chr(10)
	"RENAME"
	from garland.adrResult	

	where	verify_code > 0
	and	rtrim (do_name)  is null  
	and	rtrim (do_alias) is null  

	and	addr_name <> form_name;

*/

--	======================================================================================================
