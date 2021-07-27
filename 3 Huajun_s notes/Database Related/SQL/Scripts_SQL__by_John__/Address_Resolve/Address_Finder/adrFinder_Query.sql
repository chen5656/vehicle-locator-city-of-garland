	set echo off;
--	=================================================================================

	select count(s.addr_name), count(a.addr_name) 
	from	adrstreets		s,
		cdreladr		a
	where	s.addr_name		= 'FIFTH'
	and	s.addr_pfx		= 'N'
	and	s.addr_name		= a.addr_name	(+)
	and	s.addr_pfx		= a.addr_pfx 	(+)
	and	217			= a.addr_num	(+);

--	=================================================================================

--	analyze table	garland.adrStreets	compute statistics;
--	analyze table	garland.Block_Side	compute statistics;
--	analyze table	garland.adrAlias		compute statistics;
--	analyze table	garland.cdreladr		compute statistics;

--	-----------------------------------------------------------------
	set serveroutput	on;
--	SELECT * FROM CDRELADR where addr_name = 'MAIN';
--	-----------------------------------------------------------------

declare
	
--		this_name		varchar2(20)	:= 'MAIN';
		this_name		varchar2(20)	:= 'asdf';

--		that_num		number		:= 500;
		that_num		number		:= 555;

		best_count		number;
		is_same_name	number;

begin

	select 
		 max(s.addr_name),
		 max(a.addr_num),
		 09
	into	this_name, 
		best_count,
		is_same_name

	from	adrStreets		s,
		cdreladr		a
	where	s.addr_name		= this_name
	and	s.addr_name		= a.addr_name (+)
	and	that_num		= a.addr_num  (+);


	dbms_output.put_line (this_name || ';' || best_count );

end;

-------------------------------------------------------------------------------- ------- -------
                                                                                    cost    rows
-------------------------------------------------------------------------------- ------- -------
..Select.State................Finder............................................     115     236
...Sort.......................Order.By..........................................     115     236
....Sort......................Unique............................................     109     236
.....Hash.Join................Outer.............................................     102     236
......Hash.Join...............Outer.............................................      18     236
01.....Table.Access...........Full..............Adrstreets......................       4     236
.......Index..................Fast.Full.Scan....Block_Side_Pkey.......Unique....      13       1
03....Table.Access............By.Index.Rowid....Cdreladr........................      83       9
.......Index..................Range.Scan........Cdreladr_X_Num........Non-Unique       4       9


--	=================================================================================
--	=================================================================================
	set echo	off;

	variable	reduced_name	varchar2(20);
	variable	compress_name	varchar2(20);
	variable	lo_num		number;
	variable	hi_num		number;
	variable	lo_block		number;
	variable	hi_block		number;
	variable	lo_parity		number;
	variable	hi_parity		number;


--	MEADOWBROOK

	execute	:reduced_name	:= 'MEADOWBROK';		
	execute	:compress_name	:= 'MDW%';

	execute	:lo_num		:= 100;
	execute	:hi_num		:= 300;

	execute	:lo_block		:= 100;
	execute	:hi_block		:= 300;

	execute	:lo_parity		:= 0;
	execute	:hi_parity		:= 01;

---------------------------------------------------------------------------------------

--	truncate table	plan_table		reuse storage;
--	explain plan	set statement_id = 'finder'   for

	select	--+  cache (s)
			distinct

			sign(nvl(a.addr_num,  0))	address_entity,
			sign(nvl(b.addr_block,0))	block_entity,

			nvl(replace(s.addr_reduced, :reduced_name),' ')	
								addr_reduced,

			s.addr_name, 						
			s.addr_type,  s.addr_pfx,   s.addr_sfx,		
			nvl(b.addr_block,0)		addr_block,				
			nvl(a.addr_num,  0)		addr_num,	

			a.parcel_id,
			a.addr_id

	from		adrStreets		s,
			Block_Side		b,
			cdreladr		a

	where	(	s.addr_compress	like :compress_name
	or		s.addr_name	    in ('alias_name', 'fuzzy1', 'fuzzy2', 'fuzzy3', 'similar_name')	)

	and		s.addr_name	= 	b.addr_name (+)
	and		s.addr_type = 	b.addr_type (+)
	and		s.addr_pfx	= 	b.addr_pfx  (+)
	and		s.addr_sfx	=	b.addr_sfx  (+)
	and		b.addr_block  (+) between :lo_block	 and :hi_block
	and		b.addr_parity (+) between :lo_parity and :hi_parity

	and		b.addr_name	= 	a.addr_name (+)
	and		b.addr_type = 	a.addr_type (+)
	and		b.addr_pfx	= 	a.addr_pfx  (+)
	and		b.addr_sfx	=	a.addr_sfx  (+)

	and		trunc(a.addr_num(+),-2)	= b.addr_block
	and		a.addr_num (+) 		between :lo_num and :hi_num

	and		rtrim(a.unit_type (+))	is null
--	and		rtrim(a.unit_num )  	is null	

	order by	1 desc, 2 desc, 3, 04, 05, 06, 07, 08, 9;

--	select * from explain_plan;

	set echo	on;
--	=================================================================================

