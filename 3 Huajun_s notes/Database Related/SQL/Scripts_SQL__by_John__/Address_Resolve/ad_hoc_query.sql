
	set timing	off;
	set echo 	off;

	variable	str_num	number;
	variable	str_name	varchar2;
	variable	str_type	varchar2;
	variable	str_pfx	varchar2;
	variable	str_sfx	varchar2;

	execute :str_num		:= 2105;
	execute :str_pfx		:= upper ('');
	execute :str_name		:= upper ('miller');
	execute :str_type		:= upper ('');
	execute :str_sfx		:= upper ('');

	print	str_num str_pfx str_name str_type str_sfx;


--	street
	select 'STREET' "STREET", addr_pfx " ", addr_name " ", addr_type " ", addr_sfx  " "
	from adrStreets
	where	addr_name = 	:str_name
--	and	addr_type = 	:str_type
--	and	addr_pfx  = 	:str_pfx
	;	

--	block
	select 'BLOCK' "BLOCK", addr_pfx " ", addr_name " ", addr_type " ", addr_sfx " ", addr_lo " ", addr_hi " "
	from trvehrcl
	where	:str_num	between trunc (addr_lo,-2) and trunc(addr_hi,-2) + 99
	and	addr_name = 	:str_name
--	and	addr_type = 	:str_type
--	and	addr_pfx  = 	:str_pfx
	;	

--	range
	select 'RANGE' "RANGE", addr_pfx " ", addr_name " ", addr_type " ", addr_sfx " ", addr_lo " ", addr_hi " "
	from trvehrcl
	where	:str_num	between addr_lo and addr_hi
	and	addr_name = 	:str_name
--	and	addr_type = 	:str_type
--	and	addr_pfx  = 	:str_pfx
	;	

--	address
	select 'ADDRESS' "ADDRESS", addr_num " ", addr_pfx " ", addr_name " ", addr_type " ", addr_sfx " "
	from cdreladr
	where	addr_num  =		:str_num
	and	addr_name = 	:str_name
--	and	addr_type = 	:str_type
--	and	addr_pfx  = 	:str_pfx
	;	

--	============================================================================================
--	============================================================================================


/*
--	============================================================================================
	select 'ADDRESS', addr_num " ", addr_pfx " ", addr_name " ", addr_type " ", addr_sfx " "
	from cdreladr

	where	addr_name	= ''
	and	addr_num	= 0
--	and	addr_type	= ''
--	and	addr_pfx	is null

	order by	addr_name, addr_type, addr_pfx, addr_sfx, addr_num;
--	============================================================================================

	select 'STREET', addr_pfx " ", addr_name " ", addr_type " ", addr_sfx " " 
	from adrStreet

	where	addr_name	= ''
--	and	addr_type	= ''
--	and	addr_pfx	is null

	order by	addr_name, addr_type, addr_pfx, addr_sfx;
--	============================================================================================

	select 'RANGE', addr_pfx, addr_name, addr_type, addr_sfx, addr_lo, addr_hi
	from	trvehrcl

	where addr_name	= ''
	and	trunc (addr_lo, -2) = 00
--	and	addr_type	= ''
--	and	addr_pfx	= ''

	order by	addr_name, addr_type, addr_pfx, addr_sfx, addr_lo;
--	============================================================================================
*/

	set echo	on;
