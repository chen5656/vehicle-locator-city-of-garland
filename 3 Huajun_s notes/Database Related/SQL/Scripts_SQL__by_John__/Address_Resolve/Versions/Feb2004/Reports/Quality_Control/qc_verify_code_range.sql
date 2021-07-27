	set echo		off;
	set timing		off;
	set charwidth	200;
	set fetchrows	99;
--	=========================================================================================

--	=========================================================================================
--	truncate table	plan_table	reuse storage;
--	explain plan	set statement_id = '+Block -Range'		for


	select count(*)	"BAD RANGE"
	/*
	select		
	rpad(addr_num,5)		|| rpad(form_pfx ,3)|| rpad(form_name, 21)|| rpad(form_type, 5)
					|| rpad(form_sfx, 2)|| '	seq= '	|| rec_seq || chr(10) ||
	rpad(verify_code,5)	|| rpad(addr_pfx,3) || rpad(addr_name,21) || rpad(addr_type,5)
					|| rpad(addr_sfx,2) || '	alias= '	|| do_alias	
								  || '	audit= '	|| do_qual || chr(10)	
				"BAD RANGE"
	*/

	from 			garland.adrResult
	where	rowid in
(
	select rowid	from adrResult	v
	where	trunc (verify_code, -1)		= 30

	And ( not exists					--	bad name 
(									
	select 'x'
	from	garland.adrStreets			s
	where	s.addr_name	= v.addr_name
)

	or 	not exists					--	bad block
(
	select 'x'		
	from	adrBlock		r
--	from	trvehrcl		r
	where	v.addr_name	= r.addr_name
	and	trunc (v.addr_num, -2) = r.addr_block

--	and	trunc (v.addr_num, -2)	between trunc (r.addr_lo, -2)
--						and	  trunc (r.addr_hi, -2)	
--	and	r.branch_no < 9999
)
	or exists						--	good range
(
	select 'x'		from	trvehrcl		r
	where	v.addr_name	= r.addr_name
	and	v.addr_num	between r.addr_lo	 and  r.addr_hi
--	and	r.branch_no < 9999
)

))	order by	verify_code, form_name, form_type, form_pfx, form_sfx, addr_num;


--	=========================================================================================
--	explain plan	set statement_id = '+Street -Many Street'		for


	select count(*)	"PART RNG"
	/*
	select
	rpad(addr_num,5)		|| rpad(form_pfx ,3)|| rpad(form_name, 21)|| rpad(form_type, 5)
					|| rpad(form_sfx, 2)|| '	seq= '	|| rec_seq || chr(10) ||
	rpad(verify_code,5)	|| rpad(addr_pfx,3) || rpad(addr_name,21) || rpad(addr_type,5)
					|| rpad(addr_sfx,2) || '	alias= '	|| do_alias	
								  || '	audit= '	|| do_qual || chr(10)	
				"PARTIAL RANGE"
	*/

	from 			garland.adrResult
	where	rowid in
(
	select rowid	from adrResult	r
	where	verify_code =	44

	And ( not exists					--	bad street
(
	select 'x'	
	from		trvehrcl		s
	where		r.addr_name	= 	s.addr_name
	and		r.addr_type	in  (	s.addr_type, ' ')	
	and		r.addr_pfx	in  (	s.addr_pfx,  ' ')	
	and		r.addr_sfx	in  (	s.addr_sfx,  ' ')	
	and		r.addr_num	between s.addr_lo and s.addr_hi
--	and		s.branch_no < 9999)

	or exists						--	single street
(
	select 	'x'
	from		trvehrcl		s
	where		r.addr_name	= 	s.addr_name
	and		r.addr_type	in  (	s.addr_type, ' ')	
	and		r.addr_pfx	in  (	s.addr_pfx,  ' ')	
	and		r.addr_sfx	in  (	s.addr_sfx,  ' ')	
	and		r.addr_num	between s.addr_lo and s.addr_hi
--	and		s.branch_no < 9999
	group by	r.addr_name
	having	count(*) = 1
))

))	order by	verify_code, form_name, form_type, form_pfx, form_sfx, addr_num;


--	=========================================================================================
--	explain plan	set statement_id = '+Street'		for


	select count(*)	"FULL RNG"
	/*
	select
	rpad(addr_num,5)		|| rpad(form_pfx ,3)|| rpad(form_name, 21)|| rpad(form_type, 5)
					|| rpad(form_sfx, 2)|| '	seq= '	|| rec_seq || chr(10) ||
	rpad(verify_code,5)	|| rpad(addr_pfx,3) || rpad(addr_name,21) || rpad(addr_type,5)
					|| rpad(addr_sfx,2) || '	alias= '	|| do_alias	
								  || '	audit= '	|| do_qual || chr(10)	
				"FULL RANGE"

	*/

	from 			garland.adrResult
	where	rowid in
(
	select rowid	from adrResult	v
	where	verify_code		= 45

	and not exists					--	bad range
(
	select 	'x'	
	from		trvehrcl		s
	where		v.addr_name	= 	s.addr_name
	and		v.addr_type =  	s.addr_type
	and		v.addr_pfx  =  	s.addr_pfx
	and		v.addr_sfx  =  	s.addr_sfx
	and		v.addr_num	between s.addr_lo and s.addr_hi
--	and		s.branch_no < 9999
)

)	order by	verify_code, form_name, form_type, form_pfx, form_sfx, addr_num;




--	=========================================================================================
--	explain plan	set statement_id = 'Wrong'		for


	select count(*)	"WRONG SEGM"
	/*
	select
	rpad(addr_num,5)		|| rpad(form_pfx ,3)|| rpad(form_name, 21)|| rpad(form_type, 5)
					|| rpad(form_sfx, 2)|| '	seq= '	|| rec_seq || chr(10) ||
	rpad(verify_code,5)	|| rpad(addr_pfx,3) || rpad(addr_name,21) || rpad(addr_type,5)
					|| rpad(addr_sfx,2) || '	alias= '	|| do_alias	
								  || '	audit= '	|| do_qual || chr(10)	
				"WRONG SEGMENT"
	*/

	from 			garland.adrResult
	where	rowid in
(
	select v.rowid	
	from			adrResult	v
	where	verify_code 			= 43

	And ( not exists					--	bad street
(
	select 'x'	from adrStreets	s
	where		v.addr_name	= 	s.addr_name
	and		v.addr_type	in ( 	s.addr_type, ' ')	
	and		v.addr_pfx	in ( 	s.addr_pfx,  ' ')
	and		v.addr_sfx	in ( 	s.addr_sfx,  ' ')
)

	or not exists					--	bad range
(
	select 'x'	from trvehrcl	r
	where		v.addr_name	= 	r.addr_name
	and		v.addr_num	>=	r.addr_lo
	and		v.addr_num	<=	r.addr_hi
--	and		r.branch_no < 9999
)
	or exists						--	good segment
(
	select 'x'	from trvehrcl	r
	where		v.addr_name	= 	r.addr_name
	and		v.addr_num	>=	r.addr_lo
	and		v.addr_num	<=	r.addr_hi
	and		v.addr_type	in ( 	r.addr_type, '')					--	revised
	and		v.addr_pfx	in ( 	r.addr_pfx,  '')
	and		v.addr_sfx	in ( 	r.addr_sfx,  '')
--	and		r.branch_no < 9999
)

))	order by	verify_code, form_name, form_type, form_pfx, form_sfx, addr_num;


--	=========================================================================================

--	select * from explain_plan;
--	select * from explain_indexed;

	set echo		on;
	set fetchrows;

--	=========================================================================================
	set echo off;


