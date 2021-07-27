	set echo		off;
	set charwidth	120;
--	====================================================================
--	Display adrResult changes to be loaded to Excel for user review

--	PREPARATION:	Load adrResult_(app)  into adrResult
--	====================================================================

	select 

--		rec_key  ||'|'||
		rec_seq  ||'|'||

		appl_num ||'|'|| appl_pfx  ||'|'|| appl_name ||'|'|| appl_type ||'|'|| appl_sfx ||'|'|| 

		nvl(alias_score,0)  ||'|'|| nvl(qual_score,0) ||'|'|| nvl(name_score,0) 

		||chr(10)||

		' ' ||'|'||

		addr_num ||'|'|| addr_pfx  ||'|'|| addr_name ||'|'|| addr_type ||'|'|| addr_sfx ||'|'|| 

		nvl(rtrim(do_alias),'-') ||'|'|| nvl(rtrim(do_qual),'-') ||'|'|| 
		nvl(rtrim(do_name),'-')  ||'|'|| verify_code
		
--		||'|'|| rpad(do_parse,9) 
		
		||chr(10)

	
	" "
	from	garland.adrResult	

	where	verify_code < 55
	and	verify_code > 10

	and (	do_alias > '0'
	or	do_name  > '0'
	or	do_qual  > '0' )

	and	rownum < 111

	order by	alias_score		desc, 
			qual_score		desc, 
			nvl(name_score,0);

--	====================================================================

--	select distinct do_qual from adrResult;

--	====================================================================
	set echo	on;
	set charwidth;


