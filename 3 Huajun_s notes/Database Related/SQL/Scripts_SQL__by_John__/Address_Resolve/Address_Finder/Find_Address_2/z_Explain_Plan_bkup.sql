	set echo	off;
--	==========================================================

	truncate table	garland.plan_table  reuse storage;
	explain plan	set statement_id = 'finder'    for

	select	--+ first_rows

		sign(a.addr_num	+ 01),					--	class = null or 01
		sign(b.addr_block + 01) - :01,		--	class = null or 01
		n.street_class,							--	class = 1 - 4

		s.addr_name, 						
		s.addr_type,  
		s.addr_pfx,   
		s.addr_sfx,		
		nvl(b.addr_block,0)			addr_block,				
		nvl(a.addr_num,  0)			addr_num,	

		x.addr2_name, 						
		x.addr2_type,  
		x.addr2_pfx,   
		x.addr2_sfx,		

		s.street_id,
		b.block_id,
		a.addr_id,
		a.parcel_id,
		x.intersect_id

	from
(
	select	addr_name, min(street_class)	street_class
	from
(
	select --+ index (s, adrStreets_pkey)
			01 street_class,	addr_name
	from		garland.adrStreets	s
	where		addr_Name = :11						-- input name	
	or		addr_Name = :12						-- reformatted name

	union											
	select --+ index (adrStreets adrStreets_x_Compact) index(adrStreets adrStreets_Pkey)
			02,			addr_name
	from		garland.adrStreets	s
	where		addr_Compact = :21					-- close to input	
	or		addr_Name between :22 and :23		-- like alias partial

	union									
	select	02,			addr_name
	from		garland.adrStreets	s					-- mutually exclusive
	where		addr_name	between :31 and :32			-- near or far	
	and		instr (:35, addr_name) > 0				-- compare entire list

	union										
	select	03,				addr_name
	from		garland.adrStreets	s					-- mutually exclusive
	where		addr_Compact between :41 and :42		-- Long or Short search
	and		addr_name like :43					-- User(%x%x%)/ Soundex(%)

	union	
	select	04,				addr_name
	from		garland.adrStreets	s					-- mutually exclusive
	where		instr (:51, addr_name) > 0				
)							
	group by addr_name		
)								N,
			garland.adrStreets		S,
			garland.block			B,
			garland.cdrelADR			A,
			garland.Intersection		X


	where		s.addr_name	=	n.addr_name

	and		s.addr_name	= 	b.addr_name (+)
	and		s.addr_type = 	b.addr_type (+)
	and		s.addr_pfx	= 	b.addr_pfx  (+)
	and		s.addr_sfx	=	b.addr_sfx  (+)
	and		b.addr_block  (+) between :71 and :72

	and		b.addr_name	= 	a.addr_name (+)
	and		b.addr_type = 	a.addr_type (+)
	and		b.addr_pfx	= 	a.addr_pfx  (+)
	and		b.addr_sfx	=	a.addr_sfx  (+)

	and		trunc(a.addr_num(+),-2)	= b.addr_block
	and		a.addr_num (+)	between :81  and :82

	and		rtrim(a.unit_type (+))	is null
--	and		rtrim(a.unit_num  (+)) 	is null

	and		x.intersect_id (+)  like :91
	and		b.addr_name		= x.addr1_name	(+)
	and		b.addr_type		= x.addr1_type	(+)
	and		b.addr_pfx		= x.addr1_pfx	(+)
	and		b.addr_sfx		= x.addr1_sfx	(+)
	and		b.addr_block	= x.addr1_block	(+)		--  NEED INDEX
	
	and		x.addr2_block = 
(
	select	addr2_block
	from		garland.Intersection
	where		intersect_id (+)	like :99
	and		addr1_name	= b.addr_name
	and		addr1_type	= b.addr_type
	and		addr1_block	= b.addr_block
	and		rownum < 2
)
	order by	1 desc, 2 desc, 3, 04,05,06,07, 8, 09;


	select * from explain_plan;

--	==========================================================
	set echo	on;


