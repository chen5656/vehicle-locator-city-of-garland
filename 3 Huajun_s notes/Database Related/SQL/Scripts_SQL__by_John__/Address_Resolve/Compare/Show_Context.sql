	set echo off;
--	==============================================================================
--	Compare Address Resolve result (A) against another address scrubbing result (B)
--		  when the two methods give different results
--	Display all relevant GIS records associated with address

--	Use Test_Filter (function) as a filter
--	==============================================================================

--	==============================================================================
	truncate table	garland.plan_table;
	explain plan	set statement_id = 'a'	into garland.plan_table		for
--	==============================================================================

	select
	decode (	id,
			1,	'Reference ',
			2,	'Original  ',
			3,	'A         ',
			4,	'B         ',
			5,	'Street    ',
			6,	'Block     ',
			7,	'Range     ',
			8,	'Address   ',
			99,	'          ',
				'?'		)		||' '||

		lpad (lo,		05)			||' '||
		lpad (hi,		05)			||' '||
		rpad (pfx,	 	02)			||' '||
		rpad (name,		20)			||' '||
		rpad (type,		05)			||' '||
		rpad (sfx,		04)			||' '||
		rpad (code1,	10)			||' '||
		rpad (unit1,	10)
		" "
	from	

/*
(	select	key,
			id,			
			lo,
			hi,
			pfx,
			name,
			type,
			sfx, 
			code1,
			unit1	
	from
*/

(
	select	x.rec_key					key,
			x.rec_seq,
			x.verify_code,	
			x.do_parse,	
			x.do_alias,	
			x.do_name,
			x.do_qual,
			2						id,			--	Original
			nvl(x.appl_num,  ' ')			lo,
			' '						hi,
			nvl(x.appl_pfx,  ' ')			pfx,
			x.appl_name			  		name,
			nvl(x.appl_type, ' ')			type,
			nvl(x.appl_sfx,  ' ')			sfx, 
			nvl(x.appl_code1,' ')			code1,
			nvl(x.appl_unit1,' ')			unit1	
		from	garland.adrResult		X,
			garland.adrResult_Input	Y
		where	x.rec_key		= y.rec_key
		and   not (	x.addr_name	= y.addr_name
			and	x.addr_type	= y.addr_type
			and	x.addr_pfx	= y.addr_pfx
			and	x.addr_sfx	= y.addr_sfx
			and	x.addr_num	= y.addr_num	)

	union
	select	x.rec_key					key,
			x.rec_seq,
			x.verify_code,	
			x.do_parse,	
			x.do_alias,	
			x.do_name,
			x.do_qual,
			3						id,			--	A
			nvl(rtrim(x.addr_num), ' ')		lo,
			' '						hi,
			nvl(x.addr_pfx,  ' ')			pfx,
			x.addr_name			  		name,
			nvl(x.addr_type, ' ')			type,
			nvl(x.addr_sfx,  ' ')			sfx, 
			nvl(x.addr_code1,' ')			code1,
			nvl(x.addr_unit1,' ')			unit1	
		from	garland.adrResult		X,
			garland.adrResult_Input	Y
		where	x.rec_key		= y.rec_key
		and   not (	x.addr_name	= y.addr_name
			and	x.addr_type	= y.addr_type
			and	x.addr_pfx	= y.addr_pfx
			and	x.addr_sfx	= y.addr_sfx
			and	x.addr_num	= y.addr_num	)


	union
	select	x.rec_key					key,
			x.rec_seq,
			x.verify_code,	
			x.do_parse,	
			x.do_alias,	
			x.do_name,
			x.do_qual,
			4						id,			--	B
			nvl(rtrim(y.addr_num), ' ')		lo,
			' '						hi,
			nvl(y.addr_pfx,  ' ')			pfx,
			y.addr_name			  		name,
			nvl(y.addr_type, ' ')			type,
			nvl(y.addr_sfx,  ' ')			sfx, 
			nvl(y.addr_code1,' ')			code1,
			nvl(y.addr_unit1,' ')			unit1	
		from	garland.adrResult		X,
			garland.adrResult_Input	Y
		where	x.rec_key		= y.rec_key
		and   not (	x.addr_name	= y.addr_name
			and	x.addr_type	= y.addr_type
			and	x.addr_pfx	= y.addr_pfx
			and	x.addr_sfx	= y.addr_sfx
			and	x.addr_num	= y.addr_num	)


	union
	select	x.rec_key			key,
			x.rec_seq,
			x.verify_code,	
			x.do_parse,	
			x.do_alias,	
			x.do_name,
			x.do_qual,
			5				id,			--	Street
			' '				lo,
			' '				hi,
			a.addr_pfx			pfx,
			a.addr_name			name,
			a.addr_type			type,
			a.addr_sfx			sfx, 
			' '				code1,
			' '				unit1	
		from	garland.adrResult		X,
			garland.adrResult_Input	Y,
			garland.adrStreet		A
		where	x.rec_key		= y.rec_key
		and	x.addr_name		= a.addr_name	
		and   not (	x.addr_name	= y.addr_name
			and	x.addr_type	= y.addr_type
			and	x.addr_pfx	= y.addr_pfx
			and	x.addr_sfx	= y.addr_sfx	)


	union
	select	x.rec_key			key,
			x.rec_seq,
			x.verify_code,	
			x.do_parse,	
			x.do_alias,	
			x.do_name,
			x.do_qual,
			6				id,			--	Block
			rtrim(a.addr_block)	lo,
			' '				hi,
			a.addr_pfx			pfx,
			a.addr_name			name,
			a.addr_type			type,
			a.addr_sfx			sfx, 
			''				code1,
			''				unit1	
		from	garland.adrResult		X,
			garland.adrResult_Input	Y,
			garland.adrBlock		A
		where	x.rec_key			= y.rec_key
		and	x.addr_name			= a.addr_name	
		and	trunc(x.addr_num,-2)	= a.addr_block
		and   not (	x.addr_name	= y.addr_name
			and	x.addr_type	= y.addr_type
			and	x.addr_pfx	= y.addr_pfx
			and	x.addr_sfx	= y.addr_sfx
			and	x.addr_num	= y.addr_num	)


	union
	select	x.rec_key			key,
			x.rec_seq,
			x.verify_code,	
			x.do_parse,	
			x.do_alias,	
			x.do_name,
			x.do_qual,
			7					id,		--	Range
			nvl(rtrim(a.addr_lo), ' ')	lo,
			nvl(rtrim(a.addr_hi), ' ')	hi,
			a.addr_pfx				pfx,
			a.addr_name				name,
			a.addr_type				type,
			a.addr_sfx				sfx, 
			''					code1,
			''					unit1	
		from	garland.adrResult		X,
			garland.adrResult_Input	Y,
			garland.trvehrcl		A
		where	x.rec_key			= y.rec_key
		and	x.addr_name			= a.addr_name	
		and	x.addr_num		between a.addr_lo  and a.addr_hi
		and   not (	x.addr_name	= y.addr_name
			and	x.addr_type	= y.addr_type
			and	x.addr_pfx	= y.addr_pfx
			and	x.addr_sfx	= y.addr_sfx
			and	x.addr_num	= y.addr_num	)


	union
	select	x.rec_key			key,
			x.rec_seq,
			x.verify_code,	
			x.do_parse,	
			x.do_alias,	
			x.do_name,
			x.do_qual,
			8					id,		--	Address
			nvl(rtrim(a.addr_num), ' ')	lo,
			' '			 		hi,
			a.addr_pfx				pfx,
			a.addr_name				name,
			a.addr_type				type,
			a.addr_sfx				sfx, 
			a.unit_type				code1,
			a.unit_num				unit1	
		from	garland.adrResult		X,
			garland.adrResult_Input	Y,
			garland.cdreladr		A
		where	x.rec_key		= y.rec_key
		and	x.addr_name		= a.addr_name	
		and	x.addr_num		= a.addr_num
		and   not (	x.addr_name	= y.addr_name
			and	x.addr_type	= y.addr_type
			and	x.addr_pfx	= y.addr_pfx
			and	x.addr_sfx	= y.addr_sfx
			and	x.addr_num	= y.addr_num	)

--	--------------------------------------------------------

	union
	select	x.rec_key			key,
			x.rec_seq,
			x.verify_code,	
			x.do_parse,	
			x.do_alias,	
			x.do_name,
			x.do_qual,
			99				id,			--	Blank line
			'' 				lo,
			'' 				hi,
			'' 				pfx,
			''				name,
			''				type,
			''				sfx, 
			''				code1,
			''				unit1	
		from	garland.adrResult		X,
			garland.adrResult_Input	Y
		where	x.rec_key		= y.rec_key
		and   not (	x.addr_name	= y.addr_name
			and	x.addr_type	= y.addr_type
			and	x.addr_pfx	= y.addr_pfx
			and	x.addr_sfx	= y.addr_sfx
			and	x.addr_num	= y.addr_num	)


	union
	select	x.rec_key			key,
			x.rec_seq,
			x.verify_code,	
			x.do_parse,	
			x.do_alias,	
			x.do_name,
			x.do_qual,
			1				id,		
			rtrim(x.verify_code)	lo,
			''				hi,
			'' 				pfx,
			nvl(x.rec_key, ' ')	name,
			nvl(x.do_alias,' ')	type,
			nvl(x.do_name, ' ')	sfx, 
			nvl(x.do_qual, ' ')	code1,
			nvl(x.do_parse,' ')	unit1	
		from	garland.adrResult		X,
			garland.adrResult_Input	Y
		where	x.rec_key		= y.rec_key
		and   not (	x.addr_name	= y.addr_name
			and	x.addr_type	= y.addr_type
			and	x.addr_pfx	= y.addr_pfx
			and	x.addr_sfx	= y.addr_sfx
			and	x.addr_num	= y.addr_num	)
)

	where	rec_seq > 0

	and	Test_Filter (id, verify_code, do_alias, do_name, do_qual, do_parse, rec_seq) = 01

--	)

	order by	key, id, name, type, pfx, sfx, lo;


--	======================================================================
	select * from garland.explain_plan;
--	select * from garland.explain_analyze;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_cost;
--	select * from garland.explain_remote;
--	======================================================================
	set echo on;
