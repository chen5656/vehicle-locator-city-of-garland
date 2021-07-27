	set echo		off;
	set timing		off;
	set charwidth	200;
	set fetchrows	99;
--	truncate table	plan_table	reuse storage;

--	=========================================================================================
--	modifications
--		adrResult
--		test branch_no < 9999
--	=========================================================================================
--	explain plan	set statement_id = '-Name'		for

	select count(*)	"BAD NAME"
	/*
	select
	rpad(addr_num,5)		|| rpad(form_pfx ,3)|| rpad(form_name, 21)|| rpad(form_type, 5)
					|| rpad(form_sfx, 2)|| '	seq= '	|| rec_seq || chr(10) ||
	rpad(verify_code,5)	|| rpad(addr_pfx,3) || rpad(addr_name,21) || rpad(addr_type,5)
					|| rpad(addr_sfx,2) || '	alias= '	|| do_alias	
								  || '	audit= '	|| do_qual || chr(10)	
				"BAD NAME"
	*/

	from 			garland.adrResult
	where	rowid in
(
	select rowid	from garland.adrResult	v
	where	verify_code		< 10
	and	ltrim(addr_name, '0123456789') is null

	and exists						--	good name 
(									
	select 'x'
	from	garland.adrStreets			s
	where	s.addr_name	= v.addr_name
)

)	order by	verify_code, form_name, form_type, form_pfx, form_sfx, addr_num;

--	=========================================================================================
--	explain plan	set statement_id = '+Name -Number'		for

	select count(*)	"STREET ONLY"
	/*
	select
	rpad(addr_num,5)		|| rpad(form_pfx ,3)|| rpad(form_name, 21)|| rpad(form_type, 5)
					|| rpad(form_sfx, 2)|| '	seq= '	|| rec_seq || chr(10) ||
	rpad(verify_code,5)	|| rpad(addr_pfx,3) || rpad(addr_name,21) || rpad(addr_type,5)
					|| rpad(addr_sfx,2) || '	alias= '	|| do_alias	
								  || '	audit= '	|| do_qual || chr(10)	
				"STREET ONLY"
	*/

	from 			garland.adrResult
	where	rowid in
(
	select rowid	from garland.adrResult	v
	where	trunc (verify_code, -1)		= 10
	and	verify_code				> 10

	And (nvl (addr_num,0) > 0			--	good number 

	or not exists					--	bad name
(
	select 'x'
	from	garland.adrStreets			s
	where	s.addr_name	= v.addr_name
)

))	order by	verify_code, form_name, form_type, form_pfx, form_sfx, addr_num;

--	=========================================================================================
--	explain plan	set statement_id = '+Format -Block'		for

	select count(*)	"BAD BLOCK"
	/*
	select	
	rpad(addr_num,5)		|| rpad(form_pfx ,3)|| rpad(form_name, 21)|| rpad(form_type, 5)
					|| rpad(form_sfx, 2)|| '	seq= '	|| rec_seq || chr(10) ||
	rpad(verify_code,5)	|| rpad(addr_pfx,3) || rpad(addr_name,21) || rpad(addr_type,5)
					|| rpad(addr_sfx,2) || '	alias= '	|| do_alias	
								  || '	audit= '	|| do_qual || chr(10)	
				"BAD BLOCK"
	*/

	from 			garland.adrResult
	where	rowid in
(
	select rowid	from garland.adrResult	v
	where	trunc (verify_code, -1)		= 20

	And (nvl (addr_num, '0') = '0'		--	no number 

	or not exists					--	bad name 
(									
	select 'x'
	from	adrStreets					s
	where	s.addr_name	= v.addr_name
)

	or exists						--	good block
(
	select 'x'		from	trvehrcl		r
	where replace (v.addr_num, '0123456789') is null
	and	v.addr_name	= r.addr_name
	and	trunc (v.addr_num, -2)	between trunc (r.addr_lo, -2)
						and	  trunc (r.addr_hi, -2)	
--	and	r.branch_no < 9999
)

))	order by	verify_code, form_name, form_type, form_pfx, form_sfx, addr_num;

--	=========================================================================================
--	explain plan	set statement_id = '+Block -Range'		for

--	=========================================================================================
--	explain plan	set statement_id = '+Range -Number'		for

	select count(*)	"BAD ADDRESS"
	/*
	select
	rpad(addr_num,5)		|| rpad(form_pfx ,3)|| rpad(form_name, 21)|| rpad(form_type, 5)
					|| rpad(form_sfx, 2)|| '	seq= '	|| rec_seq || chr(10) ||
	rpad(verify_code,5)	|| rpad(addr_pfx,3) || rpad(addr_name,21) || rpad(addr_type,5)
					|| rpad(addr_sfx,2) || '	alias= '	|| do_alias	
								  || '	audit= '	|| do_qual || chr(10)	
				"BAD ADDRESS"
	*/

	from 			garland.adrResult
	where	rowid in
(
	select rowid	from garland.adrResult	v
	where	trunc (verify_code, -1)		= 40

	and	nvl (v.addr_num, 0) > 0

	And ( exists					--	good number	
(
	select 'x'		from	cdreladr		a
	where	v.addr_name	= a.addr_name
	and	v.addr_num	= a.addr_num
)
	or not exists					--	bad name
(
	select 'x'		from	adrStreets		s
	where	v.addr_name	= s.addr_name
)
	or not exists					--	bad range
(
	select 'x'		from	trvehrcl		r
	where	v.addr_name	= r.addr_name
	and	v.addr_num	between r.addr_lo	 and  r.addr_hi
--	and	r.branch_no < 9999
)

))	order by	verify_code, form_name, form_type, form_pfx, form_sfx, addr_num;

--	=========================================================================================
--	explain plan	set statement_id = '+Name +Number'		for

	select count(*)	"GOOD ADDR"
	/*
	select
	rpad(addr_num,5)		|| rpad(form_pfx ,3)|| rpad(form_name, 21)|| rpad(form_type, 5)
					|| rpad(form_sfx, 2)|| '	seq= '	|| rec_seq || chr(10) ||
	rpad(verify_code,5)	|| rpad(addr_pfx,3) || rpad(addr_name,21) || rpad(addr_type,5)
					|| rpad(addr_sfx,2) || '	alias= '	|| do_alias	
								  || '	audit= '	|| do_qual || chr(10)	
				"GOOD ADDRESS"
	*/

	from 			garland.adrResult
	where	rowid in
(
	select rowid	from garland.adrResult	v
	where	trunc (verify_code, -1)		= 50

	and not exists					--	bad name or number 
(									
	select 'x'
	from	cdreladr					a
	where	a.addr_name	= v.addr_name
	and	a.addr_num	= v.addr_num
)

)	order by	verify_code, form_name, form_type, form_pfx, form_sfx, addr_num;


--	=========================================================================================
--	=========================================================================================
--	explain plan	set statement_id = '+Name -Quals'		for

	select count(*)	"POOR"
	/*
	select
	rpad(addr_num,5)		|| rpad(form_pfx ,3)|| rpad(form_name, 21)|| rpad(form_type, 5)
					|| rpad(form_sfx, 2)|| '	seq= '	|| rec_seq || chr(10) ||
	rpad(verify_code,5)	|| rpad(addr_pfx,3) || rpad(addr_name,21) || rpad(addr_type,5)
					|| rpad(addr_sfx,2) || '	alias= '	|| do_alias	
								  || '	audit= '	|| do_qual || chr(10)	
				"POOR STREET"
	*/

	from 			garland.adrResult
	where	rowid in
(
	select rowid	from garland.adrResult	v
	where	verify_code			> 9
	and	mod(verify_code,10) 	= 1

	And ( not exists					--	bad name
(
	select 'x'		from	garland.adrStreets		s
	where	v.addr_name	= s.addr_name
)

	Or ( exists						--	good type
(
	select 'x'		from	garland.adrStreets		s
	where		v.addr_name	= 		s.addr_name
	and		v.addr_type	in ( ' ',	s.addr_type	)
)

	and exists						--	good prefix
(
	select 'x'		from	garland.adrStreets		s
	where		v.addr_name	= 		s.addr_name
	and		v.addr_pfx	in ( ' ',	s.addr_pfx	)
)

	and exists						--	good suffix
(
	select 'x'		from	garland.adrStreets		s
	where		v.addr_name	= 		s.addr_name
	and		v.addr_sfx	in ( ' ',	s.addr_sfx	)
)

)))	order by	verify_code, form_name, form_type, form_pfx, form_sfx, addr_num;

--	=========================================================================================
--	explain plan	set statement_id = '+Name +Quals -Street'		for

	select count(*)	"MIXED"
	/*
	select
	rpad(addr_num,5)		|| rpad(form_pfx ,3)|| rpad(form_name, 21)|| rpad(form_type, 5)
					|| rpad(form_sfx, 2)|| '	seq= '	|| rec_seq || chr(10) ||
	rpad(verify_code,5)	|| rpad(addr_pfx,3) || rpad(addr_name,21) || rpad(addr_type,5)
					|| rpad(addr_sfx,2) || '	alias= '	|| do_alias	
								  || '	audit= '	|| do_qual || chr(10)	
				"MIXED STREET"
	*/

	from 			garland.adrResult
	where	rowid in
(
	select rowid	from garland.adrResult	v
	where	verify_code			> 9
	and	mod(verify_code,10)	= 2

	And ( exists					--	good street
(
	select 'x'		from	garland.adrStreets		s
	where		v.addr_name	= 		s.addr_name
	and		v.addr_type	in ( ' ',	s.addr_type	)
	and		v.addr_pfx	in ( ' ',	s.addr_pfx	)
	and		v.addr_sfx	in ( ' ',	s.addr_sfx	)
)

	or not exists					--	bad name
(
	select 'x'
	from		adrStreets				s	
	where		s.addr_name = v.addr_name
)
	or not exists					--	bad type
(
	select 'x'		from	garland.adrStreets		s
	where		v.addr_name	= 		s.addr_name
	and		v.addr_type	in ( ' ',	s.addr_type	)
)
	or not exists					--	bad prefix
(
	select 'x'		from	garland.adrStreets		s
	where		v.addr_name	= 		s.addr_name
	and		v.addr_pfx	in ( ' ',	s.addr_pfx	)
)
	or not exists					--	bad suffix
(
	select 'x'		from	garland.adrStreets		s
	where		v.addr_name	= 		s.addr_name
	and		v.addr_sfx	in ( ' ',	s.addr_sfx	)
)

))	order by	verify_code, form_name, form_type, form_pfx, form_sfx, addr_num;

--	=========================================================================================
--	explain plan	set statement_id = '+Street -Many Street'		for

	select count(*)	"PART STR"
	/*
	select
	rpad(addr_num,5)		|| rpad(form_pfx ,3) || rpad(form_name,21)|| rpad(form_type, 5)
					|| rpad(form_sfx, 2) || '	seq= '	|| rec_seq || chr(10) ||
	rpad(verify_code,5)	|| rpad(addr_pfx,3)  || rpad(addr_name,21)|| rpad(addr_type,5)
					|| rpad(addr_sfx,2)  || '	alias= '	|| do_alias	
								   || '	audit= '	|| do_qual || chr(10)	
				"PARTIAL STREET"
	*/

	from 			garland.adrResult
	where	rowid in
(
	select rowid	from garland.adrResult	r
	where	verify_code	in ( 14, 24 )

	And ( not exists					--	bad street
(
	select 	'x'	
	from		garland.adrStreets		s
	where		r.addr_name	= 	s.addr_name
	and		r.addr_type	in  (	s.addr_type, ' ')	
	and		r.addr_pfx	in  (	s.addr_pfx,  ' ')	
	and		r.addr_sfx	in  (	s.addr_sfx,  ' ')	
)
	or exists						--	single street
(
	select 	'x'
	from		garland.adrStreets		s
	where		r.addr_name	= 	s.addr_name
	and		r.addr_type	in  (	s.addr_type, ' ')	
	and		r.addr_pfx	in  (	s.addr_pfx,  ' ')	
	and		r.addr_sfx	in  (	s.addr_sfx,  ' ')	
	group by	s.addr_name
	having	count(*) = 1
)

))	order by	verify_code, form_name, form_type, form_pfx, form_sfx, addr_num;

--	=========================================================================================
--	explain plan	set statement_id = '+Street -Many Street'		for

	select count(*)	"PART BLK"
	/*
	select
	rpad(addr_num,5)		|| rpad(form_pfx ,3) || rpad(form_name, 21)|| rpad(form_type, 5)
					|| rpad(form_sfx, 2) || '	seq= '	 || rec_seq || chr(10) ||
	rpad(verify_code,5)	|| rpad(addr_pfx,3)  || rpad(addr_name,21) || rpad(addr_type,5)
					|| rpad(addr_sfx,2)  || '	alias= '	 || do_alias	
								   || '	audit= '	 || do_qual || chr(10)	
				"PARTIAL BLOCK"
	*/


	from 			garland.adrResult
	where	rowid in
(
	select rowid	from garland.adrResult	r
	where	verify_code	=	34

	And ( not exists					--	bad block
(
	select 'x'	
	from		block		s
	where		r.addr_name	= 	s.addr_name
	and		r.addr_type	in  (	s.addr_type, ' ')	
	and		r.addr_pfx	in  (	s.addr_pfx,  ' ')	
	and		r.addr_sfx	in  (	s.addr_sfx,  ' ')	
	and		trunc(r.addr_num,-2) = s.addr_block	
)

	or exists						--	single block
(
	select 	'x'
	from		block		S
	where		r.addr_name	= 	s.addr_name
	and		r.addr_type	in  (	s.addr_type, ' ')	
	and		r.addr_pfx	in  (	s.addr_pfx,  ' ')	
	and		r.addr_sfx	in  (	s.addr_sfx,  ' ')	
	and		trunc(r.addr_num,-2) = s.addr_block	
	group by	r.addr_name
	having	count(*) = 1
)

))	order by	verify_code, form_name, form_type, form_pfx, form_sfx, addr_num;


--	=========================================================================================
--	explain plan	set statement_id = '+Street -Many Street'		for

--	=========================================================================================
--	explain plan	set statement_id = '+Street -Many Street'		for

	select count(*)	"PART ADR"
	/*
	select
	rpad(addr_num,5)		|| rpad(form_pfx ,3)|| rpad(form_name, 21)|| rpad(form_type, 5)
					|| rpad(form_sfx, 2)|| '	seq= '	|| rec_seq || chr(10) ||
	rpad(verify_code,5)	|| rpad(addr_pfx,3) || rpad(addr_name,21) || rpad(addr_type,5)
					|| rpad(addr_sfx,2) || '	alias= '	|| do_alias	
								  || '	audit= '	|| do_qual || chr(10)	
				"PARTIAL ADDRESS"
	*/

	from 			garland.adrResult
	where	rowid in
(
	select rowid	from garland.adrResult	r
	where	verify_code	=	54

	And ( not exists					--	bad address
(
	select 'x'	
	from		cdreladr		s
	where		r.addr_name	= 	s.addr_name
	and		r.addr_num	=	s.addr_num
	and		r.addr_type	in  (	s.addr_type, ' ')	
	and		r.addr_pfx	in  (	s.addr_pfx,  ' ')	
	and		r.addr_sfx	in  (	s.addr_sfx,  ' ')	
)

	or exists						--	single address
(
	select 	'x'
	from		cdreladr		s
	where		r.addr_name	= 	s.addr_name
	and		r.addr_num	=	s.addr_num
	and		r.addr_type	in  (	s.addr_type, ' ')	
	and		r.addr_pfx	in  (	s.addr_pfx,  ' ')	
	and		r.addr_sfx	in  (	s.addr_sfx,  ' ')	
	group by	r.addr_name
	having	count(*) = 1
)

))	order by	verify_code, form_name, form_type, form_pfx, form_sfx, addr_num;

--	=========================================================================================
--	explain plan	set statement_id = '+Street'		for

	select count(*)	"FULL STR"
	/*
	select
	rpad(addr_num,5)		|| rpad(form_pfx ,3)|| rpad(form_name, 21)|| rpad(form_type, 5)
					|| rpad(form_sfx, 2)|| '	seq= '	|| rec_seq || chr(10) ||
	rpad(verify_code,5)	|| rpad(addr_pfx,3) || rpad(addr_name,21) || rpad(addr_type,5)
					|| rpad(addr_sfx,2) || '	alias= '	|| do_alias	
								  || '	audit= '	|| do_qual || chr(10)	
				"FULL STREET"

	*/

	from 			garland.adrResult
	where	rowid in
(
	select rowid	from garland.adrResult	v
	where	verify_code	in ( 15, 25 )				

	and not exists					--	bad street
(
	select 	'x'	
	from		garland.adrStreets		s
	where		v.addr_name	= 	s.addr_name
	and		v.addr_type =  	s.addr_type
	and		v.addr_pfx  =  	s.addr_pfx
	and		v.addr_sfx  =  	s.addr_sfx
)

)	order by	verify_code, form_name, form_type, form_pfx, form_sfx, addr_num;

--	=========================================================================================
--	explain plan	set statement_id = '+Street'		for

	select count(*)	"FULL BLK"
	/*
	select
	rpad(addr_num,5)		|| rpad(form_pfx ,3)|| rpad(form_name, 21)|| rpad(form_type, 5)
					|| rpad(form_sfx, 2)|| '	seq= '	|| rec_seq || chr(10) ||
	rpad(verify_code,5)	|| rpad(addr_pfx,3) || rpad(addr_name,21) || rpad(addr_type,5)
					|| rpad(addr_sfx,2) || '	alias= '	|| do_alias	
								  || '	audit= '	|| do_qual || chr(10)	
				"FULL BLOCK"

	*/

	from 			garland.adrResult
	where	rowid in
(
	select rowid	from garland.adrResult	v
	where	verify_code		= 35

	and not exists					--	bad block
(
	select	 'x'	
	from		adrBlock		s
--	from		trvehrcl		s
	where		v.addr_name	= 	s.addr_name
	and		v.addr_type	in  (	s.addr_type, ' ')	
	and		v.addr_pfx	in  (	s.addr_pfx,  ' ')	
	and		v.addr_sfx	in  (	s.addr_sfx,  ' ')	
	and		trunc(v.addr_num,-2) = s.addr_block

--	and		v.addr_num	between trunc (s.addr_lo, -2) and trunc (s.addr_hi, -2) + 99
--	and		v.addr_type =  	s.addr_type
--	and		v.addr_pfx  =  	s.addr_pfx
--	and		v.addr_sfx  =  	s.addr_sfx
--	and		s.branch_no < 9999
)

)	order by	verify_code, form_name, form_type, form_pfx, form_sfx, addr_num;

--	=========================================================================================
--	explain plan	set statement_id = '+Street'		for

--	=========================================================================================
--	explain plan	set statement_id = '+Street'		for

	select count(*)	"FULL ADR"
	/*
	select
	rpad(addr_num,5)		|| rpad(form_pfx ,3)	|| rpad(form_name, 21)	|| rpad(form_type, 5)
					|| rpad(form_sfx, 2)	||	'          seq= '	|| rec_seq || chr(10)	||
	rpad(verify_code,5)	|| rpad(addr_pfx,3)	|| rpad(addr_name,21)	|| rpad(addr_type,5)	
					|| rpad(addr_sfx,2)	||	'          alias= '	|| do_alias	
									||	'     audit= '	|| do_qual || chr(10)	
				"FULL ADDRESS"
	*/

	from 			garland.adrResult
	where	rowid in
(
	select rowid	from garland.adrResult	v
	where	verify_code		= 55

	and not exists					--	bad address
(
	select	 'x'	
	from		cdreladr		s
	where		v.addr_name	= 	s.addr_name
	and		v.addr_num	=	s.addr_num
	and		v.addr_type =  	s.addr_type
	and		v.addr_pfx  =  	s.addr_pfx
	and		v.addr_sfx  =  	s.addr_sfx
)

)	order by	verify_code, form_name, form_type, form_pfx, form_sfx, addr_num;

--	=========================================================================================
--	explain plan	set statement_id = '+Number +Street - Address'		for

	select count(*)	"WRONG ADDR"
	/*
	select
	rpad(addr_num,5)		|| rpad(form_pfx ,3)|| rpad(form_name, 21)|| rpad(form_type, 5)
					|| rpad(form_sfx, 2)|| '	seq= '	|| rec_seq || chr(10) ||
	rpad(verify_code,5)	|| rpad(addr_pfx,3) || rpad(addr_name,21) || rpad(addr_type,5)
					|| rpad(addr_sfx,2) || '	alias= '	|| do_alias	
								  || '	audit= '	|| do_qual || chr(10)	
				"WRONG ADDRESS"
	*/

	from 			garland.adrResult
	where	rowid in
(
	select v.rowid	
	from			garland.adrResult	v
	where	verify_code				= 53

	And ( not exists				--	bad name or number
(
	select 'x'	from cdreladr		a
	where		v.addr_name	= 		a.addr_name
	and		v.addr_num	=		a.addr_num
)
	or not exists				--	bad street
(
	select 'x'	from adrStreets		s
	where		v.addr_name	= 		s.addr_name
	and		v.addr_type	in ( ' ',	s.addr_type	)
	and		v.addr_pfx	in ( ' ',	s.addr_pfx	)
	and		v.addr_sfx	in ( ' ',	s.addr_sfx	)
)
	or exists					--	good address
(
	select 'x'	from cdreladr		a
	where		v.addr_name	= 		a.addr_name
	and		v.addr_num	=		a.addr_num
	and		v.addr_type	in ( ' ',	a.addr_type	)
	and		v.addr_pfx	in ( ' ',	a.addr_pfx	)
	and		v.addr_sfx	in ( ' ',	a.addr_sfx	)
)

))	order by	verify_code, form_name, form_type, form_pfx, form_sfx, addr_num;

--	=========================================================================================
--	explain plan	set statement_id = '+Street +Range - Segment'		for

--	=========================================================================================
--	explain plan	set statement_id = '+Street +Range - Segment'		for

	select count(*)	"WRONG BLOK"
	/*
	select
	rpad(addr_num,5)		|| rpad(form_pfx ,3)|| rpad(form_name, 21)|| rpad(form_type, 5)
					|| rpad(form_sfx, 2)|| '	seq= '	|| rec_seq || chr(10) ||
	rpad(verify_code,5)	|| rpad(addr_pfx,3) || rpad(addr_name,21) || rpad(addr_type,5)
					|| rpad(addr_sfx,2) || '	alias= '	|| do_alias	
								  || '	audit= '	|| do_qual || chr(10)	
				"WRONG BLOCK"
	*/

	from 			garland.adrResult
	where	rowid in
(
	select v.rowid	
	from			garland.adrResult	v
	where	verify_code 			= 33

	And ( not exists					--	bad street
(
	select 'x'	from adrStreets	s
	where		v.addr_name	= 	s.addr_name
	and		v.addr_type	in ( 	s.addr_type, ' ')					--	revised
	and		v.addr_pfx	in ( 	s.addr_pfx,  ' ')
	and		v.addr_sfx	in ( 	s.addr_sfx,  ' ')
)

	or not exists					--	bad block
(
	select 'x'	from trvehrcl	r
	where		v.addr_name	= 	r.addr_name
	and		v.addr_num	between trunc (addr_lo, -2) and trunc (addr_hi, -2) + 99
--	and		r.branch_no < 9999
)
	or exists						--	good block
(
	select 'x'	from trvehrcl	r
	where		v.addr_name	= 	r.addr_name
	and		v.addr_num	between trunc (addr_lo, -2) and trunc (addr_hi, -2) + 99
	and		v.addr_type	in ( 	r.addr_type, '')			
	and		v.addr_pfx	in ( 	r.addr_pfx,  '')
	and		v.addr_sfx	in ( 	r.addr_sfx,  '')					--	revised
--	and		r.branch_no < 9999
)

))	order by	verify_code, form_name, form_type, form_pfx, form_sfx, addr_num;


--	=========================================================================================

--	select * from explain_plan;
--	select * from explain_indexed;

	set echo		on;
	set fetchrows;

--	=========================================================================================


