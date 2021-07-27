	set echo	off;
--	===========================================================
--	find overlapping blocks of similar street names
--	===========================================================

	variable	name1			varchar2(40);
	variable	name2			varchar2(40);
	variable	name3			varchar2(40);
	variable	blok			number;

 	variable	do_common		varchar2(1);
	variable	do_numbers		varchar2(1);
	variable	do_transpose	varchar2(1);

--	------------------------------------------------------------

	execute	:do_common		:= '';
	execute	:do_numbers		:= '1';
	execute	:do_transpose	:= '';

--	------------------------------------------------------------

--	execute	:name1	:=	 '%';
--	execute	:name2 	:=	 '%';
--	execute	:name3	:=	 '%';

	execute	:name1	:=	'WALNUT';
	execute	:name2	:=	'WALNUT CIRCLE EAST';
	execute	:name3 	:=	'WALNUT CIRCLE WEST';

	execute	:blok	 	:=	 00;

--	===========================================================

(
	select addr_block
	from	block
	where	addr_name like	:name1
	and	:blok		in (0, addr_block)
	and	addr_name > :do_common

	intersect

	select addr_block
	from	block
	where	addr_name like	:name2
	and	:blok		in (0, addr_block)

	intersect

	select addr_block
	from	block
	where	addr_name like	:name3
	and	:blok		in (0, addr_block)
)


	union all

(
	select addr_num
	from	cdreladr
	where	addr_name like	:name1
	and	:blok		=  trunc(addr_num, -2)
	and	addr_name > :do_common

	intersect

	select addr_num
	from	cdreladr
	where	addr_name like	:name2
	and	:blok		=  trunc(addr_num, -2)

	intersect

	select addr_num
	from	cdreladr
	where	addr_name like	:name3
	and	:blok		=  trunc(addr_num, -2)
);



(
	select addr_num
	from	 cdreladr
	where	 addr_name	= :name1
	and	:blok		=  trunc(addr_num, -2)
	and	addr_name > :do_common

	intersect

	select addr_num
	from	 cdreladr
	where	 addr_name	= :name2
	and	:blok		=  trunc(addr_num, -2)
);


--	===========================================================
--	compare transposed alias name blocks

(
	select addr_block
	from	block		b,
		adralias	a

	where	alias_how like 'trans'
	and	a.alias_name > a.addr_name
	and	b.addr_name = a.alias_name
	and	b.addr_name > :do_transpose

	intersect

	select addr_block
	from	block		b,
		adralias	a
	where	alias_how like 'trans'
	and	a.alias_name > a.addr_name
	and	b.addr_name = a.addr_name
);


--	===========================================================

	select addr_num, addr_pfx, addr_name, addr_type, addr_sfx
	from	garland.cdreladr
	where	addr_name in ( :name1, :name2, :name3 )
	and	addr_name > :do_numbers
	;


--	===========================================================


--	===========================================================
--	===========================================================
	set echo	on;
