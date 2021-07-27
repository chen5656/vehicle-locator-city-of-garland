	set echo		off;
	set charwidth	180;
--	====================================================================
--	Display adrResult changes to be loaded to Excel for user review
--	====================================================================

	select 

/*
'1='||	decode(sign(alias_weight - 3), +1, 0, alias_weight),				-- high risk alias			

'2='||	((length(do_qual) - length(translate(do_qual,'/rc','/'))) * 100 +		-- r,c count + total count

		length(do_qual)),

'3='||	do_qual,											-- S,B,A	

'4='||	decode(sign(alias_weight - 3), +1, alias_weight, 0),				-- low risk alias

'5='||	do_name,											-- A,B,C
*/


		rpad(seq,10)			||' '||

		rpad(nvl(appl_num,' '), 06)	||' '|| 
		rpad(nvl(appl_pfx, ' '),04)	||' '|| 
		rpad(nvl(appl_name,' '),20)	||' '|| 
		rpad(nvl(appl_type,' '),06)	||' '|| 
		rpad(nvl(appl_sfx, ' '),10)	||' '|| 

		rpad(rec_key,08)			||' '||

		chr(10)||

		rpad(' ',10)			||' '||
		rpad(    addr_num||' ', 06)	||' '|| 
		rpad(nvl(addr_pfx, ' '),04)	||' '|| 
		rpad(nvl(addr_name,' '),20)	||' '|| 
		rpad(nvl(addr_type,' '),06)	||' '|| 
		rpad(nvl(addr_sfx, ' '),10)	||' '|| 


		rpad(do_alias,10)			||' '||
		rpad(do_qual, 15)			||' '||
		rpad(do_name, 05)			||
		chr(10)
	
	" "	from

(
	select
		appl_num, appl_pfx, appl_name, appl_type, appl_sfx, 
		addr_num, addr_pfx, addr_name, addr_type, addr_sfx, 
		do_alias, do_qual,  do_name,
		nvl(alias_how,' ')	alias_how,
		nvl(alias_weight,10)	alias_weight,
		rec_key,  
		rownum			seq
	from
(
	select distinct	
		r.appl_num, r.appl_pfx, r.appl_name, r.appl_type, r.appl_sfx, 
		r.addr_num, r.addr_pfx, r.addr_name, r.addr_type, r.addr_sfx, 
		r.do_alias, r.do_qual,  r.do_name,
		r.rec_key,  
		a.alias_weight, a.alias_how

	from	garland.adrResult		R,
		garland.adrAlias		A

	where	r.do_alias = a.alias_how (+)

	and	verify_code > 10

--	-------------------------------------------

	and	(
		rec_key is null		-- dummy
	or	do_name  > '0'
	or	do_alias > '0'
	or	do_qual  > '0' 
		)


--	and	do_alias > '0'
--	and	do_qual  > '0'
--	and	do_name  > '0'

--	and	rownum < 22

--	-------------------------------------------
)

	order by

		decode(sign(alias_weight - 3), +1, 10, alias_weight)	
		+ decode(rpad(alias_how, 01), '1',10, 0)						desc,	

		(length(do_qual) - length(translate(do_qual,'/rc','/'))) * 100 +			
		 length(do_qual)										asc,

--		do_qual											desc,											

		decode(sign(alias_weight - 3), +1, alias_weight, 0)
		|| decode(rpad(alias_how,1), '1', 10, 0)						desc,	

		do_name											asc,												

		addr_name,											
		addr_type,
		addr_pfx,
		addr_num
);

--	====================================================================
	set echo	on;
	set charwidth;


