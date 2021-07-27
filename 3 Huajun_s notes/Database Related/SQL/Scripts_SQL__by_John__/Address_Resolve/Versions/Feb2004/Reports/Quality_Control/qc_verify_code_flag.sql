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

--	select count(*)	"BAD NAME"
--	from garland.adrResult

	update 	garland.adrResult
	set		addr_code2 = '!0X'
	where		rtrim(addr_code2) is null 

	and	rowid in
(
	select rowid	from adrResult	v
	where	verify_code		< 10

	and exists						--	good name 
(									
	select 'x'
	from	adrStreets					s
	where	s.addr_name	= v.addr_name
)

);

--	=========================================================================================
--	explain plan	set statement_id = '+Name -Number'		for

--	select count(*)	"STREET ONLY"
--	from garland.adrResult

	update	garland.adrResult
	set		addr_code2 = '!1X'
	where		rtrim(addr_code2) is null 

	and	rowid in
(
	select rowid	from adrResult	v
	where	trunc (verify_code, -1)		= 10
	and	verify_code				> 10

	And (nvl (addr_num,0) > 0			--	good number 

	or not exists					--	bad name
(
	select 'x'
	from	adrStreets					s
	where	s.addr_name	= v.addr_name
)

));

--	=========================================================================================
--	explain plan	set statement_id = '+Format -Block'		for

--	select count(*)	"BAD BLOCK"
--	from garland.adrResult

	update 	garland.adrResult
	set		addr_code2 = '!2X'
	where		rtrim(addr_code2) is null 

	and	rowid in
(
	select rowid	from adrResult	v
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

));

--	=========================================================================================
--	explain plan	set statement_id = '+Block -Range'		for

--	select count(*)	"BAD RANGE"
--	from garland.adrResult

	update 	garland.adrResult
	set		addr_code2 = '!3X'
	where		rtrim(addr_code2) is null 

	and	rowid in
(
	select rowid	from adrResult	v
	where	trunc (verify_code, -1)		= 30

	And ( not exists					--	bad name 
(									
	select 'x'
	from	adrStreets					s
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

));


--	=========================================================================================
--	explain plan	set statement_id = '+Range -Number'		for

--	select count(*)	"BAD ADDRESS"
--	from garland.adrResult

	update 	garland.adrResult
	set		addr_code2 = '!4X'
	where		rtrim(addr_code2) is null 

	and	rowid in
(
	select rowid	from adrResult	v
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

));

--	=========================================================================================
--	explain plan	set statement_id = '+Name +Number'		for

--	select count(*)	"GOOD ADDR"
--	from garland.adrResult

	update 	garland.adrResult
	set		addr_code2 = '!5X'
	where		rtrim(addr_code2) is null 

	and	rowid in
(
	select rowid	from adrResult	v
	where	trunc (verify_code, -1)		= 50

	and not exists					--	bad name or number 
(									
	select 'x'
	from	cdreladr					a
	where	a.addr_name	= v.addr_name
	and	a.addr_num	= v.addr_num
)

);


--	=========================================================================================
--	=========================================================================================
--	explain plan	set statement_id = '+Name -Quals'		for

--	select count(*)	"POOR"
--	from garland.adrResult

	update 	garland.adrResult
	set		addr_code2 = '!X1'
	where		rtrim(addr_code2) is null 

	and	rowid in
(
	select rowid	from adrResult	v
	where	verify_code			> 9
	and	mod(verify_code,10) 	= 1

	And ( not exists					--	bad name
(
	select 'x'		from	adrStreets		s
	where	v.addr_name	= s.addr_name
)

	Or ( exists						--	good type
(
	select 'x'	from adrStreets			s
	where		v.addr_name	= 		s.addr_name
	and		v.addr_type	in ( ' ',	s.addr_type	)
)

	and exists						--	good prefix
(
	select 'x'	from adrStreets			s
	where		v.addr_name	= 		s.addr_name
	and		v.addr_pfx	in ( ' ',	s.addr_pfx	)
)

	and exists						--	good suffix
(
	select 'x'	from adrStreets			s
	where		v.addr_name	= 		s.addr_name
	and		v.addr_sfx	in ( ' ',	s.addr_sfx	)
)

)));

--	=========================================================================================
--	explain plan	set statement_id = '+Name +Quals -Street'		for

--	select count(*)	"MIXED"
--	from garland.adrResult

	update 	garland.adrResult
	set		addr_code2 = '!X2'
	where		rtrim(addr_code2) is null 

	and	rowid in
(
	select rowid	from adrResult	v
	where	verify_code			> 9
	and	mod(verify_code,10)	= 2

	And ( exists					--	good street
(
	select 'x'	from adrStreets			s
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
	select 'x'	from adrStreets			s
	where		v.addr_name	= 		s.addr_name
	and		v.addr_type	in ( ' ',	s.addr_type	)
)
	or not exists					--	bad prefix
(
	select 'x'	from adrStreets			s
	where		v.addr_name	= 		s.addr_name
	and		v.addr_pfx	in ( ' ',	s.addr_pfx	)
)
	or not exists					--	bad suffix
(
	select 'x'	from adrStreets			s
	where		v.addr_name	= 		s.addr_name
	and		v.addr_sfx	in ( ' ',	s.addr_sfx	)
)

));

--	=========================================================================================
--	explain plan	set statement_id = '+Street -Many Street'		for

--	select count(*)	"PART STR"
--	from garland.adrResult

	update 	garland.adrResult
	set		addr_code2 = '!PS'
	where		rtrim(addr_code2) is null 

	and	rowid in
(
	select rowid	from adrResult	r
	where	verify_code	in ( 14, 24 )

	And ( not exists					--	bad street
(
	select 	'x'	
	from		adrStreets		s
	where		r.addr_name	= 	s.addr_name
	and		r.addr_type	in  (	s.addr_type, ' ')	
	and		r.addr_pfx	in  (	s.addr_pfx,  ' ')	
	and		r.addr_sfx	in  (	s.addr_sfx,  ' ')	
)
	or exists						--	single street
(
	select 	'x'
	from		adrStreets		s
	where		r.addr_name	= 	s.addr_name
	and		r.addr_type	in  (	s.addr_type, ' ')	
	and		r.addr_pfx	in  (	s.addr_pfx,  ' ')	
	and		r.addr_sfx	in  (	s.addr_sfx,  ' ')	
	group by	s.addr_name
	having	count(*) = 1
)

));

--	=========================================================================================
--	explain plan	set statement_id = '+Street -Many Street'		for

--	select count(*)	"PART BLK"
--	from garland.adrResult

	update 	garland.adrResult
	set		addr_code2 = '!PB'
	where		rtrim(addr_code2) is null 

	and	rowid in
(
	select rowid	from adrResult	r
	where	verify_code	=	34

	And ( not exists					--	bad block
(
	select	 'x'	
	from		trvehrcl		s
	where		r.addr_name	= 	s.addr_name
	and		r.addr_type	in  (	s.addr_type, ' ')	
	and		r.addr_pfx	in  (	s.addr_pfx,  ' ')	
	and		r.addr_sfx	in  (	s.addr_sfx,  ' ')	
	and		r.addr_num	between trunc(s.addr_lo,-2) and trunc(s.addr_hi,-2) + 99
--	and		s.branch_no < 9999
)

	or exists						--	single street
(
	select 	'x'
	from		trvehrcl		s
	where		r.addr_name	= 	s.addr_name
	and		r.addr_type	in  (	s.addr_type, ' ')	
	and		r.addr_pfx	in  (	s.addr_pfx,  ' ')	
	and		r.addr_sfx	in  (	s.addr_sfx,  ' ')	
	and		r.addr_num	between trunc(s.addr_lo,-2) and trunc(s.addr_hi,-2) + 99
--	and		s.branch_no < 9999
	group by	r.addr_name
	having	count(*) = 1
)

));

--	=========================================================================================
--	explain plan	set statement_id = '+Street -Many Street'		for

--	select count(*)	"PART RNG"
--	from garland.adrResult

	update 	garland.adrResult
	set		addr_code2 = '!PR'
	where		rtrim(addr_code2) is null 

	and	rowid in
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

));


--	=========================================================================================
--	explain plan	set statement_id = '+Street -Many Street'		for

--	select count(*)	"PART ADR"
--	from garland.adrResult

	update 	garland.adrResult
	set		addr_code2 = '!PA'
	where		rtrim(addr_code2) is null 

	and	rowid in
(
	select rowid	from adrResult	r
	where	verify_code	=	54

	And ( not exists					--	bad street
(
	select 'x'	
	from		cdreladr		s
	where		r.addr_name	= 	s.addr_name
	and		r.addr_num	=	s.addr_num
	and		r.addr_type	in  (	s.addr_type, ' ')	
	and		r.addr_pfx	in  (	s.addr_pfx,  ' ')	
	and		r.addr_sfx	in  (	s.addr_sfx,  ' ')	
)

	or exists						--	single street
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

));

--	=========================================================================================
--	explain plan	set statement_id = '+Street'		for

--	select count(*)	"FULL STR"
--	from garland.adrResult

	update 	garland.adrResult
	set		addr_code2 = '!FS'
	where		rtrim(addr_code2) is null 

	and	rowid in
(
	select rowid	from adrResult	v
	where	verify_code	in ( 15, 25 )				

	and not exists					--	bad street
(
	select 	'x'	
	from		adrStreets		s
	where		v.addr_name	= 	s.addr_name
	and		v.addr_type =  	s.addr_type
	and		v.addr_pfx  =  	s.addr_pfx
	and		v.addr_sfx  =  	s.addr_sfx
)

);

--	=========================================================================================
--	explain plan	set statement_id = '+Street'		for

--	select count(*)	"FULL BLK"
--	from garland.adrResult

	update 	garland.adrResult
	set		addr_code2 = '!FB'
	where		rtrim(addr_code2) is null 

	and	rowid in
(
	select rowid	from adrResult	v
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

);

--	=========================================================================================
--	explain plan	set statement_id = '+Street'		for

--	select count(*)	"FULL RNG"
--	from garland.adrResult

	update 	garland.adrResult
	set		addr_code2 = '!FR'
	where		rtrim(addr_code2) is null 

	and	rowid in
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

);

--	=========================================================================================
--	explain plan	set statement_id = '+Street'		for

--	select count(*)	"FULL ADR"
--	from garland.adrResult

	update 	garland.adrResult
	set		addr_code2 = '!FA'
	where		rtrim(addr_code2) is null 

	and	rowid in
(
	select rowid	from adrResult	v
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

);

--	=========================================================================================
--	explain plan	set statement_id = '+Number +Street - Address'		for

--	select count(*)	"WRONG ADDR"
--	from garland.adrResult

	update 	garland.adrResult
	set		addr_code2 = '!WA'
	where		rtrim(addr_code2) is null 

	and	rowid in
(
	select v.rowid	
	from			adrResult	v
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

));

--	=========================================================================================
--	explain plan	set statement_id = '+Street +Range - Segment'		for

--	select count(*)	"WRONG SEGM"
--	from garland.adrResult

	update 	garland.adrResult
	set		addr_code2 = '!WR'
	where		rtrim(addr_code2) is null 

	and	rowid in
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

));

--	=========================================================================================
--	explain plan	set statement_id = '+Street +Range - Segment'		for

--	select count(*)	"WRONG BLOK"
--	from garland.adrResult

	update 	garland.adrResult
	set		addr_code2 = '!WB'
	where		rtrim(addr_code2) is null 

	and	rowid in
(
	select v.rowid	
	from			adrResult	v
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

));


--	=========================================================================================

--	ROLLBACK;
	commit;

--	=========================================================================================

	set echo		on;
	set fetchrows;

--	=========================================================================================
