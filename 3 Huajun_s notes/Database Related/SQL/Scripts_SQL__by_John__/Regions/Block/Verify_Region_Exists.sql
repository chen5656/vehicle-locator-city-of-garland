	set echo off;
--	=======================================================
--	Verify "vacant" and "filled" gaps for specified block
--	Compare against listing from update job
--	=======================================================

	variable	adr_block	number;
	variable	adr_name	varchar2(20);
	variable	adr_pfx	varchar2(30);
	variable	adr_type	varchar2(20);
	variable	adr_sfx	varchar2(20);
	variable	region	varchar2(20);

	execute	:adr_name	:= 	'ABLON';
	execute	:adr_pfx	:= 	' ';
	execute	:adr_type	:=	'';
	execute	:adr_sfx	:=	'';
	execute	:region	:=	'';
	execute	:adr_block	:= 	0;
	
--	=======================================================

--	analyze table	adrBlock_side	compute statistics;

--	=======================================================
--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for


	select
			lpad(b.addr_parity,6)	"parity",
			lpad(a.addr_num,   6)	"number",
			lpad(b.addr_block, 6)	" block", 
			b.addr_pfx " ", b.addr_name "street", b.addr_type " ", b.addr_sfx " ", 
			lpad(t.addr_lo,    6)	"   lo",
			lpad(t.addr_hi,    6)	"   hi",

			b.POLICE_BEAT	"b BEAT",		p.POLICE_BEAT	"p BEAT"

	from		cdrelpar		p,
			trvehrcl		t,
			adrBlock_Side	b,
			cdreladr		a

	where		nvl(rtrim(	p.POLICE_BEAT	),'.')	> nvl(:region,' ')

	and		:adr_name	= b.addr_name  

	and		:adr_block			in ( 0,  b.addr_block)
	and		nvl(:adr_type,' ')	in (' ', b.addr_type )
	and		nvl(:adr_pfx, ' ')	in (' ', b.addr_pfx  )
	and		nvl(:adr_sfx, ' ')	in (' ', b.addr_sfx  )

	and		b.addr_name			= t.addr_name
	and		b.addr_type			= t.addr_type
	and		b.addr_pfx			= t.addr_pfx
	and		b.addr_sfx			= t.addr_sfx
	and		b.addr_block		between t.addr_lo and t.addr_hi

	and		b.addr_name			= a.addr_name  (+)
	and		b.addr_type			= a.addr_type  (+)
	and		b.addr_pfx			= a.addr_pfx   (+)
	and		b.addr_sfx			= a.addr_sfx   (+)
	and		b.addr_block		= trunc(a.addr_num (+),-2)
	and		b.addr_parity		= mod  (a.addr_num (+), 2) 

	and		a.parcel_id 		= p.parcel_id  (+)

	order by	b.addr_name, b.addr_type, b.addr_pfx, b.addr_sfx, b.addr_block, b.addr_parity;

--	======================================================================
--	select * from explain_plan;
--	select * from explain_analyze;
--	select * from explain_indexed;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_cost;
--	======================================================================

--	======================================================================
/*
	
	select *
	from 	cdreladr	a,
		cdrelpar	p
	where	a.parcel_id	= p.parcel_id (+)

	and	addr_name	= 'AVENUE A'
	and	addr_num	= 100

	order by	addr_name, addr_type, addr_pfx, addr_sfx, addr_num;



	select *
	from adrBlock_Side

	where	addr_name  = 'AVENUE A'
--	and	addr_block = 100

	order by	addr_name, addr_type, addr_pfx, addr_sfx, addr_block;


*/
--	======================================================================
 
	set echo on;

--	======================================================================
/*

filled 14148  [1]  3300 - 3300    SATURN                        RD        47
filled 14148  [1]  3300 - 3500    SATURN                        RD        47
filled 14148  [1]  3300 - 4100    SATURN                        RD        47
filled 14148  [1]  3300 - 4200    SATURN                        RD        45

*/
--	======================================================================

